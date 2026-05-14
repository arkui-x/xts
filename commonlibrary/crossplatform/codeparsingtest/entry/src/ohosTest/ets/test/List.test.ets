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

import actscodeparsingtest from './actscodeparsingtest/ActsCodeParsingTest.test'
import ArrayCombinationTest1 from './arraytest/ArrayCombination001.test'
import TypeArrayBigInt64ArrayTest from './builtinsarray2test/TypeArrayBigInt64Array.test'
import ArrayConstructor1Test from './builtinsarraytest/ArrayCombination1Test.test'
import BigInt64ArrayTest from './builtinstest/BigInt64Array.test'
import ArrayBuffer1Test from './builtinsupplytest/ArrayBuffer1.test'
import ArrayCache1Test from './cachecombotest/ArrayPop.test'
import DateTimeTest from './etsspectest/datetime/DateTimeTest.test'
import ExpressionTest1 from './etsspectest/expression/ExpressionTest1.test'
import FunctionTest from './etsspectest/function/FunctionTest1.test'
import InheritTest from './etsspectest/Inherit/Inherit.test'
import KeyCollectionTest from './etsspectest/keycollection/keycollection.test'
import UnionTypeCombination from './etsspectest/literalAs/UnionTypeCombination.test'
import looper1Test from './etsspectest/looper/Looper1.test'
import NumberTest from './etsspectest/numberstring/NumberTest.test'
import RegExpTest from './etsspectest/regexp/regexp.test'
import BuiltinsStatementBreakTest from './etsspectest/statement/BuiltinsStatementBreakTest.test'
import TypeArrayBigInt64Array from './etsspectest/typearray/TypeArrayBigInt64Array.test'
import MapClearTest from './maptest/MapClear.test';
import proxyTest from './proxytest/Proxy.test';
import reflect4Test from './proxy2test/Reflect4.test';
import RegExpTest001 from './regexptest/RegExp001.test';
import DateTestCase001Test from './datetest/DateTestCase001.test';
import JsonBasicTest from './jsontest/JSONStringifyBasicTest.test';
import Object1Test from './objecttest/Object1.test';
import DataView1Test from './dataviewtest/DataView1.test';
import Settest from './settest/SetTest.test';
import specialchartest from './specialchartest/specialchartest.test';
import symbol1test from "./symbol1test/symbol1test.test";
import symbol2test from "./symbol2test/symbol2test.test";
import StringBasicTest from './stringtest/StringBasicTest.test';
import weaktest from './weaktest/weaktest.test';

export default function testsuite() {
  actscodeparsingtest()
  ArrayCombinationTest1()
  TypeArrayBigInt64ArrayTest()
  ArrayConstructor1Test()
  BigInt64ArrayTest()
  ArrayBuffer1Test()
  ArrayCache1Test()
  DateTimeTest()
  ExpressionTest1()
  FunctionTest()
  InheritTest()
  KeyCollectionTest()
  UnionTypeCombination()
  looper1Test()
  NumberTest()
  RegExpTest()
  BuiltinsStatementBreakTest()
  TypeArrayBigInt64Array()
  DateTestCase001Test();
  JsonBasicTest();
  MapClearTest();
  Object1Test();
  reflect4Test();
  proxyTest();
  RegExpTest001();
  DataView1Test();
  Settest();
  specialchartest();
  symbol1test();
  symbol2test();
  StringBasicTest();
  weaktest();

}
