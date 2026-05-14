/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';

// 定义对象接口类型
interface TestObject {
  id?: number;
  name?: string;
  data?: string;
  key?: string;
  prop?: string;
  a?: number;
  b?: number;
  unused?: string;
  new?: string;
  x?: number;
  y?: number;
}

// 定义数组类型
type TestArray = Array<number | string | boolean | null | undefined>;

// 定义函数接口类型
interface TestFunction extends Function {
  prop?: string;
}

//定义对象类型
class MockSymbol {
  description: string; // 1. 先在类中声明字段

  constructor(description: string) { // 2. 构造函数参数不加修饰符
    this.description = description; // 3. 在构造函数体内赋值
  }
}

export default function weaktest() {
  describe('weaktest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0100
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0100
     * @tc.desc Verify that a common object can be added into a WeakSet and detected by has().
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetAdd0001 start');
        const ws1 = new WeakSet();
        const obj1: TestObject = { id: 1 }; // 添加类型注解
        ws1.add(obj1);
        console.log("1. Object-add successful" + ws1.has(obj1));
        expect(ws1.has(obj1)).assertTrue();
        done();
        console.log('testWeakSetAdd0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0200
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0200
     * @tc.desc Verify that a common object exists in WeakSet after being added.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetAdd0002 start');
        const ws2 = new WeakSet();
        const obj2: TestObject = { name: "Test" }; // 添加类型注解
        ws2.add(obj2);
        console.log("2. Object-has exists" + ws2.has(obj2));
        expect(ws2.has(obj2)).assertTrue();
        done();
        console.log('testWeakSetAdd0002 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0300
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0300
     * @tc.desc Verify that a common object can be successfully deleted from WeakSet.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetDelete0001 start');
        const ws3 = new WeakSet();
        const obj3: TestObject = { data: "value" }; // 添加类型注解
        ws3.add(obj3);
        console.log("3. Object-delete successful" + ws3.delete(obj3));
        expect(ws3.delete(obj3)).assertFalse();
        done();
        console.log('testWeakSetDelete0001 done');
      });


    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0400
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0400
     * @tc.desc Verify that different object instances with same content are treated as different values in WeakSet.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetInstance0001 start');
        const ws5 = new WeakSet();
        const obj5a: TestObject = { id: 5 };
        const obj5b: TestObject = { id: 5 };
        ws5.add(obj5a);

        expect(ws5.has(obj5b)).assertFalse();
        done();
        console.log('testWeakSetInstance0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0500
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0500
     * @tc.desc Verify that modified object can still be recognized in WeakSet.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetModify0001 start');
        const ws6 = new WeakSet();
        const obj6: TestObject = { prop: "old" };
        ws6.add(obj6);
        obj6.prop = "new";
        console.log("6. remainsIdentifiableAfterModification: " + ws6.has(obj6));
        expect(ws6.has(obj6)).assertTrue();
        done();
        console.log('testWeakSetModify0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0600
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0600
     * @tc.desc Verify that duplicate addition of same object returns WeakSet itself.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetDuplicate0001 start');
        const ws7 = new WeakSet();
        const obj7: TestObject = { a: 1 };
        ws7.add(obj7);
        const result7 = ws7.add(obj7);
        console.log("7. returnsSelfWhenAddingDuplicate: " + (result7 === ws7));
        expect(result7 === ws7).assertTrue();
        done();
        console.log('testWeakSetDuplicate0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0700
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0700
     * @tc.desc Verify that deleting non-existent object returns false.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetDeleteNotExist0001 start');
        const ws8 = new WeakSet();
        const obj8: TestObject = { unused: "obj" };
        console.log("8. returnsFalseWhenDeletingNonExistentObject: " + !ws8.delete(obj8));
        expect(ws8.delete(obj8)).assertFalse();
        done();
        console.log('testWeakSetDeleteNotExist0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0800
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0800
     * @tc.desc Verify that checking non-existent object returns false.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetHasNotExist0001 start');
        const ws9 = new WeakSet();
        const obj9: TestObject = { new: "object" };
        console.log("9. returnsFalseWhenDeletingNonExistentObject: " + !ws9.has(obj9));
        expect(ws9.has(obj9)).assertFalse();
        done();
        console.log('testWeakSetHasNotExist0001 done');
      });

    /**
     * @tc.number ArkUIX_SUB_WEAKTEST_WEAKTEST_0900
     * @tc.name ArkUIX_SUB_WEAKTEST_WEAKTEST_0900
     * @tc.desc Verify that multiple different objects can be added to WeakSet.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     */
    it("ArkUIX_SUB_WEAKTEST_WEAKTEST_0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('testWeakSetMultiple0001 start');
        const ws10 = new WeakSet();
        const obj10a: TestObject = { x: 10 };
        const obj10b: TestObject = { y: 20 };
        ws10.add(obj10a).add(obj10b);
        console.log("10. addMultipleDistinctObjects: " + (ws10.has(obj10a) && ws10.has(obj10b)));
        expect(ws10.has(obj10a) && ws10.has(obj10b)).assertTrue();
        done();
        console.log('testWeakSetMultiple0001 done');
      });

    /**
     * @tc.number    ArkUIX_SUB_WEAKTEST_WEAKTEST_1000
     * @tc.name      ArkUIX_SUB_WEAKTEST_WEAKTEST_1000
     * @tc.desc      Verify that add() on an empty WeakSet throws no exception (basic object)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it('ArkUIX_SUB_WEAKTEST_WEAKTEST_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_ARK_WEAKSET_EMPTY_ADD_01000 start');
        interface ValueType { id: string; }
        const ws = new WeakSet<ValueType>();
        class Val implements ValueType {
          id: string;
          constructor() {
            this.id = 'val-0001';
          }
        }
        const val = new Val();
        let errorThrown = false;
        try {
          ws.add(val);
        } catch (e) {
          errorThrown = true;
        }
        expect(errorThrown).assertFalse();
        console.log('ArkUIX_SUB_ARK_WEAKSET_EMPTY_ADD_01000 done');
        done();
      });

  })
}