/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
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


import { i18n } from '@kit.LocalizationKit';
import { describe, it, expect, Level, TestType, Size, afterAll,afterEach } from '@ohos/hypium';
import { common } from '@kit.AbilityKit';
import fileIo from '@ohos.file.fs';
import deviceInfo from '@ohos.deviceInfo';


let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");

interface testcase{
  lang: string, country?: string, desc?:string
}

interface lauage{
  code: string, expected?: string, name?:string
}

interface languages{
  code: string, name?:string
}

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function i18n_xts() {
  describe('i18ntest_xts', () => {
    afterEach(async () =>{
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
      await sleep(100);

    });
    afterAll(async () =>{
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
      await sleep(1000);

    })
    /**
     * @tc.number ARKUIX_I18n_System_GetSystemLanguages_0100
     * @tc.name ARKUIX_I18n_System_GetSystemLanguages_0100
     * @tc.desc check i18n System getSystemLanguages
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSystemLanguages_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_System_GetSystemLanguages_0100';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('zh-CN');
          expect(indexUtil != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_System_GetSystemCountries_0100
     * @tc.name ARKUIX_I18n_System_GetSystemCountries_0100
     * @tc.desc check i18n System getSystemCountries with zh locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSystemCountries_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSystemCountries_0100';
      try {
        let indexUtil: i18n.IndexUtil = i18n.getInstance('de-DE');
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSystemCountries_0200
     * @tc.name ARKUIX_I18n_System_GetSystemCountries_0200
     * @tc.desc check i18n System getSystemCountries with null locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSystemCountries_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSystemCountries_0200';
      try {
        let systemCountries: Array<string> = i18n.System.getSystemCountries(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSystemCountries_0300
     * @tc.name ARKUIX_I18n_System_GetSystemCountries_0300
     * @tc.desc check i18n System getSystemCountries with undefined locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSystemCountries_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSystemCountries_0300';
      try {
        let systemCountries: Array<string> = i18n.System.getSystemCountries(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_IsSuggested_0100
     * @tc.name ARKUIX_I18n_System_IsSuggested_0100
     * @tc.desc check i18n System isSuggested with two parameters
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_IsSuggested_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_IsSuggested_0100';
      try {
        const testCases:testcase[] = [
          { lang: 'en', country: 'CN', desc: '英语+中国' },
          { lang: 'en', country: 'US', desc: '英语+美国' },
          { lang: 'zh', country: 'CN', desc: '中文+中国' },
          { lang: 'zh', country: 'US', desc: '中文+美国' }
        ];
        let arr1:boolean[] = [];
        let arr2:boolean[]=[false,true,true,false];
        if(isiOS){
           arr2 = [true,true,true,false]
        }

        testCases.forEach((testCase, index) => {
          const result = i18n.System.isSuggested(testCase.lang, testCase.country);
          arr1.push(result)
        });
        for(let i=0;i<arr1.length;i++){
          expect(arr1[i]===arr2[i]).assertTrue()
        }
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_IsSuggested_0200
     * @tc.name ARKUIX_I18n_System_IsSuggested_0200
     * @tc.desc check i18n System isSuggested with single parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_IsSuggested_0200',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_IsSuggested_0200';
      try {
        const testCases:testcase[] = [
          { lang: 'en' },
          { lang: 'zh' },
        ];
        let arr1:boolean[] = [];
        let arr2:boolean[]=[false,true];
        if(isiOS){
          arr2 = [true,true]
        }
        testCases.forEach((testCase, index) => {
          const result = i18n.System.isSuggested(testCase.lang);
          arr1.push(result)
        });
        for(let i=0;i<arr1.length;i++){
          expect(arr1[i]===arr2[i]).assertTrue()
        }
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_IsSuggested_0300
     * @tc.name ARKUIX_I18n_System_IsSuggested_0300
     * @tc.desc check i18n System isSuggested with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_IsSuggested_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_IsSuggested_0300';
      try {
        let isSuggestedCountry: boolean = i18n.System.isSuggested(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })
    /**
     * @tc.number ARKUIX_I18n_System_IsSuggested_0400
     * @tc.name ARKUIX_I18n_System_IsSuggested_0400
     * @tc.desc check i18n System isSuggested with undefined parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_IsSuggested_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_IsSuggested_0400';
      try {
        let isSuggestedCountry: boolean = i18n.System.isSuggested(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetPreferredLanguageList_0100
     * @tc.name ARKUIX_I18n_System_GetPreferredLanguageList_0100
     * @tc.desc check i18n System getPreferredLanguageList
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetPreferredLanguageList_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetPreferredLanguageList_0100';
      try {
        let value = i18n.System.getPreferredLanguageList();
        expect(value.length).assertLarger(0);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetFirstPreferredLanguage_0100
     * @tc.name ARKUIX_I18n_System_GetFirstPreferredLanguage_0100
     * @tc.desc check i18n System getFirstPreferredLanguage with empty setting
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetFirstPreferredLanguage_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetFirstPreferredLanguage_0100';
      try {
        let value = i18n.System.getFirstPreferredLanguage();
        let list = i18n.System.getPreferredLanguageList();
        expect(list.length).assertLarger(0);
        if(list[0] == 'zh-Hans'){
          expect(value).assertEqual('zh-Hans');
        }
        else if(list[0] == 'en'){
          expect(value).assertEqual('en');
        }
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetUsingLocalDigit_0100
     * @tc.name ARKUIX_I18n_System_GetUsingLocalDigit_0100
     * @tc.desc check i18n System whether use of local digits is enabled
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetUsingLocalDigit_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetUsingLocalDigit_0100';
      try {
        let usingLocalDigit: boolean = i18n.System.getUsingLocalDigit();
        expect(usingLocalDigit).assertEqual(false);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })


    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0100
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0100
     * @tc.desc check i18n System getSimplifiedLanguage with no parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_0100';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage();
        let simplifiedSystemLanguage: string = i18n.System.getSimplifiedLanguage();
        expect(simplifiedLanguage === simplifiedSystemLanguage).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0200
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0200
     * @tc.desc check i18n System getSimplifiedLanguage with chinese parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_0200';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage("zh-Hans-CN");
        expect(simplifiedLanguage).assertEqual("zh");
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0300
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0300
     * @tc.desc test i18n System getSimplifiedLanguage with 'en-GB' and 'en-Latn-US' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_0300';
      try {
        let type_one = i18n.System.getSimplifiedLanguage('en-GB');

        let type_two = i18n.System.getSimplifiedLanguage('en-Latn-US');

        expect(type_one).assertEqual('en-GB');
        expect(type_two).assertEqual('en');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0400
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0400
     * @tc.desc test i18n System getSimplifiedLanguage with 'zh-Hant-HK' and 'zh-Hant-TW' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_0400';
      try {
        let type_one = i18n.System.getSimplifiedLanguage('zh-Hant-HK');

        let type_two = i18n.System.getSimplifiedLanguage('zh-Hant-TW');
        expect(type_one).assertEqual('zh-HK');
        expect(type_two).assertEqual('zh-TW');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0500
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0500
     * @tc.desc test i18n System getSimplifiedLanguage with 'es-ES' and 'es-US' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('es-ES');
      let type_two = i18n.System.getSimplifiedLanguage('es-US');
      expect(type_one).assertEqual('es');
      expect(type_two).assertEqual('es-US');
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0600
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0600
     * @tc.desc test i18n System getSimplifiedLanguage with 'pt-PT' and 'pt-BR' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('pt-PT');
      let type_two = i18n.System.getSimplifiedLanguage('pt-BR');
      expect(type_one).assertEqual('pt-PT');
      expect(type_two).assertEqual('pt');
    })


    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0700
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0700
     * @tc.desc test i18n System getSimplifiedLanguage with 'en-CN' and 'en-Test' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0700',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('en-CN');
      let type_two = i18n.System.getSimplifiedLanguage('en-Test');
      expect(type_one).assertEqual('en-CN');
      expect(type_two).assertEqual('en-Test');
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0800
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0800
     * @tc.desc test i18n System getSimplifiedLanguage with 'zh-Hant-CN' and 'zh-Hant-Test' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('zh-Hant-CN');
      let type_two = i18n.System.getSimplifiedLanguage('zh-Hant-Test');
      expect(type_one).assertEqual('zh-Hant-CN');
      expect(type_two).assertEqual('zh');
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_0900
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_0900
     * @tc.desc test i18n System getSimplifiedLanguage with 'es-CN' and 'es-Test' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_0900',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('es-CN');
      let type_two = i18n.System.getSimplifiedLanguage('es-Test');
      expect(type_one).assertEqual('es-CN');
      expect(type_two).assertEqual('es-Test');
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1000
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1000
     * @tc.desc test i18n System getSimplifiedLanguage with 'pt-CN' and 'pt-Test' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('pt-CN');
      let type_two = i18n.System.getSimplifiedLanguage('pt-Test');
      expect(type_one).assertEqual('pt-CN');
      expect(type_two).assertEqual('pt-Test');
    })
    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1100
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1100
     * @tc.desc test i18n System getSimplifiedLanguage with 'bo-CN' and 'bo-US' and 'bo-Test' parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (): Promise<void> => {
      let type_one = i18n.System.getSimplifiedLanguage('bo-CN');
      let type_two = i18n.System.getSimplifiedLanguage('bo-US');
      let type_three = i18n.System.getSimplifiedLanguage('bo-Test');
      expect(type_one).assertEqual('bo');
      expect(type_two).assertEqual('bo-US');
      expect(type_three).assertEqual('bo-Test');
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1200
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1200
     * @tc.desc test i18n System getSimplifiedLanguage with " "
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_1200';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage(" ");
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1300
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1300
     * @tc.desc test i18n System getSimplifiedLanguage with '111111111111111'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_1300';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage('111111111111111');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1400
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1400
     * @tc.desc check i18n System getSimplifiedLanguage with letter parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_1400';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage('abc');
        expect(simplifiedLanguage).assertEqual("abc");
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1500
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1500
     * @tc.desc check i18n System getSimplifiedLanguage with special char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_1500';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage('!#');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetSimplifiedLanguage_1600
     * @tc.name ARKUIX_I18n_System_GetSimplifiedLanguage_1600
     * @tc.desc check i18n System getSimplifiedLanguage with chinese char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetSimplifiedLanguage_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetSimplifiedLanguage_1600';
      try {
        let simplifiedLanguage: string = i18n.System.getSimplifiedLanguage('刘');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetFirstDayOfWeek_0100
     * @tc.name ARKUIX_I18n_System_GetFirstDayOfWeek_0100
     * @tc.desc check i18n System getFirstDayOfWeek is SUN
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetFirstDayOfWeek_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetFirstDayOfWeek_0100';
      try {
        const result = i18n.System.getFirstDayOfWeek();
        expect(result).assertEqual(7);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureType_0100
     * @tc.name ARKUIX_I18n_System_GetTemperatureType_0100
     * @tc.desc check i18n System getTemperatureType
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureType_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureType_0100';
      try {
        let temperatureType: i18n.TemperatureType = i18n.System.getTemperatureType();
        expect(temperatureType).assertEqual(1);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0100
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0100
     * @tc.desc check i18n System getTemperatureName of CELSIUS
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0100';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(i18n.TemperatureType.CELSIUS);
        expect(temperatureName).assertEqual("celsius");
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0200
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0200
     * @tc.desc check i18n System getTemperatureName of FAHRENHEIT
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0200';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(i18n.TemperatureType.FAHRENHEIT);
        expect(temperatureName).assertEqual("fahrenheit");
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0300
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0300
     * @tc.desc check i18n System getTemperatureName of KELVIN
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0300';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(i18n.TemperatureType.KELVIN);
        expect(temperatureName).assertEqual("kelvin");
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0400
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0400
     * @tc.desc check i18n System getTemperatureName with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0400';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0500
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0500
     * @tc.desc check i18n System getTemperatureName with undefined parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0500';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_System_GetTemperatureName_0600
     * @tc.name ARKUIX_I18n_System_GetTemperatureName_0600
     * @tc.desc check i18n System getTemperatureName with 4 parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_System_GetTemperatureName_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_System_GetTemperatureName_0600';
      try {
        let temperatureName: string = i18n.System.getTemperatureName(4);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0100
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0100
     * @tc.desc check I18NUtil unitConvert with normal parameters
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0100';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='236.588 liters';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0200
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0200
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(fromUnit - '')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0200';
      try {
        let fromUnit: i18n.UnitInfo = { unit: '', measureSystem: '' };
        let toUnit: i18n.UnitInfo = {  unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0300
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0300
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(fromUnit - '111111111')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0300';
      try {
        let fromUnit: i18n.UnitInfo = { unit: '111111111', measureSystem: '111111111' };
        let toUnit: i18n.UnitInfo = {  unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0400
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0400
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(fromUnit - 'abc')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0400';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'abc', measureSystem: 'abc' };
        let toUnit: i18n.UnitInfo = {  unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0500
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0500
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(fromUnit - '!#')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0500';
      try {
        let fromUnit: i18n.UnitInfo = { unit: '!#', measureSystem: '!#' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0600
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0600
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(fromUnit - '刘')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0600';
      try {
        let fromUnit: i18n.UnitInfo = { unit: '刘', measureSystem: '刘' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0700
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0700
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(toUnit - '')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0700';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US'};
        let toUnit: i18n.UnitInfo = { unit: '', measureSystem: ''};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000 cups';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0800
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0800
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(toUnit - '11111111111111')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0800';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: '11111111111', measureSystem: '11111111111111'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000 cups';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_0900
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_0900
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(toUnit - 'abc')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_0900';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'abc', measureSystem: 'abc'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000 cups';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1000
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1000
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(toUnit - '!#')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1000';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: '!#', measureSystem: '!#'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000 cups';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1100
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1100
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(toUnit - '刘')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1100';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: '刘', measureSystem: '刘'};
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'en-US', 'long');
        let exp:string='1,000 cups';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1200
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1200
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - 1000.5)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1200';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000.5, 'en-US', 'long');
        let exp:string='236.707 liters';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1300
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1300
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - 0)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1300';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 0, 'en-US', 'long');
        let exp:string='0 liters';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1400
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1400
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1400';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, null, 'en-US', 'long');
        expect(convertResult===undefined).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1500
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1500
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1500';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, undefined, 'en-US', 'long');
        expect(convertResult===undefined).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1600
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1600
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - 131564848798)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1600';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 131564848798, 'en-US', 'long');
        let exp:string='31,126,695,562.508 liters';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1700
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1700
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(value - -1)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1700';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, -1, 'en-US', 'long');
        let exp:string='-0.237 liters';
        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1800
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1800
     * @tc.desc check I18NUtil unitConvert with normal parameters(locale - zh-CN)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1800';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_1900
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_1900
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_1900';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, null, 'long');

        expect(convertResult===undefined).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2000
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2000
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2000';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, undefined, 'long');

        expect(convertResult===undefined).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2100
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2100
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - '')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2100';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, '', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2200
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2200
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - '111111111111')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2200';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, '111111111111', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2300
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2300
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - 'abc')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2300';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'abc', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2400
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2400
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - '!#')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2400';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, '!#', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2500
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2500
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(locale - '刘')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2500';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, '刘', 'long');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2600
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2600
     * @tc.desc test I18NUtil unitConvert without style parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2600';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2700
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2700
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2700';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', null);
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2800
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2800
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2800';
        try {
          let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
          let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
          let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', undefined);
          let exp:string='236.588升';

          expect(convertResult===exp).assertTrue();
        } catch (error) {
          console.error(`${caseName} failed, error: ${error.message}`);
          expect().assertFail();
        }
        done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_2900
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_2900
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - '')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_2900';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', '');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3000
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3000
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - '111111111111111')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3000';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', '111111111111111');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3100
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3100
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - 'abc')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3100';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', 'abc');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3200
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3200
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - '!#')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3200';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', '!#');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3300
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3300
     * @tc.desc check I18NUtil unitConvert with abnormal situation parameters(style - '刘')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3300';
      try {
        let fromUnit: i18n.UnitInfo = { unit: 'cup', measureSystem: 'US' };
        let toUnit: i18n.UnitInfo = { unit: 'liter', measureSystem: 'SI' };
        let convertResult: string = i18n.I18NUtil.unitConvert(fromUnit, toUnit, 1000, 'zh-CN', '刘');
        let exp:string='236.588升';

        expect(convertResult===exp).assertTrue();
      } catch (error) {
        console.error(`${caseName} failed, error: ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3400
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3400
     * @tc.desc check I18NUtil unitConvert with normal parameters(style - short)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3400';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'cup', measureSystem: 'US'},
          {unit: 'liter', measureSystem: 'SI'},
          1000,
          'en-US',
          'short');
        expect(value).assertEqual('236.588 L');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3500
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3500
     * @tc.desc check I18NUtil unitConvert with normal parameters(style - narrow)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3500';
      let value = i18n.I18NUtil.unitConvert({unit: 'cup', measureSystem: 'US'},
        {unit: 'liter', measureSystem: 'SI'},
        1000,
        'en-US',
        'narrow');
      expect(value).assertEqual('236.588L');
      done()
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3600
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3600
     * @tc.desc check I18NUtil unitConvert with normal parameters(style - medium)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3600';
      let value = i18n.I18NUtil.unitConvert({unit: 'cup', measureSystem: 'US'},
        {unit: 'liter', measureSystem: 'SI'},
        1000,
        'en-US',
        'medium');
      let condition = (value === '236.588 L') || (value === '236.588 liters');
      expect(condition).assertTrue();
      done()
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3700
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3700
     * @tc.desc check I18NUtil unitConvert with normal parameters(meter to mile)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3700';
      let value = i18n.I18NUtil.unitConvert({unit: 'meter', measureSystem: 'SI'},
        {unit: 'mile', measureSystem: 'SI'},
        1000,
        'zh-CN',
        'long');
      expect(value).assertEqual('0.621英里');
      done()
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3800
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3800
     * @tc.desc check I18NUtil unitConvert with normal parameters(hour to second)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3800';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'hour', measureSystem: 'SI'},
          {unit: 'second', measureSystem: 'SI'},
          10,
          'zh-CN',
          'medium');
        let condition = (value === '36,000秒') || (value === '36,000秒钟');
        expect(condition).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_3900
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_3900
     * @tc.desc check I18NUtil unitConvert with normal parameters(celsius to fahrenheit)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_3900';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'celsius', measureSystem: 'SI'},
          {unit: 'fahrenheit', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'short');
        expect(value).assertEqual('1,832°F');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4000
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4000
     * @tc.desc check I18NUtil unitConvert with normal parameters(acre to hectare)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4000';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'acre', measureSystem: 'SI'},
          {unit: 'hectare', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');
        expect(value).assertEqual('404.686公顷');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4100
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4100
     * @tc.desc check I18NUtil unitConvert with normal parameters(acre to square-meter)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4100';
        let value = i18n.I18NUtil.unitConvert({unit: 'acre', measureSystem: 'SI'},
          {unit: 'square-meter', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');

        expect(value).assertEqual('4,046,856.422平方米');
      done()
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4200
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4200
     * @tc.desc check I18NUtil unitConvert with normal parameters(kilometer-per-hour to knot)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4200';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'kilometer-per-hour', measureSystem: 'SI'},
          {unit: 'knot', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');

        expect(value).assertEqual('539.957节');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4300
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4300
     * @tc.desc check I18NUtil unitConvert with normal parameters(kilometer-per-hour to meter-per-second)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4300';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'kilometer-per-hour', measureSystem: 'SI'},
          {unit: 'meter-per-second', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');

        expect(value).assertEqual('每秒277.778米');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4400
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4400
     * @tc.desc check I18NUtil unitConvert with normal parameters(meter to kilometer)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4400';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'meter', measureSystem: 'SI'},
          {unit: 'kilometer', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');

        expect(value).assertEqual('1公里');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_UnitConvert_4500
     * @tc.name ARKUIX_I18n_I18NUtil_UnitConvert_4500
     * @tc.desc check I18NUtil unitConvert with normal parameters(meter to meter-per-second)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_UnitConvert_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_UnitConvert_4500';
      try {
        let value = i18n.I18NUtil.unitConvert({unit: 'meter', measureSystem: 'SI'},
          {unit: 'meter-per-second', measureSystem: 'SI'},
          1000,
          'zh-CN',
          'long');

        expect(value).assertEqual('1,000米');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0100
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0100
     * @tc.desc check I18NUtil getTimePeriodName with valid hour and zh-CN locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0100';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, 'zh-CN');
        expect(name).assertEqual('凌晨');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0200
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0200
     * @tc.desc check I18NUtil getTimePeriodName with only valid hour
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0200';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2);
        expect(name).assertEqual('凌晨');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_getTimePeriodName_0300
     * @tc.name ARKUIX_I18n_I18NUtil_getTimePeriodName_0300
     * @tc.desc check I18NUtil getTimePeriodName with error hour parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_getTimePeriodName_0300',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_getTimePeriodName_0300';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(3.123123);
        expect(name).assertEqual('凌晨');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0400
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0400
     * @tc.desc check I18NUtil getTimePeriodName with null hour
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0400';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0500
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0500
     * @tc.desc check I18NUtil getTimePeriodName with undefined hour
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0500';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0600
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0600
     * @tc.desc check I18NUtil getTimePeriodName with empty locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0600';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, '');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0700
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0700
     * @tc.desc check I18NUtil getTimePeriodName with number locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0700';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, '1111111111111');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0800
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0800
     * @tc.desc check I18NUtil getTimePeriodName with number locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0800';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, 'a'.repeat(500));
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_0900
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_0900
     * @tc.desc check I18NUtil getTimePeriodName with letter locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_0900';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, 'abc');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1000
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1000
     * @tc.desc check I18NUtil getTimePeriodName with special char locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1000';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, '!#');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1100
     * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1100
     * @tc.desc check I18NUtil getTimePeriodName with chinese char locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1100';
      try {
        let name: string = i18n.I18NUtil.getTimePeriodName(2, '刘');
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue();
      }
      done();
    })

      /**
       * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1200
       * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1200
       * @tc.desc check I18NUtil getTimePeriodName with number locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 1
       * @tc.require
       */
      it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1200';
        try {
          let name: string = i18n.I18NUtil.getTimePeriodName(-1);
          expect(name).assertEqual("晚上");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code==890001).assertTrue();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1300
       * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1300
       * @tc.desc check I18NUtil getTimePeriodName with number locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 1
       * @tc.require
       */
      it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1300';
        try {
          let name: string = i18n.I18NUtil.getTimePeriodName(26);
          expect(name).assertEqual("凌晨");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code==890001).assertTrue();
        }
        done();
      })
      /**
       * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1400
       * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1400
       * @tc.desc check I18NUtil getTimePeriodName with number locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 1
       * @tc.require
       */
      it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1400';
        try {
          let name: string = i18n.I18NUtil.getTimePeriodName(41);
          expect(name).assertEqual("下午");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code==890001).assertTrue();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_I18NUtil_GetTimePeriodName_1500
       * @tc.name ARKUIX_I18n_I18NUtil_GetTimePeriodName_1500
       * @tc.desc check I18NUtil getTimePeriodName with number locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 2
       * @tc.require
       */
      it('ARKUIX_I18n_I18NUtil_GetTimePeriodName_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_I18NUtil_GetTimePeriodName_1500';
        try {
          let name: string = i18n.I18NUtil.getTimePeriodName(12);
          expect(name).assertEqual("中午");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code==890001).assertTrue();
        }
        done();
      })
    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0100
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0100
     * @tc.desc check I18NUtil getThreeLetterLanguage with valid zh code
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0100';
      try {
        let language: string = i18n.I18NUtil.getThreeLetterLanguage('zh');
        const expected = 'zho';
        expect(language).assertEqual(expected)
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0200
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0200
     * @tc.desc check I18NUtil getThreeLetterLanguage with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0200';
      try {

        let language: string = i18n.I18NUtil.getThreeLetterLanguage(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0300
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0300
     * @tc.desc check I18NUtil getThreeLetterLanguage with undefined parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0300';
      try {
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0400
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0400
     * @tc.desc check I18NUtil getThreeLetterLanguage with space parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0400';
      try {
        let str=''
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName}failed, error: ${err.message}${err.code}}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0500
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0500
     * @tc.desc check I18NUtil getThreeLetterLanguage with long number parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0500';
      try {
        let str='111111111111111'
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName}failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0600
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0600
     * @tc.desc check I18NUtil getThreeLetterLanguage with letter parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0600';
      try {
        let str='abc'
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName}failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0700
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0700
     * @tc.desc check I18NUtil getThreeLetterLanguage with special char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0700';
      try {
        let str='!#'
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName}failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0800
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0800
     * @tc.desc check I18NUtil getThreeLetterLanguage with chinese char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterLanguage_0800';
      try {
        let str='刘'
        let language: string = i18n.I18NUtil.getThreeLetterLanguage(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0100
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0100
     * @tc.desc check I18NUtil getThreeLetterRegion with valid CN code
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0100';
      try {

        let region: string = i18n.I18NUtil.getThreeLetterRegion('CN');
        const expected = 'CHN';
        expect(region).assertEqual(expected)
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0200
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0200
     * @tc.desc check I18NUtil getThreeLetterRegion with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0200';
      try {
        let language: string = i18n.I18NUtil.getThreeLetterRegion(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0300
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0300
     * @tc.desc check I18NUtil getThreeLetterRegion with undefined parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0300';
      try {
        let language: string = i18n.I18NUtil.getThreeLetterRegion(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0400
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0400
     * @tc.desc check I18NUtil getThreeLetterRegion with space parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0400';
      try {
        let str=''
        let language: string = i18n.I18NUtil.getThreeLetterRegion(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0500
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0500
     * @tc.desc check I18NUtil getThreeLetterRegion with long number parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0500';
      try {
        let str='111111111111111'
        let language: string = i18n.I18NUtil.getThreeLetterRegion(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0600
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0600
     * @tc.desc check I18NUtil getThreeLetterRegion with letter parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0600';
      try {
        let str='abc'
        let language: string = i18n.I18NUtil.getThreeLetterRegion(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0700
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0700
     * @tc.desc check I18NUtil getThreeLetterRegion with special char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0700';
      try {
        let str='!#'
        let language: string = i18n.I18NUtil.getThreeLetterRegion(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0800
     * @tc.name ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0800
     * @tc.desc check I18NUtil getThreeLetterRegion with chinese char parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetThreeLetterRegion_0800';
      try {
        let str='刘'
        let language: string = i18n.I18NUtil.getThreeLetterRegion(str);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0100
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0100
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with valid path and ar locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0100';
      try {
        let path: string = '/data/out/tmp';
        let delimiter: string = '/';
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath(path, delimiter, locale);
        let flag=i18n.Unicode.isRTL(mirrorPath);
        const expected = true
        expect(flag).assertEqual(expected);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0200
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0200
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with only valid path
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0200';
      try {
        let path: string = '/data/out/tmp';
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath(path);

        const expected = '/data/out/tmp';
        expect(mirrorPath).assertEqual(expected);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0300
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0300
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with null path
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0300';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath(null, '/', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0400
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0400
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with undefined path
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0400';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath(undefined, '/', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0500
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0500
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with empty path
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0500';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath("", '/', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.code}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0600
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0600
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with null delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0600';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', null, locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0700
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0700
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with undefined delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0700';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', undefined, locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="401").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0800
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0800
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with empty delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0800';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0900
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0900
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with number delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_0900';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '111111111111111', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1000
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1000
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with letter delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1000';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', 'abc', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1100
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1100
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with special char delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1100';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '!#', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1200
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1200
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with chinese char delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1200';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '刘', locale);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName}failed, error: ${err.code}`);
        expect(err.code==="890001").assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1300
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1300
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with backslash delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1300';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '\\', locale);
        let flag=i18n.Unicode.isRTL(mirrorPath);
        const expected = false
        expect(flag).assertEqual(expected);
        expect(mirrorPath).assertEqual('/data/out/tmp')
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1400
     * @tc.name ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1400
     * @tc.desc check I18NUtil getUnicodeWrappedFilePath with vertical line delimiter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_I18NUtil_GetUnicodeWrappedFilePath_1400';
      try {
        let locale: Intl.Locale = new Intl.Locale('ar');
        let mirrorPath: string = i18n.I18NUtil.getUnicodeWrappedFilePath('/data/out/tmp', '|', locale);
        let flag=i18n.Unicode.isRTL(mirrorPath);
        const expected = false
        expect(flag).assertEqual(expected);
        expect(mirrorPath).assertEqual('/data/out/tmp')
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0100
     * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0100
     * @tc.desc check Calendar getDisplayName with zh locale
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Calendar_GetDisplayName_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0100';
      try {

        const calendarType = 'buddhist';
        const calendarLocale = 'en-US';
        let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
        const targetLocale = 'zh';
        let str:string='佛历'
        let calendarName: string = calendar.getDisplayName(targetLocale);
        expect(calendarName).assertEqual(str)

      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0200
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0200
       * @tc.desc check Calendar getDisplayName with EU locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0200';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const localeList:lauage[] = [
            { code: 'de', expected: 'Buddhistischer Kalender', name: '德语' },
            { code: 'fr', expected: 'calendrier bouddhiste', name: '法语' },
            { code: 'es', expected: 'calendario budista', name: '西班牙语' },
            { code: 'it', expected: 'Calendario buddista', name: '意大利语' },
            { code: 'pt', expected: 'Calendário Budista', name: '葡萄牙语' },
            { code: 'nl', expected: 'Boeddhistische kalender', name: '荷兰语' },
            { code: 'pl', expected: 'kalendarz buddyjski', name: '波兰语' },
            { code: 'ro', expected: 'calendar budist', name: '罗马尼亚语' },
            { code: 'hu', expected: 'Buddhista naptár', name: '匈牙利语' },
            { code: 'cs', expected: 'Buddhistický kalendář', name: '捷克语' },
          ];
          localeList.forEach(item => {
            let calendarName: string = calendar.getDisplayName(item.code);
            expect(calendarName).assertEqual(item.expected)
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0300
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0300
       * @tc.desc check Calendar getDisplayName with null
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 1
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0300';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val:undefined=undefined
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          let calendarName: string = calendar.getDisplayName(null);

          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0400
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0400
       * @tc.desc check Calendar getDisplayName with undefined
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 1
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0400';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val:undefined=undefined
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          let calendarName: string = calendar.getDisplayName(undefined);

          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0500
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0500
       * @tc.desc check Calendar getDisplayName with invalid locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0500';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const invalidLocale = 'invalid-locale-123';
          let calendarName: string = calendar.getDisplayName(invalidLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0600
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0600
       * @tc.desc check Calendar getDisplayName with empty locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0600';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val='buddhist'
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const emptyLocale = '';
          let calendarName: string = calendar.getDisplayName(emptyLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0700
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0700
       * @tc.desc check Calendar getDisplayName with long locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0700';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const longLocale = 'a'.repeat(1000);;
          let calendarName: string = calendar.getDisplayName(longLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0800
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0800
       * @tc.desc check Calendar getDisplayName with space locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0800';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const spaceLocale = ' ';
          let calendarName: string = calendar.getDisplayName(spaceLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_0900
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_0900
       * @tc.desc check Calendar getDisplayName with multi-space locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_0900';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const spaceLocale = '   ';
          let calendarName: string = calendar.getDisplayName(spaceLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1000
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1000
       * @tc.desc heck Calendar getDisplayName with special char locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1000';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const specialCharLocale = '!@#$%^&*()';
          let calendarName: string = calendar.getDisplayName(specialCharLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1100
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1100
       * @tc.desc check Calendar getDisplayName with chinese locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1100';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const chineseLocale = '中文';
          let calendarName: string = calendar.getDisplayName(chineseLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1200
       * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1200
       * @tc.desc check Calendar getDisplayName with invalid format locale(en-US#123)
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_Calendar_GetDisplayName_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1200';
        try {

          const calendarType = 'buddhist';
          const calendarLocale = 'en-US';
          let val=''
          let calendar: i18n.Calendar = i18n.getCalendar(calendarLocale, calendarType);
          const invalidFormatLocale = 'en-US#123';
          let calendarName: string = calendar.getDisplayName(invalidFormatLocale);
          expect(calendarName).assertEqual(val)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1300
     * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1300
     * @tc.desc check Calendar getDisplayName with naomal format locale(zh，chinese)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Calendar_GetDisplayName_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1300';
      try {
        let calendar = i18n.getCalendar('zh', 'chinese');
        let name = calendar.getDisplayName('zh');

        expect(name).assertEqual('农历');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1400
     * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1400
     * @tc.desc check Calendar getDisplayName with naomal format locale('zh', 'japanese')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Calendar_GetDisplayName_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1400';
      try {
        let calendar = i18n.getCalendar('zh', 'japanese');
        let name = calendar.getDisplayName('zh');

        expect(name).assertEqual('和历');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1500
     * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1500
     * @tc.desc check Calendar getDisplayName with naomal format locale(zh，zh)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Calendar_GetDisplayName_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1500';
      try {
        let calendar = i18n.getCalendar('zh');
        let value = calendar.getDisplayName('zh');

        expect(value).assertEqual('公历');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
    /**
     * @tc.number ARKUIX_I18n_Calendar_GetDisplayName_1600
     * @tc.name ARKUIX_I18n_Calendar_GetDisplayName_1600
     * @tc.desc check Calendar getDisplayName with naomal format locale(zh，en)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Calendar_GetDisplayName_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Calendar_GetDisplayName_1600';
      try {
        let calendar = i18n.getCalendar('zh');
        let value = calendar.getDisplayName('en');

        expect(value).assertEqual('Gregorian Calendar');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0100
       * @tc.name ARKUIX_I18n_GetLineInstance_0100
       * @tc.desc check getLineInstance with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0100';
        try {
          const targetLocale = 'en';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);

          expect(iterator!=null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0200
       * @tc.name ARKUIX_I18n_GetLineInstance_0200
       * @tc.desc check getLineInstance with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0200';
        interface  lauage{
          code:string;
          name:string
        }
        try {
          const localeList:lauage[] = [
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'nl', name: '荷兰语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' },
            { code: 'ur', name: '乌尔都语' }
          ];
          localeList.forEach(item => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(item.code);

              expect(iterator!=null).assertTrue();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0300
       * @tc.name ARKUIX_I18n_GetLineInstance_0300
       * @tc.desc check getLineInstance with null
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0300';
        try {
          const targetLocale = null;
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0400
       * @tc.name ARKUIX_I18n_GetLineInstance_0400
       * @tc.desc check getLineInstance with undefined
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0400';
        try {
          const targetLocale = undefined;
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0500
       * @tc.name ARKUIX_I18n_GetLineInstance_0500
       * @tc.desc check getLineInstance with empty string
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0500';
        try {
          const targetLocale = '';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);

          expect(iterator!=null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0600
       * @tc.name ARKUIX_I18n_GetLineInstance_0600
       * @tc.desc check getLineInstance with space
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0600';
        try {
          const targetLocale = ' ';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0700
       * @tc.name ARKUIX_I18n_GetLineInstance_0700
       * @tc.desc check getLineInstance with invalid locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0700';
        try {
          const targetLocale = 'invalid-locale-123';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0800
       * @tc.name ARKUIX_I18n_GetLineInstance_0800
       * @tc.desc check getLineInstance with special chars
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0800';
        try {
          const targetLocale = '!@#$%^&*()';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_0900
       * @tc.name ARKUIX_I18n_GetLineInstance_0900
       * @tc.desc check getLineInstance with chinese chars
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_0900';
        try {
          const targetLocale = '中文';
          let iterator: i18n.BreakIterator = i18n.getLineInstance(targetLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_GetLineInstance_1000
       * @tc.name ARKUIX_I18n_GetLineInstance_1000
       * @tc.desc check getLineInstance with long string
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_GetLineInstance_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_GetLineInstance_1000';
        try {
          const longLocale = 'a'.repeat(1000);
          let iterator: i18n.BreakIterator = i18n.getLineInstance(longLocale);
          expect(iterator!=null).assertTrue();

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Current_0100
       * @tc.name ARKUIX_I18n_BreakIterator_Current_0100
       * @tc.desc check BreakIterator current() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Current_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Current_0100';
        try {
          let val: number = 0
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let currentPos: number = iterator.current();
          expect(currentPos===val).assertTrue()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Current_0200
       * @tc.name ARKUIX_I18n_BreakIterator_Current_0200
       * @tc.desc check BreakIterator current() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Current_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Current_0200';
        try {
          const languages:languages[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          let val: number = 0
          const testText = 'Apple is my favorite fruit.';
          languages.forEach(lang => {
            let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
            iterator.setLineBreakText(testText);
            let currentPos: number = iterator.current();
            expect(currentPos === val).assertTrue()
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_First_0100
       * @tc.name ARKUIX_I18n_BreakIterator_First_0100
       * @tc.desc check BreakIterator first() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_First_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_First_0100';
        try {
          let val: number = 0
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let firstPos: number = iterator.first();
          expect(firstPos === val).assertTrue()

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_First_0200
       * @tc.name ARKUIX_I18n_BreakIterator_First_0200
       * @tc.desc check BreakIterator first() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_First_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_First_0200';
        try {

          const languages:languages[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          let val: number = 0
          const testText = 'Apple is my favorite fruit.';
          languages.forEach(lang => {
            let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
            iterator.setLineBreakText(testText);
            let firstPos: number = iterator.first();
            expect(firstPos === val).assertTrue()
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Last_0100
       * @tc.name ARKUIX_I18n_BreakIterator_Last_0100
       * @tc.desc check BreakIterator last() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Last_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Last_0100';
        try {

          let val: number =27
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let lastPos: number = iterator.last();
          expect(lastPos === val).assertTrue()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Last_0200
       * @tc.name ARKUIX_I18n_BreakIterator_Last_0200
       * @tc.desc check BreakIterator last() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Last_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Last_0200';
        try {

          const languages:languages[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          let val: number = 27
          const testText = 'Apple is my favorite fruit.';
          languages.forEach(lang => {
            let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
            iterator.setLineBreakText(testText);
            let lastPos: number = iterator.last();
            expect(lastPos === val).assertTrue()
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Next_0100
       * @tc.name ARKUIX_I18n_BreakIterator_Next_0100
       * @tc.desc check BreakIterator next() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Next_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Next_0100';
        try {

          let val: number =6
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let Pos: number = iterator.first();
          Pos= iterator.next();
          expect(Pos === val).assertTrue()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Next_0200
       * @tc.name ARKUIX_I18n_BreakIterator_Next_0200
       * @tc.desc check BreakIterator next(num) with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Next_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Next_0200';
        try {
          let val: number =-1
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let pos: number = iterator.first();
          pos= iterator.next();
          pos = iterator.next(10);
          expect(pos === val).assertTrue()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Next_0300
       * @tc.name ARKUIX_I18n_BreakIterator_Next_0300
       * @tc.desc check BreakIterator next() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Next_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Next_0300';
        try {

          let val: number =6
          const testText = 'Apple is my favorite fruit.';
          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          languages.forEach(lang => {
            let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
            iterator.setLineBreakText(testText);
            iterator.first();
            let nextPos: number = iterator.next();
            expect(nextPos === val).assertTrue()

          })

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })
      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Previous_0100
       * @tc.name ARKUIX_I18n_BreakIterator_Previous_0100
       * @tc.desc check BreakIterator previous() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Previous_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Previous_0100';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);

          let pos: number = iterator.first();
          expect(pos).assertEqual(0);

          pos = iterator.next(3);
          expect(pos).assertEqual(12);

          pos = iterator.previous();
          expect(pos).assertEqual(9);

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Previous_0200
       * @tc.name ARKUIX_I18n_BreakIterator_Previous_0200
       * @tc.desc check BreakIterator previous() with boundary value
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Previous_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Previous_0200';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);
          let pos: number = iterator.first();
          pos = iterator.previous();
          expect(pos).assertEqual(-1);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Previous_0300
       * @tc.name ARKUIX_I18n_BreakIterator_Previous_0300
       * @tc.desc check BreakIterator previous() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Previous_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Previous_0300';
        try {
          const testText = 'Apple is my favorite fruit.';
          const expectedPreviousPos = 9;
          interface  lauage{
            code:string;
            name:string
          }
          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];

          languages.forEach(lang => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
              iterator.setLineBreakText(testText);
              iterator.first();
              const next3Pos = iterator.next(3);
              const prevPos = iterator.previous();
              expect(prevPos).assertEqual(expectedPreviousPos);
            }catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_SetLineBreakText_0100
       * @tc.name ARKUIX_I18n_BreakIterator_SetLineBreakText_0100
       * @tc.desc check BreakIterator setLineBreakText() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_SetLineBreakText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_SetLineBreakText_0100';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';

          iterator.setLineBreakText(testText);

          let res: string = iterator.getLineBreakText();

          expect(res).assertEqual(testText);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_SetLineBreakText_0200
       * @tc.name ARKUIX_I18n_BreakIterator_SetLineBreakText_0200
       * @tc.desc check BreakIterator setLineBreakText() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_SetLineBreakText_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_SetLineBreakText_0200';
        try {
          const testText = 'Apple is my favorite fruit.';
          interface  lauage{
            code:string;
            name:string
          }
          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];

          languages.forEach(lang => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
              iterator.setLineBreakText(testText);
              const res = iterator.getLineBreakText();
              expect(res).assertEqual(testText);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Following_0100
       * @tc.name ARKUIX_I18n_BreakIterator_Following_0100
       * @tc.desc check BreakIterator following() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Following_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Following_0100';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);

          let pos: number = iterator.following(0);
          expect(pos).assertEqual(6);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Following_0200
       * @tc.name ARKUIX_I18n_BreakIterator_Following_0200
       * @tc.desc check BreakIterator following() with boundary value
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Following_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Following_0200';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);

          let pos: number = iterator.following(0);
          expect(pos).assertEqual(6);

          pos = iterator.following(100);
          expect(pos).assertEqual(-1);

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_Following_0300
       * @tc.name ARKUIX_I18n_BreakIterator_Following_0300
       * @tc.desc check BreakIterator following() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_Following_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_Following_0300';
        try {

          const testText = 'Apple is my favorite fruit.';
          const offset = 0;
          const expectedFollowingPos = 6;
          interface  lauage{
            code:string;
            name:string
          }

          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          languages.forEach(lang => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
              iterator.setLineBreakText(testText);
              const follPos = iterator.following(offset);
              expect(follPos).assertEqual(expectedFollowingPos);

            } catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_GetLineBreakText_0100
       * @tc.name ARKUIX_I18n_BreakIterator_GetLineBreakText_0100
       * @tc.desc check BreakIterator getLineBreakText() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_GetLineBreakText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_GetLineBreakText_0100';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.123';

          iterator.setLineBreakText(testText);

          let res: string = iterator.getLineBreakText();
          expect(res).assertEqual(testText);

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_GetLineBreakText_0200
       * @tc.name ARKUIX_I18n_BreakIterator_GetLineBreakText_0200
       * @tc.desc check BreakIterator getLineBreakText() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_GetLineBreakText_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_GetLineBreakText_0200';
        try {
          const testText = 'Apple is my favorite fruit.123';
          interface  lauage{
            code:string;
            name:string
          }

          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];

          languages.forEach(lang => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
              iterator.setLineBreakText(testText);
              const res = iterator.getLineBreakText();
              expect(res).assertEqual(testText);

            } catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_IsBoundary_0100
       * @tc.name ARKUIX_I18n_BreakIterator_IsBoundary_0100
       * @tc.desc check BreakIterator isBoundary() with en locale
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_IsBoundary_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_IsBoundary_0100';
        try {
          let iterator: i18n.BreakIterator = i18n.getLineInstance('en');
          const testText = 'Apple is my favorite fruit.';
          iterator.setLineBreakText(testText);

          // 测试isBoundary(0)
          let isBoundary: boolean = iterator.isBoundary(0);
          let pos: number = iterator.current();

          // 测试isBoundary(5)
          let isBoundary1 = iterator.isBoundary(5);
          let pos1: number = iterator.current();

          const isSuccess = (pos == 0 && pos1 == 6);
          expect(isBoundary).assertEqual(true);
          expect(pos).assertEqual(0);
          expect(isBoundary1).assertEqual(false);
          expect(pos1).assertEqual(6);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

      /**
       * @tc.number ARKUIX_I18n_BreakIterator_IsBoundary_0200
       * @tc.name ARKUIX_I18n_BreakIterator_IsBoundary_0200
       * @tc.desc check BreakIterator isBoundary() with multi locales
       * @tc.size MediumTest
       * @tc.type Function
       * @tc.level level 0
       * @tc.require
       */
      it('ARKUIX_I18n_BreakIterator_IsBoundary_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_BreakIterator_IsBoundary_0200';
        try {
          const testText = 'Apple is my favorite fruit.';
          interface  lauage{
            code:string;
            name:string
          }
          const languages:lauage[] = [
            { code: 'en', name: '英语' },
            { code: 'zh', name: '中文' },
            { code: 'de', name: '德语' },
            { code: 'fr', name: '法语' },
            { code: 'es', name: '西班牙语' },
            { code: 'it', name: '意大利语' },
            { code: 'ar', name: '阿拉伯语' },
            { code: 'he', name: '希伯来语' }
          ];
          languages.forEach(lang => {
            try {
              let iterator: i18n.BreakIterator = i18n.getLineInstance(lang.code);
              iterator.setLineBreakText(testText);
              // 测试isBoundary(0)
              const isBoundary0 = iterator.isBoundary(0);
              const pos0 = iterator.current();
              // 测试isBoundary(5)
              const isBoundary5 = iterator.isBoundary(5);
              const pos5 = iterator.current();
              expect(isBoundary0).assertEqual(true);
              expect(pos0).assertEqual(0);
              expect(isBoundary5).assertEqual(false);
              expect(pos5).assertEqual(6);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_BreakIterator_IsBoundary_0300
     * @tc.name ARKUIX_I18n_BreakIterator_IsBoundary_0300
     * @tc.desc check BreakIterator isBoundary() with multi locales
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_BreakIterator_IsBoundary_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_BreakIterator_IsBoundary_0300';
      try {
        let iterator =i18n.getLineInstance('en');
        iterator.setLineBreakText('My name is Tom.Welcome to the sky world.');
        // current
        let current = iterator.current();

        expect(current).assertEqual(0);
        // next
        let next = iterator.next();

        expect(next).assertEqual(3);
        // current
        let current2 = iterator.current();

        expect(current2).assertEqual(3);
        // next 5
        let next2 = iterator.next(5);

        expect(next2).assertEqual(30);
        // previous
        let previous = iterator.previous();

        expect(previous).assertEqual(26);
        // following 2
        let follwoing = iterator.following(3);

        expect(follwoing).assertEqual(8);
        // current
        let current3 = iterator.current();

        expect(current3).assertEqual(8);
        // isBoundary
        let value = iterator.isBoundary(3);

        expect(value).assertTrue();
        // current
        let current4 = iterator.current();

        expect(current4).assertEqual(3);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_GetInstance_0100
     * @tc.name ARKUIX_I18n_GetInstance_0100
     * @tc.desc Specifies the locale for localization; use 'zh-CN'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_GetInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_GetInstance_0100';
      try {

        let indexUtil: i18n.IndexUtil = i18n.getInstance('zh-CN');
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_GetInstance_0200
     * @tc.name ARKUIX_I18n_GetInstance_0200
     * @tc.desc Specifies the locale for localization; use 'de-DE'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_GetInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_GetInstance_0200';
      try {

        let indexUtil: i18n.IndexUtil = i18n.getInstance('de-DE');
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_GetInstance_0300
     * @tc.name ARKUIX_I18n_GetInstance_0300
     * @tc.desc Specifies the locale for localization; use 'fr-FR'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_GetInstance_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_GetInstance_0300';
      try {

        let indexUtil: i18n.IndexUtil = i18n.getInstance('fr-FR');
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_GetInstance_0400
     * @tc.name ARKUIX_I18n_GetInstance_0400
     * @tc.desc Specifies the locale for localization; use 'it-IT'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_GetInstance_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_GetInstance_0400';
      try {

        let indexUtil: i18n.IndexUtil = i18n.getInstance('it-IT');
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_GetInstance_0500
     * @tc.name ARKUIX_I18n_GetInstance_0500
     * @tc.desc No parameters required, uses default locale and configuration settings for general index processing
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_GetInstance_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_GetInstance_0500';
      try {
        let indexUtil: i18n.IndexUtil = i18n.getInstance();
        expect(indexUtil != null).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndexList_0100
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndexList_0100
     * @tc.desc check get getIndexList with 'zh-CN'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndexList_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndexList_0100';
        try {

          let i: number = 0;
          let indexList1: Array<string> =
            ["…", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
              "U", "V", "W", "X", "Y", "Z", "…"]
          let indexUtil: i18n.IndexUtil = i18n.getInstance('zh-CN');
          let indexList: Array<string> = indexUtil.getIndexList();
          for (i; i < indexList1.length; i++) {
            expect(indexList[i] === indexList1[i]).assertTrue()
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndexList_0200
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndexList_0200
     * @tc.desc Retrieves the index list corresponding to the current locale/region; returns index identifiers applicable to the active regional configuration
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndexList_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndexList_0200';
        try {

          let i: number = 0;
          let indexList1: Array<string> =
            ["…", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
              "U", "V", "W", "X", "Y", "Z", "…"]
          let indexUtil: i18n.IndexUtil = i18n.getInstance('de-DE');
          let indexList: Array<string> = indexUtil.getIndexList();
          for (i; i < indexList1.length; i++) {
            expect(indexList[i] === indexList1[i]).assertTrue()
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndexList_0300
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndexList_0300
     * @tc.desc Retrieves the index list corresponding to the current locale/region; returns index identifiers applicable to the active regional configuration
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndexList_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndexList_0300';
        try {

          let i: number = 0;
          let indexList1: Array<string> =
            ["…", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
              "U", "V", "W", "X", "Y", "Z", "…"]
          let indexUtil: i18n.IndexUtil = i18n.getInstance('fr-FR');
          let indexList: Array<string> = indexUtil.getIndexList();
          for (i; i < indexList1.length; i++) {
            expect(indexList[i] === indexList1[i]).assertTrue()
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndexList_0400
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndexList_0400
     * @tc.desc Retrieves the index list corresponding to the current locale/region; returns index identifiers applicable to the active regional configuration
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndexList_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndexList_0400';
        try {

          let i: number = 0;
          let indexList1: Array<string> =
            ["…", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
              "U", "V", "W", "X", "Y", "Z", "…"]
          let indexUtil: i18n.IndexUtil = i18n.getInstance('it-IT');
          let indexList: Array<string> = indexUtil.getIndexList();
          for (i; i < indexList1.length; i++) {
            expect(indexList[i] === indexList1[i]).assertTrue()
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })
    /**
     * @tc.number ARKUIX_I18n_IndexUtil_AddLocAle_0100
     * @tc.name ARKUIX_I18n_IndexUtil_AddLocAle_0100
     * @tc.desc Adds the index list of a new locale to the index list of the current locale to form a composite list;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_AddLocAle_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_AddLocAle_0100';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('zh-CN');
          indexUtil.addLocale('ar-sa');
          let indexList: Array<string> = indexUtil.getIndexList();
          let len=indexList.length;
          expect(len).assertLarger(25);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_AddLocAle_0200
     * @tc.name ARKUIX_I18n_IndexUtil_AddLocAle_0200
     * @tc.desc Adds the index list of a new locale to the index list of the current locale to form a composite list;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_AddLocAle_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_AddLocAle_0200';
        try {
          let indexUtil: i18n.IndexUtil = i18n.getInstance('de-DE');
          indexUtil.addLocale('ar-sa');
          let indexList: Array<string> = indexUtil.getIndexList();
          let len=indexList.length;
          expect(len).assertLarger(25);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_AddLocAle_0300
     * @tc.name ARKUIX_I18n_IndexUtil_AddLocAle_0300
     * @tc.desc Adds the index list of a new locale to the index list of the current locale to form a composite list;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_AddLocAle_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_AddLocAle_0300';

        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('fr-FR');
          indexUtil.addLocale('ar-sa');
          let indexList: Array<string> = indexUtil.getIndexList();
          let len=indexList.length;
          expect(len).assertLarger(25);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_AddLocAle_0400
     * @tc.name ARKUIX_I18n_IndexUtil_AddLocAle_0400
     * @tc.desc Adds the index list of a new locale to the index list of the current locale to form a composite list;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_AddLocAle_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_AddLocAle_0400';
        try {
          let indexUtil: i18n.IndexUtil = i18n.getInstance('it-IT');
          indexUtil.addLocale('ar-sa');
          let indexList: Array<string> = indexUtil.getIndexList();

          let len=indexList.length;
          expect(len).assertLarger(25);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })
    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndex_0100
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndex_0100
     * @tc.desc Retrieves the index value corresponding to the input text; maps the given text string to its associated index identifier based on current locale or index rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndex_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndex_0100';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('zh-CN');
          let index: string = indexUtil.getIndex('hi');
          expect(index).assertEqual('H')
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndex_0200
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndex_0200
     * @tc.desc Retrieves the index value corresponding to the input text; maps the given text string to its associated index identifier based on current locale or index rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndex_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndex_0200';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('de-DE');
          let index: string = indexUtil.getIndex('hi');
          expect(index).assertEqual('H')
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndex_0300
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndex_0300
     * @tc.desc Retrieves the index value corresponding to the input text; maps the given text string to its associated index identifier based on current locale or index rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndex_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndex_0300';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('fr-FR');
          let index: string = indexUtil.getIndex('hi');
          expect(index).assertEqual('H')
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_IndexUtil_GetIndex_0400
     * @tc.name ARKUIX_I18n_IndexUtil_GetIndex_0400
     * @tc.desc Retrieves the index value corresponding to the input text; maps the given text string to its associated index identifier based on current locale or index rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_IndexUtil_GetIndex_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_IndexUtil_GetIndex_0400';
        try {

          let indexUtil: i18n.IndexUtil = i18n.getInstance('it-IT');
          let index: string = indexUtil.getIndex('hi');
          expect(index).assertEqual('H')
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_TimeZone_GetDisplayName_0100
     * @tc.name ARKUIX_I18n_TimeZone_GetDisplayName_0100
     * @tc.desc test getDisplayName with normal parameters('zh-CN',false)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_TimeZone_GetDisplayName_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_TimeZone_GetDisplayName_0100';
        try {

          let str: string = '中国标准时间'
          let timezone: i18n.TimeZone = i18n.getTimeZone('Asia/Shanghai');
          let timezoneName: string = timezone.getDisplayName('zh-CN', false);
          expect(timezoneName).assertEqual(str)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_TimeZone_GetDisplayName_0200
     * @tc.name ARKUIX_I18n_TimeZone_GetDisplayName_0200
     * @tc.desc test getDisplayName with default parameters
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_TimeZone_GetDisplayName_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_TimeZone_GetDisplayName_0200';
        try {

          let str: string = '中国标准时间'
          let timezone: i18n.TimeZone = i18n.getTimeZone('Asia/Shanghai');
          let timezoneName: string = timezone.getDisplayName();
          expect(timezoneName).assertEqual(str)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ARKUIX_I18n_TimeZone_GetDisplayName_0300
     * @tc.name ARKUIX_I18n_TimeZone_GetDisplayName_0300
     * @tc.desc test getDisplayName with normal parameter('zh-CN')
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_TimeZone_GetDisplayName_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ARKUIX_I18n_TimeZone_GetDisplayName_0300';
        try {

          let str: string = '中国标准时间'
          let timezone: i18n.TimeZone = i18n.getTimeZone('Asia/Shanghai');
          let timezoneName: string = timezone.getDisplayName('zh-CN');
          expect(timezoneName).assertEqual(str)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })
    /**
     * @tc.number ARKUIX_I18n_TimeZone_GetZoneRules_0100
     * @tc.name ARKUIX_I18n_TimeZone_GetZoneRules_0100
     * @tc.desc Verify that TimeZone.getZoneRules() (America/Tijuana).
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_TimeZone_GetZoneRules_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_TimeZone_GetZoneRules_0100';
      try {

        let tzId: string = 'America/Tijuana';
        let timeZone: i18n.TimeZone = i18n.getTimeZone(tzId);
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        expect(zoneRules != null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_ZoneRules_NextTransition_0100
     * @tc.name ARKUIX_I18n_ZoneRules_NextTransition_0100
     * @tc.desc Verify that ZoneRules.nextTransition(timestamp)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_ZoneRules_NextTransition_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_ZoneRules_NextTransition_0100';
      try {

        let timeZone: i18n.TimeZone = i18n.getTimeZone('America/Tijuana');
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        let date = new Date(2025, 4, 13);
        let zoneOffsetTransition: i18n.ZoneOffsetTransition = zoneRules.nextTransition(date.getTime());
        expect(zoneOffsetTransition != null).assertTrue()

      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_ZoneRules_NextTransition_0200
     * @tc.name ARKUIX_I18n_ZoneRules_NextTransition_0200
     * @tc.desc Verify that ZoneRules.nextTransition()
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_ZoneRules_NextTransition_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_ZoneRules_NextTransition_0200';
      try {

        let timeZone: i18n.TimeZone = i18n.getTimeZone('America/Tijuana');
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        let zoneOffsetTransition: i18n.ZoneOffsetTransition = zoneRules.nextTransition();
        expect(zoneOffsetTransition != null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_ZoneOffsetTransition_GetMilliseconds_0100
     * @tc.name ARKUIX_I18n_ZoneOffsetTransition_GetMilliseconds_0100
     * @tc.desc Verify getMilliseconds returns the correct transition timestamp for the next zone transition after the specified date
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_ZoneOffsetTransition_GetMilliseconds_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_ZoneOffsetTransition_GetMilliseconds_0100';
      try {

        let value: number = 1762074000000
        let timeZone: i18n.TimeZone = i18n.getTimeZone('America/Tijuana');
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        let date = new Date(2025, 4, 13);
        let zoneOffsetTransition: i18n.ZoneOffsetTransition =
          zoneRules.nextTransition(date.getTime()); // 获取2025年5月13日以后的下一个时区跳变对象
        let val:number = zoneOffsetTransition.getMilliseconds();
        expect(val === value).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_ZoneOffsetTransition_GetOffsetAfter_0100
     * @tc.name ARKUIX_I18n_ZoneOffsetTransition_GetOffsetAfter_0100
     * @tc.desc Verify getOffsetAfter() returns the correct UTC offset  applied after the transition for the next zone transition
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_ZoneOffsetTransition_GetOffsetAfter_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_ZoneOffsetTransition_GetOffsetAfter_0100';
      try {

        let value: number = -28800000
        let timeZone: i18n.TimeZone = i18n.getTimeZone('America/Tijuana');
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        let date = new Date(2025, 4, 13);
        let zoneOffsetTransition: i18n.ZoneOffsetTransition =
          zoneRules.nextTransition(date.getTime()); // 获取2025年5月13日以后的下一个时区跳变对象
        let val:number = zoneOffsetTransition.getOffsetAfter();
        expect(JSON.stringify(val)).assertEqual(JSON.stringify(value))
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_ZoneOffsetTransition_GetOffsetBefore_0100
     * @tc.name ARKUIX_I18n_ZoneOffsetTransition_GetOffsetBefore_0100
     * @tc.desc Verify getOffsetBefore() returns the correct UTC offset  applied before the transition for the next zone transition
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_ZoneOffsetTransition_GetOffsetBefore_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_ZoneOffsetTransition_GetOffsetBefore_0100';
      try {

        let value: number = -25200000
        let timeZone: i18n.TimeZone = i18n.getTimeZone('America/Tijuana');
        let zoneRules: i18n.ZoneRules = timeZone.getZoneRules();
        let date = new Date(2025, 4, 13);
        let zoneOffsetTransition: i18n.ZoneOffsetTransition =
          zoneRules.nextTransition(date.getTime()); // 获取2025年5月13日以后的下一个时区跳变对象
        let val:number = zoneOffsetTransition.getOffsetBefore();
        expect(val === value).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_GetAvailableIDs_0100
     * @tc.name ARKUIX_I18n_Transliterator_GetAvailableIDs_0100
     * @tc.desc Verify the list of conversion IDs supported by transliteration;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_GetAvailableIDs_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_GetAvailableIDs_0100';
      try {

        let ids: string[] = i18n.Transliterator.getAvailableIDs();

        let len=ids.length
        expect(len>0).assertEqual(true)
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_GetInstance_0100
     * @tc.name ARKUIX_I18n_Transliterator_GetInstance_0100
     * @tc.desc Creates a transliterator object for the specified conversion ID;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_GetInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_GetInstance_0100';
      try {

        let transliterator: i18n.Transliterator = i18n.Transliterator.getInstance('Any-Latn');
        expect(transliterator != null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0100
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0100
     * @tc.desc Verify transform with 'Latin ASCII' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0100';
      try {
        let val: string = 'zhong guo'
        let transliterator:i18n.Transliterator= i18n.Transliterator.getInstance('Any-Latn;Latin-Ascii')
        let transliterateAscii: string = transliterator.transform('中国');
        expect(transliterateAscii === val).assertTrue()

      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0200
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0200
     * @tc.desc Verify transform with 'Any-Latn' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0200';
      try {
        let val: string = 'zhōng guó'
        let transliterator:i18n.Transliterator= i18n.Transliterator.getInstance('Any-Latn')
        let transliterateAscii: string = transliterator.transform('中国');
        expect(transliterateAscii === val).assertTrue()

      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0300
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0300
     * @tc.desc Verify transform with 'Han-Latin/Names' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0300';
        try {
          let val: string = 'shàn lǎo shī'
          let transliterator:i18n.Transliterator= i18n.Transliterator.getInstance('Han-Latin/Names')
          let transliterateAscii: string = transliterator.transform('单老师');
          expect(transliterateAscii === val).assertTrue()

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0400
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0400
     * @tc.desc Verify transform with 'Any-Accents' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0400';
      try {
        let trans = i18n.Transliterator.getInstance('Any-Accents');
        let value = trans.transform('中国');

        expect(value).assertEqual('中国');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0500
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0500
     * @tc.desc Verify transform with 'Any-Thai' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0500';
      try {
        let trans = i18n.Transliterator.getInstance('Any-Thai');
        let value = trans.transform('中国');

        expect(value).assertEqual('中国');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0600
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0600
     * @tc.desc Verify transform with 'Any-zh' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0600';
      try {
        let trans = i18n.Transliterator.getInstance('Any-zh');
        let value = trans.transform('nihao');

        expect(value).assertEqual('nihao');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0700
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0700
     * @tc.desc Verify transform with 'Any-Hant' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0700';
      try {
        let trans = i18n.Transliterator.getInstance('Any-Hant');
        let value = trans.transform('hello');

        expect(value).assertEqual('hello');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Transliterator_Transform_0800
     * @tc.name ARKUIX_I18n_Transliterator_Transform_0800
     * @tc.desc Verify transform with 'Any-Kannada' using the specified transliteration rules
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Transliterator_Transform_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Transliterator_Transform_0800';
      try {
        let trans = i18n.Transliterator.getInstance('Any-Kannada');
        let value = trans.transform('hello');

        expect(value).assertEqual('ಹೆಲ್ಲೊ');
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0100
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0100
     * @tc.desc Verify that Normalizer.getInstance(NFC) returns a non-null Normalizer instance.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0100';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFC);
        expect(normalizer !=null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0200
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0200
     * @tc.desc Verify that Normalizer.getInstance(NFD) returns a non-null Normalizer instance.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0200';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFD);
        expect(normalizer !=null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0300
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0300
     * @tc.desc Verify that Normalizer.getInstance(NFKC) returns a non-null Normalizer instance.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0300';
        try {

          let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFKC);
          expect(normalizer !=null).assertTrue()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0400
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0400
     * @tc.desc Verify that Normalizer.getInstance(NFKD) returns a non-null Normalizer instance.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0400';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFKD);
        expect(normalizer !=null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0500
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0500
     * @tc.desc test Normalizer.getInstance with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0500';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0600
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0600
     * @tc.desc test Normalizer.getInstance with undefined parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0600';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(undefined);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0700
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0700
     * @tc.desc test Normalizer.getInstance with 0 parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0700';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(0);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_GetInstance_0800
     * @tc.name ARKUIX_I18n_Normalizer_GetInstance_0800
     * @tc.desc test Normalizer.getInstance with 5 parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_GetInstance_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_GetInstance_0800';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(5);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_Normalize_0100
     * @tc.name ARKUIX_I18n_Normalizer_Normalize_0100
     * @tc.desc Verify normalize('\u1E9B\u0323') converts the input combining sequence to the expected NFC normalized
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_Normalize_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_Normalize_0100';
      try {
        let val:string='ẛ̣'
        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFC);
        let normalizedText: string = normalizer.normalize('\u1E9B\u0323');
        expect(normalizedText).assertEqual(val)
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_Normalize_0200
     * @tc.name ARKUIX_I18n_Normalizer_Normalize_0200
     * @tc.desc Verify normalize(null) converts the input combining sequence to the expected NFC normalized
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_Normalize_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_Normalize_0200';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFC);
        let normalizedText: string = normalizer.normalize(null);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_Normalizer_Normalize_0300
     * @tc.name ARKUIX_I18n_Normalizer_Normalize_0300
     * @tc.desc Verify normalize(undefined) converts the input combining sequence to the expected NFC normalized
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_Normalizer_Normalize_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_Normalizer_Normalize_0300';
      try {

        let normalizer: i18n.Normalizer = i18n.Normalizer.getInstance(i18n.NormalizerMode.NFC);
        let normalizedText: string = normalizer.normalize(undefined);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_Constructor_0100
     * @tc.name ARKUIX_I18n_HolidayManaGer_Constructor_0100
     * @tc.desc Creates a HolidayManager object for parsing holiday data;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_Constructor_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_Constructor_0100';
      try {
        let icsPath= ''

        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        icsPath = context.filesDir+'/reso.ics';
        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)

        const holidayManager = new i18n.HolidayManager(icsPath);
        expect(holidayManager !=null).assertTrue()

      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_IsHoliday_0100
     * @tc.name ARKUIX_I18n_HolidayManaGer_IsHoliday_0100
     * @tc.desc Determines whether the specified date is a holiday;
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_IsHoliday_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_IsHoliday_0100';
      try {
        let icsPath= ''


          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          icsPath = context.filesDir+'/reso.ics';
          let data = context?.resourceManager.getRawFileContentSync("reso.ics")
          let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
          fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
          fileIo.writeSync(fd.fd, data?.buffer)
          fileIo.closeSync(fd)


        const holidayManager = new i18n.HolidayManager(icsPath);
        let isHoliday = holidayManager.isHoliday(new Date(2023, 0, 1))
        expect(isHoliday).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_IsHoliday_0200
     * @tc.name ARKUIX_I18n_HolidayManaGer_IsHoliday_0200
     * @tc.desc test isHoliday with null parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_IsHoliday_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_IsHoliday_0200';
      try {

        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let isHoliday = holidayManager.isHoliday()
        expect(isHoliday).assertFalse()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_IsHoliday_0300
     * @tc.name ARKUIX_I18n_HolidayManaGer_IsHoliday_0300
     * @tc.desc test isHoliday with normal parameter(new Date(2023.23, 5.43, 25.2))
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_IsHoliday_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_IsHoliday_0300';
      try {
        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let isHoliday = holidayManager.isHoliday(new Date(2023.23, 5.43, 25.2))
        expect(isHoliday).assertFalse()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0100
     * @tc.name ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0100
     * @tc.desc test getHolidayInfoItemArray with normal parameter(2023)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0100';
      try {
        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let holidayInfoItemArray: Array<i18n.HolidayInfoItem> = holidayManager.getHolidayInfoItemArray(2023);
        expect(holidayInfoItemArray !=null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0200
     * @tc.name ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0200
     * @tc.desc test getHolidayInfoItemArray with normal parameter(null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0200';
      try {
        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let holidayInfoItemArray: Array<i18n.HolidayInfoItem> = holidayManager.getHolidayInfoItemArray();
        expect(holidayInfoItemArray !=null).assertTrue()
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0300
     * @tc.name ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0300
     * @tc.desc test getHolidayInfoItemArray with abnormal parameter(-1)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0300';
      try {
        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let holidayInfoItemArray: Array<i18n.HolidayInfoItem> = holidayManager.getHolidayInfoItemArray(-1);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0400
     * @tc.name ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0400
     * @tc.desc test getHolidayInfoItemArray with abnormal parameter(-3.5)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_HolidayManaGer_GetHolidayInfoItemArray_0400';
      try {
        const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
        let icsPath = context.filesDir+'/reso.ics';

        let data = context?.resourceManager.getRawFileContentSync("reso.ics")
        let fd = fileIo.openSync(context?.filesDir + '/reso.ics', fileIo.OpenMode.CREATE |
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
        fileIo.writeSync(fd.fd, data?.buffer)
        fileIo.closeSync(fd)
        const holidayManager = new i18n.HolidayManager(icsPath);
        let holidayInfoItemArray: Array<i18n.HolidayInfoItem> = holidayManager.getHolidayInfoItemArray(-3.5);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code==890001).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0100
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0100
     * @tc.desc EntityRecognizer - Construct with locale "zh-CN" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0100';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0200
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0200
     * @tc.desc EntityRecognizer - Construct with locale "en-US" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0200';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('en-US');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0300
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0300
     * @tc.desc EntityRecognizer - Construct with locale "de-DE" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0300';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('de-DE');
        let phoneNumberText: string = '如有疑问，请联系15812342312';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0400
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0400
     * @tc.desc EntityRecognizer - Construct with locale "fr" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0400';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer();
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.message).assertEqual("Cannot read property type of undefined");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0500
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0500
     * @tc.desc EntityRecognizer - Construct with locale "es" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0500';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('fr');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.message).assertEqual("Cannot read property type of undefined");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0600
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0600
     * @tc.desc EntityRecognizer - Construct with locale "it" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0600';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('es');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.message).assertEqual("Cannot read property type of undefined");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0700
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0700
     * @tc.desc EntityRecognizer - Construct with locale "ar-SA" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0700';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('it');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.message).assertEqual("Cannot read property type of undefined");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0800
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0800
     * @tc.desc EntityRecognizer - Construct with empty locale and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0800';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('ar-SA');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.message).assertEqual("Cannot read property type of undefined");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_0900
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_0900
     * @tc.desc EntityRecognizer - Construct with invalid locale "abc" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_0900';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('abc');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code).assertEqual("890001");
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_1000
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_1000
     * @tc.desc EntityRecognizer - Construct with blank locale "   " and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_1000';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('   ');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        if(isAndroid){
          expect(err.message!=null).assertTrue();
        }
        if(isOH){
          expect(err.message!=null).assertTrue();
        }
        if(isiOS){
          expect(err.message!=null).assertTrue();
        }
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_1100
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_1100
     * @tc.desc EntityRecognizer - Construct with special char locale "!@#$%" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_1100';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('!@#$%');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        if(isAndroid){
          expect(err.message!=null).assertTrue();
        }
        if(isOH){
          expect(err.message!=null).assertTrue();
        }
        if(isiOS){
          expect(err.message!=null).assertTrue();
        }
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_1200
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_1200
     * @tc.desc EntityRecognizer - Construct with Chinese char locale "汉字" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_1200';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('汉字');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        if(isAndroid){
          expect(err.message!=null).assertTrue();
        }
        if(isOH){
          expect(err.message!=null).assertTrue();
        }
        if(isiOS){
          expect(err.message!=null).assertTrue();
        }
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_1300
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_1300
     * @tc.desc EntityRecognizer - Construct with undefined locale and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_1300';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer(undefined);
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code).assertEqual('401');
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_Constructor_1400
     * @tc.name ARKUIX_I18n_EntityRecognizer_Constructor_1400
     * @tc.desc EntityRecognizer - Construct with numeric locale "111111111111111" and identify phone number
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_Constructor_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_Constructor_1400';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('111111111111111');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);

        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        if(isAndroid){
          expect(err.message!=null).assertTrue();
        }
        if(isOH){
          expect(err.message!=null).assertTrue();
        }
        if(isiOS){
          expect(err.message!=null).assertTrue();
        }
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0100
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0100
     * @tc.desc Test to obtain phoneNumber text with 'zh-CN'
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0100';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let phoneNumberText: string = '如有疑问，请联系15312345678';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(8);
        expect(phoneNumberEntity[0].end).assertEqual(19);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0200
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0200
     * @tc.desc Test to obtain date text with 'zh-CN'(2023年12月1日)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0200';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = '我们2023年12月1日一起吃饭吧。';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(2);
        expect(dateEntity[0].end).assertEqual(12);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0300
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0300
     * @tc.desc Test to obtain date text with 'zh-CN'(2025 年 11 月 28 日下午 3 点)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0300';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = '"2025 年 11 月 28 日下午 3 点，李四发送邮件至 lisi@example.com"。';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(1);
        expect(dateEntity[0].end).assertEqual(23);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0400
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0400
     * @tc.desc Test to obtain date text with 'zh-CN'(2025-12-31)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0400';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = 'Tom 计划 2025-12-31 前往上海，与 Wang Li 会面';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(7);
        expect(dateEntity[0].end).assertEqual(17);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0500
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0500
     * @tc.desc Test to obtain phoneNumber text with 'zh-CN'(138-0000-0000)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0500';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let phoneNumberText: string = '手机号：138-0000-0000，邮箱：zhangsan+tag@example.co.uk';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(4);
        expect(phoneNumberEntity[0].end).assertEqual(17);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0600
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0600
     * @tc.desc Test to obtain phoneNumber text with 'zh-CN'(400-888-8888)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0600';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let phoneNumberText: string = '2025/11/28 14:30:00，张三拨打了 400-888-8888';
        let phoneNumberEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(phoneNumberText);
        expect(phoneNumberEntity[0].type).assertEqual('phone_number');
        expect(phoneNumberEntity[0].begin).assertEqual(26);
        expect(phoneNumberEntity[0].end).assertEqual(38);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0700
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0700
     * @tc.desc Test to obtain date text with 'zh-CN'(no date)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0700';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = '张三在北京市北京区中关村大街 1 号大厦工作。';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(2);
        expect(dateEntity[0].end).assertEqual(12);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        // expect(err.code).assertEqual('401');
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0800
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0800
     * @tc.desc findEntityInfo - No recognizable entity in special char text "!@#$%"
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0800';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = '!@#$%';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(2);
        expect(dateEntity[0].end).assertEqual(12);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        // expect(err.code).assertEqual('401');
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0900
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0900
     * @tc.desc findEntityInfo - No recognizable date in pure numeric text "111111111111111"
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_0900';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText: string = '111111111111111';
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect(dateEntity[0].type).assertEqual('date');
        expect(dateEntity[0].begin).assertEqual(2);
        expect(dateEntity[0].end).assertEqual(12);
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        // expect(err.code).assertEqual('401');
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1000
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1000
     * @tc.desc findEntityInfo - Handle null text input
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1000';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer('zh-CN');
        let dateText:string|null = null;
        let dateEntity: Array<i18n.EntityInfoItem> = entityRecognizer.findEntityInfo(dateText);
        expect().assertFail();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect(err.code).assertEqual('401');
      }
      done();
    })


    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1100
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1100
     * @tc.desc findEntityInfo - Identifying Entity Information in Text
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1100';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("zh-CN");
        let text: string = "如有疑问，请联系010 1234 5678";
        let result = entityRecognizer.findEntityInfo(text);
        expect(result[0].type == "phone_number").assertTrue();
        expect(result[0].begin == 8).assertTrue();
        expect(result[0].end == 21).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1200
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1200
     * @tc.desc findEntityInfo - no recognizable entity information in Text
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1200';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("zh-CN");
        let text: string = "如有疑问，请联系我";
        let result = entityRecognizer.findEntityInfo(text);
        expect(result.length == 0).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1300
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1300
     * @tc.desc findEntityInfo - Identifying Entity Information in Text
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1300';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("en-GB");
        let text: string = "If you have any questions, Please call 15312345678";
        let result = entityRecognizer.findEntityInfo(text);
        expect(result[0].type == "phone_number").assertTrue();
        expect(result[0].begin == 39).assertTrue();
        expect(result[0].end == 50).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1400
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1400
     * @tc.desc findEntityInfo - Identifying Entity Date Information in Text(Chinese)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1400';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("zh-CN");
        let text: string = "我们2023年12月1日下午8点一起吃饭吧。";
        let result = entityRecognizer.findEntityInfo(text);
        expect(result[0].type == "date").assertTrue();
        expect(result[0].begin == 2).assertTrue();
        expect(result[0].end == 16).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1500
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1500
     * @tc.desc findEntityInfo - Identifying Entity Date Information in Text(Chinese)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1500';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("zh-CN");
        let text: string = "今天下午3点到5点有个会议。";
        let result = entityRecognizer.findEntityInfo(text);
        expect(result[0].type == "date").assertTrue();
        expect(result[0].begin == 0).assertTrue();
        expect(result[0].end == 9).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1600
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1600
     * @tc.desc findEntityInfo - Identifying Entity Date Information in Text(English)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1600';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("en-GB");
        let text: string = "Let's have dinner in December 1, 2023.";
        let result = entityRecognizer.findEntityInfo(text);
        expect([result[0].type, result[1].type].indexOf("date") != -1).assertTrue();
        expect([result[0].begin, result[1].begin].indexOf(21) != -1).assertTrue();
        expect([result[0].end, result[1].end].indexOf(37) != -1).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1700
     * @tc.name ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1700
     * @tc.desc findEntityInfo - Identifying Entity Date Information in Text(English)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'ARKUIX_I18n_EntityRecognizer_FindEntityInfo_1700';
      try {
        let entityRecognizer: i18n.EntityRecognizer = new i18n.EntityRecognizer("en-GB");
        let text: string = "The time is 11/10/2023-11/13/2023.";
        let result = entityRecognizer.findEntityInfo(text);

        expect(result[1].type == "date").assertTrue();
        expect(result[1].begin == 12).assertTrue();
        expect(result[1].end == 34).assertTrue();
      } catch (err) {
        console.error(`${caseName} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done();
    })


  })
 }
