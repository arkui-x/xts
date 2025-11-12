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

export default function setCdataTest() {
  class Utils {
    static async msSleep(count: number): Promise<number> {
      return new Promise<number>((resolve) => {
        setTimeout(() => {
          resolve(0)
        }, count)
      })
    }
  }
  describe('setCdataTest', (): void => {
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
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_CDATA_0100
     * @tc.name   : testSetCdata0001
     * @tc.desc   : Writes the CDATA.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetCdata0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setCdata('root SYSTEM');
      let result = '<![CDATA[root SYSTEM]]>';
      let arrayBuffer = thatSer.getOutput();
      let view1 = "";
      let view = new Uint8Array(arrayBuffer);
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_CDATA_0200
     * @tc.name   : testSetCdata0002
     * @tc.desc   : Writes the CDATA.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testsetCdata0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.endElement();
      thatSer.setCdata('root SYSTEM "http://www.test.org/test.dtd"');
      let arrayBuffer = thatSer.getOutput();
      let result = '<note/>\r\n<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_CDATA_0300
     * @tc.name   : testsetCdata0003
     * @tc.desc   : Writes the CDATA.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetCdata0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setCdata('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput();
      let result = '<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>\r\n<note/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_CDATA_0400
     * @tc.name   : testSetCdata0004
     * @tc.desc   : Writes the CDATA.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetCdata0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.startElement("note");
      thatSer.setCdata('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput();
      let result = '<note>\r\n  <![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>\r\n</note>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_XML_DYNAMIC_SERIALIZER_SET_CDATA_0500
     * @tc.name   : testSetCdata0005
     * @tc.desc   : Writes the CDATA.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSetCdata0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let thatSer = new xml.XmlDynamicSerializer();
      thatSer.setCdata('root SYSTEM "http://www.test.org/test.dtd"');
      thatSer.startElement("note");
      thatSer.setAttributes("name", "cat");
      thatSer.endElement();
      let arrayBuffer = thatSer.getOutput();
      let result = '<![CDATA[root SYSTEM "http://www.test.org/test.dtd"]]>\r\n<note name="cat"/>';
      let view = new Uint8Array(arrayBuffer);
      let view1 = "";
      for (let i = 0; i < result.length; ++i) {
        view1 = view1 + String.fromCodePoint(view[i]);
      }
      expect(view1).assertEqual(result);
    });
  })
}