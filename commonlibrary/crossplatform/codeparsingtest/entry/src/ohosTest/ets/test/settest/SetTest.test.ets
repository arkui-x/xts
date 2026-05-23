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

interface SymbolLike {
  id: string;
  description?: string;
}

interface BuiltInSymbols {
  iterator: SymbolLike;
}

function createSymbol(description?: string): SymbolLike {
  return {
    id: `symbol_${Date.now()}_${Math.random().toString(36).slice(2, 10)}`,
    description
  };
}

const symbolRegistry = new Map<string, SymbolLike>();

function createSharedSymbol(key: string): SymbolLike {
  if (!symbolRegistry.has(key)) {
    symbolRegistry.set(key, createSymbol(key));
  }
  return symbolRegistry.get(key)!;
}

const builtInSymbols: BuiltInSymbols = {
  iterator: createSymbol("iterator")
};

function getSetValues<T>(set: Set<T>): T[] {
  const values: T[] = [];
  set.forEach(item => values.push(item));
  return values;
}

function arrayContains<T>(array: T[], target: T, comparator: (a: T, b: T) => boolean): boolean {
  return array.some(item => comparator(item, target));
}

export default function SetTest() {
  describe('SetTest', () => {
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
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0100
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0100
     * @tc.desc      Set add string value and verify success
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_STRING_0100 start');
        const set1 = new Set<string>();
        set1.add("hello");
        let result: boolean = set1.has("hello");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_STRING_0100 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_STRING_0100 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0200
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0200
     * @tc.desc      Set has string value and verify existence
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_HAS_STRING_0200 start');
        const set2 = new Set<string>();
        set2.add("world");
        let result: boolean = set2.has("world");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_HAS_STRING_0200 done');
        done();
        console.log('ArkUIX_SUB_SET_HAS_STRING_0200 end');
      });


    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0300
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0300
     * @tc.desc      Set delete string value and verify has returns false
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_DELETE_HAS_STRING_0300 start');
        const set4 = new Set<string>();
        set4.add("example");
        set4.delete("example");
        let result: boolean = !set4.has("example");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_DELETE_HAS_STRING_0300 done');
        done();
        console.log('ArkUIX_SUB_SET_DELETE_HAS_STRING_0300 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0400
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0400
     * @tc.desc      Set add multiple different string values and verify count
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_MULTIPLE_STRINGS_0500 start');
        const set5 = new Set<string>();
        set5.add("a").add("b").add("c");
        let result: boolean = set5.size === 3;
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_MULTIPLE_STRINGS_0500 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_MULTIPLE_STRINGS_0500 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0500
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0500
     * @tc.desc      Set add same string value multiple times and verify size remains unchanged
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_SAME_STRING_0600 start');
        const set6 = new Set<string>();
        set6.add("repeat");
        const sizeBefore = set6.size;
        set6.add("repeat");
        let result: boolean = set6.size === sizeBefore;
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_SAME_STRING_0600 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_SAME_STRING_0600 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0600
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0600
     * @tc.desc      Set delete unadded string value and verify returns false
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_STRING_0700 start');
        const set7 = new Set<string>();
        const result: boolean = !set7.delete("notadded");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_STRING_0700 done');
        done();
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_STRING_0700 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0700
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0700
     * @tc.desc      Set add empty string value and verify success
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_EMPTY_STRING_0800 start');
        const set8 = new Set<string>();
        set8.add("");
        let result: boolean = set8.has("");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_EMPTY_STRING_0800 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_EMPTY_STRING_0800 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0800
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0800
     * @tc.desc      Set add string with special characters and verify success
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_SPECIAL_CHARS_0900 start');
        const set9 = new Set<string>();
        set9.add("!@#$%");
        let result: boolean = set9.has("!@#$%");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_SPECIAL_CHARS_0900 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_SPECIAL_CHARS_0900 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_0900
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_0900
     * @tc.desc      Set add string value and verify modifying variable does not affect set
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_MODIFY_VAR_1000 start');
        const set10 = new Set<string>();
        let str = "original";
        set10.add(str);
        str = "modified";
        let result: boolean = set10.has("original");
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_MODIFY_VAR_1000 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_MODIFY_VAR_1000 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1000
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1000
     * @tc.desc      Set add nested object and verify success
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_NESTED_OBJECT_2800 start');

        interface Innermost {
          c: number;
        }

        interface Middle {
          b: Innermost;
        }

        interface Outer {
          a: Middle;
        }

        const set28 = new Set<Outer>();
        const nestedObj: Outer = { a: { b: { c: 1 } } };
        set28.add(nestedObj);
        let result: boolean = set28.has(nestedObj);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_ADD_NESTED_OBJECT_2800 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_NESTED_OBJECT_2800 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1100
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1100
     * @tc.desc      Set add object and verify reassigning variable to new object does not affect set
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_ADD_REASSIGN_OBJECT_2900 start');

        interface InitialObject {
          initial: string;
        }

        const set29 = new Set<InitialObject>();
        let obj29: InitialObject = { initial: "value" };
        set29.add(obj29);
        obj29 = { initial: "value" } as InitialObject;
        let result: boolean = set29.has({ initial: "value" });
        expect(result).assertFalse();
        console.log('ArkUIX_SUB_SET_ADD_REASSIGN_OBJECT_2900 done');
        done();
        console.log('ArkUIX_SUB_SET_ADD_REASSIGN_OBJECT_2900 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1200
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1200
     * @tc.desc      Set delete unadded object and verify returns false
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_OBJECT_3000 start');

        interface UnusedObject {
          unused: string;
        }

        const set30 = new Set<UnusedObject>();
        const obj30: UnusedObject = { unused: "object" };
        let result: boolean = !set30.delete(obj30);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_OBJECT_3000 done');
        done();
        console.log('ArkUIX_SUB_SET_DELETE_UNADDED_OBJECT_3000 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1300
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1300
     * @tc.desc      Set add normal unique object and verify existence (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_NORMAL_3100 start');
        const set31 = new Set<SymbolLike>();
        const sym31: SymbolLike = createSymbol("test");
        set31.add(sym31);

        const result: boolean = set31.has(sym31);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_NORMAL_3100 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_NORMAL_3100 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1400
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1400
     * @tc.desc      Verify Set has() returns true for existing unique object (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_HAS_EXIST_3200 start');
        const set32 = new Set<SymbolLike>();
        const sym32: SymbolLike = createSymbol("demo");
        set32.add(sym32);

        const result: boolean = set32.has(sym32);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_HAS_EXIST_3200 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_HAS_EXIST_3200 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1500
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1500
     * @tc.desc      Verify Set delete() returns true for existing unique object (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_SUCCESS_3300 start');
        const set33 = new Set<SymbolLike>();
        const sym33: SymbolLike = createSymbol("delete");
        set33.add(sym33);

        const result: boolean = set33.delete(sym33);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_SUCCESS_3300 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_SUCCESS_3300 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1600
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1600
     * @tc.desc      Verify Set has() returns false after delete (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_HAS_NOTEXIST_3400 start');
        const set34 = new Set<SymbolLike>();
        const sym34: SymbolLike = createSymbol("removed");
        set34.add(sym34);
        set34.delete(sym34);

        const result: boolean = !set34.has(sym34);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_HAS_NOTEXIST_3400 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_HAS_NOTEXIST_3400 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1700
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1700
     * @tc.desc      Verify added unique object exists in iteration (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ITERATE_EXIST_3500 start');
        const set35 = new Set<SymbolLike>();
        const sym35: SymbolLike = createSymbol("iterate");
        set35.add(sym35);

        const values = getSetValues(set35);
        const result: boolean = arrayContains(values, sym35, (a, b) => a.id === b.id);

        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ITERATE_EXIST_3500 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ITERATE_EXIST_3500 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1800
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1800
     * @tc.desc      Verify different objects with same description are treated as distinct (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DIFFERENT_3600 start');
        const set36 = new Set<SymbolLike>();
        const sym36a: SymbolLike = createSymbol("same");
        const sym36b: SymbolLike = createSymbol("same");

        set36.add(sym36a);
        set36.add(sym36b);
        const result: boolean = set36.size === 2;

        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DIFFERENT_3600 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DIFFERENT_3600 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_1900
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_1900
     * @tc.desc      Verify shared objects are treated as same in Set (simulate Symbol.for feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_1900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_SHARED_3700 start');
        const set37 = new Set<SymbolLike>();
        const sym37a: SymbolLike = createSharedSymbol("shared");
        const sym37b: SymbolLike = createSharedSymbol("shared");

        set37.add(sym37a);
        set37.add(sym37b);
        const result: boolean = set37.size === 1;

        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_SHARED_3700 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_SHARED_3700 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_2000
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_2000
     * @tc.desc      Verify delete() returns false for non-existent object (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_2000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_NOTADDED_3800 start');
        const set38 = new Set<SymbolLike>();
        const sym38: SymbolLike = createSymbol("notadded");

        const result: boolean = !set38.delete(sym38);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_NOTADDED_3800 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_DELETE_NOTADDED_3800 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_2100
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_2100
     * @tc.desc      Verify adding built-in unique object works (simulate built-in Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_2100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_BUILTIN_3900 start');
        const set39 = new Set<SymbolLike>();
        const sym39: SymbolLike = builtInSymbols.iterator;
        set39.add(sym39);

        const result: boolean = set39.has(sym39);
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_BUILTIN_3900 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_BUILTIN_3900 end');
      });

    /**
     * @tc.number    ArkUIX_SUB_SETTEST_SETTEST_2200
     * @tc.name      ArkUIX_SUB_SETTEST_SETTEST_2200
     * @tc.desc      Verify duplicate add of same object doesn't change size (simulate Symbol feature)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 0
     */
    it("ArkUIX_SUB_SETTEST_SETTEST_2200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DUPLICATE_4000 start');
        const set40 = new Set<SymbolLike>();
        const sym40: SymbolLike = createSymbol("repeat");
        set40.add(sym40);
        set40.add(sym40);

        const result: boolean = set40.size === 1;
        expect(result).assertTrue();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DUPLICATE_4000 done');
        done();
        console.log('ArkUIX_SUB_SET_SYMBOL_ADD_DUPLICATE_4000 end');
      });
  })
}
