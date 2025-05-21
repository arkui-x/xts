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

import { afterAll, afterEach, beforeAll, describe, expect, it, Level, TestType, Size } from '@ohos/hypium';
import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';

const WAIT_MS_200 = 200;
const WAIT_MS_400 = 400;
const COMMERCIAL = hiTraceMeter.HiTraceOutputLevel.COMMERCIAL;
const overLength_str: string = "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" +
  "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HiTraceMeterTest() {
  describe('HiTraceMeterTest', () => {
    afterAll(async () => {
      await sleep(WAIT_MS_400);
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0100
     * @tc.name ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0100
     * @tc.desc Test the name parameter of HiTraceMeter StartSyncTrace And FinishSyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startSyncTrace(COMMERCIAL, "test startSyncTrace and finishSyncTrace");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "测试同步跟踪接口");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "测试startSyncTrace与finishSyncTrace");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "测试全半角字符:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}" +
          ":“《》？·-=【】、；‘，。、");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "测试同步跟踪接口超长名称: " + overLength_str);
        hiTraceMeter.startSyncTrace(COMMERCIAL, "");
        hiTraceMeter.startSyncTrace(COMMERCIAL, null);
        hiTraceMeter.startSyncTrace(COMMERCIAL, undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0100, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0200
     * @tc.name ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0200
     * @tc.desc Test the level parameter of HiTraceMeter StartSyncTrace And FinishSyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test DEBUG");
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.INFO, "test INFO");
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.CRITICAL, "test CRITICAL");
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test COMMERCIAL");
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.MAX, "test MAX");
        hiTraceMeter.startSyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test parameter format mismatch");
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.INFO);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.CRITICAL);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.MAX);
        hiTraceMeter.finishSyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0200, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0300
     * @tc.name ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0300
     * @tc.desc Test the customArgs parameter of HiTraceMeter StartSyncTrace And FinishSyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startSyncTrace(COMMERCIAL, "test customArgs_normal", "key1=value1,key2=value2");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "test customArgs_empty", "");
        hiTraceMeter.startSyncTrace(COMMERCIAL, "test customArgs_null", null);
        hiTraceMeter.startSyncTrace(COMMERCIAL, "test customArgs_undefined", undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);
        hiTraceMeter.finishSyncTrace(COMMERCIAL);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartSyncTraceAndFinishSyncTrace_0300, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0100
     * @tc.name ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0100
     * @tc.desc Test the name parameter of HiTraceMeter StartTrace And FinishTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startTrace("test startTrace and finishTrace", 1001);
        hiTraceMeter.startTrace("测试异步跟踪接口", 1002);
        hiTraceMeter.startTrace("测试startTrace与finishTrace", 1003);
        hiTraceMeter.startTrace("测试全半角字符:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}:“《》？·-=【】、；" +
          "‘，。、", 1004);
        hiTraceMeter.startTrace("测试异步跟踪接口超长名称: " + overLength_str, 1005);
        hiTraceMeter.startTrace("", 1006);
        hiTraceMeter.startTrace(null, 1007);
        hiTraceMeter.startTrace(undefined, 1008);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishTrace("test startTrace and finishTrace", 1001);
        hiTraceMeter.finishTrace("测试异步跟踪接口", 1002);
        hiTraceMeter.finishTrace("测试startTrace与finishTrace", 1003);
        hiTraceMeter.finishTrace("测试全半角字符:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}:“《》？·-=【】、；" +
          "‘，。、", 1004);
        hiTraceMeter.finishTrace("测试异步跟踪接口超长名称: " + overLength_str, 1005);
        hiTraceMeter.finishTrace("", 1006);
        hiTraceMeter.finishTrace(null, 1007);
        hiTraceMeter.finishTrace(undefined, 1008);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0100, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0200
     * @tc.name ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0200
     * @tc.desc Test the id parameter of HiTraceMeter StartTrace And FinishTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startTrace("测试异步跟踪接口: 传入小数", 3.14);
        hiTraceMeter.startTrace("测试异步跟踪接口: 数字传入null", null);
        hiTraceMeter.startTrace("测试异步跟踪接口: 数字传入undefined", undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishTrace("测试异步跟踪接口: 传入小数", 3.14);
        hiTraceMeter.finishTrace("测试异步跟踪接口: 数字传入null", null);
        hiTraceMeter.finishTrace("测试异步跟踪接口: 数字传入undefined", undefined);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartTraceAndFinishTrace_0200, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0100
     * @tc.name ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0100
     * @tc.desc Test the name parameter of HiTraceMeter StartAsyncTrace And FinishAsyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0100', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL1, async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test startAsyncTrace and finishAsyncTrace", 2001, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试异步跟踪接口", 2002, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试startAsyncTrace与finishAsyncTrace", 2003, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试全半角字符:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}" +
          ":“《》？·-=【】、；‘，。、", 2004, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试异步跟踪接口超长名称: " + overLength_str, 2005, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "", 2006, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, null, 2007, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, undefined, 2008, "");
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test startAsyncTrace and finishAsyncTrace", 2001);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试异步跟踪接口", 2002);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试startAsyncTrace与finishAsyncTrace", 2003);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试全半角字符:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}" +
          ":“《》？·-=【】、；‘，。、", 2004);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试异步跟踪接口超长名称: " + overLength_str, 2005);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "", 2006);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, null, 2007);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, undefined, 2008);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0100, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0200
     * @tc.name ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0200
     * @tc.desc Test the id parameter of HiTraceMeter StartAsyncTrace And FinishAsyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0200', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL1, async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 传入小数", 4.14, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 数字传入null", null, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 数字传入undefined", undefined, "");
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 传入小数", 4.14);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 数字传入null", null);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "测试异步跟踪接口: 数字传入undefined", undefined);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0200, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0300
     * @tc.name ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0300
     * @tc.desc Test the level parameter of HiTraceMeter StartAsyncTrace And FinishAsyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0300', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL1, async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test DEBUG", 1, "");
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.INFO, "test INFO", 2, "");
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.CRITICAL, "test CRITICAL", 3, "");
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test COMMERCIAL", 4, "");
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.MAX, "test MAX", 5, "");
        hiTraceMeter.startAsyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test parameter format mismatch", 6, "");
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test DEBUG", 1);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.INFO, "test INFO", 2);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.CRITICAL, "test CRITICAL", 3);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test COMMERCIAL", 4);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.MAX, "test MAX", 5);
        hiTraceMeter.finishAsyncTrace(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test parameter format mismatch", 6);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0300, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0400
     * @tc.name ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0400
     * @tc.desc Test the customCategory parameter of HiTraceMeter StartAsyncTrace And FinishAsyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0400', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL1, async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customCategory", 1, "categoryTest");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customCategory", 2, "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customCategory", 3, null);
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customCategory", 4, undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customCategory", 1);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customCategory", 2);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customCategory", 3);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customCategory", 4);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0400, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0500
     * @tc.name ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0500
     * @tc.desc Test the customArgs parameter of HiTraceMeter StartAsyncTrace And FinishAsyncTrace function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0500', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL1, async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customArgs", 1, "", "key1=value1,key2=value2");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customArgs", 2, "", "");
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customArgs", 3, "", null);
        hiTraceMeter.startAsyncTrace(COMMERCIAL, "test customArgs", 4, "", undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customArgs", 1);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customArgs", 2);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customArgs", 3);
        hiTraceMeter.finishAsyncTrace(COMMERCIAL, "test customArgs", 4);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_StartAsyncTraceAndFinishAsyncTrace_0500, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0100
     * @tc.name ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0100
     * @tc.desc Test the name parameter of HiTraceMeter traceByValue_TwoParameters function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.traceByValue("test traceByValue_TwoParameters", 1000001);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数", 1000002);
        hiTraceMeter.traceByValue("测试traceByValue_TwoParameters", 1000003);
        hiTraceMeter.traceByValue("测试整数跟踪接口全半角字符_两个参数:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}" +
          ":“《》？·-=【】、；‘，。、", 1000004);
        hiTraceMeter.traceByValue("测试整数跟踪接口超长名称_两个参数: " + overLength_str, 1000005);
        await sleep(WAIT_MS_400);
        hiTraceMeter.traceByValue("test traceByValue_TwoParameters", 2000001);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数", 2000002);
        hiTraceMeter.traceByValue("测试traceByValue_TwoParameters", 2000003);
        hiTraceMeter.traceByValue("测试整数跟踪接口全半角字符_两个参数:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥%……&*（）——+{}" +
          ":“《》？·-=【】、；‘，。、", 2000004);
        hiTraceMeter.traceByValue("测试整数跟踪接口超长名称_两个参数: " + overLength_str, 2000005);

        hiTraceMeter.traceByValue("", 1000006);
        await sleep(WAIT_MS_200);
        hiTraceMeter.traceByValue(null, 2000006);
        await sleep(WAIT_MS_200);
        hiTraceMeter.traceByValue(undefined, 3000006);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0100, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0200
     * @tc.name ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0200
     * @tc.desc Test the count parameter of HiTraceMeter traceByValue_TwoParameters function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 传入小数", 3.14);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 数字传入null", null);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 数字传入undefined", undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 传入小数", 4.14);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 数字传入null", null);
        hiTraceMeter.traceByValue("测试整数跟踪接口_两个参数: 数字传入undefined", undefined);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_traceByValue_TwoParameters_0200, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0100
     * @tc.name ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0100
     * @tc.desc Test the name parameter of HiTraceMeter traceByValue_ThreeParameters function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.traceByValue(COMMERCIAL, "test traceByValue_ThreeParameters", 1000001);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数", 1000002);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试traceByValue_ThreeParameters", 1000003);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口全半角字符_三个参数:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥" +
          "%……&*（）——+{}:“《》？·-=【】、；‘，。、", 1000004);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口超长名称_三个参数: " + overLength_str, 1000005);
        await sleep(WAIT_MS_400);
        hiTraceMeter.traceByValue(COMMERCIAL, "test traceByValue_ThreeParameters", 2000001);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数", 2000002);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试traceByValue_ThreeParameters", 2000003);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口全半角字符_三个参数:~!@#$%^&*()_+{}:\"<>?`-=[]\\;',./~！@#￥" +
          "%……&*（）——+{}:“《》？·-=【】、；‘，。、", 2000004);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口超长名称_三个参数: " + overLength_str, 2000005);

        hiTraceMeter.traceByValue(COMMERCIAL, "", 1000006);
        await sleep(WAIT_MS_200);
        hiTraceMeter.traceByValue(COMMERCIAL, null, 2000006);
        await sleep(WAIT_MS_200);
        hiTraceMeter.traceByValue(COMMERCIAL, undefined, 3000006);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0100, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0200
     * @tc.name ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0200
     * @tc.desc Test the count parameter of HiTraceMeter traceByValue_ThreeParameters function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 传入小数", 3.14);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 数字传入null", null);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 数字传入undefined", undefined);
        await sleep(WAIT_MS_400);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 传入小数", 4.14);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 数字传入null", null);
        hiTraceMeter.traceByValue(COMMERCIAL, "测试整数跟踪接口_三个参数: 数字传入undefined", undefined);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0200, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0300
     * @tc.name ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0300
     * @tc.desc Test the level parameter of HiTraceMeter traceByValue_ThreeParameters function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test DEBUG", 1);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.INFO, "test INFO", 2);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.CRITICAL, "test CRITICAL", 3);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test COMMERCIAL", 4);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.MAX, "test MAX", 5);
        await sleep(WAIT_MS_400);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.DEBUG, "test DEBUG", 11);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.INFO, "test INFO", 12);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.CRITICAL, "test CRITICAL", 13);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.COMMERCIAL, "test COMMERCIAL", 14);
        hiTraceMeter.traceByValue(hiTraceMeter.HiTraceOutputLevel.MAX, "test MAX", 15);

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_traceByValue_ThreeParameters_0300, code: ${error.code},
          message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_HiTraceMeter_isTraceEnabled_0100
     * @tc.name ArkUIX_HiTraceMeter_isTraceEnabled_0100
     * @tc.desc Test HiTraceMeter isTraceEnabled function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_HiTraceMeter_isTraceEnabled_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let isPass = true;
      try {
        hiTraceMeter.isTraceEnabled();

        expect(isPass).assertTrue();
      } catch (error) {
        isPass = false;
        console.error(`ArkUIX_HiTraceMeter_isTraceEnabled_0100, code: ${error.code}, message: ${error.message}`);
        expect(isPass).assertTrue();
      }
      done();
    });
  })
}