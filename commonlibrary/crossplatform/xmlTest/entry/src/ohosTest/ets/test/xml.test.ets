/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
import { describe, expect, it, afterEach } from '@ohos/hypium';
import xml from '@ohos.xml';
import util from '@ohos.util';

let str = "";
async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function XmlSerializerXmlPullParserTest() {
  describe("XmlSerializerXmlPullParserTest", () => {
    afterEach(async () => {
      await sleep(200);
    });

    /**
     * @tc.number: TEST_CONSTRUCTOR_001
     * @tc.name  : testConstructor001
     * @tc.desc  : Create an xml instance. For example: let xml = new xml.XmlSerializer(arrayBuffer).
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testConstructor001", 0, () => {
      try {
        const myMAX = 2048;
        let arrayBuffer = new ArrayBuffer(myMAX);
        let thatSer = new xml.XmlSerializer(arrayBuffer);
        expect(thatSer != null).assertEqual(true);
      } catch (err) {
        console.log("testConstructor001 meet error: " + err);
      }
    });

    /**
     * @tc.number: TEST_CONSTRUCTOR_002
     * @tc.name  : testConstructor002
     * @tc.desc  : Create an xml instance. For example: let xml = new xml.XmlSerializer(arrayBuffer, encoding).
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testConstructor002", 0, () => {
      try {
        const myMAX = 2048;
        let arrayBuffer = new ArrayBuffer(myMAX);
        let thatSer = new xml.XmlSerializer(arrayBuffer, "utf-8");
        expect(thatSer != null).assertEqual(true);
      } catch (err) {
        console.log("testConstructor002 meet error: " + err);
      }
    });

    /**
     * @tc.number: TEST_SET_ATTRIBUTES_001
     * @tc.name  : testsetAttributes001
     * @tc.desc  : Write an attribute.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetAttributes001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.endElement();
      let result = '<note importance1="high1"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_ATTRIBUTES_002
     * @tc.name  : testsetAttributes002
     * @tc.desc  : Write an attribute.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetAttributes002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setAttributes("importance2", "high2");
      thatSer.endElement();
      let result = '<note importance1="high1" importance2="high2"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_ATTRIBUTES_003
     * @tc.name  : testsetAttributes003
     * @tc.desc  : Write an attribute.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetAttributes003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setAttributes("importance2", "high2");
      thatSer.setAttributes("importance3", "high3");
      thatSer.endElement();
      let result =
        '<note importance1="high1" importance2="high2" importance3="high3"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_ATTRIBUTES_004
     * @tc.name  : testsetAttributes004
     * @tc.desc  : Write an attribute.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetAttributes004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance1", "high1");
      thatSer.setAttributes("importance2", "high2");
      thatSer.setAttributes("importance3", "high3");
      thatSer.setAttributes("importance4", "high4");
      thatSer.endElement();
      let result =
        '<note importance1="high1" importance2="high2" importance3="high3" importance4="high4"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_ADD_EMPTY_ELEMENT_001
     * @tc.name  : testAddEmptyElement001
     * @tc.desc  : Add an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testAddEmptyElement001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.addEmptyElement("a");
      thatSer.endElement();
      let result = "<note>\r\n  <a/>\r\n</note>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_ADD_EMPTY_ELEMENT_002
     * @tc.name  : testAddEmptyElement002
     * @tc.desc  : Add an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testAddEmptyElement002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.endElement();
      thatSer.addEmptyElement("b");
      let result = "<note/>\r\n<b/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_ADD_EMPTY_ELEMENT_003
     * @tc.name  : testAddEmptyElement003
     * @tc.desc  : Add an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testAddEmptyElement003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.addEmptyElement("c");
      thatSer.startElement("note");
      thatSer.endElement();
      let result = "<c/>\r\n<note/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_ADD_EMPTY_ELEMENT_004
     * @tc.name  : testAddEmptyElement004
     * @tc.desc  : Add an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testAddEmptyElement004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.addEmptyElement("d");
      let result = "<d/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_ADD_EMPTY_ELEMENT_005
     * @tc.name  : testAddEmptyElement005
     * @tc.desc  : Add an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testAddEmptyElement005", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.addEmptyElement("c");
      thatSer.addEmptyElement("d");
      thatSer.endElement();
      let result = "<note>\r\n  <c/>\r\n  <d/>\r\n</note>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DECLARATION_001
     * @tc.name  : testSetDeclaration001
     * @tc.desc  : Writes xml declaration with encoding. For example: <?xml version="1.0" encoding="utf-8"?>.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDeclaration001", 0, () => {
      let arrayBuffer = new ArrayBuffer(2048);
      let thatSer = new xml.XmlSerializer(arrayBuffer, "utf-8");
      thatSer.setDeclaration();
      let result = '<?xml version="1.0" encoding="utf-8"?>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_START_ELEMENT_001
     * @tc.name  : testStartElement001
     * @tc.desc  : Writes an elemnet start tag with the given name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testStartElement001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.endElement();
      let result = "<note1/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_START_ELEMENT_002
     * @tc.name  : testStartElement002
     * @tc.desc  : Writes an elemnet start tag with the given name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testStartElement002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.endElement();
      thatSer.startElement("note2");
      thatSer.endElement();
      let result = "<note1/>\r\n<note2/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_START_ELEMENT_003
     * @tc.name  : testStartElement003
     * @tc.desc  : Writes an elemnet start tag with the given name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testStartElement003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let result = "<note1>\r\n  <note2/>\r\n</note1>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_START_ELEMENT_004
     * @tc.name  : testStartElement004
     * @tc.desc  : Writes an elemnet start tag with the given name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testStartElement004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.startElement("note3");
      thatSer.endElement();
      thatSer.endElement();
      thatSer.endElement();
      let result =
        "<note1>\r\n  <note2>\r\n    <note3/>\r\n  </note2>\r\n</note1>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_START_ELEMENT_005
     * @tc.name  : testStartElement005
     * @tc.desc  : Writes an elemnet start tag with the given name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testStartElement005", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.startElement("note3");
      thatSer.endElement();
      thatSer.endElement();
      let result = "<note1>\r\n  <note2/>\r\n  <note3/>\r\n</note1>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_END_ELEMENT_001
     * @tc.name  : testEndElement001
     * @tc.desc  : Writes end tag of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testEndElement001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.endElement();
      let result = "<note/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_END_ELEMENT_002
     * @tc.name  : testEndElement002
     * @tc.desc  : Writes end tag of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testEndElement002", 0, () => {
      const myMAX = 2048;
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
     * @tc.number: TEST_END_ELEMENT_003
     * @tc.name  : testEndElement003
     * @tc.desc  : Writes end tag of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testEndElement003", 0, () => {
      const myMAX = 2048;
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
     * @tc.number: TEST_END_ELEMENT_004
     * @tc.name  : testEndElement004
     * @tc.desc  : Writes end tag of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testEndElement004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let result = "<note1>\r\n  <note2/>\r\n</note1>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_END_ELEMENT_005
     * @tc.name  : testEndElement005
     * @tc.desc  : Writes end tag of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testEndElement005", 0, () => {
      const myMAX = 2048;
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

    /**
     * @tc.number: TEST_SET_NAMESPECE_001
     * @tc.name  : testSetNamespace001
     * @tc.desc  : Writes the namespace of the current element tag.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetNamespace001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDeclaration();
      thatSer.setNamespace("h", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.endElement();
      let result =
        '<?xml version="1.0" encoding="utf-8"?>\r\n<h:note xmlns:h="http://www.w3.org/TR/html4/"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_NAMESPECE_002
     * @tc.name  : testSetNamespace002
     * @tc.desc  : Writes the namespace of the current element tag.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetNamespace002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDeclaration();
      thatSer.setNamespace("b", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.endElement();
      let result =
        '<?xml version="1.0" encoding="utf-8"?>\r\n<b:note xmlns:b="http://www.w3.org/TR/html4/"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_NAMESPECE_003
     * @tc.name  : testSetNamespace003
     * @tc.desc  : Writes the namespace of the current element tag.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetNamespace003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDeclaration();
      thatSer.setNamespace("h", "http://www.111/");
      thatSer.startElement("note");
      thatSer.endElement();
      let result =
        '<?xml version="1.0" encoding="utf-8"?>\r\n<h:note xmlns:h="http://www.111/"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_NAMESPECE_004
     * @tc.name  : testSetNamespace004
     * @tc.desc  : Writes the namespace of the current element tag.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetNamespace004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDeclaration();
      thatSer.setNamespace("h", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let result =
        '<?xml version="1.0" encoding="utf-8"?>\r\n<h:note1 xmlns:h="http://www.w3.org/TR/html4/">' +
          "\r\n  <h:note2/>\r\n</h:note1>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_COMMENT_001
     * @tc.name  : testSetComment001
     * @tc.desc  : Writes the comment.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetComment001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setComment("Hi!");
      thatSer.endElement();
      let result = "<note>\r\n  <!--Hi!-->\r\n</note>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_COMMENT_002
     * @tc.name  : testSetComment002
     * @tc.desc  : Writes the comment.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetComment002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setComment("Hello, World!");
      thatSer.endElement();
      let result = "<note>\r\n  <!--Hello, World!-->\r\n</note>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_COMMENT_003
     * @tc.name  : testSetComment003
     * @tc.desc  : Writes the comment.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetComment003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setComment("Hello, World!");
      let result = "<!--Hello, World!-->";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_COMMENT_005
     * @tc.name  : testSetComment005
     * @tc.desc  : Writes the comment.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetComment004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setComment("Hello, World!");
      thatSer.startElement("note");
      thatSer.endElement();
      let result = "<!--Hello, World!-->\r\n<note/>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_CDATA_001
     * @tc.name  : testSetCDATA001
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetCDATA001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setCDATA("root SYSTEM");
      let result = "<![CDATA[root SYSTEM]]>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_CDATA_002
     * @tc.name  : testSetCDATA002
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetCDATA002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setCDATA('root SYSTEM "http://www.test.org/test.dtd"');
      let result = '<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_CDATA_003
     * @tc.name  : testSetCDATA003
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetCDATA003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.endElement();
      thatSer.setCDATA('root SYSTEM "http://www.test.org/test.dtd"');
      let result =
        '<note/>\r\n<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_CDATA_004
     * @tc.name  : testSetCDATA004
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetCDATA004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setCDATA('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.endElement();
      let result =
        '<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>\r\n<note/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_CDATA_005
     * @tc.name  : testSetCDATA005
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetCDATA005", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setCDATA('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.endElement();
      let result =
        '<note>\r\n  <![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>\r\n</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_TEXT_001
     * @tc.name  : testSetText001
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetText001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance", "high");
      thatSer.setText("Happy1");
      thatSer.endElement();
      let result = '<note importance="high">Happy1</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_TEXT_002
     * @tc.name  : testSetText002
     * @tc.desc  : Writes the CDATA.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetText002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setAttributes("importance", "high");
      thatSer.setText("Happy2");
      thatSer.endElement();
      let result = '<note importance="high">Happy2</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DOC_TYPE_001
     * @tc.name  : testSetDocType001
     * @tc.desc  : Writes the DOCTYPE.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDocType001", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDocType("root SYSTEM");
      let result = "<!DOCTYPE root SYSTEM>";
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DOC_TYPE_002
     * @tc.name  : testSetDocType002
     * @tc.desc  : Writes the DOCTYPE.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDocType002", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      let result = '<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DOC_TYPE_003
     * @tc.name  : testSetDocType003
     * @tc.desc  : Writes the DOCTYPE.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDocType003", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.endElement();
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      let result =
        '<note/>\r\n<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DOC_TYPE_004
     * @tc.name  : testSetDocType004
     * @tc.desc  : Writes the DOCTYPE.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDocType004", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.endElement();
      let result =
        '<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">\r\n<note/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_SET_DOC_TYPE_005
     * @tc.name  : testSetDocType005
     * @tc.desc  : Writes the DOCTYPE.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testSetDocType005", 0, () => {
      const myMAX = 2048;
      let arrayBuffer = new ArrayBuffer(myMAX);
      let thatSer = new xml.XmlSerializer(arrayBuffer);
      thatSer.startElement("note");
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.endElement();
      let result =
        '<note>\r\n  <!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">\r\n</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });

    /**
     * @tc.number: TEST_GET_COLUMN_NUMBER_001
     * @tc.name  : testGetColumnNumber001
     * @tc.desc  : Get the current column number, starting from 1.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetColumnNumber001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetColumnNumber001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:1key:2 value:77key:10 value:81key:2 value:88key:4 value:93key:3 value:101" +
          "key:3 value:108key:1 value:108"
      expect(expectResult).assertEqual(str);

    });

    /**
     * @tc.number: TEST_GET_DEPTH_001
     * @tc.name  : testGetDepth001
     * @tc.desc  : Gets the current depth of the element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetDepth001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetDepth001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:0key:2 value:1key:10 value:1key:2 value:2key:4 value:2key:3 value:2key:3 value:1key:1 value:0";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_GET_LINE_NUMBER_001
     * @tc.name  : testGetLineNumber001
     * @tc.desc  : Get the current line number, starting from 1.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetLineNumber001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetLineNumber001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:1key:2 value:1key:10 value:1key:2 value:1key:4 value:1key:3 value:1key:3 value:1key:1 value:1";
      expect(expectResult).assertEqual(str);
    });

    /**
     * @tc.number: TEST_GET_NAME_001
     * @tc.name  : testGetName001
     * @tc.desc  : Gets the current element name.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetName001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetName001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:key:2 value:notekey:10 value:key:2 value:titlekey:4 value:key:3 value:titlekey:3 value:notekey:1 value:";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_GET_NAME_SPACE_001
     * @tc.name  : testGetNamespace001
     * @tc.desc  : Gets the namespace of the current element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetNamespace001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetNamespace001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:key:2 value:key:10 value:key:2 value:key:4 value:key:3 value:key:3 value:key:1 value:";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_GET_PREFIX_001
     * @tc.name  : testGetPrefix001
     * @tc.desc  : Gets the namespace of the current element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetPrefix001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let i = 0;
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetPrefix001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:key:2 value:key:10 value:key:2 value:key:4 value:key:3 value:key:3 value:key:1 value:";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_GET_TEXT_001
     * @tc.name  : testGetText001
     * @tc.desc  : Gets the text content of the current event.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetText001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetText001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:key:2 value:key:10 value:    key:2 value:key:4 value:Happykey:3 value:key:3 value:key:1 value:";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_IS_EMPTY_ELEMENT_001
     * @tc.name  : testIsEmptyElementTag001
     * @tc.desc  : Determine whether the current element is an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testIsEmptyElementTag001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testIsEmptyElementTag001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:falsekey:2 value:falsekey:10 value:falsekey:2 value:falsekey:4 value:falsekey:3 value:falsekey:3 value:falsekey:1 value:false";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_IS_WHITE_SPACE_001
     * @tc.name  : testIsWhitespace001
     * @tc.desc  : Determine whether the current element is an empty element.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testIsWhitespace001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testIsWhitespace001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:truekey:2 value:falsekey:10 value:truekey:2 value:truekey:4 value:falsekey:3 value:truekey:3 value:truekey:1 value:true";
      expect(expectResult == str).assertTrue();
    });

    /**
     * @tc.number: TEST_GET_ATTRIBUTE_COUNT_001
     * @tc.name  : testGetAttributeCount001
     * @tc.desc  : Gets the number of attributes for the current start tag.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testGetAttributeCount001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<note importance="high" logged="true">' +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tokenValueCallbackFunction: testGetAttributeCount001Fun,
      };
      that.parse(options);
      const expectResult =
        "key:0 value:0key:2 value:2key:10 value:0key:2 value:0key:4 value:0key:3 value:0key:3 value:0key:1 value:0";
      expect(str).assertEqual(expectResult);
    });

    /**
     * @tc.number: TEST_PARSE_TAG_001
     * @tc.name  : testParseTag001
     * @tc.desc  : Starts parsing the XML file.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testParseTag001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<!DOCTYPE note [<!ENTITY foo "baa">]>' +
          '<note importance="high" logged="true">' +
          "    <![CDATA[\r\nfuncrion matchwo(a,6)\r\n{\r\nreturn 1;\r\n}\r\n]]>" +
          "    <!--Hello, World!-->" +
          "    <company>John &amp; Hans</company>" +
          "    <title>Happy</title>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer);
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        tagValueCallbackFunction: testParseTag001Fun
      };
      that.parse(options);
      expect(":").assertEqual(str);
    });
    /**
     * @tc.number: TEST_PARSE_001
     * @tc.name  : testParse001
     * @tc.desc  : Starts parsing the XML file.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("testParse001", 0, () => {
      let strXml =
        '<?xml version="1.0" encoding="utf-8"?>' +
          '<!DOCTYPE note [\n<!ENTITY foo "baa">]>' +
          '<note importance="high" logged="true">' +
          "    <![CDATA[\r\nfuncrion matchwo(a,6)\r\n{\r\nreturn 1;\r\n}\r\n]]>" +
          "    <!--Hello, World!-->" +
          "    <company>John &amp; Hans</company>" +
          "    <title>Happy</title>" +
          "    <title>Happy</title>" +
          "    <lens>Work</lens>" +
          "    <lens>Play</lens>" +
          "    <?go there?>" +
          "    <a><b/></a>" +
          '    <h:table xmlns:h="http://www.w3.org/TR/html4/">' +
          "        <h:tr>" +
          "            <h:td>Apples</h:td>" +
          "            <h:td>Bananas</h:td>" +
          "        </h:tr>" +
          "    </h:table>" +
          "</note>";
      let textEncoder = new util.TextEncoder();
      let arrbuffer = textEncoder.encodeInto(strXml);
      let that = new xml.XmlPullParser(arrbuffer.buffer as object as ArrayBuffer, 'UTF-8');
      str = "";
      let options: xml.ParseOptions = {
        supportDoctype: true,
        ignoreNameSpace: true,
        attributeValueCallbackFunction: testParse001Fun,
      };
      that.parse(options);
      let str1 =
        "importance:highlogged:truexmlns:h:http://www.w3.org/TR/html4/";
      expect(str).assertEqual(str1);
    });
  });
}

function testGetColumnNumber001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += 'key:' + key + ' value:' + value.getColumnNumber();
  return true;
}

function testGetDepth001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getDepth();
  return true;
}


function testGetLineNumber001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getLineNumber();
  return true;
}

function testGetName001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getName();
  return true;
}

function testGetNamespace001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getNamespace();
  return true;
}

function testGetPrefix001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getPrefix();
  return true;
}

function testGetText001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getText();
  return true;
}

function testIsEmptyElementTag001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.isEmptyElementTag();
  return true;
}

function testIsWhitespace001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.isWhitespace();
  return true;
}

function testGetAttributeCount001Fun(key: xml.EventType, value: xml.ParseInfo) {
  str += "key:" + key + " value:" + value.getAttributeCount();
  return true;
}

function testParseTag001Fun(name: string, value: string) {
  str = name + ":" + value;
  return true;
}

function testParse001Fun(name: string, value: string) {
  str += name + ":" + value;
  return true;
}

