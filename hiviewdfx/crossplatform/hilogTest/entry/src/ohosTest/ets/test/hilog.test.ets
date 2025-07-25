/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import hilog from "@ohos.hilog";

function wait(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HilogJsTest() {
  describe("HilogJsTest", async () => {
    beforeAll(() => {
      console.info("beforeAll called");
    });
    beforeEach(async () => {
      console.info("beforeEach called");
      await wait(500);
    });
    afterAll(async () => {
      console.info("afterAll called");
      await wait(2000);
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_001
     * @tc.name  : testHilogDebug001
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug001 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}s", "hilogJs1800");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug001 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug001 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_002
     * @tc.name  : testHilogDebug002
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug002 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}d", 2.1);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug002 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug002 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_003
     * @tc.name  : testHilogDebug003
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug003 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}d", 65535);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug003 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug003 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_004
     * @tc.name  : testHilogDebug004
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug004 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}s", "hilog info");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug004 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug004 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_005
     * @tc.name  : testHilogDebug005
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug005 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}d", 2147483647);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug005 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug005 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_006
     * @tc.name  : testHilogDebug006
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug006 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}s", "100%s%d%x%f");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug006 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug006 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_007
     * @tc.name  : testHilogDebug007
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug007 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}s", "65536");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug007 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug007 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_008
     * @tc.name  : testHilogDebug008
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug008 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "username:%{public}s, password:%{private}s.", "username", "password");
        expect(true).assertTrue();
        hilog.debug(0x3200, "HILOGTEST", "username:%{public}s, password:%s.", "username123", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug008 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug008 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_009
     * @tc.name  : testHilogDebug009
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug009 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{public}s", "hilog public");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug009 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug009 end");
    });

    /**
     * @tc.number: TEST_HILOG_DEBUG_010
     * @tc.name  : testHilogDebug010
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogDebug010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogDebug010 start");
      try {
        hilog.debug(0x3200, "HILOGTEST", "%{nopublic}s", "Hilogtest");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogDebug010 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogDebug010 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_001
     * @tc.name  : testHilogInfo001
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo001 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "%{public}s", "hilogJs0400");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo001 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo001 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_002
     * @tc.name  : testHilogInfo002
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo002 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "username:%{public}s, password:%{private}s.", "username", "password");
        expect(true).assertTrue();
        hilog.info(0x3200, "HILOGTEST", "username:%{public}s, password:%s.", "username123", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo002 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo002 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_003
     * @tc.name  : testHilogInfo003
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo003 start");
      try {
        hilog.info(0xffff, "HILOGTEST", "username:%{public}s, password:%{public}s.", "username", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo003 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo003 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_004
     * @tc.name  : testHilogInfo004
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo004 start");
      try {
        hilog.info(0xfffe, "HILOGTEST", "username:%{public}s, password:%{public}s.", "username", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo004 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo004 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_005
     * @tc.name  : testHilogInfo005
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo005 start");
      try {
        hilog.info(0xfffff, "HILOGTEST", "username:%{public}s, password:%{public}s.", "username", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo005 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo005 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_006
     * @tc.name  : testHilogInfo006
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo006 start");
      try {
        hilog.info(0xffffe, "HILOGTEST", "username:%{public}s, password:%{public}s.", "username", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo006 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo006 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_007
     * @tc.name  : testHilogInfo007
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo007 start");
      try {
        hilog.info(100, "HILOGTEST", "username:%{public}s, password:%{public}s.", "username", "password");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo007 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo007 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_009
     * @tc.name  : testHilogInfo009
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo008 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "username:%{public}s.", null);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo008 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo008 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_009
     * @tc.name  : testHilogInfo009
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo009 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "username:%{public}s.", undefined);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo009 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo009 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_010
     * @tc.name  : testHilogInfo010
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo010 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "MAX Number:%{public}d, MIN Number:%{public}d", Number.MAX_VALUE,
          Number.MIN_VALUE);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo010 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo010 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_011
     * @tc.name  : testHilogInfo011
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo011 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "中文测试:%{public}s, 混合打印:%{public}s", "中文打印测试",
          "for中文test,.;:*_-=^(%)?#$/|\\");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo011 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo011 end");
    });

    /**
     * @tc.number: TEST_HILOG_INFO_012
     * @tc.name  : testHilogInfo012
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogInfo012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogInfo012 start");
      try {
        hilog.info(0x3200, "HILOGTEST", "boolean1:%{public}s, boolean2:%{public}s", true, false);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogInfo012 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogInfo012 end");
    });

    /**
     * @tc.number: TEST_HILOG_WARN_001
     * @tc.name  : testHilogWarn001
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogWarn001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogWarn001 start");
      try {
        hilog.warn(0x3200, "HILOGTEST", "%{public}s", "hilogJs0500");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogWarn001 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogWarn001 end");
    });

    /**
     * @tc.number: TEST_HILOG_ERROR_001
     * @tc.name  : testHilogError001
     * @tc.desc  : hilog begin interface test.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogError001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogError001 start");
      try {
        hilog.error(0x3200, "HILOGTEST", "%{public}s", "hilogJs0200");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogError001 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogError001 end");
    });

    /**
     * @tc.number: TEST_HILOG_ERROR_002
     * @tc.name  : testHilogError002
     * @tc.desc  :The log tool can read valid app log types when domain on.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogError002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogError002 start");
      try {
        hilog.error(0xffff, "HILOGTEST", "%{public}s", ["hilogJs0100"]);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogError002 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogError002 end");
    });

    /**
     * @tc.number: TEST_HILOG_ERROR_003
     * @tc.name  : testHilogError003
     * @tc.desc  : The log tool can't read white app log types when domain on.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogError003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogError003 start");
      try {
        hilog.error(0xd003200, "HILOGTEST", "%{public}s", ["hilogJs0200"]);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogError003 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogError003 end");
    });
    
    /**
     * @tc.number: TEST_HILOG_ERROR_004
     * @tc.name  : testHilogError004
     * @tc.desc  : The log tool can read valid app log types when domain off.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogError004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogError004 start");
      try {
        hilog.error(0xffff, "HILOGTEST", "%{public}s", ["hilogJs0100"]);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogError004 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogError004 end");
    });

    /**
     * @tc.number: TEST_HILOG_ERROR_005
     * @tc.name  : testHilogError005
     * @tc.desc  : The log tool can read white app log types when domain off.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogError005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogError005 start");
      try {
        hilog.error(0xd003200, "HILOGTEST", "%{public}s", ["hilogJs0200"]);
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogError005 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogError005 end");
    });

    /**
     * @tc.number: TEST_HILOG_FATAL_001
     * @tc.name  : testHilogFatal001
     * @tc.desc  : Print FATAL level logs
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testHilogFatal001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info("testHilogFatal001 start");
      try {
        hilog.fatal(0x3200, "HILOGTEST", "%{public}s", "hilogJs0300");
        expect(true).assertTrue();
      } catch (error) {
        console.log(`testHilogFatal001 got an error: ${JSON.stringify(error)}`);
        expect().assertFail();
      }
      console.info("testHilogFatal001 end");
    });
  });
}
