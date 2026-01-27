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

import TCPSocketServerTest from './TCPSocketServer.test'
import TCPSocketConnectionTest from './TCPSocketConnection.test'
import SocketTest from './Socket.test'
import UdpSocketTest from './UdpSocket.test'
import TCPSocketTest from './TCPSocket.test'
import MulticastSocketTest from './MulticastSocket.test'
import LocalSocketTest from './LocalSocket.test'
import LocalSocketServerTest from './LocalSocketServer.test'
import LocalSocketConnectionTest from './LocalSocketConnection.test'

export default function testsuite() {
  TCPSocketServerTest();
  TCPSocketConnectionTest();
  SocketTest();
  UdpSocketTest();
  TCPSocketTest();
  MulticastSocketTest();
  LocalSocketTest();
  LocalSocketServerTest();
  LocalSocketConnectionTest();
}