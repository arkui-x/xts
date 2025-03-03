/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { BusinessError } from '@ohos.base'
import { describe, it, expect, afterEach, afterAll } from '@ohos/hypium'
import deviceInfo from '@ohos.deviceInfo'
import socket from '@ohos.net.socket'

const osFullNameInfo: string = deviceInfo.osFullName
const platform = osFullNameInfo.split(' ')[0]

async function addMembershipFunc(multicast: socket.MulticastSocket, addr: socket.NetAddress) {
  await multicast.addMembership(addr).then(() => {
    console.log('addMembershipFunc success')
  }).catch((err: BusinessError) => {
    let code: Number = (err as BusinessError).code
    let message: string = (err as BusinessError).message
    console.info("addMembershipFuncErrorParam, code =" + code + ", message=" + message)
    console.log('addMembershipFunc fail')
    expect().assertFail()
  })
}

async function dropMembershipFunc(multicast: socket.MulticastSocket, addr: socket.NetAddress) {
  await multicast.dropMembership(addr).then(() => {
    console.log('dropMembershipFunc success')
  }).catch((err: BusinessError) => {
    let code: Number = (err as BusinessError).code
    let message: string = (err as BusinessError).message
    console.info("dropMembershipFuncErrorParam, code =" + code + ", message=" + message)
    console.log('dropMembershipFunc fail')
    expect().assertFail()
  })
}

async function setMulticastTTLFunc(multicast: socket.MulticastSocket, ttl: number) {
  await multicast.setMulticastTTL(ttl).then(() => {
    console.log('setMulticastTTLFunc success')
  }).catch((err: BusinessError) => {
    let code: Number = (err as BusinessError).code
    let message: string = (err as BusinessError).message
    console.info("setMulticastTTLFuncErrorParam, code =" + code + ", message=" + message)
    console.log('setMulticastTTLFunc fail')
    expect().assertFail()
  })
}

async function setLoopbackModeFunc(multicast: socket.MulticastSocket, value: boolean) {
  await multicast.setLoopbackMode(value).then(() => {
    console.log('setLoopbackModeFunc success')
  }).catch((err: Object) => {
    let code: Number = (err as BusinessError).code
    let message: string = (err as BusinessError).message
    console.info("setLoopbackModeFuncErrorParam, code =" + code + ", message=" + message)
    console.log('setLoopbackModeFunc fail, err: ' + JSON.stringify(err))
    expect().assertFail()
  })
}

async function getLoopbackModeFunc(multicast: socket.MulticastSocket) {
  await multicast.getLoopbackMode().then((value: Boolean) => {
    console.log('getLoopbackModeFunc success: ', JSON.stringify(value))
  }).catch((err: Object) => {
    let code: Number = (err as BusinessError).code
    let message: string = (err as BusinessError).message
    console.info("getLoopbackModeFuncErrorParam, code =" + code + ", message=" + message)
    console.log('getLoopbackModeFunc failed')
    expect().assertFail()
  })
}

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function MultiSockTest() {
  describe('MultiSockTest', () => {

    afterEach(async()=>{
      await sleep(1000);
    })

    afterAll(async ()=>{
      await sleep(3000);
    })

    /**
     * @tc.number : SUB_netSocket_constructMulticastSocketInstance_Func_0010
     * @tc.name   : test constructMulticastSocketInstance normal
     * @tc.desc   : test constructMulticastSocketInstance normal
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_constructMulticastSocketInstance_Func_0010', 0, async (done: Function) => {
      try {
        let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
        console.info("constructMulticastSocketInstance success")
        expect(multicast != null).assertTrue()
        done()
      } catch (err) {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("constructMulticastSocketInstance fail")
        console.info("constructMulticastSocketInstanceErrorParam, code =" + code + ", message=" + message)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0010
     * @tc.name   : test addMembership normal
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_addMembership_Func_0010', 0, async (done: Function) => {
      let addr: socket.NetAddress = {
        address: '239.255.0.1',
        port: 8080
      }
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.addMembership(addr, (err: BusinessError) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("addMembership fail")
          console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
          expect().assertFail()
          done()
        } else {
          expect(err == null).assertTrue()
          console.info("addMembership success")
        }
      })
      await sleep(1000)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0020
     * @tc.name   : test addMembership wrong addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_addMembership_Func_0020', 0, async (done: Function) => {
      let addr: socket.NetAddress = {
        address: '110.110.0.1',
        port: 8080
      }
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.addMembership(addr, (err: BusinessError) => {
        if (err) {
          console.log('addMembership success')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301022).assertTrue()
          }
        } else {
          console.log('addMembership failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0030
     * @tc.name   : test addMembership invalid addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_addMembership_Func_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.110111.0.1',
        port: 8080
      }
      multicast.addMembership(addr, (err: Object) => {
        if (err) {
          console.log('addMembership success')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301022).assertTrue()
          }
        } else {
          console.log('addMembership failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0040
     * @tc.name   : test addMembership normal
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_addMembership_Func_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.2',
        port: 8081
      }
      await multicast.addMembership(addr).then(async () => {
        console.log('addMembership success')
        expect(addr != null).assertTrue()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
        console.log('addMembership fail')
        expect().assertFail()
        done()
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0050
     * @tc.name   : test addMembership wrong addr by Promise
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_addMembership_Func_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.110.0.1',
        port: 8081
      }
      await multicast.addMembership(addr).then(async () => {
        console.log('addMembership success')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
        console.log('addMembership fail')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301022).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_addMembership_Func_0060
     * @tc.name   : test addMembership invalid addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_addMembership_Func_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.110111.0.1',
        port: 8080
      }
      await multicast.addMembership(addr).then(async () => {
        console.log('addMembership success')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("addMembershipErrorParam, code =" + code + ", message=" + message)
        console.log('addMembership fail')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301022).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0010
     * @tc.name   : test dropMembership normal
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_dropMembership_Func_0010', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.3',
        port: 8082
      }
      await addMembershipFunc(multicast, addr)
      multicast.dropMembership(addr, (err: Object) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          console.log('dropMembership failed')
          expect().assertFail()
        } else {
          console.log('dropMembership success')
          expect(addr != null).assertTrue()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0020
     * @tc.name   : test dropMembership wrong addr by CallBack
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0020', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.110.0.1',
        port: 8080
      }
      multicast.dropMembership(addr, (err: Object) => {
        if (err) {
          console.log('dropMembership success')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('dropMembership failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0030
     * @tc.name   : test dropMembership invalid addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.1100001.0.1',
        port: 8080
      }
      multicast.dropMembership(addr, (err: Object) => {
        if (err) {
          console.log('dropMembership success')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('dropMembership failed')
          expect().assertFail()
          done()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0040
     * @tc.name   : test dropMembership no add addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.100',
        port: 8080
      }
      multicast.dropMembership(addr, (err: Object) => {
        if (err) {
          console.log('dropMembership success')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('dropMembership failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0050
     * @tc.name   : test dropMembership normal
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_dropMembership_Func_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.4',
        port: 8083
      }
      try {
        await addMembershipFunc(multicast, addr)
        await multicast.dropMembership(addr).then(() => {
          console.log('dropMembership success')
          expect(addr != null).assertTrue()
          done()
        }).catch((err: BusinessError) => {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          console.log('dropMembership fail')
          expect().assertFail()
          done()
        })
      } catch (error) {
        let code: Number = (error as BusinessError).code
        let message: string = (error as BusinessError).message
        console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0060
     * @tc.name   : test dropMembership wrong addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.110.0.1',
        port: 8081
      }
      try {
        await multicast.dropMembership(addr).then(async () => {
          console.log('dropMembership fail')
          expect().assertFail()
          done()
        }).catch((err: BusinessError) => {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
          console.log('dropMembership success')
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
          done()
        })
      } catch (error) {
        let code: Number = (error as BusinessError).code
        let message: string = (error as BusinessError).message
        console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0070
     * @tc.name   : test dropMembership invalid addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0070', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '110.11011111.0.1',
        port: 8080
      }
      await multicast.dropMembership(addr).then(async () => {
        console.log('dropMembership failed')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
        console.log('dropMembership success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301009).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_dropMembership_Func_0080
     * @tc.name   : test dropMembership no add addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_dropMembership_Func_0080', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.100',
        port: 8080
      }
      await multicast.dropMembership(addr).then(async () => {
        console.log('dropMembership failed')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
        console.log('dropMembership success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301009).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0010
     * @tc.name   : test setMulticastTTL normal
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setMulticastTTL_Func_0010', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.5',
        port: 8084
      }
      try {
        await addMembershipFunc(multicast, addr)
        let ttl = 8
        multicast.setMulticastTTL(ttl, (err: Object) => {
          if (err) {
            console.log('setMulticastTTL failed')
            expect().assertFail()
          } else {
            console.log('setMulticastTTL success')
            expect(addr != null).assertTrue()
          }
        })
        await sleep(1000)
        await multicast.dropMembership(addr)
        done()
      } catch (error) {
        let code: Number = (error as BusinessError).code
        let message: string = (error as BusinessError).message
        console.info("dropMembershipErrorParam, code =" + code + ", message=" + message)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0020
     * @tc.name   : test setMulticastTTL negative num
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0020', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.6',
        port: 8085
      }
      try {
        await addMembershipFunc(multicast, addr)
        let ttl = -5
        multicast.setMulticastTTL(ttl, (err: Object) => {
          if (err) {
            let code: Number = (err as BusinessError).code
            let message: string = (err as BusinessError).message
            console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
            console.log('setMulticastTTL success')
            if (platform == "iOS") {
              expect(code == 2301005).assertTrue()
            } else {
              expect(code == 2301022).assertTrue()
            }
          } else {
            console.log('setMulticastTTL failed')
            expect().assertFail()
          }
        })
        await sleep(1000)
        await multicast.dropMembership(addr)
        done()
      } catch (error) {
        let code: Number = (error as BusinessError).code
        let message: string = (error as BusinessError).message
        console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0030
     * @tc.name   : test setMulticastTTL more than normal
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.7',
        port: 8086
      }
      await addMembershipFunc(multicast, addr)
      let ttl = 100000
      multicast.setMulticastTTL(ttl, (err: Object) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
          console.log('setMulticastTTL success')
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301022).assertTrue()
          }
        } else {
          console.log('setMulticastTTL failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      await multicast.dropMembership(addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0040
     * @tc.name   : test setMulticastTTL no add addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let ttl = 10
      multicast.setMulticastTTL(ttl, (err: Object) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
          console.log('setMulticastTTL success')
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('setMulticastTTL failed')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0050
     * @tc.name   : test setMulticastTTL normal
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setMulticastTTL_Func_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.8',
        port: 8087
      }
      await addMembershipFunc(multicast, addr)
      let ttl = 5
      await multicast.setMulticastTTL(ttl).then(async () => {
        console.log('setMulticastTTL success')
        expect(addr != null).assertTrue()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('setMulticastTTL fail')
        expect().assertFail()
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0060
     * @tc.name   : test setMulticastTTL negative num
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.9',
        port: 8088
      }
      await addMembershipFunc(multicast, addr)
      let ttl = -5
      await multicast.setMulticastTTL(ttl).then(() => {
        console.log('setMulticastTTL failed')
        expect().assertFail()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('setMulticastTTL success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301022).assertTrue()
        }
      })
      dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0070
     * @tc.name   : test setMulticastTTL more than normal
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0070', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.10',
        port: 8089
      }
      await addMembershipFunc(multicast, addr)
      let ttl = 500
      await multicast.setMulticastTTL(ttl).then(() => {
        console.log('setMulticastTTL failed')
        expect().assertFail()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('setMulticastTTL success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301022).assertTrue()
        }
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setMulticastTTL_Func_0080
     * @tc.name   : test setMulticastTTL no add addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setMulticastTTL_Func_0080', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let ttl = 10
      await multicast.setMulticastTTL(ttl).then(() => {
        console.log('setMulticastTTL failed')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('setMulticastTTL success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301009).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0010
     * @tc.name   : test getMulticastTTL get default ttl
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getMulticastTTL_Func_0010', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.11',
        port: 8090
      }
      await addMembershipFunc(multicast, addr)
      multicast.getMulticastTTL((err: Object, value: Number) => {
        if (err) {
          console.log('getMulticastTTL fail, err: ' + JSON.stringify(err))
          expect().assertFail()
        } else {
          console.log('getMulticastTTL success, value: ' + JSON.stringify(value))
          expect(addr != null).assertTrue()
        }
      })
      await sleep(1000)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0020
     * @tc.name   : test getMulticastTTL get set ttl
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getMulticastTTL_Func_0020', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.12',
        port: 8091
      }
      await addMembershipFunc(multicast, addr)
      let ttl = 8
      await setMulticastTTLFunc(multicast, ttl)
      multicast.getMulticastTTL((err: Object, value: Number) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("getMulticastTTLErrorParam, code =" + code + ", message=" + message)
          console.log('getMulticastTTL fail')
          expect().assertFail()
        } else {
          console.log('getMulticastTTL success, value: ' + JSON.stringify(value))
          expect(ttl == value).assertTrue()
        }
      })
      await sleep(1000)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0030
     * @tc.name   : test getMulticastTTL no add addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_getMulticastTTL_Func_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.getMulticastTTL((err: Object, value: Number) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("getMulticastTTLErrorParam, code =" + code + ", message=" + message)
          console.log('tests getMulticastTTL success, err: ' + JSON.stringify(err))
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('test getMulticastTTL failed, value: ' + JSON.stringify(value))
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0040
     * @tc.name   : test getMulticastTTL get default ttl
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getMulticastTTL_Func_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.13',
        port: 8092
      }
      await addMembershipFunc(multicast, addr)
      await multicast.getMulticastTTL().then((value: number) => {
        console.log('getMulticastTTL success')
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('getMulticastTTL failed')
        expect().assertFail()
      })
      await multicast.dropMembership(addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0050
     * @tc.name   : test getMulticastTTL get set ttl
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getMulticastTTL_Func_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.14',
        port: 8093
      }
      await addMembershipFunc(multicast, addr)
      let ttl = 8
      await setMulticastTTLFunc(multicast, ttl)
      await multicast.getMulticastTTL().then((value: number) => {
        console.log('getMulticastTTL success')
        expect(ttl == value).assertTrue()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('getMulticastTTL failed')
        expect().assertFail()
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getMulticastTTL_Func_0060
     * @tc.name   : test getMulticastTTL no add addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_getMulticastTTL_Func_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      await multicast.getMulticastTTL().then((value: number) => {
        console.log('test getMulticastTTL failed')
        expect().assertFail()
        done()
      }).catch((err: BusinessError) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getMulticastTTLErrorParam, code =" + code + ", message=" + message)
        console.log('getMulticastTTL success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301009).assertTrue()
        }
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0010
     * @tc.name   : test setLoopbackMode true
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setLoopbackMode_test_0010', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.15',
        port: 8094
      }
      await addMembershipFunc(multicast, addr)
      multicast.setLoopbackMode(true, (err: Object) => {
        if (err) {
          console.log('setLoopbackMode fail, err: ' + JSON.stringify(err))
          expect().assertFail()
        } else {
          console.log('setLoopbackMode success')
          expect(addr != null)
        }
      })
      await sleep(1000)
      await getLoopbackModeFunc(multicast)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0020
     * @tc.name   : test setLoopbackMode false
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setLoopbackMode_test_0020', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.16',
        port: 8095
      }
      await addMembershipFunc(multicast, addr)
      multicast.setLoopbackMode(false, (err: Object) => {
        if (err) {
          console.log('setLoopbackMode fail, err: ' + JSON.stringify(err))
          expect().assertFail()
        } else {
          console.log('setLoopbackMode success')
          expect(addr != null).assertTrue()
        }
      })
      await sleep(1000)
      await getLoopbackModeFunc(multicast)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0030
     * @tc.name   : test setLoopbackMode false no add addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setLoopbackMode_test_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.setLoopbackMode(false, (err: Object) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("setLoopbackModeErrorParam, code =" + code + ", message=" + message)
          console.log('test setLoopbackMode success, err: ' + JSON.stringify(err))
          if (platform == "iOS") {
            expect(code == 2301005).assertTrue()
          } else {
            expect(code == 2301009).assertTrue()
          }
        } else {
          console.log('test setLoopbackMode fail')
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0040
     * @tc.name   : test setLoopbackMode true
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setLoopbackMode_test_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.17',
        port: 8096
      }
      await addMembershipFunc(multicast, addr)
      multicast.setLoopbackMode(true).then(() => {
        console.log('setLoopbackMode success')
        expect(addr != null).assertTrue()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('setLoopbackMode fail, err: ' + JSON.stringify(err))
        expect().assertFail()
      })
      await getLoopbackModeFunc(multicast)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0050
     * @tc.name   : test setLoopbackMode false
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_setLoopbackMode_test_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.18',
        port: 8097
      }
      await addMembershipFunc(multicast, addr)
      await multicast.setLoopbackMode(false).then(() => {
        console.log('setLoopbackMode success')
        expect(addr != null).assertTrue()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('setLoopbackMode fail, err: ' + JSON.stringify(err))
        expect().assertFail()
      })
      await getLoopbackModeFunc(multicast)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_setLoopbackMode_test_0060
     * @tc.name   : test setLoopbackMode false no add addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_setLoopbackMode_test_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      await multicast.setLoopbackMode(false).then(() => {
        console.log('setLoopbackMode fail')
        expect().assertFail()
        done()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("setLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('setLoopbackMode success, err: ' + JSON.stringify(err))
        expect(true).assertTrue()
        done()
      })
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0010
     * @tc.name   : test getLoopbackMode true
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getLoopbackMode_test_0010', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.19',
        port: 8098
      }
      await addMembershipFunc(multicast, addr)
      await setLoopbackModeFunc(multicast, true)
      multicast.getLoopbackMode((err: Object, value: Boolean) => {
        if (err) {
          console.log('getLoopbackMode fail, err: ' + JSON.stringify(err))
          expect().assertFail()
        } else {
          console.log('getLoopbackMode success')
          expect(value).assertTrue()
        }
      })
      await sleep(1000)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0020
     * @tc.name   : test getLoopbackMode false
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getLoopbackMode_test_0020', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.20',
        port: 8099
      }
      await addMembershipFunc(multicast, addr)
      await setLoopbackModeFunc(multicast, false)
      multicast.getLoopbackMode((err: Object, value: Boolean) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
          console.log('getLoopbackMode fail, err: ' + JSON.stringify(err))
          expect().assertFail()
        } else {
          console.log('getLoopbackMode success')
          expect(value).assertFalse()
        }
      })
      await sleep(1000)
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0030
     * @tc.name   : test getLoopbackMode no add addr
     * @tc.desc   : Use CallBack Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_getLoopbackMode_test_0030', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.getLoopbackMode((err: Object, value: Boolean) => {
        if (err) {
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
          expect(code != 0).assertTrue()
        } else {
          console.log('test getLoopbackMode failed')
          let code: Number = (err as BusinessError).code
          let message: string = (err as BusinessError).message
          console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
          expect().assertFail()
        }
      })
      await sleep(1000)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0040
     * @tc.name   : test getLoopbackMode true
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getLoopbackMode_test_0040', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.21',
        port: 8100
      }
      await addMembershipFunc(multicast, addr)
      await setLoopbackModeFunc(multicast, true)
      await multicast.getLoopbackMode().then((value: Boolean) => {
        console.log('getLoopbackMode success: ', JSON.stringify(value))
        expect(value).assertTrue()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('getLoopbackMode failed')
        expect().assertFail()
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0050
     * @tc.name   : test getLoopbackMode false
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 0
     */
    it('SUB_netSocket_getLoopbackMode_test_0050', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      let addr: socket.NetAddress = {
        address: '239.255.0.22',
        port: 8101
      }
      await addMembershipFunc(multicast, addr)
      await setLoopbackModeFunc(multicast, false)
      await multicast.getLoopbackMode().then((value: Boolean) => {
        console.log('getLoopbackMode success: ', JSON.stringify(value))
        expect(value).assertFalse()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('get getLoopbackMode failed')
        expect().assertFail()
      })
      await dropMembershipFunc(multicast, addr)
      done()
    })

    /**
     * @tc.number : SUB_netSocket_getLoopbackMode_test_0060
     * @tc.name   : test getLoopbackMode no add addr
     * @tc.desc   : Use Promise Type
     * @tc.level  : Level 2
     */
    it('SUB_netSocket_getLoopbackMode_test_0060', 0, async (done: Function) => {
      let multicast: socket.MulticastSocket = socket.constructMulticastSocketInstance()
      multicast.getLoopbackMode().then((value: Boolean) => {
        console.log('test getLoopbackMode failed: ', JSON.stringify(value))
        expect().assertFail()
        done()
      }).catch((err: Object) => {
        let code: Number = (err as BusinessError).code
        let message: string = (err as BusinessError).message
        console.info("getLoopbackModeErrorParam, code =" + code + ", message=" + message)
        console.log('test getLoopbackMode success')
        if (platform == "iOS") {
          expect(code == 2301005).assertTrue()
        } else {
          expect(code == 2301009).assertTrue()
        }
        done()
      })
    })

  })
}