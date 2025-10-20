/*
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

import socketJsunit from './socketJsunit.test'
import SocketErrorCodeTest01 from './socketErrorCode.test'
import TCPSocketTest from './tcpSocket.test'
import TLSSocketTest from './tlsSocket.test'
import networkManagerSocketTest from './networkManagerSocket.test'
import ConnectionBasicTest from './netBearType.test'
import UDPSocketTest from './udpSocket.test'

export default function testsuite() {
  socketJsunit()
  SocketErrorCodeTest01()
  TCPSocketTest()
  TLSSocketTest()
  networkManagerSocketTest()
  ConnectionBasicTest()
  UDPSocketTest()
}