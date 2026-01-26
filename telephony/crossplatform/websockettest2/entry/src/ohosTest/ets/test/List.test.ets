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

import WebSocketTest_1 from './WebSocketTest_1.test'
import WebSocketTest_2 from './WebSocketTest_2.test'
import WebSocketTest_3 from './WebSocketTest_3.test'
import WebSocketTest_4 from './WebSocketTest_4.test'
import WebSocketMultiWorkerTest from './WebsocketWork.test'

export default function testsuite() {

  WebSocketTest_1()
  WebSocketTest_2()
  WebSocketTest_4();
  WebSocketTest_3();
  WebSocketMultiWorkerTest();
}