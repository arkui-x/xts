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

import { describe, beforeAll, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest'
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
let driver = Driver.create();

const AWAIT_SLEEP_MS_500 = 500;
const AWAIT_SLEEP_MS_1000 = 1000;
const AWAIT_SLEEP_MS_2000 = 2000;
const AWAIT_SLEEP_MS_3000 = 3000;
const AWAIT_SLEEP_MS_10000 = 10000;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function WebDownloadDelegateTest() {
  describe('WebDownloadDelegateTest', () => {
    beforeAll(async () => {
      await sleep(AWAIT_SLEEP_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("webDownloadDelegate测试"));
      await button_goPage.click();
      await sleep(AWAIT_SLEEP_MS_3000);
    })
    afterAll(async () => {
      await sleep(AWAIT_SLEEP_MS_3000);
    })

    /**
     * @tc.number : ArkUIX_Web_onDownloadFinish_Func_0100
     * @tc.name   : ArkUIX_Web_onDownloadFinish_Func_0100
     * @tc.desc   : Test WebDownloadDelegate.onDownloadFinish function
     * @tc.level  : Level 0
     */
    it('ArkUIX_Web_onDownloadFinish_Func_0100', 0, async (done: Function) => {
      try {
        await (await driver.findComponent(ON.id("clear_info"))).click();
        await sleep(AWAIT_SLEEP_MS_500);
        await (await driver.findComponent(ON.id("setDownloadDelegate_onDownloadFinish"))).click();
        await sleep(AWAIT_SLEEP_MS_500);
        await (await driver.findComponent(ON.id("startDownload_picture"))).click();
        await sleep(AWAIT_SLEEP_MS_10000);
        let Guid = await (await driver.findComponent(ON.id("Guid"))).getText();
        expect(Guid != null).assertTrue();
        let CurrentSpeed = await (await driver.findComponent(ON.id("CurrentSpeed"))).getText();
        expect(CurrentSpeed != null).assertTrue();
        let PercentComplete = await (await driver.findComponent(ON.id("PercentComplete"))).getText();
        expect(PercentComplete != null).assertTrue();
        let TotalBytes = await (await driver.findComponent(ON.id("TotalBytes"))).getText();
        expect(TotalBytes == '485892').assertTrue();
        let ReceivedBytes = await (await driver.findComponent(ON.id("ReceivedBytes"))).getText();
        expect(ReceivedBytes != null).assertTrue();
        let LastErrorCode = await (await driver.findComponent(ON.id("LastErrorCode"))).getText();
        expect(LastErrorCode == '0').assertTrue();
        let Method = await (await driver.findComponent(ON.id("Method"))).getText();
        expect(Method == 'GET').assertTrue();
        let state = await (await driver.findComponent(ON.id("State"))).getText();
        expect(state == '1').assertTrue();
        let MimeType = await (await driver.findComponent(ON.id("MimeType"))).getText();
        expect(MimeType != null).assertTrue();
        let SuggestedFileName = await (await driver.findComponent(ON.id("SuggestedFileName"))).getText();
        expect(SuggestedFileName != null).assertTrue();
        let Url = await (await driver.findComponent(ON.id("Url"))).getText();
        expect(Url == 'https://vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg').assertTrue();
        let FullPath = await (await driver.findComponent(ON.id("FullPath"))).getText();
        expect(FullPath != null).assertTrue();
      } catch (error) {
        console.info(`UiTestCase, onDownloadFinish_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ArkUIX_Web_onBeforeDownload_Func_0100
     * @tc.name   : ArkUIX_Web_onBeforeDownload_Func_0100
     * @tc.desc   : Test WebDownloadDelegate.onBeforeDownload function
     * @tc.level  : Level 0
     */
    it('ArkUIX_Web_onBeforeDownload_Func_0100', 0, async (done: Function) => {
      try {
        await (await driver.findComponent(ON.id("clear_info"))).click();
        await sleep(AWAIT_SLEEP_MS_500);
        await (await driver.findComponent(ON.id("setDownloadDelegate_onBeforeDownload"))).click();
        await sleep(AWAIT_SLEEP_MS_500);
        await (await driver.findComponent(ON.id("startDownload_picture"))).click();
        await sleep(AWAIT_SLEEP_MS_3000);
        let Guid = await (await driver.findComponent(ON.id("Guid"))).getText();
        expect(Guid != null).assertTrue();
        let CurrentSpeed = await (await driver.findComponent(ON.id("CurrentSpeed"))).getText();
        expect(CurrentSpeed != null).assertTrue();
        let PercentComplete = await (await driver.findComponent(ON.id("PercentComplete"))).getText();
        expect(PercentComplete != null).assertTrue();
        let TotalBytes = await (await driver.findComponent(ON.id("TotalBytes"))).getText();
        expect(TotalBytes != null).assertTrue();
        let ReceivedBytes = await (await driver.findComponent(ON.id("ReceivedBytes"))).getText();
        expect(ReceivedBytes == '0').assertTrue();
        let LastErrorCode = await (await driver.findComponent(ON.id("LastErrorCode"))).getText();
        expect(LastErrorCode == '0').assertTrue();
        let Method = await (await driver.findComponent(ON.id("Method"))).getText();
        expect(Method == 'GET').assertTrue();
        let state = await (await driver.findComponent(ON.id("State"))).getText();
        expect(state == '4').assertTrue();
        let MimeType = await (await driver.findComponent(ON.id("MimeType"))).getText();
        expect(MimeType != null).assertTrue();
        let SuggestedFileName = await (await driver.findComponent(ON.id("SuggestedFileName"))).getText();
        expect(SuggestedFileName != null).assertTrue();
        let Url = await (await driver.findComponent(ON.id("Url"))).getText();
        expect(Url == 'https://vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg').assertTrue();
      } catch (error) {
        console.info(`UiTestCase, onBeforeDownload_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ArkUIX_Web_onBeforeDownload_Func_0200
     * @tc.name   : ArkUIX_Web_onBeforeDownload_Func_0200
     * @tc.desc   : Test WebDownloadDelegate.onBeforeDownload function
     * @tc.level  : Level 2
     */
    it('ArkUIX_Web_onBeforeDownload_Func_0200', 0, async (done: Function) => {
      if (platform == 'Android') {
        done();
        return;
      }
      try {
        let button_clear_info = await driver.findComponent(ON.id("clear_info"));
        await button_clear_info.click();
        let button_pause = await driver.findComponent(ON.id("pause"));
        await button_pause.click();
        await sleep(AWAIT_SLEEP_MS_1000);
        let button_resume = await driver.findComponent(ON.id("resume"));
        await button_resume.click();
        await sleep(AWAIT_SLEEP_MS_2000);
        let pause_error = await (await driver.findComponent(ON.id("pause_error"))).getText();
        expect(pause_error == '17100019').assertTrue();
        let resume_error = await (await driver.findComponent(ON.id("resume_error"))).getText();
        expect(resume_error == '17100016').assertTrue();
      } catch (error) {
        console.info(`UiTestCase, onBeforeDownload_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ArkUIX_Web_onDownloadUpdated_Func_0100
     * @tc.name   : ArkUIX_Web_onDownloadUpdated_Func_0100
     * @tc.desc   : Test WebDownloadDelegate.onDownloadUpdated function
     * @tc.level  : Level 0
     */
    it('ArkUIX_Web_onDownloadUpdated_Func_0100', 0, async (done: Function) => {
      try {
        let button_clear_info = await driver.findComponent(ON.id("clear_info"));
        await button_clear_info.click();
        let button_onDownloadUpdated = await driver.findComponent(ON.id("setDownloadDelegate_onDownloadUpdated"));
        await button_onDownloadUpdated.click();
        await sleep(AWAIT_SLEEP_MS_500);
        let button_startDownload_picture = await driver.findComponent(ON.id("startDownload_picture"));
        await button_startDownload_picture.click();
        await sleep(AWAIT_SLEEP_MS_1000);
        let Guid = await (await driver.findComponent(ON.id("Guid"))).getText();
        expect(Guid != null).assertTrue();
        let CurrentSpeed = await (await driver.findComponent(ON.id("CurrentSpeed"))).getText();
        expect(CurrentSpeed != null).assertTrue();
        let PercentComplete = await (await driver.findComponent(ON.id("PercentComplete"))).getText();
        expect(PercentComplete != null).assertTrue();
        let TotalBytes = await (await driver.findComponent(ON.id("TotalBytes"))).getText();
        expect(TotalBytes != null).assertTrue();
        let ReceivedBytes = await (await driver.findComponent(ON.id("ReceivedBytes"))).getText();
        expect(ReceivedBytes != null).assertTrue();
        let LastErrorCode = await (await driver.findComponent(ON.id("LastErrorCode"))).getText();
        expect(LastErrorCode == '0').assertTrue();
        let Method = await (await driver.findComponent(ON.id("Method"))).getText();
        expect(Method == 'GET').assertTrue();
        let state = await (await driver.findComponent(ON.id("State"))).getText();
        expect(state == '4' || state == '0' || state == '1').assertTrue();
        let MimeType = await (await driver.findComponent(ON.id("MimeType"))).getText();
        console.info(`UiTestCase, onDownloadUpdated_picture_MimeType: ` + MimeType)
        expect(MimeType != null).assertTrue();
        let SuggestedFileName = await (await driver.findComponent(ON.id("SuggestedFileName"))).getText();
        expect(SuggestedFileName != null).assertTrue();
        let Url = await (await driver.findComponent(ON.id("Url"))).getText();
        expect(Url == 'https://vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg').assertTrue();
      } catch (error) {
        console.info(`UiTestCase, onDownloadUpdated_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ArkUIX_Web_onDownloadUpdated_Func_0200
     * @tc.name   : ArkUIX_Web_onDownloadUpdated_Func_0200
     * @tc.desc   : Test WebDownloadDelegate.onDownloadUpdated function
     * @tc.level  : Level 0
     */
    it('ArkUIX_Web_onDownloadUpdated_Func_0200', 0, async (done: Function) => {
      if (platform == 'Android') {
        done();
        return;
      }
      try {
        let button_onDownloadUpdated_pause = await driver.findComponent(ON.id("setDownloadDelegate_onDownloadUpdated_pause"));
        await button_onDownloadUpdated_pause.click();
        await sleep(AWAIT_SLEEP_MS_1000);
        let button_startDownload = await driver.findComponent(ON.id("startDownload"));
        await button_startDownload.click();
        await sleep(AWAIT_SLEEP_MS_500);
        let button_pause = await driver.findComponent(ON.id("pause"));
        await button_pause.click();
        await sleep(AWAIT_SLEEP_MS_1000);
        let State_pause = await (await driver.findComponent(ON.id("State_pause"))).getText();
        expect(State_pause == '5').assertTrue();
        await sleep(AWAIT_SLEEP_MS_500);
        let button_resume = await driver.findComponent(ON.id("resume"));
        await button_resume.click();
        await sleep(AWAIT_SLEEP_MS_1000);
        let State_resume = await (await driver.findComponent(ON.id("State_pause"))).getText();
        expect(State_resume == '4' || State_resume == '0').assertTrue();
        await sleep(AWAIT_SLEEP_MS_500);
        let State_cancel = await driver.findComponent(ON.id("cancel"));
        State_cancel.click()
        await sleep(AWAIT_SLEEP_MS_500);
      } catch (error) {
        console.info(`UiTestCase, onDownloadUpdated_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ArkUIX_Web_onDownloadFailed_Func_0100
     * @tc.name   : ArkUIX_Web_onDownloadFailed_Func_0100
     * @tc.desc   : Test WebDownloadDelegate.onDownloadFailed function
     * @tc.level  : Level 0
     */
    it('ArkUIX_Web_onDownloadFailed_Func_0100', 0, async (done: Function) => {
      try {
        let button_clear_info = await driver.findComponent(ON.id("clear_info"));
        await button_clear_info.click();
        let button_onDownloadFailed = await driver.findComponent(ON.id("setDownloadDelegate_onDownloadFailed"));
        await button_onDownloadFailed.click();
        await sleep(AWAIT_SLEEP_MS_500);
        let button_startDownload_picture = await driver.findComponent(ON.id("startDownload_picture"));
        await button_startDownload_picture.click();
        await sleep(AWAIT_SLEEP_MS_10000);
        let Guid = await (await driver.findComponent(ON.id("Guid"))).getText();
        expect(Guid != null).assertTrue();
        let CurrentSpeed = await (await driver.findComponent(ON.id("CurrentSpeed"))).getText();
        expect(CurrentSpeed != null).assertTrue();
        let PercentComplete = await (await driver.findComponent(ON.id("PercentComplete"))).getText();
        expect(PercentComplete != null).assertTrue();
        let TotalBytes = await (await driver.findComponent(ON.id("TotalBytes"))).getText();
        expect(TotalBytes == '0' || TotalBytes == '485892').assertTrue();
        let ReceivedBytes = await (await driver.findComponent(ON.id("ReceivedBytes"))).getText();
        expect(ReceivedBytes == '0').assertTrue();
        let LastErrorCode = await (await driver.findComponent(ON.id("LastErrorCode"))).getText();
        expect(LastErrorCode == '40').assertTrue();
        let Method = await (await driver.findComponent(ON.id("Method"))).getText();
        expect(Method == 'GET').assertTrue();
        let state = await (await driver.findComponent(ON.id("State"))).getText();
        expect(state == '2').assertTrue();
        let MimeType = await (await driver.findComponent(ON.id("MimeType"))).getText();
        expect(MimeType != null).assertTrue();
        let SuggestedFileName = await (await driver.findComponent(ON.id("SuggestedFileName"))).getText();
        expect(SuggestedFileName != null).assertTrue();
        let Url = await (await driver.findComponent(ON.id("Url"))).getText();
        expect(Url == 'https://vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg').assertTrue();
      } catch (error) {
        console.info(`UiTestCase, onDownloadFailed_picture_${error.code},${error.message}`)
        expect().assertFail();
      }
      done();
    })

  })
}