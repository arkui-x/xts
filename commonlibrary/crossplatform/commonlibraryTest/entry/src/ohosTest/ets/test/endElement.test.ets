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
import {describe,  it, expect, TestType, Size, Level, beforeAll, beforeEach, afterEach, afterAll} from '@ohos/hypium'
import xml from '@ohos.xml'

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function endElementTest() {
  describe('endElementTest', ()=> {
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
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_END_ELEMENT_0100
     * @tc.name   : testEndElement0001
     * @tc.desc   : Writes end tag of the element.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEndElement0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, ()=> {
      let myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.endElement();
      let result = '<note/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_END_ELEMENT_0200
     * @tc.name   : testEndElement0002
     * @tc.desc   : Writes end tag of the element.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEndElement0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, ()=> {
      let myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance", "high");
      thatSer.endElement();
      let result = '<note importance="high"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_END_ELEMENT_0300
     * @tc.name   : testEndElement0003
     * @tc.desc   : Writes end tag of the element.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEndElement0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, ()=> {
      let myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("impo", "hi");
      thatSer.endElement();
      let result = '<note impo="hi"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_END_ELEMENT_0400
     * @tc.name   : testEndElement0004
     * @tc.desc   : Writes end tag of the element.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEndElement0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, ()=> {
      let myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let result = '<note1>\r\n  <note2/>\r\n</note1>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_END_ELEMENT_0500
     * @tc.name   : testEndElement0005
     * @tc.desc   : Writes end tag of the element.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEndElement0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, ()=> {
      let myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note2");
      thatSer.setAttributes("importance", "high");
      thatSer.endElement();
      let result = '<note2 importance="high"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}