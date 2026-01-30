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
import deviceInfo from '@ohos.deviceInfo';
import pasteboard from '@ohos.pasteboard'
import image from '@ohos.multimedia.image';
import Want from '@ohos.app.ability.Want';
import { Driver, ON } from '@kit.TestKit';
import { BusinessError } from "@kit.BasicServicesKit";
import { abilityAccessCtrl, PermissionRequestResult } from '@kit.AbilityKit';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_100: number = 100

let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
const delegator: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
class Sizes {
  height: number = 3;
  width: number = 5;
}

let opt: image.InitializationOptions = {
  size: new Sizes,
  pixelFormat: 3,
  editable: true,
  alphaType: 1,
  scaleMode: 1
}
let drivenFn = async () => {
  try {
    let driver: Driver = Driver.create();
    console.info('come in driveFn');
    console.info(`driver is ${JSON.stringify(driver)}`);
    await sleep(WAIT_READY_MS_1000);
    let button = await driver.findComponent(ON.text('始终允许'));
    if (button) {
      console.info(`button is ${JSON.stringify(button)}`);
      await sleep(WAIT_READY_MS_1000);
      await button.click();
      await sleep(WAIT_READY_MS_1000);
    } else {
      let button1 = await driver.findComponent(ON.text('仅本次允许'));
      console.info(`button is ${JSON.stringify(button)}`);
      await sleep(WAIT_READY_MS_1000);
      await button1.click();
      await sleep(WAIT_READY_MS_1000);
    }
  } catch (err) {
    console.info('err is' + err);
    return;
  }
}

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

let html = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "<meta charset=\"utf-8\">\n" +
  "<title>HTML-PASTEBOARD_HTML</title>\n" + "</head>\n" + "<body>\n" + "    <h1>HEAD</h1>\n"
  + "    <p></p>\n" + "</body>\n" + "</html>";

let object: Want = {
  bundleName: "com.example.aafwk.test",
  abilityName: "com.example.aafwk.test.TwoAbility"
};

let platform: string = deviceInfo.osFullName.split(' ')[0];

let error: BusinessError | undefined = undefined;

let sleep = (ms: number) => {
  return new Promise<void>(resolve => setTimeout(resolve, ms));
}

const color = new ArrayBuffer(128);

const ARRAY_BUFFER = new ArrayBuffer(256);

export default function pasteDataRecordTest() {
  describe('pasteDataRecordTest', () => {
    console.info('start################################start');
    beforeAll(async (done: Function) => {
      console.info('start################################start');
      await getPermission();
      await sleep(WAIT_READY_MS_1000);
      await drivenFn();
      await sleep(WAIT_READY_MS_1000);
      pasteboard.getSystemPasteboard().clearDataSync();
      done();
    })
    beforeEach(async () => {
      await pasteboard.getSystemPasteboard().clearData();
      error = undefined;
      await sleep(WAIT_READY_MS_100);
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_100);
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0100
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0100
     * @tc.desc Test toPlainText for plain text PasteDataRecord and verify content matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0100';
        console.info(`${caseName} start`);
        try {
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
          let str = await pasteDataRecord.toPlainText();
          expect(str).assertEqual("valueType");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0200
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0200
     * @tc.desc Test toPlainText for PixelMap-type PasteDataRecord and verify returns empty string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0200';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let str = "init";
          let pixelMap = await image.createPixelMap(color, opt);
          let pasteDataRecord: pasteboard.PasteDataRecord =
            pasteboard.createRecord(pasteboard.MIMETYPE_PIXELMAP, pixelMap);
          str = pasteDataRecord.toPlainText();
          expect(str).assertEqual("");
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
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0300
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0300
     * @tc.desc Test toPlainText for ArrayBuffer-type PasteDataRecord and verify returns empty string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0300';
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          console.info(`${caseName} start`);
          let pasteDataRecord = pasteboard.createRecord("ArrayBuffer", ARRAY_BUFFER);
          let str = await pasteDataRecord.toPlainText();
          expect(str).assertEqual("");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0400
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0400
     * @tc.desc Test toPlainText for plain text PasteDataRecord in pasteboard and verify content matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0400';
        try {
          console.info(`${caseName} start`);
          const systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();

          const textData = 'Hello World!';
          const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          await systemPasteboard.setData(pasteData);
          const hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          const data = await systemPasteboard.getData();
          expect(data.getRecordCount() == 1).assertTrue();

          const pasteDataRecord = data.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);

          const str = pasteDataRecord.toPlainText();
          console.info(`${caseName} pasteDataRecord.toPlainText = ` + str);
          expect(str).assertEqual(textData);

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0500
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0500
     * @tc.desc Test toPlainText (plain text with Chinese/special chars) and verify content match
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0500';
        try {
          console.info(`${caseName} start`);
          const systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();

          const textData = 'Hello 中国!@#$%^&amp;*()_+{}\\?.';
          const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          await systemPasteboard.setData(pasteData);
          const hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          const clipboardData = await systemPasteboard.getData();
          expect(clipboardData.getRecordCount() == 1).assertTrue();

          const pasteDataRecord = clipboardData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);

          const resultText = pasteDataRecord.toPlainText();
          console.info(`${caseName} pasteDataRecord.toPlainText = ` + resultText);
          expect(resultText).assertEqual(textData);

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0600
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0600
     * @tc.desc Test toPlainText for plain text PasteDataRecord with 301 'A's in pasteboard and verify content matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0600';
        try {
          console.info(`${caseName} start`);
          const systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();

          const textData = new Array(301).fill("A").join('');
          const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          await systemPasteboard.setData(pasteData);
          const hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          const clipboardData = await systemPasteboard.getData();
          expect(clipboardData.getRecordCount()).assertEqual(1);

          const pasteDataRecord = clipboardData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);

          const resultText = pasteDataRecord.toPlainText();
          console.info(`${caseName} text length: ${resultText.length}`);
          expect(resultText).assertEqual(textData);

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0700
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0700
     * @tc.desc Test toPlainText for URI-type PasteDataRecord in pasteboard and verify content matches URI string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0700';
        try {
          console.info(`${caseName} start`);
          const systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();

          const uriText = 'https://www.baidu.com/';
          const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);

          await systemPasteboard.setData(pasteData);
          const hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          const clipboardData = await systemPasteboard.getData();
          expect(clipboardData.getRecordCount()).assertEqual(1);

          const pasteDataRecord = clipboardData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_URI);

          const resultUri = pasteDataRecord.toPlainText();
          console.info(`${caseName} URI content: ${resultUri}`);
          expect(resultUri).assertEqual(uriText);

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0800
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0800
     * @tc.desc Test toPlainText for HTML-type PasteDataRecord in pasteboard and verify content matches HTML string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_ToPlainText_0800';
        console.info(`${caseName} start`);

        try {
          const systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();

          const htmlContent = '<html><head></head><body>Hello World!</body></html>';
          const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlContent);

          await systemPasteboard.setData(pasteData);

          const hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          const clipboardData = await systemPasteboard.getData();
          expect(clipboardData.getRecordCount()).assertEqual(1);

          const pasteDataRecord = clipboardData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_HTML);

          const convertedText = pasteDataRecord.toPlainText();
          console.info(`${caseName} Converted plain text: ${convertedText}`);
          expect(convertedText).assertEqual(htmlContent);

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_AddEntry_0100
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_AddEntry_0100
     * @tc.desc Test addEntry to add plain text entry to URI-type PasteDataRecord and verify getValidTypes returns
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_AddEntry_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_AddEntry_0100';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_URI,
          ]);
          expect(types.length).assertEqual(2);
          expect(types).assertDeepEquals(['text/plain', 'text/uri']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail()
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_AddEntry_0200
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_AddEntry_0200
     * @tc.desc Test addEntry to add URI entry to plain text-type PasteDataRecord and verify getValidTypes returns
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_AddEntry_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_AddEntry_0200';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_URI, uriText);
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_URI,
          ]);
          expect(types.length).assertEqual(2);
          expect(types).assertDeepEquals(['text/plain', 'text/uri']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail()
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_AddEntry_0300
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_AddEntry_0300
     * @tc.desc Test addEntry to add HTML entry to plain text-type PasteDataRecord and verify getValidTypes returns
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_AddEntry_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_AddEntry_0300';
        console.info(`${caseName} start`);
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_HTML, html);
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_HTML,
          ]);
          expect(types.length).assertEqual(2);
          expect(types).assertDeepEquals(['text/plain', 'text/html']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail()
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_AddEntry_0400
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_AddEntry_0400
     * @tc.desc Test addEntry to add WANT entry to plain text-type PasteDataRecord and verify getValidTypes returns
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_AddEntry_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_AddEntry_0400';
        console.info(`${caseName} start`);
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_WANT, object);
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_WANT,
          ]);
          expect(types.length).assertEqual(2);
          expect(types).assertDeepEquals(['text/plain', 'text/want']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail()
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_AddEntry_0500
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_AddEntry_0500
     * @tc.desc Test addEntry with invalid parameters (null mimeType, undefined value) and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_AddEntry_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_AddEntry_0500';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let htmlText = '<html><head></head><body>Hello World!</body></html>';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          record.addEntry(null, undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0100
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0100
     * @tc.desc Test getValidTypes for URI-type PasteDataRecord with plain text entry and verify returns 2 valid types
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0100';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_URI,
          ]);
          expect(types.length).assertEqual(2);
          expect(types).assertDeepEquals(['text/plain', 'text/uri']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0200
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0200
     * @tc.desc Test getValidTypes for multi-type PasteDataRecord (6 types) and verify returns all 6 valid types
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0200';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let buffer = new ArrayBuffer(128);
        let realSize: image.Size = { height: 3, width: 5 };
        let opt: image.InitializationOptions = {
          size: realSize,
          pixelFormat: 3,
          editable: true,
          alphaType: 1,
          scaleMode: 1
        };
        let pixelMap: image.PixelMap = image.createPixelMapSync(buffer, opt);
        let uriText = 'https://www.baidu.com/';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        try {
          record.addEntry(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
          record.addEntry(pasteboard.MIMETYPE_TEXT_HTML, html);
          record.addEntry(pasteboard.MIMETYPE_PIXELMAP, pixelMap)
          record.addEntry(pasteboard.MIMETYPE_TEXT_WANT, object)
          record.addEntry('app/xml', new ArrayBuffer(256),)
          let types: string[] = record.getValidTypes([
            pasteboard.MIMETYPE_TEXT_PLAIN,
            pasteboard.MIMETYPE_TEXT_HTML,
            pasteboard.MIMETYPE_TEXT_URI,
            pasteboard.MIMETYPE_TEXT_WANT,
            pasteboard.MIMETYPE_PIXELMAP,
            'app/xml'
          ]);
          expect(types.length).assertEqual(6);
          expect(types).assertDeepEquals(['text/plain', 'text/html', 'text/uri', 'text/want', 'pixelMap', 'app/xml']);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0300
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0300
     * @tc.desc Test getValidTypes with null parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetValidTypes_0300';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let htmlText = '<html><head></head><body>Hello World!</body></html>';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        record.addEntry(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
        record.addEntry(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
        try {
          let types: string[] = record.getValidTypes(null);
          expect(types.length).assertEqual(0);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetData_0100
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetData_0100
     * @tc.desc Test getData for plain text-type PasteDataRecord and verify content matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetData_0100';
        console.info(`${caseName} start`);
        let textData = 'hello';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
        try {
          let value = await record.getData(pasteboard.MIMETYPE_TEXT_PLAIN);
          let plainData = value as string;
          expect(plainData).assertEqual(textData);
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
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetData_0200
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetData_0200
     * @tc.desc Test getData for HTML-type PasteDataRecord and verify content matches HTML string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetData_0200';
        console.info(`${caseName} start`);
        let htmlText = '<html><head></head><body>Hello World!</body></html>';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
        try {
          let value = await record.getData(pasteboard.MIMETYPE_TEXT_HTML);
          let htmlData = value as string;
          expect(htmlData).assertEqual(htmlText);
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
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetData_0300
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetData_0300
     * @tc.desc Test getData for URI-type PasteDataRecord and verify content matches URI string
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetData_0300';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        try {
          let value = await record.getData(pasteboard.MIMETYPE_TEXT_URI);
          let uriData = value as string;
          expect(uriData).assertEqual(uriText);
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
     * @tc.number ArKUIX_ArkTS_PasteDataRecord_GetData_0400
     * @tc.name ArKUIX_ArkTS_PasteDataRecord_GetData_0400
     * @tc.desc Test getData for WANT-type PasteDataRecord and verify content contains target Want properties
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteDataRecord_GetData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteDataRecord_GetData_0400';
        console.info(`${caseName} start`);
        let object: Want = {
          bundleName: "com.example.aafwk.test",
          abilityName: "com.example.aafwk.test.TwoAbility"
        };
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_WANT, object);
        try {
          let value = await record.getData(pasteboard.MIMETYPE_TEXT_WANT);
          let wantData = value as string;
          expect(JSON.stringify(wantData))
            .assertContain('"bundleName":"com.example.aafwk.test","abilityName":"com.example.aafwk.test.TwoAbility"');
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
     * @tc.number ArKUIX_ArkTS_ArkTS_PasteDataRecord_GetData_0500
     * @tc.name ArKUIX_ArkTS_ArkTS_PasteDataRecord_GetData_0500
     * @tc.desc Test getData with null parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_ArkTS_PasteDataRecord_GetData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_ArkTS_PasteDataRecord_GetData_0500';
        console.info(`${caseName} start`);
        let uriText = 'https://www.baidu.com/';
        let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
        record.addEntry(pasteboard.MIMETYPE_TEXT_PLAIN, 'hello');
        try {
          record.getData(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        
        done();
      })
  })
}