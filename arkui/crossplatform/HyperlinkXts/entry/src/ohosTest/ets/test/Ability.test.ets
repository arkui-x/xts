/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { abilityDelegatorRegistry, Driver } from '@kit.TestKit';

const TAG: string = '[Test][entry_test]:: '
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const LONG_STRING: string = 'a'.repeat(500)
const LONG_STRING_RES: string = 'Res' + 'b'.repeat(218)
const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300
const RES_LOG_START: number = 3000
const RES_LOG_END: number = 5000

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function abilityTest() {
  describe('ActsAbilityTest', () => {
    beforeAll(async () => {
      await delegator.startAbility({
        bundleName: 'com.example.hyperlink',
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      })
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(() => {
    })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0100
     * @tc.name ArkUIX_Component_Hyperlink_address_0100
     * @tc.desc Test the Hyperlink attribute address, set value http://hcl.baidu.com/, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"http://hcl.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0200
     * @tc.name ArkUIX_Component_Hyperlink_address_0200
     * @tc.desc Test the Hyperlink attribute address, set value http://hcl.baidu.com/, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"http://hcl.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0300
     * @tc.name ArkUIX_Component_Hyperlink_address_0300
     * @tc.desc Test the Hyperlink attribute address, set value https://www.gov.cn/, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"https://www.gov.cn/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0400
     * @tc.name ArkUIX_Component_Hyperlink_address_0400
     * @tc.desc Test the Hyperlink attribute address, set value https://www.gov.cn/, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"https://www.gov.cn/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0500
     * @tc.name ArkUIX_Component_Hyperlink_address_0500
     * @tc.desc Test the Hyperlink attribute address, set value ABcd1234中文!@#！@#￥%, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0500')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"ABcd1234中文!@#！@#￥%"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0600
     * @tc.name ArkUIX_Component_Hyperlink_address_0600
     * @tc.desc Test the Hyperlink attribute address, set value ResABcd1234中文!@#！@#￥%, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0600')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"ResABcd1234中文!@#！@#￥%"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0700
     * @tc.name ArkUIX_Component_Hyperlink_address_0700
     * @tc.desc Test the Hyperlink attribute address, set value '', type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0700')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":""')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0800
     * @tc.name ArkUIX_Component_Hyperlink_address_0800
     * @tc.desc Test the Hyperlink attribute address, set value '', type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0800')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":""')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_0900
     * @tc.name ArkUIX_Component_Hyperlink_address_0900
     * @tc.desc Test the Hyperlink attribute address, set value LONG_STRING, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_0900')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain(LONG_STRING)
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_1000
     * @tc.name ArkUIX_Component_Hyperlink_address_1000
     * @tc.desc Test the Hyperlink attribute address, set value LONG_STRING_RES, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_1000')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain(LONG_STRING_RES)
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_1100
     * @tc.name ArkUIX_Component_Hyperlink_address_1100
     * @tc.desc Test the Hyperlink attribute address, set failed resource, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_1100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":""')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_1200
     * @tc.name ArkUIX_Component_Hyperlink_address_1200
     * @tc.desc Test the Hyperlink attribute address, set system resource, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_1200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":"星期一"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_1300
     * @tc.name ArkUIX_Component_Hyperlink_address_1300
     * @tc.desc Test the Hyperlink attribute address, set null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_1300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":""')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_address_1400
     * @tc.name ArkUIX_Component_Hyperlink_address_1400
     * @tc.desc Test the Hyperlink attribute address, set undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_address_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_address_1400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"address":""')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0100
     * @tc.name ArkUIX_Component_Hyperlink_content_0100
     * @tc.desc Test the Hyperlink attribute content, not set value
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0200
     * @tc.name ArkUIX_Component_Hyperlink_content_0200
     * @tc.desc Test the Hyperlink attribute content, set value ABcd1234中文!@#！@#￥%, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"ABcd1234中文!@#！@#￥%"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0300
     * @tc.name ArkUIX_Component_Hyperlink_content_0300
     * @tc.desc Test the Hyperlink attribute content, set value '', type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0400
     * @tc.name ArkUIX_Component_Hyperlink_content_0400
     * @tc.desc Test the Hyperlink attribute content, set value LONG_STRING, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain(LONG_STRING)
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0500
     * @tc.name ArkUIX_Component_Hyperlink_content_0500
     * @tc.desc Test the Hyperlink attribute content, set value ResABcd1234中文!@#！@#￥%, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0500')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"ResABcd1234中文!@#！@#￥%"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0600
     * @tc.name ArkUIX_Component_Hyperlink_content_0600
     * @tc.desc Test the Hyperlink attribute content, set value '', type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0600')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0700
     * @tc.name ArkUIX_Component_Hyperlink_content_0700
     * @tc.desc Test the Hyperlink attribute content, set value LONG_STRING, type is resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0700')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain(LONG_STRING_RES)
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0800
     * @tc.name ArkUIX_Component_Hyperlink_content_0800
     * @tc.desc Test the Hyperlink attribute content, set failed resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0800')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_0900
     * @tc.name ArkUIX_Component_Hyperlink_content_0900
     * @tc.desc Test the Hyperlink attribute content, set system resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_0900')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"星期一"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_1000
     * @tc.name ArkUIX_Component_Hyperlink_content_1000
     * @tc.desc Test the Hyperlink attribute content, set null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_1000')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_content_1100
     * @tc.name ArkUIX_Component_Hyperlink_content_1100
     * @tc.desc Test the Hyperlink attribute content, set undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_content_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_content_1100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"content":"https://www.baidu.com/"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0100
     * @tc.name ArkUIX_Component_Hyperlink_color_0100
     * @tc.desc Test the Hyperlink attribute color, not set value
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FF007DFF"') || result.includes('"color":"#FF0A59F7"')
        expect(res).assertTrue()
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0200
     * @tc.name ArkUIX_Component_Hyperlink_color_0200
     * @tc.desc Test the Hyperlink attribute color, set value Color.Black
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF000000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0300
     * @tc.name ArkUIX_Component_Hyperlink_color_0300
     * @tc.desc Test the Hyperlink attribute color, set value Color.Blue
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF0000FF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0400
     * @tc.name ArkUIX_Component_Hyperlink_color_0400
     * @tc.desc Test the Hyperlink attribute color, set value Color.Brown
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFA52A2A"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0500
     * @tc.name ArkUIX_Component_Hyperlink_color_0500
     * @tc.desc Test the Hyperlink attribute color, set value Color.Gray
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0500')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF808080"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0600
     * @tc.name ArkUIX_Component_Hyperlink_color_0600
     * @tc.desc Test the Hyperlink attribute color, set value Color.Grey
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0600')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF808080"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0700
     * @tc.name ArkUIX_Component_Hyperlink_color_0700
     * @tc.desc Test the Hyperlink attribute color, set value Color.Green
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0700')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF008000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0800
     * @tc.name ArkUIX_Component_Hyperlink_color_0800
     * @tc.desc Test the Hyperlink attribute color, set value Color.Orange
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0800')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFA500"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_0900
     * @tc.name ArkUIX_Component_Hyperlink_color_0900
     * @tc.desc Test the Hyperlink attribute color, set value Color.Pink
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_0900')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFC0CB"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1000
     * @tc.name ArkUIX_Component_Hyperlink_color_1000
     * @tc.desc Test the Hyperlink attribute color, set value Color.Red
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1000')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFF0000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1100
     * @tc.name ArkUIX_Component_Hyperlink_color_1100
     * @tc.desc Test the Hyperlink attribute color, set value Color.White
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFFFFF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1200
     * @tc.name ArkUIX_Component_Hyperlink_color_1200
     * @tc.desc Test the Hyperlink attribute color, set value Color.Yellow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFFF00"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1300
     * @tc.name ArkUIX_Component_Hyperlink_color_1300
     * @tc.desc Test the Hyperlink attribute color, set value Color.Transparent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#00000000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1400
     * @tc.name ArkUIX_Component_Hyperlink_color_1400
     * @tc.desc Test the Hyperlink attribute color, set value 0xffffff
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFFFFF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1500
     * @tc.name ArkUIX_Component_Hyperlink_color_1500
     * @tc.desc Test the Hyperlink attribute color, set value 0xffff0000
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1500')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFF0000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1600
     * @tc.name ArkUIX_Component_Hyperlink_color_1600
     * @tc.desc Test the Hyperlink attribute color, set value -1
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1600')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFFFFF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1700
     * @tc.name ArkUIX_Component_Hyperlink_color_1700
     * @tc.desc Test the Hyperlink attribute color, set value #ffffff
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1700')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFFFFFF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1800
     * @tc.name ArkUIX_Component_Hyperlink_color_1800
     * @tc.desc Test the Hyperlink attribute color, set value #ff000000
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1800')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FF000000"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_1900
     * @tc.name ArkUIX_Component_Hyperlink_color_1900
     * @tc.desc Test the Hyperlink attribute color, set value rgb(255, 100, 255)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_1900')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFFF64FF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2000
     * @tc.name ArkUIX_Component_Hyperlink_color_2000
     * @tc.desc Test the Hyperlink attribute color, set value rgba(255, 100, 255, 0.5)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2000')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#80FF64FF"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2100
     * @tc.name ArkUIX_Component_Hyperlink_color_2100
     * @tc.desc Test the Hyperlink attribute color, set failed value, type is string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2100')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FF007DFF"') || result.includes('"color":"#FF0A59F7"')
        expect(res).assertTrue()
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2200
     * @tc.name ArkUIX_Component_Hyperlink_color_2200
     * @tc.desc Test the Hyperlink attribute color, set app resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2200')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        expect(result).assertContain('"color":"#FFBA3C3C"')
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2300
     * @tc.name ArkUIX_Component_Hyperlink_color_2300
     * @tc.desc Test the Hyperlink attribute color, set system resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2300')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FFFF7500"') || result.includes('"color":"#FFED6F21"')
        expect(res).assertTrue()
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2400
     * @tc.name ArkUIX_Component_Hyperlink_color_2400
     * @tc.desc Test the Hyperlink attribute color, set failed resource
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2400')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FF007DFF"') || result.includes('"color":"#FF0A59F7"')
        expect(res).assertTrue()
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2500
     * @tc.name ArkUIX_Component_Hyperlink_color_2500
     * @tc.desc Test the Hyperlink attribute color, set null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2500')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FF007DFF"') || result.includes('"color":"#FF0A59F7"')
        expect(res).assertTrue()
        done()
      })

    /**
     * @tc.number ArkUIX_Component_Hyperlink_color_2600
     * @tc.name ArkUIX_Component_Hyperlink_color_2600
     * @tc.desc Test the Hyperlink attribute color, set undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Component_Hyperlink_color_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: string = getInspectorByKey('ArkUIX_Component_Hyperlink_color_2600')
        await sleep(WAIT_READY_MS_2000)
        console.info(TAG + 'Component Inspector is ' + result.slice(RES_LOG_START, RES_LOG_END))
        let res: boolean = result.includes('"color":"#FF007DFF"') || result.includes('"color":"#FF0A59F7"')
        expect(res).assertTrue()
        done()
      })
  })
}
