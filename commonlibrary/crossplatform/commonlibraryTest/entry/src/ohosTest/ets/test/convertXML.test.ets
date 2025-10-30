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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Size, Level, TestType } from '@ohos/hypium';
import { convertxml } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function ConvertXMLTest() {
  describe('ConvertXMLTest', () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number     : SUB_COMMONLIBRARY_ConvertXML_FAST_CONVERT_TO_JS_OBJECT_0100
     * @tc.name       : testFastConvertToJSObject0001
     * @tc.desc       : Test the function of the interface fastConvertToJSObject.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testFastConvertToJSObject0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testFastConvertToJSObject0001';
      try {
        let xml = `<?xml version="1.0" encoding="utf-8"?>
                      <note importance="high" logged="true">
                          <title>Hello\r\nWorld</title>
                          <todo><![CDATA[Work\r\n]]></todo>
                      </note>`;
        let conv = new convertxml.ConvertXML();
        let options: convertxml.ConvertOptions = {
          trim: false,
          declarationKey: "_declaration",
          instructionKey: "_instruction",
          attributesKey: "_attributes",
          textKey: "_text",
          cdataKey: "_cdata",
          doctypeKey: "_doctype",
          commentKey: "_comment",
          parentKey: "_parent",
          typeKey: "_type",
          nameKey: "_name",
          elementsKey: "_elements"
        };
        let result = JSON.stringify(conv.fastConvertToJSObject(xml, options));
        console.log(`${TAG}+${result}`);
        let equal =
          '{"_declaration":{"_attributes":{"version":"1.0","encoding":"utf-8"}},"_elements":[{"_type":"element","_name":"note","_attributes":{"importance":"high","logged":"true"},"_elements":[{"_type":"element","_name":"title","_elements":[{"_type":"text","_text":"Hello\\nWorld"}]},{"_type":"element","_name":"todo","_elements":[{"_type":"cdata","_cdata":"Work\\n"}]}]}]}';
        expect(result.toString()).assertEqual(equal);
      } catch (e) {
        console.log((e as Error).toString());
        console.error(`${TAG} failed: ${e.message}`);
        expect().assertFail();
      }
    });
  })
}