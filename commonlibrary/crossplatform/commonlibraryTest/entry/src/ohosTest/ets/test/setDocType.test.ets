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
import {
  afterEach,
  describe,
  expect,
  it,
  Level,
  Size,
  TestType
} from '@ohos/hypium';
import xml from '@ohos.xml'
export default function setDocTypeTest() {
  class Utils {
    static async msSleep(count: number): Promise<number> {
      return new Promise<number>((resolve) => {
        setTimeout(() => {
          resolve(0)
        }, count)
      })
    }
  }
  describe('setDocTypeTest', (): void => {
    afterEach(async (): Promise<void>=> {
      await Utils.msSleep(10)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DOC_TYPE_0100
     * @tc.name   : testSetDocType0001
     * @tc.desc   : Writes the DOCTYPE.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDocType0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDocType('root SYSTEM');
      let result = '<!DOCTYPE root SYSTEM>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DOC_TYPE_0200
     * @tc.name   : testSetDocType0002
     * @tc.desc   : Writes the DOCTYPE.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDocType0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.endElement();
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      let arrayBuffer = thatSer.getOutput()
      let result = '<note/>\r\n<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DOC_TYPE_0300
     * @tc.name   : testSetDocType0003
     * @tc.desc   : Writes the DOCTYPE.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDocType0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">\r\n<note/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DOC_TYPE_0400
     * @tc.name   : testSetDocType0004
     * @tc.desc   : Writes the DOCTYPE.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDocType0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput();
      let result = '<note>\r\n  <!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">\r\n</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_DOC_TYPE_0500
     * @tc.name   : testSetDocType0005
     * @tc.desc   : Writes the DOCTYPE.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetDocType0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDocType('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.setAttributes("name", "cat");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput();
      let result = '<!DOCTYPE root SYSTEM "http://www.test.org/test.dtd">\r\n<note name="cat"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}