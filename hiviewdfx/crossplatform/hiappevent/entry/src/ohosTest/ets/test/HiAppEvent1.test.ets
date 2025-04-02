/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { describe, beforeEach, it, expect, Level } from '@ohos/hypium'
import { hiAppEvent } from '@kit.PerformanceAnalysisKit'

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HiAppEvent1() {
  describe('HiAppEvent1Test', () => {
    beforeEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0100
     * @tc.name testHiAppEventsetUserIdgetUserId0100
     * @tc.desc Verify that setUserId, userid name and value are valid, and getUserId obtains the userid value
     *          consistent with the setting
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId0100', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("Abc123_$", "value");
        let userIdValue: string = hiAppEvent.getUserId("Abc123_$");
        expect(userIdValue == "value").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0100 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0200
     * @tc.name testHiAppEventsetUserIdgetUserId0200
     * @tc.desc Verify setUserId with name as the outlier 123456Abc
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0200', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId("123456Abc", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0200 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0300
     * @tc.name testHiAppEventsetUserIdgetUserId0300
     * @tc.desc Verify setUserId with name as the outlier Abc!@#$
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0300', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId("Abc!@#$", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0300 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0400
     * @tc.name testHiAppEventsetUserIdgetUserId0400
     * @tc.desc Verify setUserId with name as the outlier ""
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0400', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId("", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0400 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0500
     * @tc.name testHiAppEventsetUserIdgetUserId0500
     * @tc.desc Verify setUserId with name as the outlier undefined
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0500', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId(undefined, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0500 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0600
     * @tc.name testHiAppEventsetUserIdgetUserId0600
     * @tc.desc Verify setUserId with name as the outlier null
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0600', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId(null, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0600 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0700
     * @tc.name testHiAppEventsetUserIdgetUserId0700
     * @tc.desc Verify setUserId with name as a long string (256 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId0700', Level.LEVEL0, async (done: Function) => {
      try {
        let strlong: string = '';
        for (let i = 0; i < 256; i++) {
          strlong += 'a';
        }
        hiAppEvent.setUserId(strlong, "value");
        let userIdValue: string = hiAppEvent.getUserId(strlong);
        expect(userIdValue == "value").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0700 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0800
     * @tc.name testHiAppEventsetUserIdgetUserId0800
     * @tc.desc Verify that setUserId, parameter name is a very long string (more than 256 characters)
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId0800', Level.LEVEL2, async (done: Function) => {
      try {
        let overstr: string = '';
        for (let i = 0; i < 258; i++) {
          overstr += 'a';
        }
        hiAppEvent.setUserId(overstr, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0800 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_0900
     * @tc.name testHiAppEventsetUserIdgetUserId0900
     * @tc.desc Verify that setUserId, the test parameter value is the normal value "Abc123!@#$"
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId0900', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "Abc123!@#$");
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "Abc123!@#$").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId0900 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1000
     * @tc.name testHiAppEventsetUserIdgetUserId1000
     * @tc.desc Verify that setUserId, the test parameter value is the normal value "123456"
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1000', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "123456");
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "123456").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1000 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1100
     * @tc.name testHiAppEventsetUserIdgetUserId1100
     * @tc.desc Verify that setUserId, test parameter value is a string of normal length (256 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1100', Level.LEVEL0, async (done: Function) => {
      try {
        let strlong: string = '';
        for (let i = 0; i < 256; i++) {
          strlong += 'a';
        }
        hiAppEvent.setUserId("key", strlong);
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == strlong).assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1100 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1200
     * @tc.name testHiAppEventsetUserIdgetUserId1200
     * @tc.desc Verify setUserId, test parameter value is an outlier Very long string (more than 256 bits)
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId1200', Level.LEVEL2, async (done: Function) => {
      try {
        let strlong: string = '';
        for (let i = 0; i < 257; i++) {
          strlong += 'a';
        }
        hiAppEvent.setUserId("key", strlong);
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1200 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1300
     * @tc.name testHiAppEventsetUserIdgetUserId1300
     * @tc.desc Verify that setUserId, the test parameter value is a normal value ""
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1300', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "");
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1300 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1400
     * @tc.name testHiAppEventsetUserIdgetUserId1400
     * @tc.desc Verify that setUserId, the test parameter value is null as normal
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1400', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", null);
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1400 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1500
     * @tc.name testHiAppEventsetUserIdgetUserId1500
     * @tc.desc Verify that setUserId is continuously called with the same name to set different values
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1500', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "value1");
        hiAppEvent.setUserId("key", "value2");
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "value2").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1500 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1600
     * @tc.name testHiAppEventsetUserIdgetUserId1600
     * @tc.desc Verify that setUserId calls the same name The second call setUserId sets value to an empty string
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1600', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "value1");
        hiAppEvent.setUserId("key", "");
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1600 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1700
     * @tc.name testHiAppEventsetUserIdgetUserId1700
     * @tc.desc Verify that setUserId calls the same name The second call setUserId sets value to null
     * @tc.level Level0
     */
    it('testHiAppEventsetUserIdgetUserId1700', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", "value1");
        hiAppEvent.setUserId("key", null);
        let userIdValue: string = hiAppEvent.getUserId("key");
        expect(userIdValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1700 > error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserId_getUserId_1800
     * @tc.name testHiAppEventsetUserIdgetUserId1800
     * @tc.desc Verify setUserId with the test parameter name as "key" and value as undefined
     * @tc.level Level2
     */
    it('testHiAppEventsetUserIdgetUserId1800', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserId("key", undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserIdgetUserId1800 > error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0100
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0100
     * @tc.desc Verify that the setUserProperty test parameter name is the normal value "Abc123_$"
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty0100', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("Abc123_$", "value");
        let userPropertyValue = hiAppEvent.getUserProperty("Abc123_$");
        expect(userPropertyValue == "value").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0100 > error code: ${err.code},
          error msg: ${err.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0200
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0200
     * @tc.desc Verify setUserProperty with the test parameter name as the outlier "123456Abc"
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0200', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("123456Abc", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0200 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0300
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0300
     * @tc.desc Verify setUserProperty with the test parameter name as the outlier "Abc!@#$"
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0300', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("Abc!@#$", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0300 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0400
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0400
     * @tc.desc Verify setUserProperty with the test parameter name as the outlier ""
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0400', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("", "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0400 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0500
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0500
     * @tc.desc Verify setUserProperty with the test parameter name as the outlier null
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0500', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty(null, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0500 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0600
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0600
     * @tc.desc Verify setUserProperty with the test parameter name as the outlier undefined
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0600', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty(undefined, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0600 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0700
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0700
     * @tc.desc Verify that the setUserProperty test parameter name is a string of normal length (256 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty0700', Level.LEVEL0, async (done: Function) => {
      try {
        let strlong: string = '';
        for (let i = 0; i < 256; i++) {
          strlong += 'a';
        }
        hiAppEvent.setUserProperty(strlong, "value");
        let userPropertyValue = hiAppEvent.getUserProperty(strlong);
        expect(userPropertyValue == "value").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0700 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0800
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0800
     * @tc.desc Verify setUserProperty, test parameter name as an outlier Very long string (more than 256 bits)
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty0800', Level.LEVEL2, async (done: Function) => {
      try {
        let overstr: string = '';
        for (let i = 0; i < 258; i++) {
          overstr += 'a';
        }
        hiAppEvent.setUserProperty(overstr, "value");
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0800 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_0900
     * @tc.name testHiAppEventsetUserPropertygetUserProperty0900
     * @tc.desc Verify that setUserProperty, test parameter value is normal "Abc123!@#$"
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty0900', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "Abc123!@#$");
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "Abc123!@#$").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty0900 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1000
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1000
     * @tc.desc Verify that setUserProperty, test parameter value is normal "123456"
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1000', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "123456");
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "123456").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1000 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1100
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1100
     * @tc.desc Verify that setUserProperty, test parameter value is a string of normal length (1024 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1100', Level.LEVEL0, async (done: Function) => {
      try {
        let strlong: string = '';
        for (let i = 0; i < 1024; i++) {
          strlong += 'a';
        }
        hiAppEvent.setUserProperty("name", strlong)
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == strlong).assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1100 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1200
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1200
     * @tc.desc Verify setUserProperty, test parameter value as outlier Extra-long string (more than 1024 bits)
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty1200', Level.LEVEL2, async (done: Function) => {
      try {
        let overstr: string = '';
        for (let i = 0; i < 1025; i++) {
          overstr += 'a';
        }
        hiAppEvent.setUserProperty("name", overstr);
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1200 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1300
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1300
     * @tc.desc Verify that setUserProperty, the test parameter value is normal ""
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1300', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "");
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1300 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1400
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1400
     * @tc.desc Verify that setUserProperty, the test parameter value is normal null
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1400', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", null);
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1400 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1500
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1500
     * @tc.desc Verify setUserProperty, testing the value of the parameter as the outlier undefined
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty1500', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1500 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1600
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1600
     * @tc.desc Verify that setUserId is invoked twice in a row, setting the same name but different value
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1600', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "value1");
        hiAppEvent.setUserProperty("name", "value2");
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "value2").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1600 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1700
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1700
     * @tc.desc Verify that setUserId is invoked twice in a row, setting the same name but different value
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1700', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "value1");
        hiAppEvent.setUserProperty("name", null);
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1700 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1800
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1800
     * @tc.desc Verify that setUserId is invoked twice in a row, setting the same name but different value
     * @tc.level Level0
     */
    it('testHiAppEventsetUserPropertygetUserProperty1800', Level.LEVEL0, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "value1");
        hiAppEvent.setUserProperty("name", "");
        let userPropertyValue = hiAppEvent.getUserProperty("name");
        expect(userPropertyValue == "").assertTrue();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1800 > error code: ${err.code},
          error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setUserProperty_getUserProperty_1900
     * @tc.name testHiAppEventsetUserPropertygetUserProperty1900
     * @tc.desc Verify that setUserId is invoked twice in a row, setting the same name but different value
     * @tc.level Level2
     */
    it('testHiAppEventsetUserPropertygetUserProperty1900', Level.LEVEL2, async (done: Function) => {
      try {
        hiAppEvent.setUserProperty("name", "value1");
        hiAppEvent.setUserProperty("name", undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`testHiAppEventsetUserPropertygetUserProperty1900 > error code: ${err.code},
          error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })
  })
}