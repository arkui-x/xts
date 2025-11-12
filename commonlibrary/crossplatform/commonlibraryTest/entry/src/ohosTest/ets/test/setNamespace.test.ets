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
  afterAll,
  afterEach, beforeAll,
  beforeEach,
  describe,
  expect,
  it,
  Level,
  Size,
  TestType
} from '@ohos/hypium';
import xml from '@ohos.xml'

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function setNamespaceTest() {
  class Utils {
    static async msSleep(count: number): Promise<number> {
      return new Promise<number>((resolve) => {
        setTimeout(() => {
          resolve(0)
        }, count)
      })
    }
  }
  describe('setNamespaceTest', (): void => {
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
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_NAMESPACE_0100
     * @tc.name   : testSetNamespace0001
     * @tc.desc   : Writes the namespace of the current element tag.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetNamespace0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDeclaration();
      thatSer.setNamespace("h", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.endElement();
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<h:note xmlns:h="http://www.w3.org/TR/html4/"/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    })
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_NAMESPACE_0200
     * @tc.name   : testSetNamespace0002
     * @tc.desc   : Writes the namespace of the current element tag.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetNamespace0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDeclaration();
      thatSer.setNamespace("b", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.setAttributes("a", "1")
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<b:note a="1" xmlns:b="http://www.w3.org/TR/html4/"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    })
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_NAMESPACE_0300
     * @tc.name   : testSetNamespace0003
     * @tc.desc   : Writes the namespace of the current element tag.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetNamespace0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDeclaration();
      thatSer.setNamespace("b", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.setAttributes("a", "1")
      thatSer.setText("cat")
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result =
        '<?xml version="1.0" encoding="utf-8"?>\r\n<b:note a="1" xmlns:b="http://www.w3.org/TR/html4/">cat</b:note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    })
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_NAMESPACE_0400
     * @tc.name   : testSetNamespace0004
     * @tc.desc   : Writes the namespace of the current element tag.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetNamespace0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setDeclaration();
      thatSer.setNamespace("h", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note1");
      thatSer.startElement("note2");
      thatSer.endElement();
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput()
      let result = '<?xml version="1.0" encoding="utf-8"?>\r\n<h:note1 xmlns:h="http://www.w3.org/TR/html4/">' +
        '\r\n  <h:note2/>\r\n</h:note1>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    })
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_NAMESPACE_0500
     * @tc.name   : testSetNamespace0005
     * @tc.desc   : Writes the namespace of the current element tag.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetNamespace0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setComment("Hello, World!");
      thatSer.setNamespace("h", "http://www.w3.org/TR/html4/");
      thatSer.startElement("note");
      thatSer.endElement();
      let result = '<!--Hello, World!-->\r\n<h:note xmlns:h="http://www.w3.org/TR/html4/"/>';
      let arrayBuffer = thatSer.getOutput()
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    })
  })
}
