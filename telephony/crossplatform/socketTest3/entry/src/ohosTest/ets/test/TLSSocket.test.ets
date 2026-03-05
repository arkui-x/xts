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
import { serverKey, serverCert, serverCa, getNextPort, PortManager, netAddress, sleep } from './public_util'

const tlsSecureConfig: socket.TLSSecureOptions = {
  key: serverKey,
  cert: serverCert,
  ca: [serverCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
};

const tlsConnectOptions: socket.TLSConnectOptions = {
  address: netAddress,
  secureOptions: tlsSecureConfig,
  ALPNProtocols: ["spdy/1", "http/1.1"],
};

export default function TLSSocketTest() {
  describe('TLSSocketTest', () => {
    beforeEach(async () => {
      await sleep(1000);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TLSSocket_GetLocalAddress_0100
     * @tc.name ArKUIX_TLSSocket_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocket_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocket_GetLocalAddress_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await new Promise<void>((resolve, reject) => {
            tlsServer!.listen(tlsConnectOptions, (err: BusinessError) => {
              if (err) {
                reject(new Error(`${caseName} listen fail: ${err.code} - ${err.message}`));
                return;
              }
              console.info(`${caseName} TLSServer listen success: ${netAddress.port}`);
              resolve();
            });
          });

          await new Promise<void>((resolve, reject) => {
            try {
              tlsClient!.bind({ address: '0.0.0.0', port: getNextPort() }, (err: BusinessError) => {
                if (err) {
                  reject(new Error(`${caseName} bind err: ${err.code} - ${err.message}`));
                  return;
                }
                console.info(`${caseName} bind success`);
                resolve();
              });
            } catch (err) {
              reject(new Error(`${caseName} bind err: ${err.code} - ${err.message}`));
              done();
            }
          });

          await tlsClient.getLocalAddress().then((localAddress: socket.NetAddress) => {
            expect(localAddress != null).assertTrue();
            console.info(`${caseName} getLocalAddress success, address: ${JSON.stringify(localAddress)}`);
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          })
          done();
        } catch (error) {
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          if (tlsClient) {
            await tlsClient.close();
          }
          if (tlsServer) {
            await tlsServer.close();
          }
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocket_GetSocketFd_0100
     * @tc.name ArKUIX_TLSSocket_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocket_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocket_GetSocketFd_0100';
        let tls: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: getNextPort()
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tls.bind(netAddress).then(() => {
                console.info(`${caseName} bind success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} bind fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tls.getSocketFd().then((data: number) => {
                  console.info(`${caseName} getSocketFd success: ${JSON.stringify(data)}`);
                  expect(data != null).assertTrue();
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} getSocketFd fail: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${err.code} - ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tls.close();
          done();
        }
      });
  })
}