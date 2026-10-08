/**
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

// Local HTTP server for the cacheDownload XTS suite, implemented with the
// @ohos.net.socket TCPSocketServer API so that Android and iOS share the same
// ArkTS server (no platform-specific Java/ObjC server required).
//
// Structured after the OHOS native requestAgentTaskTest iTcpServer.ets: a
// singleton server whose serverStart() resolves with the actual listening
// port once listen() has completed. The routing is shared with Server.ets
// through HttpServerCore.ets.

import { HttpServerCore } from './HttpServerCore';

export default class Server {
  private myPort: number = 0;

  /**
   * Start (or reuse) the singleton server on 127.0.0.1:8080.
   * @returns the actual listening port (8080 on success)
   */
  async serverStart(): Promise<number> {
    let port: number = await HttpServerCore.start();
    this.myPort = port;
    return port;
  }

  getPort(): number {
    return this.myPort !== 0 ? this.myPort : HttpServerCore.getPort();
  }

  getBaseUrl(): string {
    return HttpServerCore.getBaseUrl();
  }

  async serverClose() {
    await HttpServerCore.close();
  }

  async serverForceClose() {
    await HttpServerCore.forceClose();
  }
}
