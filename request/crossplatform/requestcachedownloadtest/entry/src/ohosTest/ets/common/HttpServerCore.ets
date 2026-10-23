/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Shared local HTTP server implementation for the cacheDownload XTS suite.
// Based on @ohos.net.socket TCPSocketServer (aligned with the OHOS native XTS
// Server.ets / iTcpServer.ets approach) so that the same code serves both the
// Android and the iOS app without any platform-specific (Java/ObjC) server.
//
// The routing table intentionally matches the behaviour of the previously used
// Android-only LocalHttpServer.java (NanoHTTPD), because the existing xts
// cases were already adapted to that routing; see handleRequest() below.

import socket from '@ohos.net.socket';

const TAG = 'HTTP_SERVER_CORE';
const SERVER_ADDRESS = '127.0.0.1';
const SERVER_PORT = 8080;

// Body served for "/" and ".txt" requests.
const TEST_FILE_CONTENT = 'This is a test file for cacheDownload.';
// Body size for the 400K size-verification file ('a' x 400*1024).
const FILE_400K_SIZE = 400 * 1024;
// Body size for image requests (0xFF x 10240).
const IMAGE_SIZE = 10240;
// Body size for mp3 requests (0x49 x 5120).
const MP3_SIZE = 5120;

// Delay injected before every 404 response. Tests call download() first and
// register the onDownloadError callback afterwards; over localhost the 404
// would otherwise arrive before the callback is registered and the error
// would be dropped.
const NOT_FOUND_DELAY_MS = 1000;
// Variable delay so two downloads of the same URL report different totalTime
// values (testGetDownloadInfo001/005). Capped with modulo so the delay stays
// bounded (5-152ms) and downloads still fit inside the 500ms poll windows.
const VARIABLE_DELAY_MAX = 50;

interface ParsedRequest {
  method: string;
  path: string;
  headers: Map<string, string>;
}

interface HttpResponse {
  statusLine: string;
  contentType: string;
  body: string | ArrayBuffer;
}

function sleep(ms: number): Promise<void> {
  return new Promise<void>((resolve: () => void) => {
    setTimeout(resolve, ms);
  });
}

function arrayBufferFromByte(fill: number, size: number): ArrayBuffer {
  let buffer: ArrayBuffer = new ArrayBuffer(size);
  let view: Uint8Array = new Uint8Array(buffer);
  for (let i = 0; i < size; i++) {
    view[i] = fill;
  }
  return buffer;
}

function textToBytes(text: string): Uint8Array {
  let out: Uint8Array = new Uint8Array(text.length);
  for (let i = 0; i < text.length; i++) {
    out[i] = text.charCodeAt(i) & 0xFF;
  }
  return out;
}

function decodeRequest(raw: ArrayBuffer): string {
  let view: Uint8Array = new Uint8Array(raw);
  let out: string = '';
  for (let i = 0; i < view.byteLength; i++) {
    out += String.fromCharCode(view[i]);
  }
  return out;
}

function parseHttpRequest(message: string): ParsedRequest {
  let lines: string[] = message.split('\r\n');
  let requestLine: string = lines.length > 0 ? lines[0] : '';
  let parts: string[] = requestLine.split(' ');
  let method: string = parts.length > 0 && parts[0] !== '' ? parts[0] : 'GET';
  let path: string = parts.length > 1 ? parts[1] : '/';
  let headers: Map<string, string> = new Map<string, string>();
  for (let i = 1; i < lines.length; i++) {
    let line: string = lines[i];
    if (line === '') {
      break;
    }
    let colonIndex: number = line.indexOf(':');
    if (colonIndex > 0) {
      headers.set(line.substring(0, colonIndex).trim().toLowerCase(), line.substring(colonIndex + 1).trim());
    }
  }
  let result: ParsedRequest = { method: method, path: path, headers: headers };
  return result;
}

function buildTextResponse(statusLine: string, contentType: string, body: string): string {
  return statusLine + '\r\n' +
    'Content-Type: ' + contentType + '\r\n' +
    'Content-Length: ' + body.length + '\r\n' +
    'Connection: close\r\n' +
    '\r\n' +
    body;
}

function buildBinaryResponse(statusLine: string, contentType: string, body: ArrayBuffer): ArrayBuffer {
  let header: string = statusLine + '\r\n' +
    'Content-Type: ' + contentType + '\r\n' +
    'Content-Length: ' + body.byteLength + '\r\n' +
    'Connection: close\r\n' +
    '\r\n';
  let headerBytes: Uint8Array = textToBytes(header);
  let out: Uint8Array = new Uint8Array(headerBytes.byteLength + body.byteLength);
  out.set(headerBytes, 0);
  out.set(new Uint8Array(body), headerBytes.byteLength);
  return out.buffer;
}

// Route the request. Order matters and mirrors LocalHttpServer.java:
// 404 paths -> 400K file -> txt/root -> json -> mp3 -> images -> default.
function handleRequest(request: ParsedRequest): HttpResponse {
  let path: string = request.path;

  // --- 404 paths ---
  // test123/testxxx/error.jpg/testpicture7/notfound are expected to fail with
  // HTTP 404 (errorCode 48 in cacheDownload).
  // test1.txt/test.jpg/bird123.png/.gif/.pdf/test.mp3 are 404 as well, aligned
  // with the OHOS native iTcpServer.ets routing. Note test.mp3 is a 404 while
  // every other .mp3 returns 200.
  if (path.indexOf('test123') >= 0 || path.indexOf('testxxx') >= 0 ||
    path.indexOf('error.jpg') >= 0 || path.indexOf('testpicture7') >= 0 ||
    path.indexOf('notfound') >= 0 || path.indexOf('test1.txt') >= 0 ||
    path.indexOf('test.jpg') >= 0 || path.indexOf('bird123.png') >= 0 ||
    path.indexOf('.gif') >= 0 || path.indexOf('.pdf') >= 0 ||
    path === '/test.mp3' || path.endsWith('/test.mp3')) {
    return {
      statusLine: 'HTTP/1.1 404 Not Found',
      contentType: 'text/plain',
      body: '404 Not Found'
    };
  }

  // --- 400K text file ---
  // CacheDownloadInfo size-verification tests expect a ~400KB body.
  if (path.indexOf('test400K') >= 0 || path.indexOf('400k') >= 0) {
    return {
      statusLine: 'HTTP/1.1 200 OK',
      contentType: 'text/plain',
      body: arrayBufferFromByte('a'.charCodeAt(0), FILE_400K_SIZE)
    };
  }

  // --- Text files ---
  if (path.endsWith('.txt') || path === '/' || path === '' ||
    path.indexOf('test_picture') >= 0 || path.indexOf('testfile') >= 0) {
    return {
      statusLine: 'HTTP/1.1 200 OK',
      contentType: 'text/plain',
      body: TEST_FILE_CONTENT
    };
  }

  // --- JSON files ---
  if (path.endsWith('.json')) {
    return {
      statusLine: 'HTTP/1.1 200 OK',
      contentType: 'application/json',
      body: '{"status":"success","count":10}'
    };
  }

  // --- MP3 audio (test.mp3 already returned 404 above) ---
  if (path.endsWith('.mp3')) {
    return {
      statusLine: 'HTTP/1.1 200 OK',
      contentType: 'audio/mpeg',
      body: arrayBufferFromByte(0x49, MP3_SIZE)
    };
  }

  // --- Image files (jpg/png/jpeg) ---
  if (path.endsWith('.jpg') || path.endsWith('.png') || path.endsWith('.jpeg')) {
    return {
      statusLine: 'HTTP/1.1 200 OK',
      contentType: 'image/jpeg',
      body: arrayBufferFromByte(0xFF, IMAGE_SIZE)
    };
  }

  // --- Default: 200 OK with text content ---
  return {
    statusLine: 'HTTP/1.1 200 OK',
    contentType: 'text/plain',
    body: TEST_FILE_CONTENT
  };
}

// Inject invalid UTF-8 bytes into a text response, aligned with the OHOS
// native Server.ets behaviour for cacheDownloadHttpHeaders0100-0400: the
// request header value identifies which invalid sequence to place at offset
// 45 of the response. The ArkUI-X cases only assert that the cache file
// exists afterwards, but keep the injection so the server stays aligned with
// the OHOS purpose of exercising HTTP responses carrying invalid header bytes.
function injectInvalidUtf8(rawRequest: string, response: string): string | ArrayBuffer {
  let bytes: Uint8Array = textToBytes(response);
  if (rawRequest.indexOf('test1:cacheDownloadHttpHeaders0100') >= 0) {
    bytes[45] = 0x80;
  } else if (rawRequest.indexOf('test2:cacheDownloadHttpHeaders0200') >= 0) {
    bytes[45] = 0xE0;
    bytes[46] = 0x80;
  } else if (rawRequest.indexOf('test3:cacheDownloadHttpHeaders0300') >= 0) {
    bytes[45] = 0xF0;
    bytes[46] = 0x80;
    bytes[47] = 0x80;
  } else if (rawRequest.indexOf('test4:cacheDownloadHttpHeaders0400') >= 0) {
    bytes[45] = 0xF4;
    bytes[46] = 0x90;
    bytes[47] = 0x80;
    bytes[48] = 0x80;
  } else {
    return response;
  }
  return bytes.buffer;
}

// ---------------------------------------------------------------------------
// Singleton server state
// ---------------------------------------------------------------------------

let globalServer: socket.TCPSocketServer | null = null;
let globalPort: number = 0;
let globalIsRunning: boolean = false;
let globalStarting: Promise<number> | null = null;
let requestCounter: number = 0;
let clientConnections: socket.TCPSocketConnection[] = [];

let onConnectCallback = (client: socket.TCPSocketConnection) => {
  clientConnections.push(client);
  client.on('message', async (value: socket.SocketMessageInfo) => {
    try {
      let rawRequest: string = decodeRequest(value.message);
      console.info(TAG + '====>request: ' + rawRequest.substring(0, 200));
      let request: ParsedRequest = parseHttpRequest(rawRequest);
      let response: HttpResponse = handleRequest(request);

      // Variable delay so same-URL downloads get different totalTime values.
      requestCounter++;
      let delay: number = 5 + (requestCounter % VARIABLE_DELAY_MAX) * 3;
      await sleep(delay);

      // Extra delay before 404 responses: tests register onDownloadError
      // AFTER calling download(); localhost would answer too fast otherwise.
      if (response.statusLine.indexOf('404') >= 0) {
        await sleep(NOT_FOUND_DELAY_MS);
      }

      let data: string | ArrayBuffer;
      if (typeof response.body === 'string') {
        let textResponse: string = buildTextResponse(response.statusLine, response.contentType, response.body);
        data = injectInvalidUtf8(rawRequest, textResponse);
      } else {
        data = buildBinaryResponse(response.statusLine, response.contentType, response.body);
      }

      let option: socket.TCPSendOptions = {
        data: data
      };
      await client.send(option);
      client.close();
    } catch (err) {
      console.info(TAG + '====>handle message err: ' + JSON.stringify(err));
      try {
        client.close();
      } catch (closeErr) {
        console.info(TAG + '====>client close err: ' + JSON.stringify(closeErr));
      }
    }
  });
};

export class HttpServerCore {
  /**
   * Start (or reuse) the singleton server on 127.0.0.1:8080.
   * Resolves only after listen() has completed, so callers never need a fixed
   * sleep to wait for readiness.
   */
  static async start(): Promise<number> {
    if (globalIsRunning && globalServer) {
      console.info(TAG + '====>reusing running server on port ' + globalPort);
      return globalPort;
    }
    if (globalStarting) {
      console.info(TAG + '====>waiting for in-flight server start');
      return globalStarting;
    }
    globalStarting = HttpServerCore.doStart();
    try {
      return await globalStarting;
    } finally {
      globalStarting = null;
    }
  }

  private static async doStart(): Promise<number> {
    globalServer = socket.constructTCPSocketServerInstance();
    let listenAddr: socket.NetAddress = {
      address: SERVER_ADDRESS,
      port: SERVER_PORT,
      family: 1
    };
    try {
      console.info(TAG + '====>listening on ' + SERVER_ADDRESS + ':' + SERVER_PORT);
      await globalServer.listen(listenAddr);
      let localAddr: socket.NetAddress = await globalServer.getLocalAddress();
      let localPort: number = localAddr.port !== undefined && localAddr.port !== 0 ? localAddr.port : SERVER_PORT;
      globalPort = localPort;
      console.info(TAG + '====>listen success, actual port: ' + globalPort);
      globalServer.on('connect', onConnectCallback);
      globalIsRunning = true;
      clientConnections = [];
      return globalPort;
    } catch (err) {
      console.info(TAG + '====>listen failed: ' + JSON.stringify(err));
      globalServer = null;
      globalIsRunning = false;
      globalPort = 0;
      throw new Error('Failed to start http server: ' + JSON.stringify(err));
    }
  }

  static getPort(): number {
    return globalPort;
  }

  static getBaseUrl(): string {
    if (globalPort === 0) {
      return '';
    }
    return 'http://' + SERVER_ADDRESS + ':' + globalPort;
  }

  /**
   * Soft close: keep the singleton running so the next suite reuses it.
   * (Matches the OHOS iTcpServer.ets singleton semantics.)
   */
  static async close(): Promise<void> {
    console.info(TAG + '====>close called (singleton mode, keeping server running)');
  }

  /** Force close the server and every live client connection. */
  static async forceClose(): Promise<void> {
    if (!globalIsRunning || !globalServer) {
      console.info(TAG + '====>forceClose: server not running');
      return;
    }
    console.info(TAG + '====>force closing server on port ' + globalPort);
    for (let i = 0; i < clientConnections.length; i++) {
      try {
        await clientConnections[i].close();
      } catch (err) {
        console.info(TAG + '====>client close err (ignored): ' + JSON.stringify(err));
      }
    }
    clientConnections = [];
    try {
      await globalServer.close();
    } catch (err) {
      console.info(TAG + '====>server close err (ignored): ' + JSON.stringify(err));
    }
    globalServer = null;
    globalIsRunning = false;
    globalPort = 0;
  }
}
