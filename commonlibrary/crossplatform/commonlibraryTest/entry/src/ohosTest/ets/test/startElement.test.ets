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
import {describe, it, expect, TestType, Size, Level} from '@ohos/hypium'
import xml from '@ohos.xml'
export default function startElementTest() {
  describe('startElementTest', ()=> {
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_START_ELEMENT_0100
     * @tc.name   : testStartElement0001
     * @tc.desc   : Writes an elemnet start tag with the given name.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testStartElement0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ()=> {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note1");
      thatSer.endElement();
      let result = '<note1/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_START_ELEMENT_0200
     * @tc.name   : testStartElement0002
     * @tc.desc   : Writes an elemnet start tag with the given name.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testStartElement0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ()=> {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note1");
      thatSer.endElement();
      thatSer.startElement("note2");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note1/>\r\n<note2/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_START_ELEMENT_0300
     * @tc.name   : testStartElement0003
     * @tc.desc   : Writes an elemnet start tag with the given name.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testStartElement0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ()=> {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note1>\r\n  <note2/>\r\n</note1>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_START_ELEMENT_0400
     * @tc.name   : testStartElement0004
     * @tc.desc   : Writes an elemnet start tag with the given name.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testStartElement0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ()=> {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.startElement("note3");
      thatSer.endElement();
      thatSer.endElement();
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note1>\r\n  <note2>\r\n    <note3/>\r\n  </note2>\r\n</note1>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_START_ELEMENT_0500
     * @tc.name   : testStartElement0005
     * @tc.desc   : Writes an elemnet start tag with the given name.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testStartElement0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ()=> {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.startElement("note3");
      thatSer.endElement();
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<note1>\r\n  <note2/>\r\n  <note3/>\r\n</note1>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}
