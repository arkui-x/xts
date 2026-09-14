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

// Local HTTP server for the cacheDownload XTS suite, implemented with the
// @ohos.net.socket TCPSocketServer API so that Android and iOS share the same
// ArkTS server (no platform-specific Java/ObjC server required).
//
// The actual server lives in HttpServerCore.ets (singleton); this class is the
// compatibility wrapper used by RequestCacheDownloadHttp.test.ets, whose
// beforeAll calls `new Server().startServer()` without awaiting the result,
// so startServer() must never reject.

import { HttpServerCore } from './HttpServerCore';

const TAG = 'SOCKET_SERVER';

export default class Server {
  async startServer(): Promise<number> {
    try {
      let port: number = await HttpServerCore.start();
      console.info(TAG + '====>Server.startServer() success on port ' + port);
      return port;
    } catch (err) {
      // Swallow the failure: the caller does not await this promise and an
      // unhandled rejection would abort the suite before the first case runs.
      console.info(TAG + '====>Server.startServer() failed: ' + JSON.stringify(err));
      return 0;
    }
  }

  getPort(): number {
    return HttpServerCore.getPort();
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
