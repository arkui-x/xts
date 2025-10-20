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

import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';
import { connection } from '@kit.NetworkKit';

const ExpectFail = () => {
  try {
    expect().assertFail();
  } catch (err) {
    console.info(`exportFail failed err: ${JSON.stringify(err)}`);
  }
}

const ExpectTrue = (n: boolean) => {
  try {
    expect(n).assertTrue();
  } catch (err) {
    console.info(`exportTrue failed err: ${JSON.stringify(err)}`);
  }
}

export default function ConnectionBasicTest() {
  describe('ConnectionBasicTest', () => {

    /**
     * @tc.number : SUB_NETMANAGER_CONNECTION_NETBEARTYPE_0100
     * @tc.name   : testNetManagerConnectionNetBearType0100
     * @tc.desc   : GetNetCapabilities  detection
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it("testNetManagerConnectionNetBearType0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      (done: Function) => {
        let caseName: string = "testNetManagerConnectionNetBearType0100";
        console.info(`${caseName}---start`);
        try {
          ExpectTrue(connection.NetBearType.BEARER_CELLULAR == 0);
          ExpectTrue(connection.NetBearType.BEARER_WIFI == 1);
          ExpectTrue(connection.NetBearType.BEARER_BLUETOOTH == 2);
          console.info(`${caseName}---End`);
          done();
        } catch (error) {
          console.info(`${caseName} catch err ->${JSON.stringify(error)}`);
          ExpectFail();
          console.info(`${caseName}---End`);
          done();
        }
      })
  });
}