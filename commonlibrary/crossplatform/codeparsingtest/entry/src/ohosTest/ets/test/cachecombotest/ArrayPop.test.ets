import { beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import {
  testEntriesWithPopDuringIteration,
  testEntriesIteratorReflectsPopChanges,
  testMultiplePopDuringEntriesIteration,
  testPopToEmptyDuringEntries,
  testEntriesIteratorSharesArrayReference,
  testPopBeforeStartingEntriesIteration,
  testPopReturnValueUnaffectedByEntries,
  testPopOnEmptyThenEntries,
  testPopCausesElementSkipInEntries,
  testManualEntriesNextWithPop,
  testEntriesAfterPopStillCorrect,
  testRepeatedPopThenEntries,
  testPopDoesNotAlterObjectReferencesInEntries,
  testEntriesAndPopOnSparseArray,
  testEntriesUsesCurrentLengthAfterPop,
  testEntriesPopInStrictMode,
  testNewEntriesAfterPopDiffersFromOld,
  testPopAffectsSymbolIteratorConsistently,
  testFrozenArrayPopFailsButEntriesWorks,
  testPopThenPushDuringEntriesIteration,
  testEntriesIteratorHasSymbolIteratorProperty,
  testPopUntilOneElementDuringEntries,
  testPopUndefinedThenEntries,
  testPopAffectsLengthDuringIteration,
  testForInVsEntriesWithPop,
  testPopObjectReferenceDuringEntries,
  testIndexContinuityAfterPop,
  testNextMethodAfterPop,
  testValueTypePreservedAfterPop,
  testPopWithNullUndefinedValues,
  testRecreateEntriesAfterPop,
  testEntriesAfterManyPops,
  testNoAccessToRemovedElements,
  testArrayFromEntriesAfterPop,
  testPopPerformanceInLongArrayEntries,
  testDuplicateValuesAfterPop,
  testCheckLengthImmediatelyAfterPop,
  testOrderPreservedAfterPop,
  testPopFunctionArrayDuringEntries,
  testPopThenUnshiftDuringEntries,
  testModifyElementsAfterPop,
  testPopNestedArrayDuringEntries,
  testPopBooleanArray,
  testSliceAfterPopDuringEntries,
  testToStringAfterPopAndEntries,
  testPopLargeNumberArray,
  testStringMethodsAfterPop,
  testEveryAfterPopInIteration,
  testPopSpecialValues,
  testConcatAfterPopInEntries,
  testIndexOfAfterPop,
  testFilterAfterPopInIteration,
  testPopDateArray,
  testIncludesAfterPopInEntries,
  testJoinAfterPop,
  testMapAfterPopInIteration,
  testPopRegexArray,
  testReduceAfterPopInEntries,
  testPopSetArray,
  testPopThenSpliceDuringEntries,
  testPopSymbolArray,
  testLengthDescriptorAfterPopInEntries,
  testPopMapArray,
  testFindAfterPopInEntries,
  testPrototypeChainAfterPop,
  testSomeAfterPopInEntries,
  testPopBigIntArray,
  testCopyWithinAfterPopInEntries,
  testPopErrorArray,
  testFillAfterPopInEntries,
  testJSONSerializationAfterPop,
  testHasOwnPropertyAfterPopInEntries,
  testPopPromiseArray,
  testReverseAfterPopInEntries,
  testPopProxyArray,
  testFlatAfterPopInEntries,
  testPopURLArray,
  testSortAfterPopInEntries,
  testConstructorAfterPop,
  testToLocaleStringAfterPopInEntries,
  testCompareTimestampsAfterPop,
  testEqualityAfterPopInEntries,
  testRegexFlagsAfterPop,
  testValuesAfterPopInEntries,
  testKeysAfterPop,
  testForEachAfterPopInEntries,
  testClassInstanceAfterPop,
  testFlatMapAfterPopInEntries,
  testMixedNullOrUndefAfterPop,
  testValueOfAfterPopInEntries,
  testExecuteArrowFunctionsAfterPop,
  testAtAfterPopInEntries,
  testLargeObjectPropertiesAfterPop,
  testReduceRightAfterPopInEntries,
  testCircularReferenceAfterPop,
  testFindIndexAfterPopInEntries,
  testTypedArrayAfterPop,
  testIsPrototypeOfAfterPopInEntries,
  testValuesPop_WithSymbolValues,
  testValuesPop_ProxyArray,
  testValuesPop_NewIteratorAfterPop,
  testValuesPop_LargeButSafeLength,
  testValuesPop_SealedArray,
  testValuesPop_FrozenArrayPopFailsButValuesWorks,
  testValuesPop_LargeArrayPopOne,
  testValuesPop_SparseArray,
  testValuesPop_NaNHandling,
  testValuesPop_ObjectReferenceStable
} from './ArrayPopTest';

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function ArrayCache1Test() {
  describe('ArrayCache1Test', () => {
    beforeEach(async () => {
      await sleep(40);
    })

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0100
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0100
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3, 4];
      const iter = arr.values();
      iter.next();
      iter.next();
      arr.pop();
      const third = iter.next();
      const fourth = iter.next();
      expect(third.value).assertEqual(3);
      expect(fourth.done).assertEqual(true);

    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0200
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0200
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [10, 20, 30];
      const iter = arr.values();
      iter.next();

      arr.pop();
      arr.pop();
      arr.pop();
      const nextAfterEmpty = iter.next();
      expect(nextAfterEmpty.done).assertEqual(true);
      expect(nextAfterEmpty.value).assertEqual(undefined);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0300
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0300
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3, 4, 5];
      let count = 0;
      const visited: number[] = [];

      for (const value of arr.values()) {
        count++;
        visited.push(value);
        arr.pop();
      }
      expect(count).assertEqual(3);
      expect(JSON.stringify(visited)).assertEqual("[1,2,3]");
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0400
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0400
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [];
      const iter = arr.values();
      const result = iter.next();
      expect(result.done).assertEqual(true);
      expect(result.value).assertEqual(undefined);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0500
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0500
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [42];
      arr.pop();
      const iter = arr.values();
      const result = iter.next();
      expect(result.done).assertEqual(true);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0600
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0600
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3];
      while (arr.length > 0) {
        arr.pop();
      }
      let count = 0;
      for (const _ of arr.values()) {
        count++;
      }
      expect(count).assertEqual(0);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0700
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0700
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [10, 20];
      const iter1 = arr.values();
      const iter2 = arr.values();

      iter1.next();
      arr.pop();

      const r1 = iter1.next();
      const r2 = iter2.next();

      expect(r1.done).assertEqual(true);
      expect(r2.value).assertEqual(10);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0800
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0800
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3];
      const iter = arr.values();
      iter.next();
      arr.pop();
      arr.push(99);
      const second = iter.next();
      const third = iter.next();
      expect(second.value).assertEqual(2);
      expect(third.value).assertEqual(99);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0900
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0900
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [5, 6, 7, 8];
      const iter = arr.values();
      iter.next();
      arr.pop();
      arr.pop();
      arr.pop();
      const next = iter.next();
      expect(next.done).assertEqual(true);
    });

    /**
     * @tc.name ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_1000
     * @tc.number ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_1000
     * @tc.desc Testing Cache Combo by Array
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL1
     */
    it('ArkUIX_SUB_CACHECOMBOTEST_ARRAYPOP_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3, 4];
      const visited: number[] = [];
      let popped = false;

      for (const v of arr.values()) {
        visited.push(v);
        if (!popped) {
          arr.pop();
          popped = true;
        }
      }
      expect(JSON.stringify(visited)).assertEqual("[1,2,3]");
    });
  })
}

