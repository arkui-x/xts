/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, DEFAULT } from '@ohos/hypium'
import { BusinessError, Callback } from '@ohos.base'
import { Driver } from '@ohos.UiTest'
import socket from '@ohos.net.socket'

let driver = Driver.create()

export default function TCPSocketConnectionTest() {
  describe('TCPSocketConnectionTest', () => {

    beforeAll(async () => {
    })

    beforeEach(async () => {
    })

    afterEach(async () => {
    })

    afterAll(async () => {
    })

    /* *
    * @tc.number: SUB_TCPSocketConnection_On_Func_0010
    * @tc.name  : on(type: 'message', callback: Callback<LocalSocketMessageInfo>): void
    * @tc.desc  : subscriptions to receive message events for TCP Socket Connection connections
    * @tc.level : level 0
    */
    it('SUB_TCPSocketConnection_On_Func_0010', 0, async (done: Function) => {
      let caseName: string = 'SUB_CPSocketConnection_OffMessage_0010'
      try {
        console.info(`${caseName} test start`)
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance()
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance()
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 8030,
          family: 1
        }
        await tcpServer.listen(listenAddress)
        let tcpConnectOptions: socket.TCPConnectOptions = {
          address: listenAddress
        }
        tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
          expect(client != null).assertTrue()
          let clientSendOptions: socket.TCPSendOptions = {
            data: 'A'
          }
          const callback1: Callback<socket.SocketMessageInfo> = (value: socket.SocketMessageInfo) => {
            console.info(`${caseName} callback1 success`)
            const uintArray = new Uint8Array(value.message)
            let messageView = ''
            for (let i = 0; i < uintArray.length; i++) {
              messageView += String.fromCharCode(uintArray[i])
            }
            expect(messageView == clientSendOptions.data).assertEqual(true)
            done()
          }
          client.on('message', callback1)
          await tcp.send(clientSendOptions)
          await driver.delayMs(1000)
          console.info(`${caseName} done`)
          client.off('message')
          await client.close()
          done()
        })
        await tcp.connect(tcpConnectOptions)
      } catch (err) {
        console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`)
        expect().assertFail()
        console.info(`${caseName} test end`)
        done()
      }
    })

    /* *
     * @tc.number: SUB_TCPSocketConnection_Off_Func_0020
     * @tc.name  : off(type: 'message', callback?: Callback<SocketMessageInfo>): void
     * @tc.desc  : UnSubscription to receive message events for TCPSocketConnection connections
     * @tc.level : level 0
     */
    it('SUB_TCPSocketConnection_Off_Func_0020', 0, async (done: Function) => {
      let caseName: string = 'SUB_TCPSocketConnection_Off_Func_0020'
      let res: boolean = true
      try {
        console.info(`${caseName} test start`)
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance()
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance()
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 8031,
          family: 1
        }
        await tcpServer.listen(listenAddress).then(() => {
          console.info(`${caseName} success`)
        }).catch((err: BusinessError) => {
          console.info(`${caseName} fail err:${JSON.stringify(err)}`)
          expect().assertFail()
          done()
        })
        let tcpConnectOptions: socket.TCPConnectOptions = {
          address: listenAddress
        }
        tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
          expect(client != null).assertTrue()
          let clientSendOptions: socket.TCPSendOptions = {
            data: 'Hello, server!'
          }
          const callback: Callback<socket.SocketMessageInfo> = () => {
            console.info(`${caseName} fail`)
            res = false
            expect().assertFail()
            done()
          }
          client.on('message', callback)
          client.off('message', callback)
          await tcp.send(clientSendOptions)
          await client.close()
          expect(res).assertTrue()
          done()
        })
        await tcp.connect(tcpConnectOptions)
      } catch (err) {
        console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`)
        expect().assertFail()
        console.info(`${caseName} test end`)
        done()
      }
    })

    /* *
     * @tc.number: SUB_TCPSocketConnection_Off_Func_0030
     * @tc.name  : off(type: 'message', callback?: Callback<SocketMessageInfo>): void
     * @tc.desc  : Cancel multiple subscriptions to receive message events for TCP Socket Connection connections
     * @tc.level : level 1
     */
    it('SUB_TCPSocketConnection_Off_Func_0030', 0, async (done: Function) => {
      let caseName: string = 'SUB_TCPSocketConnection_Off_Func_0030'
      let res: boolean = true
      try {
        console.info(`${caseName} test start`)
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance()
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance()
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 8032,
          family: 1
        }
        await tcpServer.listen(listenAddress)
        let tcpConnectOptions: socket.TCPConnectOptions = {
          address: listenAddress
        }
        tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
          expect(client != null).assertTrue()
          let clientSendOptions: socket.TCPSendOptions = {
            data: 'Hello, server!'
          }
          const callback1: Callback<socket.SocketMessageInfo> = () => {
            console.info(`${caseName} callback1 fail`)
            res = false
            expect().assertFail()
            done()
          }
          const callback2: Callback<socket.SocketMessageInfo> = () => {
            console.info(`${caseName} callback2 fail`)
            res = false
            expect().assertFail()
            done()
          }
          client.on('message', callback1)
          client.on('message', callback2)
          client.off('message')
          await tcp.send(clientSendOptions)
          await client.close()
          expect(res).assertTrue()
          done()
        })
        await tcp.connect(tcpConnectOptions)
      } catch (err) {
        console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`)
        expect().assertFail()
        console.info(`${caseName} test end`)
        done()
      }
    })

  })
}