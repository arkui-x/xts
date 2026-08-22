/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to applicable law is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// arkui-x crossplatform compile-only port: @ohos.wifiManager is not crossplatform-supported,
// so the WiFi precheck is stubbed to a no-op. The exported signature is preserved so that
// migrated test files (which call `await WifiConnectStatus()` in beforeEach) compile unchanged.

export async function WifiConnectStatus() {
  console.info('====>WifiConnectStatus: stubbed no-op (arkui-x crossplatform port)');
}
