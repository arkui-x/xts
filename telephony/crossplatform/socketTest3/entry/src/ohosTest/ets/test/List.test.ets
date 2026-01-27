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

import TLSSocketConnection_1Test from './TLSSocketConnection_1.test'
import TLSSocketConnection_2Test from './TLSSocketConnection_2.test'
import TLSSocketServerTest1 from './TLSSocketServer_1.test'
import TLSSocketServerTest2 from './TLSSocketServer_2.test'
import TLSSocketServerTest3 from './TLSSocketServer_3.test'
import TLSSocketTest from './TLSSocket.test'
import SocketWorkTest from './socketWork.test'

export default function testsuite() {
  TLSSocketConnection_1Test();
  TLSSocketConnection_2Test();
  TLSSocketServerTest1();
  TLSSocketServerTest2();
  TLSSocketServerTest3();
  TLSSocketTest();
  SocketWorkTest()
}