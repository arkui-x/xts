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

import { describe, it, expect, Level, TestType, Size, beforeEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';

let platform: string = deviceInfo.osFullName.split(' ')[0];

const ERR_CODE_PERMISSION_ERROR = 201;

const tlsSecureConfig: socket.TLSSecureOptions = {
  key: `-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAnoncKS+sTY/GjMRQ86LG4/3PbGIxOLUDZFMttzK73wK+hMj6
op/KVJkVl1h3d/vaNReZfPm0PQDdWjXmMw+t6MYgtDmk2WZLvmqfUOizYFpaK9+0
2PMbAcbxwC3g6yrQ8duX2u5gHSm4FmszEf/RDID0/sLFI3kW9s9JhKqwgQUuVsIv
gfDY+wlWY0hRSm2A+XSro8cf8BjdYBcnuTM5RsoMFhAc685nqFffCpktH3iAmVfK
KDd6Sz6+Fko/vdbPDsD1Hf7A0aoO51ZwGUSkjGEhKzJxeIoVNIvBnJZ1eD/lEHSy
Ce6Yot8L7/UCA35j17vm6KzIC5OLiCSB4w/cXwIDAQABAoIBABkOhONli3/+t0zM
QlcfZPvnw37Hziu+QDj9BH6t4A+RKXdnJGXLh3jzcPwomUk3XveBMVsVRC1YE6QM
XMO5OK1Pkx+o9Kr/hf0kcOWiwab64MGKa9TWJ3CSdub+2UuRytBO+qM5hatWSqgQ
bVPs8KdfQll5gxrmKoD7pgz3xUm+vi0tkSE38o0UYEaW1AE8f+dasl/3gBYCgcup
ebKWEGd5s9ijd8Fx4EhY87qV29ijKz28z0L65Qw/C4+ywcOEHEICDvxjxkiz665d
vIbyQk6PIxGTh2jiqs0PU5b3yevo5SR6Rp92wTydGnkscT6CK23Vbz9jp7JBXqre
a+XnBnECgYEAzz3m1h6J4/8Zp0BU79rO+M2MAVMXisASH2wrPR2jjYeEeBU1FJAg
OBlfpPZoByW8pWrkAR8HKKtLaq6Lm2vwGpMYzdYg7lwGXI2h9oueCl6U4fGT7z/Z
hsQvApka3MqAZnIcF1S1YS4KfugzPhlGPbD3m2ezXXzzHVMrOhGk3eMCgYEAw9aT
t4ilZKvisyp8fF+9WSq1Kl93+OabiERpiO6C5LPNIg7P2gTwbeJ5+tHEigKn1wHE
FcHOsXEv4f5Z6oEcPmQSG439SujbS9/GTA98KPaMZGEMw3WWBSDGtXdc7XWTLdC6
5OjLdr4tM8CN87DLs0ZuKRRzx3Bl+yCINtr8EFUCgYAPMCcxvA05A2Ia6tEOvwd6
Hn5LPo60IX1yhhfpI7nvzmW78znvptxloB5tVY2sMGzR5rKNDnwU0/D0AZTDsDZp
jCw+MZo6Pc5NjCe5jOPpOKNKp8zCtPg5MzmKxDO+yKx+VZCPeSrN03T7dgMDYxDN
xqFu5zuy90xN8uFxIQfnJwKBgQCqbfD7xlV5eQS/O3g+nOsh0EL9bzvvRnGQc0kM
u9T5x2f7/bvxVl8OogvZtfg+yvTZ7lWBQbrpPUGYgUwrAtVbjqcbh8QpDuDZ9RKT
Wt6In5eqO7Np3skCCXYkso4SsUG2m3IqiFWZLwQTh72BmBiOGfsAkSX5KN33YGZq
psS6SQKBgAG6c+xTACeh8p7gNFnc6ggqXutVkfvLhBjtpkcvG7rOpKuy5Q+efEoB
aUr8muQ7IKQ0XEg57GKy/E3ySFeOhMyhw4/dF1Scx2nm8/XzuDr7onUY4/uzAUiJ
bNe8gZRkSz8wvWyV04HOCcfTwz9cAfZ/n/k6X0OwpvYRHh9HtMql
-----END RSA PRIVATE KEY-----`,
  cert: `-----BEGIN CERTIFICATE-----
MIICrzCCAZcCFAm/T+dPts7MtyE0zTcLwQ9dejlAMA0GCSqGSIb3DQEBCwUAMBQx
EjAQBgNVBAMMCWxvY2FsaG9zdDAeFw0yNTEwMzEwOTQyNTFaFw0yNjEwMzEwOTQy
NTFaMBQxEjAQBgNVBAMMCWxvY2FsaG9zdDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAJ6J3CkvrE2PxozEUPOixuP9z2xiMTi1A2RTLbcyu98CvoTI+qKf
ylSZFZdYd3f72jUXmXz5tD0A3Vo15jMPrejGILQ5pNlmS75qn1Dos2BaWivftNjz
GwHG8cAt4Osq0PHbl9ruYB0puBZrMxH/0QyA9P7CxSN5FvbPSYSqsIEFLlbCL4Hw
2PsJVmNIUUptgPl0q6PHH/AY3WAXJ7kzOUbKDBYQHOvOZ6hX3wqZLR94gJlXyig3
eks+vhZKP73Wzw7A9R3+wNGqDudWcBlEpIxhISsycXiKFTSLwZyWdXg/5RB0sgnu
mKLfC+/1AgN+Y9e75uisyAuTi4gkgeMP3F8CAwEAATANBgkqhkiG9w0BAQsFAAOC
AQEAB42BI8v2TkKObx2pdceI4K3h7c69ahUvyYq2HKSzP39cvtDw2BM0NDsKzs2g
2uKn1w9VreIHg3e811SCteIq18yr3Zrj5eCHX6601zJlsAtbpku4vdciyEv+o9uD
iYTtD/9Z6u/yDiwpJgaU5HrDRC7O/0TipQfuQwxxN+An11UOd81P+bvj+DKoDs3F
E6E2M4vQY33S78RF7P4EZVlrcW3JhcW23l+lAbqcSfL1/X+QYQfGL0Lp3BLOCtBL
y/Hp0zgI2Zq1+paupseHHBjTiORJzEUIQvQyI357pTA+lT5b0Bw7VsBpxYH7vpk9
mSNTffduRuD5KUKprT8t3Nw4FQ==
-----END CERTIFICATE-----`,
  ca: [`-----BEGIN CERTIFICATE-----
MIICrzCCAZcCFAm/T+dPts7MtyE0zTcLwQ9dejlAMA0GCSqGSIb3DQEBCwUAMBQx
EjAQBgNVBAMMCWxvY2FsaG9zdDAeFw0yNTEwMzEwOTQyNTFaFw0yNjEwMzEwOTQy
NTFaMBQxEjAQBgNVBAMMCWxvY2FsaG9zdDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAJ6J3CkvrE2PxozEUPOixuP9z2xiMTi1A2RTLbcyu98CvoTI+qKf
ylSZFZdYd3f72jUXmXz5tD0A3Vo15jMPrejGILQ5pNlmS75qn1Dos2BaWivftNjz
GwHG8cAt4Osq0PHbl9ruYB0puBZrMxH/0QyA9P7CxSN5FvbPSYSqsIEFLlbCL4Hw
2PsJVmNIUUptgPl0q6PHH/AY3WAXJ7kzOUbKDBYQHOvOZ6hX3wqZLR94gJlXyig3
eks+vhZKP73Wzw7A9R3+wNGqDudWcBlEpIxhISsycXiKFTSLwZyWdXg/5RB0sgnu
mKLfC+/1AgN+Y9e75uisyAuTi4gkgeMP3F8CAwEAATANBgkqhkiG9w0BAQsFAAOC
AQEAB42BI8v2TkKObx2pdceI4K3h7c69ahUvyYq2HKSzP39cvtDw2BM0NDsKzs2g
2uKn1w9VreIHg3e811SCteIq18yr3Zrj5eCHX6601zJlsAtbpku4vdciyEv+o9uD
iYTtD/9Z6u/yDiwpJgaU5HrDRC7O/0TipQfuQwxxN+An11UOd81P+bvj+DKoDs3F
E6E2M4vQY33S78RF7P4EZVlrcW3JhcW23l+lAbqcSfL1/X+QYQfGL0Lp3BLOCtBL
y/Hp0zgI2Zq1+paupseHHBjTiORJzEUIQvQyI357pTA+lT5b0Bw7VsBpxYH7vpk9
mSNTffduRuD5KUKprT8t3Nw4FQ==
-----END CERTIFICATE-----`],
  password: "",
  protocols: socket.Protocol.TLSv12,
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256"
};

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok')
    }, time)
  });
}

export default function SocketTest_permission_failed() {
  describe('SocketTest_permission_failed', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1800
     * @tc.name ArKUIX_TCPSocketConnection_Send_1800
     * @tc.desc The test permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        try {
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14017,
            family: 1
          };
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                let tcpSendOption: socket.TCPSendOptions = {
                  data: 'Hello, client!'
                };
                client.send(tcpSendOption, (err: BusinessError) => {
                  if (err) {
                    console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                    expect().assertFail();
                    reject(err);
                  } else {
                    console.info(`${caseName} success`);
                    expect().assertFail();
                    resolve();
                  }
                  tcpServer.off('connect');
                });
              });
              tcp.connect(tcpConnectOptions).then(() => {
                console.info('connect success');
              }).catch((err: BusinessError) => {
                console.info('fail to connect' + err.code.toString());
                reject(err);
              });
            });
          })();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3300
     * @tc.name ArKUIX_TCPSocketConnection_Send_3300
     * @tc.desc The test permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3300';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14032,
          family: 1
        };
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                  let tcpSendOption: socket.TCPSendOptions = {
                    data: 'Hello, client!'
                  };
                  client.send(tcpSendOption).then(() => {
                    console.info(`${caseName} success`);
                    expect().assertFail();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                    expect().assertFail();
                    reject(err);
                  }).finally(() => {
                    tcpServer.off('connect');
                  });
                });
                let tcpConnectOptions: socket.TCPConnectOptions = {
                  address: listenAddress
                };
                tcp.connect(tcpConnectOptions).then(() => {
                  console.info('connect success');
                }).catch((err: BusinessError) => {
                  console.info('fail to connect' + err.code.toString());
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0500
     * @tc.name ArKUIX_TCPSocketConnection_Close_0500
     * @tc.desc The test permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0500';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14040,
          family: 1
        };
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                  client.close((err: BusinessError) => {
                    if (err) {
                      console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                      expect().assertFail();
                      reject(err);
                    } else {
                      console.info(`${caseName} success`);
                      resolve();
                    }
                    tcpServer.off('connect');
                  });
                });
                let tcpConnectOptions: socket.TCPConnectOptions = {
                  address: listenAddress
                };
                tcp.connect(tcpConnectOptions).then(() => {
                  console.info('connect success');
                }).catch((err: BusinessError) => {
                  console.info('fail to connect' + err.code.toString());
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0700
     * @tc.name ArKUIX_TCPSocketConnection_Close_0700
     * @tc.desc The test permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0700';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14042,
          family: 1
        };
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                  client.close().then(() => {
                    console.info(`${caseName} success`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                    reject(err);
                  }).finally(() => {
                    tcpServer.off('connect');
                  });
                });
                let tcpConnectOptions: socket.TCPConnectOptions = {
                  address: listenAddress
                };
                tcp.connect(tcpConnectOptions).then(() => {
                  console.info('connect success');
                }).catch((err: BusinessError) => {
                  console.info('fail to connect' + err.code.toString());
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0500
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0500
     * @tc.desc The test permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0500';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14047,
          family: 1
        };
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                  client.getRemoteAddress((err: BusinessError, data: socket.NetAddress) => {
                    if (err) {
                      console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                      reject(err);
                    } else {
                      console.info(`${caseName} success`);
                      expect().assertFail();
                      done();
                      resolve();
                    }
                    tcpServer.off('connect');
                  });
                });
                let tcpConnectOptions: socket.TCPConnectOptions = {
                  address: listenAddress
                };
                tcp.connect(tcpConnectOptions).then(() => {
                  console.info('connect success');
                }).catch((err: BusinessError) => {
                  console.info('fail to connect' + err.code.toString());
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0700
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0700
     * @tc.desc The test permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0700';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14049,
          family: 1
        };
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
                  client.getRemoteAddress().then((data: socket.NetAddress) => {
                    console.info(`${caseName} success`);
                    expect().assertFail();
                    done();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                    reject(err);
                  });
                });
                let tcpConnectOptions: socket.TCPConnectOptions = {
                  address: listenAddress
                };
                tcp.connect(tcpConnectOptions).then(() => {
                  console.info('connect success');
                }).catch((err: BusinessError) => {
                  console.info('fail to connect' + err.code.toString());
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1100
     * @tc.name ArKUIX_TCPSocketServer_Listen_1100
     * @tc.desc The test permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1100';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        try {
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tcpServer.listen(listenAddr, (err: BusinessError) => {
                if (err) {
                  console.info(`${caseName} failed, error: ${err.message}`);
                  reject(err);
                } else {
                  console.info(`${caseName} listen success`);
                  expect().assertFail();
                  done();
                  resolve();
                }
              });
            });
          })();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}, code: ${error.code}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2000
     * @tc.name ArKUIX_TCPSocketServer_Listen_2000
     * @tc.desc The test permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2000';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Close_0300
     * @tc.name ArKUIX_TCPSocketServer_Close_0300
     * @tc.desc The test permission verification failed.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Close_0300';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          await tcpServer.close();
          console.info(`${caseName} close success`);
          if (platform === 'iOS') {
            expect(true).assertEqual(true);
            done();
          }
          expect().assertFail();
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} close failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Close_0200
     * @tc.name ArKUIX_TLSSocketServer_Close_0200
     * @tc.desc The test permission verification failed
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Close_0200';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        try {
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.close().then(() => {
                console.info(`${caseName} close success`);
                expect().assertFail();
                done();
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} close failed: ${err.code}, ${err.message}`);
                reject(err);
              });
            });
          })();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}, code: ${error.code}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (tlsServer) {
            tlsServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6400
     * @tc.name ArKUIX_TLSSocketServer_Listen_6400
     * @tc.desc The test for permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6400';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions, (err: BusinessError) => {
          if (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          } else {
            expect().assertFail();
          }
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6500
     * @tc.name ArKUIX_TLSSocketServer_Listen_6500
     * @tc.desc The test for permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6500';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8088 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        tlsServer.listen(listenOptions).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1400
     * @tc.desc The test permission verification failed. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1400';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            let tcpExtraOptions: socket.TCPExtraOptions = {
              keepAlive: true,
              OOBInline: true,
              TCPNoDelay: true,
              socketLinger: { on: true, linger: 10 } as SocketLinger,
              receiveBufferSize: 8192,
              sendBufferSize: 8192,
              reuseAddress: true,
              socketTimeout: 3000
            }
            try {
              await tcpServer.setExtraOptions(tcpExtraOptions);
              console.info(`${caseName} setExtraOptions success`);
              expect().assertFail();
              done();
            } catch (err) {
              const error = err as BusinessError;
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
              done();
            }
          })
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          if (tcpServer) {
            tcpServer.close();
          }
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6500
     * @tc.desc The test permission verification failed. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6500';
        if (platform === 'iOS') {
          done();
          return;
        }
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: true,
          TCPNoDelay: true,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: 8192,
          sendBufferSize: 8192,
          reuseAddress: true,
          socketTimeout: 3000
        }
        try {
          tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
              done();
            } else {
              expect().assertFail();
              done();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          if (tcpServer) {
            tcpServer.close();
          }
        }
      });
  })
}