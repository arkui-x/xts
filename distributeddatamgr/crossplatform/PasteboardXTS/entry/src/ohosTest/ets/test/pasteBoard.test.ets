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
import pasteboard from '@ohos.pasteboard'
import Want from '@ohos.app.ability.Want';
import deviceInfo from '@ohos.deviceInfo';
import { Driver, ON } from '@kit.TestKit';
import { BusinessError } from "@kit.BasicServicesKit";
import { abilityAccessCtrl, PermissionRequestResult } from '@kit.AbilityKit';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_100: number = 100

let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
const delegator:AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

let error: BusinessError | undefined = undefined;
let platform: string = deviceInfo.osFullName.split(' ')[0];

let html = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "<meta charset=\"utf-8\">\n"
  + "<title>HTML-PASTEBOARD_HTML</title>\n" + "</head>\n" + "<body>\n"
  + "    <h1>HEAD</h1>\n" + "    <p></p>\n" + "</body>\n" + "</html>";
let uri = 'dataability:///com.example.myapplication1/user.txt';

let object: Want = {
  bundleName: "com.example.aafwk.test",
  abilityName: "com.example.aafwk.test.TwoAbility"
};

const WANT: Want = {
  bundleName: "com.acts.distributeddatamgr.pasteboardtest",
  abilityName: "com.acts.distributeddatamgr.pasteboardtest.MainAbility"
};

const ARRAY_BUFFER = new ArrayBuffer(256);

function createData(mimetype: ESObject, valueType: ESObject) {
  pasteboard.createData(mimetype, valueType);
}

function createRecord(mimetype: ESObject, valueType: ESObject) {
  pasteboard.createRecord(mimetype, valueType);
}

let sleep = (ms: number) => {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
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
export default function pasteBoardTest() {
  describe('pasteBoardTest', () => {
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
    beforeEach(() => {
      error = undefined;
    })
    beforeEach(async () => {
      await pasteboard.getSystemPasteboard().clearData();
      await sleep(WAIT_READY_MS_100);
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_100);
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0100
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0100
     * @tc.desc Create pasteData with MIMETYPE_TEXT_PLAIN and string value successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0100';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "String");
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0200
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0200
     * @tc.desc Create pasteData with MIMETYPE_TEXT_URI and URI value successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0200';
        console.info(`${caseName} start`);
        try {
          let uri = "https://www.baidu.com/";
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uri);
          expect(pasteData.getRecord(0).uri).assertEqual(uri);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0300
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0300
     * @tc.desc Create pasteData with MIMETYPE_TEXT_HTML and HTML string successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0300';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0400
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0400
     * @tc.desc Create pasteData with MIMETYPE_TEXT_WANT and WANT value successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0400';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, WANT);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0500
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0500
     * @tc.desc Create pasteData with 1024-length MIME type and ARRAY_BUFFER successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0500';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let mimeType = "x".repeat(1024);
          let pasteData = pasteboard.createData(mimeType, ARRAY_BUFFER);
          let hasType: boolean = pasteData.hasType(mimeType);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0600
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0600
     * @tc.desc Create pasteData with "string" MIME type and ARRAY_BUFFER successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0600';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
          let hasType: boolean = pasteData.hasType("string");
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0700
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0700
     * @tc.desc Create pasteData fails when mimeType is number type (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0700';
        console.info(`${caseName} start`);
        try {
          createData(0, "String");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_0800
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_0800
     * @tc.desc Create pasteData fails when mimeType is null (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_0800';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(null, "String");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0100
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0100
     * @tc.desc Create pasteData with Record (MIMETYPE_TEXT_PLAIN + text value) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0100';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_PLAIN] = 'hello';
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataText = pasteData.getPrimaryText();
          expect(pasteDataText).assertEqual('hello');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0200
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0200
     * @tc.desc Create pasteData with Record (MIMETYPE_TEXT_WANT + WANT object) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0200';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_WANT] = object;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataWant = pasteData.getPrimaryWant();
          expect(JSON.stringify(pasteDataWant))
            .assertContain('"bundleName":"com.example.aafwk.test","abilityName":"com.example.aafwk.test.TwoAbility"');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0300
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0300
     * @tc.desc Create pasteData with Record (MIMETYPE_TEXT_URI + URI value) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0300';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_URI] = uri;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataUri = pasteData.getPrimaryUri();
          expect(pasteDataUri).assertEqual(uri);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0400
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0400
     * @tc.desc Create pasteData with Record (MIMETYPE_TEXT_HTML + HTML value) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0400';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_HTML] = html;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataHtml = pasteData.getPrimaryHtml();
          expect(pasteDataHtml).assertEqual(html);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0500
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0500
     * @tc.desc Create pasteData with Record (TEXT_PLAIN + TEXT_WANT) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0500';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_PLAIN] = 'hello';
        record[pasteboard.MIMETYPE_TEXT_WANT] = object;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataText = pasteData.getPrimaryText();
          expect(pasteDataText).assertEqual('hello');
          let pasteDataWant = pasteData.getPrimaryWant();
          expect(JSON.stringify(pasteDataWant))
            .assertContain('"bundleName":"com.example.aafwk.test","abilityName":"com.example.aafwk.test.TwoAbility"');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0600
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0600
     * @tc.desc Create pasteData with Record (HTML + URI + WANT) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0600';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_HTML] = html;
        record[pasteboard.MIMETYPE_TEXT_URI] = uri;
        record[pasteboard.MIMETYPE_TEXT_WANT] = object;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataHtml = pasteData.getPrimaryHtml()
          expect(pasteDataHtml).assertEqual(html)
          let pasteDataUri = pasteData.getPrimaryUri();
          expect(pasteDataUri).assertEqual(uri);
          let pasteDataWant = pasteData.getPrimaryWant();
          expect(JSON.stringify(pasteDataWant))
            .assertContain('"bundleName":"com.example.aafwk.test","abilityName":"com.example.aafwk.test.TwoAbility"');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0700
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0700
     * @tc.desc Create pasteData with Record (TEXT_PLAIN + HTML + URI + WANT) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0700';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_PLAIN] = 'hello';
        record[pasteboard.MIMETYPE_TEXT_HTML] = html;
        record[pasteboard.MIMETYPE_TEXT_URI] = uri;
        record[pasteboard.MIMETYPE_TEXT_WANT] = object;
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let pasteDataText = pasteData.getPrimaryText();
          expect(pasteDataText).assertEqual('hello');
          let pasteDataHtml = pasteData.getPrimaryHtml()
          expect(pasteDataHtml).assertEqual(html)
          let pasteDataUri = pasteData.getPrimaryUri();
          expect(pasteDataUri).assertEqual(uri);
          let pasteDataWant = pasteData.getPrimaryWant();
          expect(JSON.stringify(pasteDataWant))
            .assertContain('"bundleName":"com.example.aafwk.test","abilityName":"com.example.aafwk.test.TwoAbility"');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0800
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0800
     * @tc.desc Create pasteData with empty Record parameter returns null successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0800';
        console.info(`${caseName} start`);
        let record: Record<string, pasteboard.ValueType> = {};
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          expect(pasteData == null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateData_Record_0900
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateData_Record_0900
     * @tc.desc Create pasteData with Record (custom "string" type + text value) successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateData_Record_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateData_Record_0900';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let record: Record<string, pasteboard.ValueType> = {};
        record["string"] = 'hello';
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(record);
          let hasType: boolean = pasteData.hasType("string");
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0100
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0100
     * @tc.desc Test createRecord creates text/plain record and verifies it is added to text/html PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0100';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "Hello World!");
          pasteData.addRecord(pasteDataRecord);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0200
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0200
     * @tc.desc Test createRecord creates text/html record and verifies it is added to text/plain PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0200';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "Hello World!");
          let htmlText = '<h1>Test CreateRecord</h1>';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          pasteData.addRecord(pasteDataRecord);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0300
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0300
     * @tc.desc Test createRecord creates text/uri record and verifies it is added to text/plain PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0300';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "Hello World!");
          let uriText = 'https://www.baidu.com/';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
          pasteData.addRecord(pasteDataRecord);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0400
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0400
     * @tc.desc Test createRecord creates text/want record and verifies it is added to text/plain PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0400';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "Hello World!");
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_WANT, WANT);
          pasteData.addRecord(pasteDataRecord);
          let hasType: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(hasType).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0500
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0500
     * @tc.desc CreateRecord fails when mimeType is number type (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0500';
        console.info(`${caseName} start`);
        try {
          createRecord(1, "String");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_CreateRecord_0600
     * @tc.name ArKUIX_ArkTS_Pasteboard_CreateRecord_0600
     * @tc.desc CreateRecord fails when mimeType is null (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_CreateRecord_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_CreateRecord_0600';
        console.info(`${caseName} start`);
        try {
          let pasteDataRecord = pasteboard.createRecord(null, "String");
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_Pasteboard_GetSystemPasteboard_0100
     * @tc.name ArKUIX_ArkTS_Pasteboard_GetSystemPasteboard_0100
     * @tc.desc Test the getSystemPasteboard function of the pasteboard
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_Pasteboard_GetSystemPasteboard_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_Pasteboard_GetSystemPasteboard_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          await systemPasteboard.setData(pasteData);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })
  })
}