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

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function MulticastSocketTest() {
  describe('MulticastSocketTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_MulticastSocket_GetSocketFd_0100
     * @tc.name ArKUIX_MulticastSocket_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_MulticastSocket_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_MulticastSocket_GetSocketFd_0100';
        let multicastSocket: socket.MulticastSocket | null = null;
        try {
          multicastSocket = socket.constructMulticastSocketInstance();
          if (!multicastSocket) {
            expect().assertFail();
          }
          await multicastSocket.bind({
            address: '127.0.0.1',
            port: 0,
            family: 1
          });
          const fd1: number = await multicastSocket.getSocketFd();
          const fd2: number = await multicastSocket.getSocketFd();
          const fd3: number = await multicastSocket.getSocketFd();

          let fd: boolean = false;
          if (typeof fd1 === 'number' && fd1 >= 0) {
            if (fd1 === fd2 && fd2 === fd3) {
              fd = true;
              expect(fd).assertTrue();
            } else {
              expect().assertFail();
            }
          } else {
            expect().assertFail();
          }
        } catch (err) {
          const error = err as BusinessError;
          console.info(`fail: ${error.code} - ${error.message}`);
        } finally {
          if (multicastSocket) {
            await multicastSocket.close();
          }
        }
        done();
      })

  })
}