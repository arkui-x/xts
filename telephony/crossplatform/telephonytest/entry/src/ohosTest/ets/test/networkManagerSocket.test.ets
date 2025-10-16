/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License')
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, it, expect, beforeAll, afterAll, Level, Size, TestType } from '@ohos/hypium';
import socket from '@ohos.net.socket';
import { BusinessError } from '@ohos.base';

export default function networkManagerSocketTest() {

  describe("Telephony_NetworkManager_SocketTest", () => {
    beforeAll(async () => {
      console.log('Telephony_NetworkManager_ActsNetworkManagerSocketTest beforeAll start');
      console.log('Telephony_NetworkManager_ActsNetworkManagerSocketTest beforeAll end');
    });
    afterAll(async () => {
      console.log('Telephony_NetworkManager_ActsNetworkManagerSocketTest afterAll start');
      console.log('Telephony_NetworkManager_ActsNetworkManagerSocketTest afterAll end');
    });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_ON_MESSAGE_0100
     * @tc.name   : testTelephonyTLSSocketonmessage0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketonmessage0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          tls.on('message', value => {
            console.log('message: ' + JSON.stringify(value.message));
            console.log('remoteInfo: ' + JSON.stringify(value.remoteInfo));
          });
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_OFF_MESSAGE_0100
     * @tc.name   : testTelephonyTLSSocketOffMessage0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketOffMessage0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          tls.on('message', value => {
            console.log('message: ' + JSON.stringify(value.message));
            console.log('remoteInfo: ' + JSON.stringify(value.remoteInfo));
          });
          tls.off('message', value => {
            console.log('message: ' + JSON.stringify(value.message));
            console.log('remoteInfo: ' + JSON.stringify(value.remoteInfo));
          })
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_ON_CONNECT_ON_CLOSE_0100
     * @tc.name   : testTelephonyTLSSocketOnConnectOnClose0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketOnConnectOnClose0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          tls.on('connect', () => {
            console.log("on connect success");
          });
          tls.on('close', () => {
            console.log("on close success");
          });
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_OFF_CONNECT_OFF_CLOSE_0100
     * @tc.name   : testTelephonyTLSSocketOffConnectOffClose0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketOffConnectOffClose0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          let callback1 = () => {
            console.log("on connect success");
          };
          tls.on('connect', callback1);
          tls.off('connect', callback1);
          tls.off('connect');
          let callback2 = () => {
            console.log("on close success");
          };
          tls.on('close', callback2);
          tls.off('close', callback2);
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_ON_ERROR_0100
     * @tc.name   : testTelephonyTLSSocketOn_error_0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketOn_error_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          tls.on('error', err => {
            console.log("on error, err:" + JSON.stringify(err));
          });
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });

    /**
     * @tc.number : TELEPHONY_TLSSOCKET_OFF_ERROR_0100
     * @tc.name   : testTelephonyTLSSocketOffError0100
     * @tc.desc   : Function test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testTelephonyTLSSocketOffError0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          let tls = socket.constructTLSSocketInstance();
          let callback = (err: BusinessError) => {
            console.log("on error, err:" + JSON.stringify(err));
          };
          tls.on('error', callback);
          tls.off('error', callback);
          done();
        } catch (err) {
          expect(true).assertFalse();
          done();
        }
      });
  })
}