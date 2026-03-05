/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
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

import { describe, it, expect, Level, TestType, Size, beforeEach, beforeAll } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { getNextPort, PortManager, SocketErrorCodes } from './TCPSocketServer.test';

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function TCPSocketTest() {
  describe('TCPSocketTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0100
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0100
     * @tc.desc Get TCPSocket status,after bind; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0100';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr);
        try {
          await tcp.getSocketFd((err: BusinessError, data: number) => {
            console.info(`${caseName} success`);
            expect(err == null).assertTrue();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0200
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0200
     * @tc.desc Get TCPSocket status,after connect; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0200';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.bind(netAddress);
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
          done();
        });
        try {
          await tcp.getSocketFd((err: BusinessError, data: number) => {
            console.info(`${caseName} success`);
            expect(err == null).assertTrue();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0300
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0300
     * @tc.desc Get TCPSocket status,before bind; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0300';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '999.999.999.999',
          port: getNextPort(),
        };
        await tcp.bind(bindAddr, (bindErr: BusinessError) => {
          if (bindErr) {
            tcp.getSocketFd((err: BusinessError, data: number) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
              } else {
                console.info(`${caseName} success`);
                expect(data == undefined).assertTrue();
              }
              tcp.close();
              done();
            });
          } else {
            console.error(`${caseName} failed, error:`);
            expect().assertFail();
            tcp.close();
            done();
          }
        });
      })


    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0400
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0400
     * @tc.desc Get TCPSocket status,before connect; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0400';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        };
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        };
        tcp.getSocketFd((err: BusinessError, data: number) => {
          if (data == undefined) {
            console.info(`${caseName} success`);
            expect(data).assertUndefined();
            tcp.close();
            done();
          } else {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            tcp.close();
            done();
          }
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0500
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0500
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0500';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
          done();
        });
        try {
          await tcp.getSocketFd().then((data: number) => {
            console.info(`${caseName} success`);
            expect(data != undefined).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0600
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0600';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
        });
        let getSocketFd = false;
        try {
          tcp.getSocketFd(undefined);
          getSocketFd = true;
          console.info(`${caseName} success`);
          expect(getSocketFd).assertTrue;
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0700
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0700
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0700';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
        });
        let getSocketFd = false;
        try {
          tcp.getSocketFd(null);
          getSocketFd = true;
          console.info(`${caseName} success`);
          expect(getSocketFd).assertTrue;
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0800
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0800
     * @tc.desc Get TCPSocket status,after bind; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0800';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        tcp.getSocketFd().then((data: number) => {
          console.info(`${caseName} success`);
          expect(data != undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          if (tcp) {
            tcp.close();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_0900
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_0900
     * @tc.desc Get TCPSocket status,after listen and connect; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_0900';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 3000
        }
        tcpServer.listen(netAddress);
        await tcp.connect(tcpconnectoptions)
        tcp.getSocketFd().then((data: number) => {
          console.info(`${caseName} success`);
          expect(data != undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          if (tcp) {
            tcp.close();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1000
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1000
     * @tc.desc Get TCPSocket status, before bind; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1000';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '999.999.999.999',
          port: getNextPort(),
        }
        await tcp.bind(bindAddr, (bindErr: BusinessError) => {
          if (bindErr) {
            tcp.getSocketFd().then((data: number) => {
              if (data == undefined) {
                console.info(`${caseName} success`);
                expect(data).assertUndefined();
              } else {
                expect().assertFail();
              }
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              if (tcp) {
                tcp.close();
              }
              done();
            })
          }
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1100
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1100
     * @tc.desc Get TCPSocket status, before connect; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1100';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        };
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 1000
        };
        await tcp.connect(tcpconnectoptions, (connectErr: BusinessError) => {
          if (connectErr) {
            tcp.close((closeErr: BusinessError) => {
              if (!closeErr) {
                tcp.getSocketFd().then((data: number) => {
                  if (data == undefined) {
                    console.info(`${caseName} success`);
                    expect(data).assertUndefined();
                  } else {
                    expect().assertFail();
                  }
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                  expect().assertFail();
                }).finally(() => {
                  if (tcp) {
                    tcp.close();
                  }
                  done();
                })
              }
            });
          }
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1200
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1200
     * @tc.desc Get TCPSocket status,after bind and connect; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1200';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
          done();
        });
        try {
          tcp.getSocketFd((err: BusinessError, data: number) => {
            console.info(`${caseName} success`);
            expect(err == null).assertTrue();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1300
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1300
     * @tc.desc Get TCPSocket status,after bind and connect; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1300';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        await tcp.bind(bindAddr)
        let netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
        }
        let tcpconnectoptions: socket.TCPConnectOptions = {
          address: netAddress,
          timeout: 6000
        }
        await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
          console.error('fail to connect' + err.code.toString());
          done();
        });
        tcp.getSocketFd().then((data: number) => {
          console.info(`${caseName} success`);
          expect(data != null).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          if (tcp) {
            tcp.close();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1400
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1400
     * @tc.desc Get TCPSocket status,after listen and connect; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1400';
        try {
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort(),
            family: 1
          };
          await tcpServer.listen(listenAddress);
          let tcpconnectoptions: socket.TCPConnectOptions = {
            address: listenAddress,
          };
          await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
            console.error('fail to connect' + err.code.toString());
            done();
          });
          try {
            tcp.getSocketFd((err: BusinessError, data: number) => {
              console.info(`${caseName} success`);
              expect(err == null).assertTrue();
            })
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          } finally {
            if (tcp) {
              tcp.close();
            }
            done();
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1500
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1500
     * @tc.desc Get TCPSocket status,after listen and connect; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1500';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: getNextPort(),
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress);
          let tcpconnectoptions: socket.TCPConnectOptions = {
            address: listenAddress,
          };
          await tcp.connect(tcpconnectoptions).catch((err: BusinessError) => {
            console.error('fail to connect' + err.code.toString());
          });
          await tcp.getSocketFd().then((data: number) => {
            console.info(`${caseName} success`);
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetLocalAddress_0100
     * @tc.name ArKUIX_TCPSocket_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetLocalAddress_0100';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort(),
          family: 1
        }
        await tcp.bind(bindAddr).then(() => {
          tcp.getLocalAddress().then((localAddress: socket.NetAddress) => {
            console.info(`${caseName} success`);
            expect(localAddress != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          if (tcp) {
            tcp.close();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocket_GetLocalAddress_0200
     * @tc.name ArKUIX_TCPSocket_GetLocalAddress_0200
     * @tc.desc Test the invalid file descriptor of getLocalAddress
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetLocalAddress_0200';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
          family: 1,
          port: getNextPort(),
        }
        await tcp.bind(bindAddr).then(() => {
          tcp.close().then(() => {
            tcp.getLocalAddress().then((localAddress: socket.NetAddress) => {
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === SocketErrorCodes.ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
            });
          });
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          if (tcp) {
            tcp.close();
          }
          done();
        })
      })
  })
}