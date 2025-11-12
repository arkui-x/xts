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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { intl } from '@kit.LocalizationKit';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function OptionsFormatTest() {
  describe('OptionsFormatTest', () => {
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
    afterEach(async() => {
      await sleep(1000)
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number    : SUB_GLOBAL_INTL_NUMBER_OPTIONS_0100
     * @tc.name      : testNumberOptions0001
     * @tc.desc      : check the number with currency EUR
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testNumberOptions0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let numfmt = new intl.NumberFormat('en-GB', {
        style: 'currency',
        currency: 'EUR',
        currencyDisplay: 'name',
        currencySign: 'accounting',
        signDisplay: 'always'
      });
      console.log('testNumberOptions0001 ' + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual('+123,456.79 euros');
      expect(numfmt.resolvedOptions().locale).assertEqual('en-GB');
      expect(numfmt.resolvedOptions().style).assertEqual('currency');
      expect(numfmt.resolvedOptions().currency).assertEqual('EUR');
      expect(numfmt.resolvedOptions().currencyDisplay).assertEqual('name');
      expect(numfmt.resolvedOptions().currencySign).assertEqual('accounting');
      expect(numfmt.resolvedOptions().signDisplay).assertEqual('always');
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_NUMBER_OPTIONS_0200
     * @tc.name      : testNumberOptions0002
     * @tc.desc      : check the number with signDisplay
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testNumberOptions0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let numfmt = new intl.NumberFormat('en-GB', {
        style: 'currency',
        currency: 'EUR',
        currencyDisplay: 'name',
        currencySign: 'accounting',
        signDisplay: 'always',
        notation: 'compact',
        compactDisplay: 'long',
        localeMatcher: 'lookup'
      });
      console.log('testNumberOptions0002 ' + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual('+123 thousand euros');
      expect(numfmt.resolvedOptions().locale).assertEqual('en-GB');
      expect(numfmt.resolvedOptions().style).assertEqual('currency');
      expect(numfmt.resolvedOptions().currency).assertEqual('EUR');
      expect(numfmt.resolvedOptions().currencyDisplay).assertEqual('name');
      expect(numfmt.resolvedOptions().currencySign).assertEqual('accounting');
      expect(numfmt.resolvedOptions().compactDisplay).assertEqual('long');
      expect(numfmt.resolvedOptions().localeMatcher).assertEqual('lookup');
      expect(numfmt.resolvedOptions().signDisplay).assertEqual('always');
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0300
     * @tc.name      : testCollatorOptions0003
     * @tc.desc      : check the compare result
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCollatorOptions0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new intl.Collator('zh', { 'localeMatcher': 'lookup' });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0003 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().localeMatcher).assertEqual('lookup');
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0400
     * @tc.name      : testCollatorOptions0004
     * @tc.desc      : check the compare result
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCollatorOptions0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new Intl.Collator('zh', { 'usage': 'sort' });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0004 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().usage).assertEqual('sort');
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0500
     * @tc.name      : testCollatorOptions0005
     * @tc.desc      : compare two different strings with zh locale and base sensitivity
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCollatorOptions0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new Intl.Collator('zh', { 'sensitivity': 'base' });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0005 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().sensitivity).assertEqual('base');
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0600
     * @tc.name      : testCollatorOptions0006
     * @tc.desc      : compare two different strings with zh locale and true ignorePunctuation
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCollatorOptions0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new Intl.Collator('zh', { 'ignorePunctuation': true });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0006 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().ignorePunctuation).assertTrue();
    });

    /**
     * @tc.number    : SUB_GLOBAL_Intl_RelativeTimeFormat_0700
     * @tc.name      : testIntlRelativeTimeFormatToParts0700
     * @tc.desc      : RelativeTimeFormat  with en-US & numeric: "auto" & day
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testIntlRelativeTimeFormatToParts0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let range: string = JSON.stringify([{ 'type': "literal", 'value': 'yesterday' }])
      let rtf = new Intl.RelativeTimeFormat('en-US', { numeric: "auto" });
      let expected = rtf.formatToParts(-1, 'day');
      expect(JSON.stringify(expected)).assertEqual(range);
    });

    /**
     * @tc.number    : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0800
     * @tc.name      : testCollatorOptions0008
     * @tc.desc      : compare two different strings with zh locale and true numeric
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCollatorOptions0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new Intl.Collator('zh', { 'numeric': true });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0008 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().numeric).assertTrue();
    });

    /**
     * @tc.number     : SUB_GLOBAL_INTL_COLLATOR_OPTIONS_0900
     * @tc.name       : testCollatorOptions0009
     * @tc.desc       : compare two different strings with zh locale and upper caseFirst
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testCollatorOptions0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let coll = new Intl.Collator('zh', { 'caseFirst': 'upper' });
      let value = coll.compare('a', 'b');
      console.log('testCollatorOptions0009 ' + value);
      expect(value).assertEqual(-1);
      expect(coll.resolvedOptions().caseFirst).assertEqual('upper');
    });

    /**
     * @tc.number    : SUB_GLOBAL_Intl_RelativeTimeFormat_1000
     * @tc.name      : testIntlRelativeTimeFormatToParts0010
     * @tc.desc      : RelativeTimeFormat  with zh-hans-AF & numeric: "always" & day
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testIntlRelativeTimeFormatToParts0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let range: string = JSON.stringify([{ 'type': "integer", 'value': '10', 'unit': 'day' },
        { 'type': 'group', 'value': ',', 'unit': 'day' }, { 'type': 'integer', 'value': '000', 'unit': 'day' },
        { 'type': 'literal', 'value': '天后' }])

      let rtf = new Intl.RelativeTimeFormat('zh-hans-AF', { numeric: "always" });
      let expected = rtf.formatToParts(10000, 'day');
      expect(JSON.stringify(expected)).assertEqual(range);
    });
  })
}