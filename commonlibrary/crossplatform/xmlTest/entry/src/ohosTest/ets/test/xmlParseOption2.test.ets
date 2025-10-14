/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
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
import { describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import xml from '@ohos.xml';
import util from '@ohos.util';

let findCategory = false;
let categoryValue = "";

function attrWithTag1(tagName: string, key: string, value: string) {
  if (value === '1') {
    findCategory = true;
    return true;
  }
  if (findCategory) {
    categoryValue = value;
    return false;
  }
  return true;
}

let str = '';

function attrWithTag2(tagName: string, key: string, value: string) {
  if (value === 'category') {
    return false;
  }
  str += tagName + ' ' + key + ' ' + value + ' ';
  return true;
}

export default function XmlSerializerXmlPullParserTest() {
  describe('XmlSerializerXmlPullParserTest', () => {
    /**
     * @tc.number: SUB_COMMONLIBRARY_XML_PARSEOPTIONS_0100
     * @tc.name: testAttributeWithTagCallbackFunction0001
     * @tc.desc: Starts parsing the XML file.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAttributeWithTagCallbackFunction0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let strXml = '<?xml version="1.0" encoding="utf-8"?>' +
        '<column name="Giana"><value integer="1"/></column>' +
        '<column name="category"><value Boolean="true"/></column>' +
        '<column name="day"><value Boolean="3"/></column>';
      let textEncoder = new util.TextEncoder();
      let uint8 = textEncoder.encodeInto(strXml);
      let pullParse = new xml.XmlPullParser(uint8.buffer as object as ArrayBuffer, 'UTF-8');

      let options: xml.ParseOptions =
        { supportDoctype: true, ignoreNameSpace: true, attributeWithTagCallbackFunction: attrWithTag1 };
      pullParse.parseXml(options);
      let result = 'category';
      expect(categoryValue).assertEqual(result);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_XML_PARSEOPTIONS_0200
     * @tc.name: testAttributeWithTagCallbackFunction0001
     * @tc.desc: Starts parsing the XML file.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAttributeWithTagCallbackFunction0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let strXml = '<?xml version="1.0" encoding="utf-8"?>' +
        '<column name="Giana"><value integer="1"/></column>' +
        '<column name="category"><value Boolean="true"/></column>' +
        '<column name="day"><value Boolean="3"/></column>';
      let textEncoder = new util.TextEncoder();
      let uint8 = textEncoder.encodeInto(strXml);
      let pullParse = new xml.XmlPullParser(uint8.buffer as object as ArrayBuffer, 'UTF-8');

      let options: xml.ParseOptions =
        { supportDoctype: true, ignoreNameSpace: true, attributeWithTagCallbackFunction: attrWithTag2 };
      pullParse.parseXml(options);
      let result = 'column name Giana value integer 1';
      expect(str.trim()).assertEqual(result);
    })

  })
}