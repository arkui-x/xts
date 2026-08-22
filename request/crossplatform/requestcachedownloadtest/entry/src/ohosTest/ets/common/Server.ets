/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

// Local HTTP server is provided by LocalHttpServer.java (NanoHTTPD) started in
// MyApplication.onCreate(). The server listens on port 8080 and serves test content.
// @ohos.net.socket is not available in ArkUI-X runtime, so the ArkTS-side Server
// class just returns the fixed port that the Java server is listening on.

const TAG = 'SOCKET_SERVER'
const SERVER_PORT = 8080;

export default class Server {
  async startServer(): Promise<number> {
    console.info(TAG + '====>Server.startServer() - using Java NanoHTTPD on port ' + SERVER_PORT);
    return SERVER_PORT;
  }

  getPort(): number {
    return SERVER_PORT;
  }

  getBaseUrl(): string {
    return `http://127.0.0.1:${SERVER_PORT}`;
  }

  async serverClose() {
    console.info(TAG + '====>Server.serverClose() - no-op (Java server managed by Application)');
  }

  async serverForceClose() {
    console.info(TAG + '====>Server.serverForceClose() - no-op');
  }
}

