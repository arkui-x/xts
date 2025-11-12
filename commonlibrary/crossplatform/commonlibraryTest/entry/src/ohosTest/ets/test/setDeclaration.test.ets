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

export default function setDeclarationTest() {
  describe('setDeclarationTest', () => {
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
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DECLARATION_0100
     * @tc.name   : testSetDeclaration0001
     * @tc.desc   : Writes xml declaration with encoding.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDeclaration0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer('utf-8');
      thatSer.setDeclaration();
      let result = '<?xml version="1.0" encoding="utf-8"?>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DECLARATION_0200
     * @tc.name   : testSetDeclaration0002
     * @tc.desc   : Writes xml declaration with encoding.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDeclaration0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer('utf-8');
      thatSer.setDeclaration();
      thatSer.startElement("note1");
      thatSer.endElement();
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<note1/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DECLARATION_0300
     * @tc.name   : testSetDeclaration0003
     * @tc.desc   : Writes xml declaration with encoding.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDeclaration0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer('utf-8');
      thatSer.setDeclaration();
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.endElement();
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<note importance1="high1"/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DECLARATION_0400
     * @tc.name   : testSetDeclaration0004
     * @tc.desc   : Writes xml declaration with encoding.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDeclaration0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer('utf-8');
      thatSer.setDeclaration();
      thatSer.setDocType('root SYSTEM');
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<!DOCTYPE root SYSTEM>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DECLARATION_0500
     * @tc.name   : testSetDeclaration0005
     * @tc.desc   : Writes xml declaration with encoding.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDeclaration0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let thatSer = new xml.XmlDynamicSerializer('utf-8');
      thatSer.setDeclaration();
      thatSer.setComment("Hello, World!");
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<!--Hello, World!-->';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}