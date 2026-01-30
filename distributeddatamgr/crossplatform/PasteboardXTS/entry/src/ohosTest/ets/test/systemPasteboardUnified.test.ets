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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import pasteboard from '@ohos.pasteboard';
import deviceInfo from '@ohos.deviceInfo';
import Want from '@ohos.app.ability.Want';
import { abilityAccessCtrl, common, PermissionRequestResult } from '@kit.AbilityKit';
import { Driver, ON } from '@kit.TestKit';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from "@kit.BasicServicesKit";
import {unifiedDataChannel} from '@kit.ArkData';
import { uniformTypeDescriptor } from '@kit.ArkData';
import image from '@ohos.multimedia.image';

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_100: number = 100

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");

const delegator: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();

let getPermission = async () => {
  console.info('getPermission is start');
  let ability = await delegator.getCurrentTopAbility();
  if (ability && ability.context) {
    atManager.requestPermissionsFromUser(ability.context, ['ohos.permission.READ_PASTEBOARD'],
      (err: BusinessError, data: PermissionRequestResult) => {
        console.info('requestPermissionsFromUser success data is' + JSON.stringify(data));
        console.info('requestPermissionsFromUser failed err is' + JSON.stringify(err));
      })
  }
}

let sleep = (ms: number) => {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

let drivenFn = async () => {
  try {
    let driver: Driver = Driver.create();
    console.info('come in driveFn');
    console.info('driver is ${JSON.stringify(driver)}');
    await sleep(WAIT_READY_MS_1000);
    let button = await driver.findComponent(ON.text('始终允许'));
    if (button) {
      console.info('button is $ {JSON.stringify(button)}');
      await sleep(WAIT_READY_MS_1000);
      await button.click();
      await sleep(WAIT_READY_MS_1000);
    } else {
      let button1 = await driver.findComponent(ON.text('仅本次允许'));
      console.info('button is $ {JSON.stringify(button)}');
      await sleep(WAIT_READY_MS_1000);
      await button1.click();
      await sleep(WAIT_READY_MS_1000);
    }
  } catch (err) {
    console.info('err is' + err);
    return
  }
}

export default function systemPasteboardUnifiedTest() {
  describe('systemPasteboardUnifiedTest', () => {
    console.info('beforeAll PasteBoardTest start');
    beforeAll(async (done: Function) => {
      console.info('start################################start');
      await getPermission();
      await sleep(WAIT_READY_MS_1000);
      await drivenFn();
      await sleep(WAIT_READY_MS_1000);
      done();
    })
    beforeEach(async () => {
      await systemPasteboard.clearData();
      await sleep(WAIT_READY_MS_100);
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_100);
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0100
     * @tc.desc Test setUnifiedData with PlainText UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0100';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let plainTextData = new unifiedDataChannel.UnifiedData();
          let plainText = new unifiedDataChannel.PlainText();
          plainText.details = {
            Key: 'plaintext',
            Value: 'plaintext'
          };
          plainText.textContent = 'TextContent';
          plainText.abstract = 'TextContent';
          plainTextData.addRecord(plainText);
          await systemPasteboard.setUnifiedData(plainTextData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
	      
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0200
     * @tc.desc Test setUnifiedDataSync with PlainText UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0200';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let plainTextData = new unifiedDataChannel.UnifiedData();
          let plainText = new unifiedDataChannel.PlainText();
          plainText.details = {
            Key: 'plaintext',
            Value: 'plaintext'
          };
          plainText.textContent = 'TextContent';
          plainText.abstract = 'TextContent';
          plainTextData.addRecord(plainText);
          systemPasteboard.setUnifiedDataSync(plainTextData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0300
     * @tc.desc Test setUnifiedData with Text-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0300';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let textData = new unifiedDataChannel.UnifiedData();
          let text = new unifiedDataChannel.Text();
          text.details = {
            Key: 'text',
            Value: 'text'
          };
          textData.addRecord(text);
          await systemPasteboard.setUnifiedData(textData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0400
     * @tc.desc Test setUnifiedData with Hyperlink UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0400';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let hyperLinkData = new unifiedDataChannel.UnifiedData();
          let link = new unifiedDataChannel.Hyperlink();
          link.details = {
            Key: 'hyperLink',
            Value: 'hyperLink'
          };
          link.url = 'url';
          link.description = 'description';
          hyperLinkData.addRecord(link);
          await systemPasteboard.setUnifiedData(hyperLinkData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0500
     * @tc.desc Test setUnifiedData with HTML UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0500';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let htmlData = new unifiedDataChannel.UnifiedData();
          let html = new unifiedDataChannel.HTML();
          html.details = {
            Key: 'html',
            Value: 'html'
          };
          html.htmlContent = 'htmlContent';
          html.plainContent = 'plainContent';
          htmlData.addRecord(html);
          await systemPasteboard.setUnifiedData(htmlData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0600
     * @tc.desc Test setUnifiedData with File-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0600';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let fileData = new unifiedDataChannel.UnifiedData();
          let file = new unifiedDataChannel.File();
          file.details = {
            Key: 'file',
            Value: 'file'
          };
          file.uri = 'uri';
          fileData.addRecord(file);
          await systemPasteboard.setUnifiedData(fileData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0700
     * @tc.desc Test setUnifiedData with Folder-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0700';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);
          let folderData = new unifiedDataChannel.UnifiedData();
          let folder = new unifiedDataChannel.Folder();
          folder.details = {
            Key: 'folder',
            Value: 'folder'
          };
          folder.uri = 'folderUri';
          folderData.addRecord(folder);
          await systemPasteboard.setUnifiedData(folderData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0800
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0800
     * @tc.desc Test setUnifiedData with Image-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0800';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let imageData = new unifiedDataChannel.UnifiedData();
          let image = new unifiedDataChannel.Image();
          image.details = {
            Key: 'image',
            Value: 'image'
          };
          image.uri = 'imageUri';
          imageData.addRecord(image);
          await systemPasteboard.setUnifiedData(imageData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0900
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0900
     * @tc.desc Test setUnifiedData with Video-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_0900';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let videoData = new unifiedDataChannel.UnifiedData();
          let video = new unifiedDataChannel.Video();
          video.details = {
            Key: 'video',
            Value: 'video'
          };
          video.videoUri = 'videoUri';
          videoData.addRecord(video);
          await systemPasteboard.setUnifiedData(videoData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1000
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1000
     * @tc.desc Test setUnifiedData with Audio-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1000';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let audioData = new unifiedDataChannel.UnifiedData();
          let audio = new unifiedDataChannel.Audio();
          audio.details = {
            Key: 'audio',
            Value: 'audio'
          };
          audio.audioUri = 'audioUri';
          audioData.addRecord(audio);
          await systemPasteboard.setUnifiedData(audioData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1100
     * @tc.desc Test setUnifiedData with Want-type UnifiedRecord and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1100';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        let wantData = new unifiedDataChannel.UnifiedData();
        let object: Want = {
          bundleName: 'bundleName',
          abilityName: 'abilityName'
        }
        let wantRecord = new unifiedDataChannel.UnifiedRecord("openharmony.want", object);
        wantData.addRecord(wantRecord)
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          await systemPasteboard.setUnifiedData(wantData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1200
     * @tc.desc Test setUnifiedData with PixelMap-type UnifiedRecord and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1200';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let pixelMapData = new unifiedDataChannel.UnifiedData();
          let buffer = new ArrayBuffer(128);
          let realSize: image.Size = { height: 3, width: 5 }
          let opt: image.InitializationOptions = {
            size: realSize,
            pixelFormat: 3,
            editable: true,
            alphaType: 1,
            scaleMode: 1
          };
          let pixelMap: image.PixelMap = image.createPixelMapSync(buffer, opt);
          let pixelMapRecord =
            new unifiedDataChannel.UnifiedRecord(uniformTypeDescriptor.UniformDataType.OPENHARMONY_PIXEL_MAP, pixelMap);
          pixelMapData.addRecord(pixelMapRecord);
          await systemPasteboard.setUnifiedData(pixelMapData);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName}Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`)
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1300
     * @tc.desc Test setUnifiedData with mixed-type UnifiedData and verify change count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1300';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`Succeeded in getting the change count.Result0:${result1}`);

          let plainTextData = new unifiedDataChannel.UnifiedData();
          let plainText = new unifiedDataChannel.PlainText();
          plainText.details = {
            Key: 'plaintext',
            Value: 'plaintext'
          };
          plainText.textContent = 'TextContent';
          plainText.abstract = 'TextContent';
          plainTextData.addRecord(plainText);

          let text = new unifiedDataChannel.Text();
          text.details = {
            Key: 'text',
            Value: 'text'
          };
          plainTextData.addRecord(text);

          let link = new unifiedDataChannel.Hyperlink();
          link.details = {
            Key: 'hyperLink',
            Value: 'hyperLink'
          };
          link.url = 'url';
          link.description = 'description';
          plainTextData.addRecord(link);

          let html = new unifiedDataChannel.HTML();
          html.details = {
            Key: 'html',
            Value: 'html'
          };
          html.htmlContent = 'htmlContent';
          html.plainContent = 'plainContent';
          plainTextData.addRecord(html);

          let file = new unifiedDataChannel.File();
          file.details = {
            Key: 'file',
            Value: 'file'
          };
          file.uri = 'uri';
          plainTextData.addRecord(file);

          let folder = new unifiedDataChannel.File();
          folder.details = {
            Key: 'folder',
            Value: 'folder'
          };
          folder.uri = 'folderUri';
          plainTextData.addRecord(folder);

          let image1 = new unifiedDataChannel.Image();
          image1.details = {
            Key: 'image',
            Value: 'image'
          };
          image1.uri = 'imageUri';
          plainTextData.addRecord(image1);

          let video = new unifiedDataChannel.Video();
          video.details = {
            Key: 'video',
            Value: 'video'
          };
          video.videoUri = 'videoUri';
          plainTextData.addRecord(video);

          let audio = new unifiedDataChannel.Audio();
          audio.details = {
            Key: 'audio',
            Value: 'audio'
          };
          audio.audioUri = 'audioUri';
          plainTextData.addRecord(audio);

          let buffer = new ArrayBuffer(128);
          let realSize: image.Size = { height: 3, width: 5 }
          let opt: image.InitializationOptions = {
            size: realSize,
            pixelFormat: 3,
            editable: true,
            alphaType: 1,
            scaleMode: 1
          };
          let pixelMap: image.PixelMap = image.createPixelMapSync(buffer, opt);
          let pixelMapRecord =
            new unifiedDataChannel.UnifiedRecord(uniformTypeDescriptor.UniformDataType.OPENHARMONY_PIXEL_MAP, pixelMap);
          plainTextData.addRecord(pixelMapRecord);

          await systemPasteboard.setUnifiedData(plainTextData);
          console.info(`${caseName} Succeeded in setting pasteData`);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success.`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1400
     * @tc.desc Test setUnifiedData with null parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1400';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.setUnifiedData(null);
          console.log(`${caseName} setUnifiedData success`);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1500
     * @tc.desc Test setUnifiedData with undefined parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_1500';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.setUnifiedData(undefined);
          console.log(`${caseName} setUnifiedData success`);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0100
     * @tc.desc Test getUnifiedData for PlainText-type UnifiedData and verify textContent/abstract/details match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0100';
        console.info(`${caseName} start`);
        let plainTextData = new unifiedDataChannel.UnifiedData();
        let plainText = new unifiedDataChannel.PlainText();
        plainText.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        plainText.textContent = 'TextContent';
        plainText.abstract = 'TextContent';
        plainTextData.addRecord(plainText);
        try {
          await systemPasteboard.setUnifiedData(plainTextData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.PLAIN_TEXT) {
              let text = records[i] as unifiedDataChannel.PlainText;
              expect(text.textContent).assertEqual("TextContent");
              if (isiOS) {
                expect(text.abstract).assertEqual("TextContent");
                if (text.details != undefined) {
                  expect(text.details.Key).assertEqual("Plaintext");
                  expect(text.details.Value).assertEqual("Plaintext");
                }
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0200
     * @tc.desc Test getUnifiedData for Text-type UnifiedData and verify details match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0200';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        let textData = new unifiedDataChannel.UnifiedData();
        let text = new unifiedDataChannel.Text();
        text.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        textData.addRecord(text);
        try {
          await systemPasteboard.setUnifiedData(textData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.TEXT) {
              let text = records[i] as unifiedDataChannel.Text;
              if (text.details != undefined) {
                expect(text.details.Key).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0300
     * @tc.desc Test getUnifiedData for Hyperlink-type UnifiedData and verify url/description/details match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0300';
        console.info(`${caseName} start`);
        let hyperLinkData = new unifiedDataChannel.UnifiedData();
        let hyperLink = new unifiedDataChannel.Hyperlink();
        hyperLink.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        hyperLink.url = 'TextContent';
        hyperLink.description = 'TextContent';
        hyperLinkData.addRecord(hyperLink);
        try {
          await systemPasteboard.setUnifiedData(hyperLinkData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.HYPERLINK) {
              let text = records[i] as unifiedDataChannel.Hyperlink;
              expect(text.url).assertEqual("TextContent");
              if (isiOS) {
                expect(text.description).assertEqual("TextContent");
                if (text.details != undefined) {
                  expect(text.details.Key).assertEqual("Plaintext");
                  expect(text.details.Value).assertEqual("Plaintext");
                }
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0400
     * @tc.desc Test getUnifiedData for HTML-type UnifiedData and verify htmlContent/plainContent/details match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0400';
        console.info(`${caseName} start`);
        let htmlData = new unifiedDataChannel.UnifiedData();
        let html = new unifiedDataChannel.HTML();
        html.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        html.htmlContent = 'TextContent';
        html.plainContent = 'TextContent';
        htmlData.addRecord(html);
        try {
          await systemPasteboard.setUnifiedData(htmlData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.HTML) {
              let text = records[i] as unifiedDataChannel.HTML;
              expect(text.htmlContent).assertEqual("TextContent");
              expect(text.plainContent).assertEqual("TextContent");
              if (isiOS && text.details != undefined) {
                expect(text.details.Key).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0500
     * @tc.desc Test getUnifiedData for File-type UnifiedData and verify uri/details match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0500';
        console.info(`${caseName} start`);
        let fileData = new unifiedDataChannel.UnifiedData();
        let file = new unifiedDataChannel.File();
        file.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        file.uri = 'TextContent';
        fileData.addRecord(file);
        try {
          await systemPasteboard.setUnifiedData(fileData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual("TextContent");
              if (isiOS && text.details != undefined) {
                expect(text.details.Key).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0600
     * @tc.desc Test getUnifiedData for Folder-type UnifiedData and verify uri/folderUri/details and uri match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0600';
        console.info(`${caseName} start`);
        let folderData = new unifiedDataChannel.UnifiedData();
        let folder = new unifiedDataChannel.Folder();
        folder.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        folder.uri = 'TextContent';
        folder.folderUri = 'TextContent';
        folderData.addRecord(folder);
        try {
          await systemPasteboard.setUnifiedData(folderData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (isiOS && records[i].getType() === uniformTypeDescriptor.UniformDataType.FOLDER) {
              let text = records[i] as unifiedDataChannel.Folder;
              expect(text.uri).assertEqual("TextContent");
              expect(text.folderUri).assertEqual("TextContent");
              if (text.details != undefined) {
                expect(text.details.Key).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
            if (isAndroid && records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0700
     * @tc.desc Test getUnifiedData for Image-type UnifiedData and verify uri/imageUri/details and uri match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0700';
        console.info(`${caseName} start`);
        let imageData = new unifiedDataChannel.UnifiedData();
        let image = new unifiedDataChannel.Image();
        image.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        image.uri = 'TextContent';
        image.imageUri = 'TextContent';
        imageData.addRecord(image);
        try {
          await systemPasteboard.setUnifiedData(imageData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (isiOS && records[i].getType() === uniformTypeDescriptor.UniformDataType.IMAGE) {
              let text = records[i] as unifiedDataChannel.Image;
              expect(text.uri).assertEqual("TextContent");
              expect(text.imageUri).assertEqual("TextContent");
              if (text.details != undefined) {
                expect(text.details.Key).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
            if (isAndroid && records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0800
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0800
     * @tc.desc Test getUnifiedData for Video-type UnifiedData and verify videoUri/details and uri match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0800';
        console.info(`${caseName} start`);
        let videData = new unifiedDataChannel.UnifiedData();
        let video = new unifiedDataChannel.Video();
        video.details = {
          Key: 'delayPlaintext',
          Value: 'delayPlaintext',
        };
        video.videoUri = 'schema://com.samples.test/files/test.mp4';
        videData.addRecord(video);
        try {
          await systemPasteboard.setUnifiedData(videData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (isiOS && records[i].getType() === uniformTypeDescriptor.UniformDataType.VIDEO) {
              let text = records[i] as unifiedDataChannel.Video;
              expect(text.videoUri).assertEqual('schema://com.samples.test/files/test.mp4');
              if (text.details != undefined) {
                expect(text.details.Key).assertEqual("delayPlaintext");
                expect(text.details.Value).assertEqual("delayPlaintext");
              }
            }
            if (isAndroid && records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual('schema://com.samples.test/files/test.mp4');
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0900
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0900
     * @tc.desc Test getUnifiedData for Audio-type UnifiedData and verify audioUri/details and uri match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_0900';
        console.info(`${caseName} start`);
        let audioData = new unifiedDataChannel.UnifiedData();
        let audio = new unifiedDataChannel.Audio();
        audio.details = {
          Key: 'delayPlaintext',
          Value: 'delayPlaintext',
        };
        audio.audioUri = 'schema://com.samples.test/files/test.mp4';
        audioData.addRecord(audio);
        try {
          await systemPasteboard.setUnifiedData(audioData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (isiOS && records[i].getType() === uniformTypeDescriptor.UniformDataType.AUDIO) {
              let text = records[i] as unifiedDataChannel.Audio;
              expect(text.audioUri).assertEqual('schema://com.samples.test/files/test.mp4');
              if (text.details != undefined) {
                expect(text.details.Key).assertEqual("delayPlaintext");
                expect(text.details.Value).assertEqual("delayPlaintext");
              }
            }
            if (isAndroid && records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual('schema://com.samples.test/files/test.mp4');
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_1000
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_1000
     * @tc.desc Test getUnifiedData for OPENHARMONY_WANT-type UnifiedRecord and verify bundleName/abilityName match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedData_1000';
        console.info(`${caseName} start`);
        let wantData = new unifiedDataChannel.UnifiedData();
        let object: Want = {
          bundleName: 'bundleName',
          abilityName: 'abilityName'
        }
        let wantRecord = new unifiedDataChannel.UnifiedRecord('openharmony.want', object);
        wantData.addRecord(wantRecord)
        try {
          await systemPasteboard.setUnifiedData(wantData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === "openharmony.want") {
              console.info(JSON.stringify(records[i].getValue()))
              let res = records[i].getValue() as Want;
              expect(res.bundleName).assertEqual("bundleName")
              expect(res.abilityName).assertEqual("abilityName")
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0100
     * @tc.desc Test setUnifiedDataSync with PlainText UnifiedData and verify hasDataSync changes from false to true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0100';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        systemPasteboard.clearDataSync();
        
        let plainTextData = new unifiedDataChannel.UnifiedData();
        let plainText = new unifiedDataChannel.PlainText();
        plainText.details = {
          Key: 'plaintext',
          Value: 'plaintext'
        };
        plainText.textContent = 'TextContent';
        plainText.abstract = 'TextContent';
        plainTextData.addRecord(plainText);
        expect(systemPasteboard.hasDataSync()).assertFalse();
        systemPasteboard.setUnifiedDataSync(plainTextData);
        expect(systemPasteboard.hasDataSync()).assertTrue();
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0200
     * @tc.desc Test setUnifiedDataSync with null parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0200';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        try {
          systemPasteboard.setUnifiedDataSync(null);
          expect().assertFail()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0300
     * @tc.desc Test setUnifiedDataSync with undefined parameter (non-Android) and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_setUnifiedDataSync_0300';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        try {
          systemPasteboard.setUnifiedDataSync(undefined);
          expect().assertFail()
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetUnifiedDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetUnifiedDataSync_0100
     * @tc.desc Test getUnifiedDataSync for PlainText-type UnifiedData and verify textContent match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetUnifiedDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetUnifiedDataSync_0100';
        console.info(`${caseName} start`);
        let plainTextData = new unifiedDataChannel.UnifiedData();
        let plainText = new unifiedDataChannel.PlainText();
        plainText.details = {
          Value1: 'Plaintext',
          Value: 'Plaintext',
        };
        plainText.textContent = 'TextContent';
        plainText.abstract = 'TextContent';
        plainTextData.addRecord(plainText);
        try {
          systemPasteboard.setUnifiedDataSync(plainTextData);
          let data: unifiedDataChannel.UnifiedData = systemPasteboard.getUnifiedDataSync();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (isiOS && records[i].getType() === uniformTypeDescriptor.UniformDataType.PLAIN_TEXT) {
              let text = records[i] as unifiedDataChannel.PlainText;
              expect(text.textContent).assertEqual("TextContent");
              expect(text.abstract).assertEqual("TextContent");
              if (text.details != undefined) {
                expect(text.details.Value1).assertEqual("Plaintext");
                expect(text.details.Value).assertEqual("Plaintext");
              }
            }
            if (isAndroid && records[i].getType() === uniformTypeDescriptor.UniformDataType.PLAIN_TEXT) {
              let text = records[i] as unifiedDataChannel.PlainText;
              expect(text.textContent).assertEqual("TextContent");
            }
          }
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0100
     * @tc.desc Set UnifiedData with PlainText (details, textContent, abstract) and verify its PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0100';
        console.info(`${caseName} start`);
        let plainTextData = new unifiedDataChannel.UnifiedData();
        let plainText = new unifiedDataChannel.PlainText();
        plainText.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        plainText.textContent = 'TextContent';
        plainText.abstract = 'TextContent';
        plainTextData.addRecord(plainText);
        try {
          await systemPasteboard.setUnifiedData(plainTextData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_PLAIN) {
              expect(record.plainText).assertEqual("TextContent");
              expect(await record.getData(pasteboard.MIMETYPE_TEXT_PLAIN)).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0200
     * @tc.desc Set UnifiedData with Text (details) and verify its PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0200';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        let plainTextData = new unifiedDataChannel.UnifiedData();
        let Text = new unifiedDataChannel.Text();
        Text.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        plainTextData.addRecord(Text);
        try {
          await systemPasteboard.setUnifiedData(plainTextData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          let record = data.getRecord(0);
          expect(record.mimeType).assertEqual("general.text");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0300
     * @tc.desc Set UnifiedData with  Hyperlink and Verify its PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0300';
        console.info(`${caseName} start`);
        let hyperLinkData = new unifiedDataChannel.UnifiedData();
        let hyperLink = new unifiedDataChannel.Hyperlink();
        hyperLink.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        hyperLink.url = 'TextContent';
        hyperLink.description = 'TextContent';
        hyperLinkData.addRecord(hyperLink);
        try {
          await systemPasteboard.setUnifiedData(hyperLinkData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_PLAIN) {
              expect(record.plainText).assertEqual("TextContent");
              expect(await record.getData(pasteboard.MIMETYPE_TEXT_PLAIN)).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0400
     * @tc.desc Set UnifiedData with HTML (details, htmlContent, plainContent) and verify its PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0400';
        console.info(`${caseName} start`);
        let htmlData = new unifiedDataChannel.UnifiedData();
        let html = new unifiedDataChannel.HTML();
        html.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        html.htmlContent = 'htmlContent';
        html.plainContent = 'plainContent';
        htmlData.addRecord(html);
        try {
          await systemPasteboard.setUnifiedData(htmlData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_HTML) {
              expect(record.htmlText).assertEqual("htmlContent");
              if (isAndroid) {
                expect(record.plainText).assertEqual("plainContent");
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0500
     * @tc.desc Set UnifiedData with File (details, uri) and verify its PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0500';
        console.info(`${caseName} start`);
        let fileData = new unifiedDataChannel.UnifiedData();
        let file = new unifiedDataChannel.File();
        file.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        file.uri = 'TextContent';
        fileData.addRecord(file);
        try {
          await systemPasteboard.setUnifiedData(fileData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_URI) {
              expect(record.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0600
     * @tc.desc Set UnifiedData with Folder and  Verify in PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0600';
        console.info(`${caseName} start`);
        let folderData = new unifiedDataChannel.UnifiedData();
        let folder = new unifiedDataChannel.Folder();
        folder.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        folder.uri = 'TextContent';
        folder.folderUri = 'TextContent';
        folderData.addRecord(folder);
        try {
          await systemPasteboard.setUnifiedData(folderData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_URI) {
              expect(record.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0700
     * @tc.desc Set UnifiedData with Image and Verify in PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0700';
        console.info(`${caseName} start`);
        let imageData = new unifiedDataChannel.UnifiedData();
        let image = new unifiedDataChannel.Image();
        image.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        image.uri = 'TextContent';
        image.imageUri = 'TextContent';
        imageData.addRecord(image);
        try {
          await systemPasteboard.setUnifiedData(imageData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_URI) {
              expect(record.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0800
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0800
     * @tc.desc Set UnifiedData with Video and Verify in PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0800';
        console.info(`${caseName} start`);
        let videData = new unifiedDataChannel.UnifiedData();
        let video = new unifiedDataChannel.Video();
        video.details = {
          Key: 'delayPlaintext',
          Value: 'delayPlaintext',
        };
        video.videoUri = 'schema://com.samples.test/files/test.mp4';
        videData.addRecord(video);
        try {
          await systemPasteboard.setUnifiedData(videData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_URI) {
              expect(record.uri).assertEqual("schema://com.samples.test/files/test.mp4");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0900
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0900
     * @tc.desc Set UnifiedData this Audio and Verify in PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_0900';
        console.info(`${caseName} start`);
        let audioData = new unifiedDataChannel.UnifiedData();
        let audio = new unifiedDataChannel.Audio();
        audio.details = {
          Key: 'Plaintext',
          Value: 'Plaintext',
        };
        audio.audioUri = 'schema://com.samples.test/files/test.mp4';
        audioData.addRecord(audio);
        try {
          await systemPasteboard.setUnifiedData(audioData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_URI) {
              expect(record.uri).assertEqual("schema://com.samples.test/files/test.mp4");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_1000
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_1000
     * @tc.desc Set UnifiedData with OPENHARMONY_WANT and Verify in PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_1000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetUnifiedData_GetPasteData_1000';
        console.info(`${caseName} start`);
        let wantData = new unifiedDataChannel.UnifiedData();
        let object: Want = {
          bundleName: 'bundleName',
          abilityName: 'abilityName'
        }
        let wantRecord = new unifiedDataChannel.UnifiedRecord("openharmony.want", object);
        wantData.addRecord(wantRecord)
        try {
          await systemPasteboard.setUnifiedData(wantData);
          console.info(`${caseName} Succeeded in setting UnifiedData.`);
          let data = await systemPasteboard.getData();
          for (let i = 0; i < data.getRecordCount(); i++) {
            let record = data.getRecord(i);
            if (record.mimeType === pasteboard.MIMETYPE_TEXT_WANT) {
              console.info(JSON.stringify(record.want))
              let res = await record.getData(pasteboard.MIMETYPE_TEXT_WANT) as Want;
              expect(res.bundleName).assertEqual("bundleName");
              expect(res.abilityName).assertEqual("abilityName");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0100
     * @tc.desc Set PasteData with PlainText and verify its UnifiedData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0100';
        console.info(`${caseName} start`);
        let plainTextData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "TextContent");
        try {
          await systemPasteboard.setData(plainTextData);
          console.info(`${caseName} Succeeded in setting PasteData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.PLAIN_TEXT) {
              let text = records[i] as unifiedDataChannel.PlainText;
              expect(text.textContent).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0200
     * @tc.desc Set PasteData with html and verify its UnifiedData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0200';
        console.info(`${caseName} start`);
        let htmlData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, "TextContent");
        try {
          await systemPasteboard.setData(htmlData);
          console.info(`${caseName} Succeeded in setting PasteData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.HTML) {
              let text = records[i] as unifiedDataChannel.HTML;
              expect(text.htmlContent).assertEqual("TextContent");
              if (isAndroid) {
                expect(text.plainContent).assertEqual("TextContent");
              }
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0300
     * @tc.desc Set PasteData with uri and verify its UnifiedData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0300';
        console.info(`${caseName} start`);
        let uriData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, "TextContent");
        try {
          await systemPasteboard.setData(uriData);
          console.info(`${caseName} Succeeded in setting PasteData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.FILE) {
              let text = records[i] as unifiedDataChannel.File;
              expect(text.uri).assertEqual("TextContent");
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0400
     * @tc.desc set a PasteData with want an Verify in UnifiedData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0400';
        console.info(`${caseName} start`);
        let object: Want = {
          bundleName: 'bundleName',
          abilityName: 'abilityName'
        }
        let wantData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, object);
        try {
          await systemPasteboard.setData(wantData);
          console.info(`${caseName} Succeeded in setting PasteData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === "openharmony.want") {
              console.info(JSON.stringify(records[i].getValue()))
              let res = records[i].getValue() as Want;
              expect(res.bundleName).assertEqual("bundleName")
              expect(res.abilityName).assertEqual("abilityName")
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();

      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0500
     * @tc.desc set a PasteData with pixelMap and Verify in UnifiedData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetPasteData_GetUnifiedData_0500';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        let buffer = new ArrayBuffer(128);
        let realSize: image.Size = { height: 3, width: 5 }
        let opt: image.InitializationOptions = {
          size: realSize,
          pixelFormat: 3,
          editable: true,
          alphaType: 1,
          scaleMode: 1
        };
        let pixelMap: image.PixelMap = image.createPixelMapSync(buffer, opt);
        const oriImageInfo = pixelMap.getImageInfoSync();

        let pixelMapData = pasteboard.createData(pasteboard.MIMETYPE_PIXELMAP, pixelMap);
        try {
          await systemPasteboard.setData(pixelMapData);
          console.info(`${caseName} Succeeded in setting PasteData.`);
          let data = await systemPasteboard.getUnifiedData();
          let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
          for (let i = 0; i < records.length; i++) {
            if (records[i].getType() === uniformTypeDescriptor.UniformDataType.OPENHARMONY_PIXEL_MAP) {
              console.info(JSON.stringify(records[i].getValue()))
              let res = records[i].getValue() as PixelMap;
              expect(JSON.stringify(res.getImageInfoSync())).assertEqual(JSON.stringify(oriImageInfo));
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          console.info(`${caseName} end`);
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })
  })
}