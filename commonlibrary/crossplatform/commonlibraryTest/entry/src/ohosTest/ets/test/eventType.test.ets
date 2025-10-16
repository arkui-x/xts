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
export default function eventTypeTest() {
  describe('eventTypeTest', () => {
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_START_DOCUMENT_0100
     * @tc.name   : testSTART_DOCUMENT0001
     * @tc.desc   : Gets the START_DOCUMENT of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSTART_DOCUMENT0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.START_DOCUMENT;
      expect(event).assertEqual(0)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_END_DOCUMENT_0200
     * @tc.name   : testEND_DOCUMENT0002
     * @tc.desc   : Gets the END_DOCUMENT of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testEND_DOCUMENT0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.END_DOCUMENT;
      expect(event).assertEqual(1)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_START_TAG_0300
     * @tc.name   : testSTART_TAG0003
     * @tc.desc   : Gets the START_TAG of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSTART_TAG0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.START_TAG;
      expect(event).assertEqual(2)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_END_TAG_0400
     * @tc.name   : testEND_TAG0004
     * @tc.desc   : Gets the END_TAG of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testEND_TAG0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.END_TAG;
      expect(event).assertEqual(3)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_TEXT_0500
     * @tc.name   : testTEXT0005
     * @tc.desc   : Gets the TEXT of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testTEXT0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.TEXT;
      expect(event).assertEqual(4)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_CDSECT_0600
     * @tc.name   : testCDSECT0006
     * @tc.desc   : Gets the CDSECT of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testCDSECT0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.CDSECT;
      expect(event).assertEqual(5)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_COMMENT_0700
     * @tc.name   : testCOMMENT0007
     * @tc.desc   : Gets the COMMENT of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testCOMMENT0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.COMMENT;
      expect(event).assertEqual(6)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_DOCDECL_0800
     * @tc.name   : testDOCDECL0008
     * @tc.desc   : Gets the DOCDECL of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testDOCDECL0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.DOCDECL;
      expect(event).assertEqual(7)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_INSTRUCTION_0900
     * @tc.name   : testINSTRUCTION0009
     * @tc.desc   : Gets the INSTRUCTION of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testINSTRUCTION0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.INSTRUCTION;
      expect(event).assertEqual(8)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_ENTITY_REFERENCE_1000
     * @tc.name   : testENTITY_REFERENCE0010
     * @tc.desc   : Gets the ENTITY_REFERENCE of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testENTITY_REFERENCE0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.ENTITY_REFERENCE;
      expect(event).assertEqual(9)
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_EVENT_TYPE_WHITESPACE_1100
     * @tc.name   : testWHITESPACE0011
     * @tc.desc   : Gets the WHITESPACE of EventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWHITESPACE0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let event = xml.EventType.WHITESPACE;
      expect(event).assertEqual(10)
    });
  })
}