/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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

import I18n from "@ohos.i18n";
import Intl from "@ohos.intl";
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function intlTest() {
  describe("intlTest", () => {
    afterEach(async () => {
      await sleep(1000)
    });

    console.log("*************start IntlTest*************");

    /* *
     * @tc.number: LOCALE_TEST_001
     * @tc.name  : localeTest001
     * @tc.desc  : test the language in en-Latn-GB locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("en-Latn-GB");
      console.log("LOCALE_TEST_001 " + locale.language);
      expect(locale.language).assertEqual("en");
    });

    /**
     * @tc.number: LOCALE_TEST_002
     * @tc.name  : localeTest002
     * @tc.desc  : test the numeric with false value
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("en-Latn-GB", undefined);
      console.log("LOCALE_TEST_002 " + locale.numeric);
      expect(locale.numeric).assertFalse();
    });

    /**
     * @tc.number: LOCALE_TEST_003
     * @tc.name  : localeTest003
     * @tc.desc  : test the script in locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("en-Latn-GB");
      console.log("LOCALE_TEST_003 " + locale.script);
      expect(locale.script).assertEqual("Latn");
    });

    /* *
     * @tc.number: LOCALE_TEST_004
     * @tc.name  : localeTest004
     * @tc.desc  : test the region in locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("en-Latn-GB");
      console.log("LOCALE_TEST_004 " + locale.region);
      expect(locale.region).assertEqual("GB");
    });

    /**
     * @tc.number: LOCALE_TEST_005
     * @tc.name  : localeTest005
     * @tc.desc  : test the basename in locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("en-Latn-GB");
      console.log("LOCALE_TEST_005 " + locale.baseName);
      expect(locale.baseName).assertEqual("en-Latn-GB");
    });

    /**
     * @tc.number: LOCALE_TEST_006
     * @tc.name  : localeTest006localeTest006
     * @tc.desc  : check the hourCycle
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN", {
        hourCycle: "h24", calendar: "gregory"
      });
      console.log("LOCALE_TEST_006 " + locale.hourCycle);
      expect(locale.hourCycle).assertEqual("h24");
    });

    /**
     * @tc.number: LOCALE_TEST_007
     * @tc.name  : localeTest007
     * @tc.desc  : check the calendar
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN", {
        hourCycle: "h24", calendar: "gregory"
      });
      console.log("LOCALE_TEST_007 " + locale.calendar);
      expect(locale.calendar).assertEqual("gregory");
    });

    /**
     * @tc.number: LOCALE_TEST_008
     * @tc.name  : localeTest008
     * @tc.desc  : test the japanese calendar
     * @tc.size  : MediumTest
     * @tc.type  : Field
     * @tc.level : Level 0
     */
    it("localeTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP-u-ca-japanese-hc-h12");
      console.log("LOCALE_TEST_008 " + locale.calendar);
      expect(locale.calendar).assertEqual("japanese");
    });

    /**
     * @tc.number: LOCALE_TEST_009
     * @tc.name  : localeTest009
     * @tc.desc  : check the h12 hourCycle
     * @tc.size  : MediumTest
     * @tc.type  : Field
     * @tc.level : Level 0
     */
    it("localeTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP-u-ca-japanese-hc-h12");
      console.log("LOCALE_TEST_009 " + locale.hourCycle);
      expect(locale.hourCycle).assertEqual("h12");
    });

    /**
     * @tc.number: LOCALE_TEST_010
     * @tc.desc  : test the caseFirst with upper
     * @tc.name  : localeTest010
     * @tc.size  : MediumTest
     * @tc.type  : Field
     * @tc.level : Level 0
     */
    it("localeTest010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP", {
        caseFirst: "upper"
      });
      console.log("LOCALE_TEST_010 " + locale.caseFirst);
      expect(locale.caseFirst).assertEqual("upper");
    });

    /**
     * @tc.number: LOCALE_TEST_011
     * @tc.name  : localeTest011
     * @tc.desc  : check the collation
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP", {
        collation: "big5han"
      });
      console.log("LOCALE_TEST_011 " + locale.collation);
      expect(locale.collation).assertEqual("big5han");
    });

    /**
     * @tc.number: LOCALE_TEST_012
     * @tc.name  : localeTest012
     * @tc.desc  : test the numeric with true value
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP", {
        numeric: true
      });
      console.log("LOCALE_TEST_012 " + locale.numeric);
      expect(locale.numeric).assertTrue();
    });

    /**
     * @tc.number: LOCALE_TEST_013
     * @tc.name  : localeTest013
     * @tc.desc  : check the numberingSystem
     * @tc.size  : MediumTest
     * @tc.type  : Field
     * @tc.level : Level 0
     */
    it("localeTest013", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("ja-Jpan-JP", {
        numberingSystem: "arab"
      });
      console.log("localeTest013 " + locale.numberingSystem);
      expect(locale.numberingSystem).assertEqual("arab");
    });

    /**
     * @tc.number: LOCALE_TEST_014
     * @tc.name  : localeTest014
     * @tc.desc  : test the toString interface with zh
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest014", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh");
      console.log("localeTest014 " + locale.toString());
      expect(locale.toString()).assertEqual("zh");
    });

    /**
     * @tc.number: LOCALE_TEST_015
     * @tc.name  : localeTest015
     * @tc.desc  : check the toString method with zh-cn
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN");
      console.log("localeTest015 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-CN");
    });

    /**
     * @tc.number: LOCALE_TEST_016
     * @tc.name  : localeTest016
     * @tc.desc  : test the toString interface with zh-Hans-CN
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest016", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN");
      console.log("localeTest016 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-Hans-CN");
    });

    /**
     * @tc.number: LOCALE_TEST_017
     * @tc.name  : localeTest017
     * @tc.desc  : test the toString interface with zh-Hans-CN-u-hc-h12-ca-japanese
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest017", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN-u-ca-japanese-hc-h12");
      console.log("localeTest017 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-Hans-CN-u-hc-h12-ca-japanese");
    });

    /**
     * @tc.number: LOCALE_TEST_018
     * @tc.name  : localeTest018
     * @tc.desc  : test the maximize interface with zh-u-ca-gregory-co-compact param
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest018", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest018 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_019
     * @tc.name  : localeTest019
     * @tc.desc  : test the toString interface with zh-CN-u-ca-gregory-co-compact param
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest019", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest019 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_020
     * @tc.name  : localeTest020
     * @tc.desc  : test the toString interface with zh-hans-CN-u-ca-gregory-co-compact param
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest020", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-hans-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest020 " + locale.toString());
      expect(locale.toString()).assertEqual("zh-hans-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_021
     * @tc.name  : localeTest021
     * @tc.desc  : test the minimize interface with one param zh
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest021", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh");
      console.log("localeTest021 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh");
    });

    /**
     * @tc.number: LOCALE_TEST_022
     * @tc.desc  : localeTest022
     * @tc.desc  : test the minimize interface with one param zh-CN
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest022", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN");
      console.log("localeTest022 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh");
    });

    /**
     * @tc.number: LOCALE_TEST_023
     * @tc.name  : localeTest023
     * @tc.desc  : test the minimize interface with one param zh-Hans-CN
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest023", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN");
      console.log("localeTest023 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh");
    });

    /**
     * @tc.number: LOCALE_TEST_024
     * @tc.name  : localeTest024
     * @tc.desc  : test the minimize interface with one param zh-Hans-CN-u-ca-gregory-co-compact
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest024", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN-u-ca-gregory-co-compact");
      console.log("localeTest024 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_025
     * @tc.name  : localeTest025
     * @tc.desc  : test the minimize interface with zh lcoale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest025", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest025 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_026
     * @tc.name  : localeTest026
     * @tc.desc  : test the minimize interface with zh-CN lcoale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest026", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest026 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_027
     * @tc.name  : localeTest027
     * @tc.desc  : test the minimize interface with zh-Hans-CN lcoale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest027", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-hans-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest027 " + locale.minimize().toString());
      expect(locale.minimize().toString()).assertEqual("zh-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_028
     * @tc.name  : localeTest028
     * @tc.desc  : test the maximize interface with one param zh
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest028", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh");
      console.log("localeTest028 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN");
    });

    /**
     * @tc.number: LOCALE_TEST_029
     * @tc.name  : localeTest029
     * @tc.desc  : test the maximize interface with one param zh-CN
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest029", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN");
      console.log("localeTest029 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN");
    });

    /**
     * @tc.number: LOCALE_TEST_030
     * @tc.name  : localeTest030
     * @tc.desc  : test the maximize interface with one param zh-Hans-CN-u-ca-gregory-co-compact
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest030", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN");
      console.log("localeTest030 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN");
    });

    /**
     * @tc.number: LOCALE_TEST_031
     * @tc.name  : localeTest031
     * @tc.desc  : test the maximize interface with zh-Hans-CN-u-ca-gregory-co-compact locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest031", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN-u-ca-gregory-co-compact");
      console.log("localeTest031 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_032
     * @tc.name  : localeTest032
     * @tc.desc  : test the maximize interface with zh locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest032", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest032 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_033
     * @tc.name  : localeTest033
     * @tc.desc  : test the maximize interface with zh-CN locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest033", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest033 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: LOCALE_TEST_034
     * @tc.name  : localeTest034
     * @tc.desc  : test the maximize interface with zh-Hans-CN locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("localeTest034", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let locale = new Intl.Locale("zh-Hans-CN", {
        calendar: "gregory", collation: "compact"
      });
      console.log("localeTest034 " + locale.maximize().toString());
      expect(locale.maximize().toString()).assertEqual("zh-Hans-CN-u-ca-gregory-co-compact");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_001
     * @tc.name  : dateTimeFormatTest001
     * @tc.desc  : format the datetime with en-GB locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let datefmt = new Intl.DateTimeFormat("en-GB");
      expect(datefmt !== null).assertTrue();
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_002
     * @tc.name  : dateTimeFormatTest002
     * @tc.desc  : format the datetime with en-GB locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let datefmt = new Intl.DateTimeFormat();
      expect(datefmt !== null).assertTrue();
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_003
     * @tc.name  : dateTimeFormatTest003
     * @tc.desc  : format the date with zh locale, check the format(date)
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2021, 11, 17, 3, 24, 0);
      let datefmt = new Intl.DateTimeFormat("zh");
      console.log("dateTimeFormatTest003 " + datefmt.format(date));
      expect(datefmt.format(date)).assertContain("2021");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_004
     * @tc.name  : dateTimeFormatTest004
     * @tc.desc  : format the date with en locale, check the format(date)
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2021, 11, 17, 3, 24, 0);
      let datefmt = new Intl.DateTimeFormat("en");
      console.log("dateTimeFormatTest004 " + datefmt.format(date));
      expect(datefmt.format(date)).assertContain("21");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_005
     * @tc.name  : dateTimeFormatTest005
     * @tc.desc  : format the date with en-US locale, check the format(date)
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2021, 11, 17, 3, 24, 0);
      let datefmt = new Intl.DateTimeFormat("en-US");
      console.log("dateTimeFormatTest005 " + datefmt.format(date));
      expect(datefmt.format(date)).assertContain("21");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_007
     * @tc.name  : dateTimeFormatTest007
     * @tc.desc  : format the date with aa locale, check the format(date)
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2021, 11, 17, 3, 24, 0);
      let datefmt = new Intl.DateTimeFormat("aa");
      let value = datefmt.format(date);
      console.log("dateTimeFormatTest007 " + value);
      expect(value).assertInstanceOf("String");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_008
     * @tc.name  : dateTimeFormatTest008
     * @tc.desc  : format the hour with ban and zh locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat(["ban", "zh"], {
        dateStyle: "full"
      });
      console.log("dateTimeFormatTest008 " + datefmt.format(date));
      expect(datefmt.format(date)).assertEqual("2020年12月20日星期日");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_009
     * @tc.name  : dateTimeFormatTest009
     * @tc.desc  : format the hour with zh-Hans-CN locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("zh-Hans-CN", {
        dateStyle: "full", timeStyle: "full"
      });
      console.log("dateTimeFormatTest009 " + datefmt.format(date));
      expect(datefmt.format(date)).assertContain("2020年12月20日星期日");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_010
     * @tc.name  : dateTimeFormatTest010
     * @tc.desc  : format the hour with zh-CN locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("zh-CN", {
        dateStyle: "long", timeStyle: "long"
      });
      console.log("dateTimeFormatTest010 " + datefmt.resolvedOptions().dateStyle);
      expect(datefmt.resolvedOptions().dateStyle).assertEqual("long");
      expect(datefmt.format(date)).assertContain("2020年12月20日");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_011
     * @tc.name  : dateTimeFormatTest011
     * @tc.desc  : format the date dateStyle with medium style
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("zh-CN", {
        dateStyle: "medium", timeStyle: "medium"
      });
      console.log("dateTimeFormatTest011 " + datefmt.resolvedOptions().dateStyle);
      expect(datefmt.resolvedOptions().dateStyle).assertEqual("medium");
      expect(datefmt.format(date)).assertContain("2020年12月20日");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_012
     * @tc.name  : dateTimeFormatTest012
     * @tc.desc  : format the date dateStyle with short style
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("zh-CN", {
        dateStyle: "short", timeStyle: "short"
      });
      console.log("dateTimeFormatTest012 " + datefmt.resolvedOptions().dateStyle);
      expect(datefmt.resolvedOptions().dateStyle).assertEqual("short");
      expect(datefmt.format(date)).assertContain("2020/12/20");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_015
     * @tc.desc  : format the year、month、day、weekday
     * @tc.name  : dateTimeFormatTest015
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("ja", {
        year: "numeric",
        month: "long",
        day: "numeric",
        weekday: "long"
      });
      const result = datefmt.format(date);
      //ios乱码表现形式:
      //2020\M-C\M^B\M-O\M^@\M-B\M-%12\M-C\M^J\M-C\M-:\M-C\24020\M-C\M^J\M-C\M-3\M-b\M^@\M-"\M-C\M^J\M-C\M-2\M-C\M-<\M-C\M^J\M-C\M-:\M-C\M-<\M-C\M^J\M-C\M-3\M-b\M^@\M-";
      const androidOhResult = ["2020年12月20日日曜日", "2020 M12 20, Sun"].indexOf(result) != -1;
      const iosResult = result.indexOf("2020") != -1;
      const exceptResult = androidOhResult || iosResult;
      expect(exceptResult).assertTrue();
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_017
     * @tc.name  : dateTimeFormatTest017
     * @tc.desc  : format the hour&minute&second
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest017", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 11, 20, 14, 23, 16);
      let datefmt = new Intl.DateTimeFormat("zh-CN-u-hc-h12", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "numeric",
        minute: "2-digit",
        second: "numeric",
        weekday: "long",
        era: "short"
      });
      console.log("dateTimeFormatTest017 " + datefmt.format(date));
      expect(datefmt.format(date)).assertContain("公元2020年12月20日星期日");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_018
     * @tc.name  : dateTimeFormatTest018
     * @tc.desc  : format the timeZone
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest018", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let date = new Date(2020, 3, 14, 15, 5, 3);
      let datefmt = new Intl.DateTimeFormat("zh-CN-u-hc-h12", {
        timeZone: "America/Los_Angeles", timeZoneName: "long"
      });
      console.log("dateTimeFormatTest018 " + datefmt.format(date));
      expect(datefmt.format(date).indexOf("北美太平洋夏令时间") !== -1).assertTrue();
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_019
     * @tc.name  : dateTimeFormatTest019
     * @tc.desc  : format the America/Los_Angeles timeZone
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest019", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let datefmt = new Intl.DateTimeFormat("zh-CN-u-hc-h12", {
        timeZone: "America/Los_Angeles", timeZoneName: "long"
      });
      console.log("dateTimeFormatTest019 " + datefmt.resolvedOptions().timeZone);
      expect(datefmt.resolvedOptions().timeZone).assertEqual("America/Los_Angeles");
    });

    /**
     * @tc.number: DATE_TIME_FORMAT_TEST_020
     * @tc.name  : dateTimeFormatTest020
     * @tc.desc  : format the America/Los_Angeles timeZoneName
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("dateTimeFormatTest020", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let datefmt = new Intl.DateTimeFormat("zh-CN-u-hc-h12", {
        timeZone: "America/Los_Angeles", timeZoneName: "long"
      });
      console.log("dateTimeFormatTest020 " + datefmt.resolvedOptions().timeZoneName);
      expect(datefmt.resolvedOptions().timeZoneName).assertEqual("long");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_001
     * @tc.name  : numberFormatTest001
     * @tc.desc  : format the number in zh
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh");
      console.log("numberFormatTest001 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_002
     * @tc.name  : numberFormatTest002
     * @tc.desc  : format the number with default locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat();
      expect(numfmt !== null).assertTrue();
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_003
     * @tc.name  : numberFormatTest003
     * @tc.desc  : format the number in zh-u-nu-latn
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-u-nu-latn");
      console.log("numberFormatTest003 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_005
     * @tc.name  : numberFormatTest005
     * @tc.desc  : format the number in en
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en");
      console.log("numberFormatTest005 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_007
     * @tc.name  : numberFormatTest007
     * @tc.desc  : format the number in en-GB
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en-GB");
      console.log("numberFormatTest007 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_008
     * @tc.name  : numberFormatTest008
     * @tc.desc  : format the number in en-US
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en-US");
      console.log("numberFormatTest008 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_009
     * @tc.name  : numberFormatTest009
     * @tc.desc  : format the number in zh and en list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat(["zh", "en"]);
      console.log("numberFormatTest009 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_010
     * @tc.name  : numberFormatTest010
     * @tc.desc  : format the number in en and zh list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat(["en", "zh"]);
      console.log("numberFormatTest010 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_011
     * @tc.name  : numberFormatTest011
     * @tc.desc  : format the number in en and aa list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat(["en", "aa"]);
      console.log("numberFormatTest011 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_012
     * @tc.name  : numberFormatTest012
     * @tc.desc  : format the number in aa and zh list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat(["aa", "zh"]);
      console.log("NUMBER_FORMAT_TEST_1200 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_013
     * @tc.name  : numberFormatTest013
     * @tc.desc  : format the number in aa and bb list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("numberFormatTest013", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let numfmt = new Intl.NumberFormat(["aa", "bb", "es"]);
      console.log("numberFormatTest013 " + numfmt.format(123456.789));
      expect(["123.456,789", "123,456.789"].indexOf(numfmt.format(123456.789)) != -1).assertTrue();
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_014
     * @tc.name  : numberFormatTest014
     * @tc.desc  : format the number in aa bb and es list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest014", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat(["aa", "it", "bb"]);
      console.log("numberFormatTest014 " + numfmt.format(123456.789));
      expect(["123.456,789", "123,456.789"].indexOf(numfmt.format(123456.789)) != -1).assertTrue();
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_015
     * @tc.name  : numberFormatTest015
     * @tc.desc  : format the number in aa it and bb list
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: "decimal", notation: "scientific"
      });
      console.log("numberFormatTest015 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("1.234568E5");
      expect(numfmt.resolvedOptions().style).assertEqual("decimal");
      expect(numfmt.resolvedOptions().notation).assertEqual("scientific");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_017
     * @tc.name  : numberFormatTest017
     * @tc.desc  : format the number with currency USD
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest017", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
        currencyDisplay: "code",
        currencySign: "accounting",
        signDisplay: "always"
      });
      console.log("numberFormatTest017 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertContain("+USD");
      expect(numfmt.format(123456.789)).assertContain("123,456.79");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_018
     * @tc.name  : numberFormatTest018
     * @tc.desc  : format the number with currency CNY
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest018", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: "currency",
        currency: "CNY",
        currencyDisplay: "symbol",
        currencySign: "accounting",
        signDisplay: "always"
      });
      console.log("numberFormatTest018 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("+¥123,456.79");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_019
     * @tc.name  : numberFormatTest019
     * @tc.desc  : format the number with currency JPY
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest019", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("ja-JP", {
        style: "currency",
        currency: "JPY",
        currencyDisplay: "narrowSymbol",
        currencySign: "accounting",
        signDisplay: "always"
      });
      //ios乱码表现形式
      //+\M-B\M-,\M-b\M^@\M-"123,457;
      const result = numfmt.format(123456.789);
      const iosResult = result.indexOf("123,457") != -1;
      const androidOhResult = ["+￥123,457", "+¥ 123,457"].indexOf(numfmt.format(123456.789)) != -1;
      const expectResult = iosResult || androidOhResult;
      expect(expectResult).assertTrue();
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_021
     * @tc.name  : numberFormatTest021
     * @tc.desc  : format the number with  meter unit
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest021", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: "unit",
        unit: "meter",
        unitDisplay: "long",
        maximumFractionDigits: 2,
        minimumIntegerDigits: 7
      });
      console.log("numberFormatTest021 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("0,123,456.79米");
      expect(numfmt.resolvedOptions().style).assertEqual("unit");
      expect(numfmt.resolvedOptions().unit).assertEqual("meter");
      expect(numfmt.resolvedOptions().unitDisplay).assertEqual("long");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_022
     * @tc.name  : numberFormatTest022
     * @tc.desc  : format the number with unitUsage
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest022", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: "unit",
        unit: "meter",
        unitDisplay: "long",
        unitUsage: "length-road"
      });
      console.log("numberFormatTest022 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789米");
      expect(numfmt.resolvedOptions().unitUsage).assertEqual("length-road");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_023
     * @tc.name  : numberFormatTest023
     * @tc.desc  : format the number with narrow value in unitUsage param
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest023", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: "unit",
        unit: "meter",
        unitDisplay: "narrow",
        unitUsage: "length-road"
      });
      console.log("numberFormatTest023 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789米");
      expect(numfmt.resolvedOptions().unitUsage).assertEqual("length-road");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_024
     * @tc.name  : numberFormatTest024
     * @tc.desc  : format the number with short value in unitUsage param
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest024", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: "unit",
        unit: "meter",
        unitDisplay: "short",
        unitUsage: "length-road"
      });
      console.log("numberFormatTest024 " + numfmt.format(123456.789));
      expect(numfmt.format(123456.789)).assertEqual("123,456.789米");
      expect(numfmt.resolvedOptions().unitUsage).assertEqual("length-road");
    });

    /* *
     * @tc.number: NUMBER_FORMAT_TEST_027
     * @tc.name  : numberFormatTest027
     * @tc.desc  : format the number with percetn style
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest027", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("en-CN", {
        style: "percent", maximumFractionDigits: 2, minimumIntegerDigits: 7
      });
      console.log("numberFormatTest027 " + numfmt.format(123456.789));
      expect(["12,345,678.9%", "0,123,456.79%"].indexOf(numfmt.format(123456.789)) != -1).assertTrue();
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_028
     * @tc.name  : numberFormatTest028
     * @tc.desc  : format the number with numberingSystem
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest028", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("ar-EG", {
        numberingSystem: "arab"
      });
      console.log("numberFormatTest028 1 " + numfmt.format(123456.789));
      expect(["١٢٣٬٤٥٦٫٧٨٩", "123,456.789"].indexOf(numfmt.format(123456.789)) != -1).assertTrue();
      console.log("numberFormatTest028 2 " + numfmt.resolvedOptions().numberingSystem);
      expect(numfmt.resolvedOptions().numberingSystem).assertEqual("arab");
    });

    /**
     * @tc.number: NUMBER_FORMAT_TEST_029
     * @tc.name  : numberFormatTest029
     * @tc.desc  : format the number with style
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("numberFormatTest029", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let numfmt = new Intl.NumberFormat("ar", {
        style: "percent",
        minimumFractionDigits: 1,
        maximumFractionDigits: 2,
        minimumIntegerDigits: 7,
        minimumSignificantDigits: 5,
        maximumSignificantDigits: 10,
        useGrouping: true
      });
      console.log("numberFormatTest029 " + numfmt.resolvedOptions().style);
      expect(numfmt.resolvedOptions().style).assertEqual("percent");
      expect(numfmt.resolvedOptions().minimumFractionDigits).assertEqual(1);
      expect(numfmt.resolvedOptions().maximumFractionDigits).assertEqual(2);
      expect(numfmt.resolvedOptions().minimumIntegerDigits).assertEqual(7);
      expect(numfmt.resolvedOptions().minimumSignificantDigits).assertEqual(5);
      expect(numfmt.resolvedOptions().maximumSignificantDigits).assertEqual(10);
      expect(numfmt.resolvedOptions().useGrouping).assertTrue();
    });

    /**
     * @tc.number: COLLATOR_TEST_001
     * @tc.name  : collatorTest001
     * @tc.desc  : compare two different strings
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("collatorTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let coll = new Intl.Collator();
      let value = coll.compare("a", "b");
      console.log("collatorTest001 " + value);
      expect([-1, -2].indexOf(value) != -1).assertTrue();
    });

    /**
     * @tc.number: COLLATOR_TEST_002
     * @tc.name  : collatorTest002
     * @tc.desc  : compare the same strings
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("collatorTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let coll = new Intl.Collator();
      let value = coll.compare("a", "a");
      console.log("collatorTest002 " + value);
      expect([0, -2].indexOf(value) != -1).assertTrue();
    });

    /**
     * @tc.number: COLLATOR_TEST_003
     * @tc.name  : collatorTest003
     * @tc.desc  : compare two different strings and return positive value
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("collatorTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let coll = new Intl.Collator();
      let value = coll.compare("b", "a");
      console.log("collatorTest003 " + value);
      expect([1, -2].indexOf(value) != -1).assertTrue();
    });

    /**
     * @tc.number: PLURALRULES_TEST_001
     * @tc.name  : pluralrulesTest001
     * @tc.desc  : get PluralRules
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules();
      let value = pl.select(0);
      console.log("pluralrulesTest001 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_002
     * @tc.name  : pluralrulesTest002
     * @tc.desc  : get PluralRules with zh locale
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh");
      let value = pl.select(0);
      console.log("pluralrulesTest002 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_003
     * @tc.name  : pluralrulesTest003
     * @tc.desc  : get PluralRules with zh locale and ordinal type
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        type: "ordinal"
      });
      let value = pl.select(0);
      console.log("pluralrulesTest003 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_004
     * @tc.name  : pluralrulesTest004
     * @tc.desc  : get PluralRules with zh locale and loolup localeMatcher
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        localeMatcher: "lookup"
      });
      let value = pl.select(0);
      console.log("pluralrulesTest004 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_005
     * @tc.name  : pluralrulesTest005
     * @tc.desc  : get PluralRules with zh locale and minimumIntegerDigits options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        minimumIntegerDigits: 10
      });
      let value = pl.select(0);
      console.log("pluralrulesTest005 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_006
     * @tc.name  : pluralrulesTest006
     * @tc.desc  : get PluralRules with zh locale and minimumFractionDigits options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        minimumFractionDigits: 11
      });
      let value = pl.select(0);
      console.log("pluralrulesTest006 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_007
     * @tc.name  : pluralrulesTest007
     * @tc.desc  : get PluralRules with zh locale and maximumFractionDigits options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        maximumFractionDigits: 11
      });
      let value = pl.select(0);
      console.log("pluralrulesTest007 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_008
     * @tc.name  : pluralrulesTest008
     * @tc.desc  : get PluralRules with zh locale and minimumSignificantDigits options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        minimumSignificantDigits: 10
      });
      let value = pl.select(0);
      console.log("pluralrulesTest008 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: PLURALRULES_TEST_009
     * @tc.name  : pluralrulesTest009
     * @tc.desc  : get PluralRules with zh locale and maximumSignificantDigits options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("pluralrulesTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let pl = new Intl.PluralRules("zh", {
        maximumSignificantDigits: 11
      });
      let value = pl.select(0);
      console.log("pluralrulesTest009 " + value);
      expect(value).assertEqual("other");
    });

    /**
     * @tc.number: RELATIVE_TIME_FORMAT_TEST_001
     * @tc.name  : relativeTimeFormatTest001
     * @tc.desc  : format the relativetime with 100 second
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("relativeTimeFormatTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let relativetimefmt = new Intl.RelativeTimeFormat();
      let value = relativetimefmt.format(100, "second");
      console.log("relativeTimeFormatTest001 " + value);
      expect(value).assertContain("100");
    });

    /**
     * @tc.number: RELATIVE_TIME_FORMAT_TEST_006
     * @tc.name  : relativeTimeFormatTest006
     * @tc.desc  : format the relativetime, get the style options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("relativeTimeFormatTest006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let relativetimefmt = new Intl.RelativeTimeFormat("en");
      let value = relativetimefmt.resolvedOptions();
      console.log("relativeTimeFormatTest006 " + value);
      expect(value.style).assertEqual("long");
    });

    /**
     * @tc.number: RELATIVE_TIME_FORMAT_TEST_007
     * @tc.name  : relativeTimeFormatTest007
     * @tc.desc  : format the relativetime, get the numeric options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("relativeTimeFormatTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let relativetimefmt = new Intl.RelativeTimeFormat("en");
      let value = relativetimefmt.resolvedOptions();
      console.log("relativeTimeFormatTest007 " + value);
      expect(value.numeric).assertEqual("always");
    });

    /**
     * @tc.number: RELATIVE_TIME_FORMAT_TEST_008
     * @tc.name  : relativeTimeFormatTest008
     * @tc.desc  : format the relativetime, get the numberingSystem options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("relativeTimeFormatTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let relativetimefmt = new Intl.RelativeTimeFormat("en");
      let value = relativetimefmt.resolvedOptions();
      console.log("relativeTimeFormatTest008 " + value.numberingSystem);
      expect(value.numberingSystem).assertEqual("latn");
    });

    /**
     * @tc.number: RELATIVE_TIME_FORMAT_TEST_009
     * @tc.name  : relativeTimeFormatTest009
     * @tc.desc  : format the relativetime with localeMatcher options
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("relativeTimeFormatTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let relativetimefmt = new Intl.RelativeTimeFormat("en", {
        localeMatcher: "best fit", numeric: "auto", style: "narrow"
      });
      let value = relativetimefmt.resolvedOptions();
      console.log("relativeTimeFormatTest009 " + value);
      expect(value.numeric).assertEqual("auto");
      expect(value.style).assertEqual("narrow");
    });
    console.log("*************end IntlTest*************");
  });
}
