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

import {describe, it, expect, TestType, Size, Level, beforeAll, beforeEach, afterEach, afterAll} from '@ohos/hypium'
import xml from '@ohos.xml'

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function setAttributesTest() {
  describe('setAttributesTest', () => {
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
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_ATTRIBUTES_0100
     * @tc.name   : testSetAttributes0001
     * @tc.desc   : Write an attribute.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetAttributes0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.endElement();
      let result = '<note importance1="high1"/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_ATTRIBUTES_0200
     * @tc.name   : testSetAttributes0002
     * @tc.desc   : Write an attribute.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetAttributes0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDeclaration();
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setAttributes("importance2", "high2");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<note importance1="high1" importance2="high2"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_ATTRIBUTES_0300
     * @tc.name   : testSetAttributes0003
     * @tc.desc   : Write an attribute.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetAttributes0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setText("cat");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note importance1="high1">cat</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_ATTRIBUTES_0400
     * @tc.name   : testSetAttributes0004
     * @tc.desc   : Write an attribute.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetAttributes0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDocType('root SYSTEM');
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setText("cat");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<!DOCTYPE root SYSTEM>\r\n<note importance1="high1">cat</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_ATTRIBUTES_0500
     * @tc.name   : testSetAttributes0005
     * @tc.desc   : Write an attribute.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetAttributes0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.endElement();
      thatSer.startElement("app");
      thatSer.setAttributes("importance1", "high1");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note importance1="high1"/>\r\n<app importance1="high1"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}
