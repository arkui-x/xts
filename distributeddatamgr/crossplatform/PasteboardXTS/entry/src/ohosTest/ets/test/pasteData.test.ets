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
import { pasteboard } from '@kit.BasicServicesKit';
import image from '@ohos.multimedia.image';
import { BusinessError } from '@ohos.base';
import { Want, abilityAccessCtrl, common, PermissionRequestResult } from '@kit.AbilityKit';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Driver, ON } from '@kit.TestKit';

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_100: number = 100

let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();

class Sizes {
  height: number = 3;
  width: number = 5;
}

interface ImageInitializationOptions {
  size: image.Size;
  pixelFormat: number;
  editable: boolean;
  alphaType: number;
  scaleMode: number;
}

let opt: ImageInitializationOptions = {
  size: new Sizes(),
  pixelFormat: 3,
  editable: true,
  alphaType: 1,
  scaleMode: 1
};

let platform: string = deviceInfo.osFullName.split(' ')[0];
let error: BusinessError | undefined = undefined;
const color = new ArrayBuffer(128);

const WANT: Want = {
  bundleName: "com.acts.distributeddatamgr.pasteboardtest",
  abilityName: "com.acts.distributeddatamgr.pasteboardtest.MainAbility"
};

const ARRAY_BUFFER = new ArrayBuffer(256);

function setPropertyFunc(func: Function, property: ESObject) {
  func();
}

function addRecord(pasteData: pasteboard.PasteData, mimeType: ESObject, valueType: ESObject) {
  pasteData.addRecord(mimeType, valueType);
}

function getRecord(pasteData: pasteboard.PasteData, index: ESObject) {
  pasteData.getRecord(index);
}

function check(pasteData: pasteboard.PasteData, mimeType: ESObject) {
  pasteData.hasType(mimeType);
}

function checkFunc(func: Function, mimeType: ESObject) {
  func();
}

function remove(pasteData: pasteboard.PasteData, index: ESObject) {
  pasteData.removeRecord(index);
}

function removeFunc(func: Function, index: ESObject) {
  func();
}

function replace(pasteData: pasteboard.PasteData, index: ESObject, record: ESObject) {
  pasteData.replaceRecord(index, record);
}

function replaceFunc(func: Function, index: ESObject, record: ESObject) {
  func();
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

export default function pasteDataTest() {
  describe('pasteDataTest', () => {
    console.info('start################################start');
    beforeAll(async (done: Function) => {
      await getPermission();
      await sleep(WAIT_READY_MS_1000);
      await drivenFn();
      await sleep(WAIT_READY_MS_1000);
      pasteboard.getSystemPasteboard().clearDataSync();
      done();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_0100
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_0100
     * @tc.desc Add TEXT_PLAIN record to pasteData with TEXT_WANT data successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_0100';
        console.info(`${caseName} start`);
        let want: Want = {
          bundleName: "com.example.aafwk.test",
          abilityName: "com.example.aafwk.test.TwoAbility"
        };
        let textData = 'hello world';
        try {
          let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          pasteData.addRecord(record);
          expect(pasteData.getRecordCount() == 2).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_0200
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_0200
     * @tc.desc Add TEXT_HTML record to pasteData with TEXT_PLAIN data successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_0200';
        console.info(`${caseName} start`);
        let html = '<html><head></head><body>Hello World!</body></html>';
        let textData = 'hello';
        try {
          let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_HTML, html);
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          pasteData.addRecord(record);
          expect(pasteData.getRecordCount() == 2).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_0300
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_0300
     * @tc.desc Add TEXT_WANT record to pasteData with TEXT_PLAIN data successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_0300';
        console.info(`${caseName} start`);
        let want: Want = {
          bundleName: "com.example.aafwk.test",
          abilityName: "com.example.aafwk.test.TwoAbility"
        };
        let textData = 'hello';
        try {
          let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_WANT, want);
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          pasteData.addRecord(record);
          expect(pasteData.getRecordCount() == 2).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_0400
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_0400
     * @tc.desc Add TEXT_URI record to pasteData with TEXT_PLAIN data successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_0400';
        console.info(`${caseName} start`);
        let uri = 'https://www.baidu.com/';
        let textData = 'hello';
        try {
          let record: pasteboard.PasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uri);
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          pasteData.addRecord(record);
          expect(pasteData.getRecordCount() == 2).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0100
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0100
     * @tc.desc Add TEXT_PLAIN record (MIME+text) to pasteData with TEXT_HTML data successfully
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0100';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let textData = 'Hello World!';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0200
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0200
     * @tc.desc Test adding URI-type record (MIME+URI) to TEXT_HTML PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0200';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let uriText = 'https://www.baidu.com/';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0300
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0300
     * @tc.desc Test adding HTML-type record (MIME+HTML) to TEXT_HTML PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0300';
        console.info(`${caseName} start`);
        try {
          let htmlText0 = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText0);
          let htmlText = '<h1>Test CreateRecord</h1>';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0400
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0400
     * @tc.desc Test adding WANT-type record (MIME+WANT) to TEXT_HTML PasteData
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0400';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_WANT, WANT);
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0500
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0500
     * @tc.desc Test adding TEXT_PLAIN record (MIME+text) to TEXT_PLAIN PasteData for system pasteboard
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let textData1 = 'Hello World1';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 2).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0600
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0600
     * @tc.desc Test adding 15 plain text records and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0600';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let textData = '';
          for (let i = 1; i < 15; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 15).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0700
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0700
     * @tc.desc Test adding 30 plain text records and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0700';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let textData = '';
          for (let i = 1; i < 30; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 30).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0800
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0800
     * @tc.desc Test adding 31 plain text records and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0800';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let textData = '';
          for (let i = 1; i < 31; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          let recordCount = pasteData1.getRecordCount();
          expect(recordCount == 31).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0900
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0900
     * @tc.desc Test adding 4 records (plain text, HTML, URI, Want) and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_0900';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);

          let uriText = 'https://www.baidu.com/';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);

          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_WANT, want);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 4).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1000
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1000
     * @tc.desc Test adding record with number-type MIME type (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1000';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
        try {
          addRecord(pasteData, 1, "string");
        } catch (err) {
          console.info(`${caseName} Add record error, err code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1100
     * @tc.name ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1100
     * @tc.desc Test adding record with null MIME type (error code 401)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_AddRecord_MimeType_1100';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
        try {
          pasteData.addRecord(null, "string");
        } catch (err) {
          console.info(`${caseName} Add record error, err code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetMimeTypes_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetMimeTypes_0100
     * @tc.desc Test getMimeTypes for plain text PasteData and verify MIME type list
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetMimeTypes_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetMimeTypes_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let types: Array<String> = pasteData.getMimeTypes();
          expect(types.length == 1).assertTrue();
          expect(types).assertDeepEquals(["text/plain"]);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetMimeTypes_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetMimeTypes_0200
     * @tc.desc Test getMimeTypes for HTML text PasteData and verify MIME type list
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetMimeTypes_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetMimeTypes_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let types: Array<String> = pasteData.getMimeTypes();
          expect(types.length == 1).assertTrue();
          expect(types).assertDeepEquals(["text/html"]);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetMimeTypes_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetMimeTypes_0300
     * @tc.desc Test getMimeTypes for URI text PasteData and verify MIME type list
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetMimeTypes_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetMimeTypes_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let types: Array<String> = pasteData.getMimeTypes();
          expect(types.length == 1).assertTrue();
          expect(types).assertDeepEquals(["text/uri"]);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetMimeTypes_0400
     * @tc.name ArKUIX_ArkTS_PasteData_GetMimeTypes_0400
     * @tc.desc Test getMimeTypes for WANT PasteData and verify MIME type list
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetMimeTypes_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetMimeTypes_0400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let myWant: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, myWant);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let types: Array<String> = pasteData.getMimeTypes();
          expect(types.length == 1).assertTrue();
          expect(types).assertDeepEquals(["text/want"]);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0100
     * @tc.desc Test getPrimaryHtml for HTML text PasteData and verify HTML content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryHtml = pasteData1.getPrimaryHtml();
          expect(primaryHtml == htmlText).assertTrue();
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0200
     * @tc.desc Test getPrimaryHtml for empty HTML text PasteData and verify empty content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          let primaryHtml = pasteData1.getPrimaryHtml();
          expect(primaryHtml == htmlText).assertTrue();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0300
     * @tc.desc Test getPrimaryHtml for HTML text with special chars/Chinese and verify content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryHtml_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = 'Hello 中国!@#$%^&*()_+{}\?.';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryHtml() == htmlText).assertTrue();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryWant_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryWant_0100
     * @tc.desc Test getPrimaryWant for WANT PasteData and verify WANT content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryWant_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryWant_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryWant = pasteData1.getPrimaryWant();
          expect(want.bundleName).assertEqual(primaryWant.bundleName);
          expect(want.abilityName).assertEqual(primaryWant.abilityName);
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryText_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryText_0100
     * @tc.desc Test getPrimaryText for plain text PasteData and verify text content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryText_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          let types: Array<String> = pasteData.getMimeTypes();
          expect(types.length == 1).assertTrue();
          expect(types).assertDeepEquals(["text/plain"]);
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText == textData).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryText_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryText_0200
     * @tc.desc Test getPrimaryText for empty plain text PasteData and verify empty content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryText_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryText_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = '';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          let PrimaryText = pasteData1.getPrimaryText();
          expect(PrimaryText == textData).assertTrue;
          let recordCount = pasteData1.getRecordCount();
          expect(recordCount == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryText_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryText_0300
     * @tc.desc Test getPrimaryText for plain text with special chars/Chinese and verify content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryText_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryText_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello 中国!@#$%^&*()_+{}\?.';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText == textData).assertTrue;
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryText_0400
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryText_0400
     * @tc.desc Test getPrimaryText for long plain text (300 chars) PasteData and verify content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryText_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryText_0400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = '';
          for (let i = 0; i < 300; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText == textData).assertTrue;
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryText_0500
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryText_0500
     * @tc.desc Test getPrimaryText for long plain text (301 chars) PasteData and verify content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryText_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryText_0500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = '';
          for (let i = 0; i < 301; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText == textData).assertTrue;
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryUri_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryUri_0100
     * @tc.desc Test getPrimaryUri for URI text PasteData and verify URI content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryUri_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryUri_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let primaryUri = pasteData1.getPrimaryUri();
          expect(primaryUri == uriText).assertTrue();
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryUri_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryUri_0200
     * @tc.desc Test getPrimaryUri for empty URI text PasteData and verify empty content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryUri_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryUri_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = '';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryUri() == uriText).assertTrue();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryUri_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryUri_0300
     * @tc.desc Test getPrimaryUri for URI text with special format and verify content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryUri_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryUri_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'Hello//';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryUri() == uriText).assertTrue();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let hastypes: boolean = pasteData1.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(hastypes).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0100
     * @tc.desc Test getPrimaryMimeType for plain text PasteData and verify primary MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryMimeType()).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0200
     * @tc.desc Test getPrimaryMimeType for long plain text (300 chars) PasteData and verify primary MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0200';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = '';
          for (let i = 0; i < 300; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryMimeType() == pasteboard.MIMETYPE_TEXT_PLAIN).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0300
     * @tc.desc Test getPrimaryMimeType for HTML text PasteData and verify primary MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0300';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryMimeType()).assertEqual(pasteboard.MIMETYPE_TEXT_HTML);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0400
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0400
     * @tc.desc Test getPrimaryMimeType for URI text PasteData and verify primary MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0400';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryMimeType()).assertEqual(pasteboard.MIMETYPE_TEXT_URI);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0500
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0500
     * @tc.desc Test getPrimaryMimeType for WANT PasteData and verify primary MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryMimeType_0500';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let myWant: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, myWant);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getPrimaryMimeType()).assertEqual(pasteboard.MIMETYPE_TEXT_WANT);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetProperty_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetProperty_0100
     * @tc.desc Test getProperty for plain text PasteData and verify property tag
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetProperty_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetProperty_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Sets the Property`);
          let pasteDataProperty = pasteData1.getProperty();
          console.info(`${caseName} timestamp = ${pasteDataProperty.timestamp}`);
          expect(pasteDataProperty.tag == "").assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetProperty_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetProperty_0200
     * @tc.desc Test getProperty for plain text PasteData and verify set property tag
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetProperty_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetProperty_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Sets the Property`);
          let pasteDataProperty = pasteData1.getProperty();
          console.info(`${caseName} timestamp = ${pasteDataProperty.timestamp}`);
          pasteDataProperty.tag = "Test";
          pasteData1.setProperty(pasteDataProperty);

          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Succeeded in setting PasteData`);
          let hasDataAfter = await systemPasteboard.hasData();
          console.info(`${caseName} Succeeded in checking the PasteData. Data: ${hasDataAfter}`);
          expect(hasDataAfter == true).assertTrue();
          let pasteData2 = await systemPasteboard.getData();
          let pasteDataProperty1 = pasteData2.getProperty();
          expect(pasteDataProperty1.tag == "Test").assertTrue();
          console.info(`${caseName} timestamp = ${pasteDataProperty1.timestamp}`);
          console.info(`${caseName} tag = ${pasteDataProperty1.tag}`);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetProperty_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetProperty_0300
     * @tc.desc Test getProperty for plain text PasteData after clear and verify property tag
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetProperty_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetProperty_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
          console.info(`${caseName} Checks the Property`);
          let pasteDataProperty1 = pasteData1.getProperty();
          expect(pasteDataProperty1.tag == "").assertTrue();
          console.info(`${caseName} timestamp = ${pasteDataProperty1.timestamp}`);
          console.info(`${caseName} tag = ${pasteDataProperty1.tag}`);
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
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0100
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0100
     * @tc.desc Test setProperty for plain text PasteData and verify MIME type in property
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0100';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        systemPasteBoard.clearDataSync();
        let prop = pasteData.getProperty();
        pasteData.setProperty(prop);
        let property = pasteData.getProperty();
        let realmimeType = property.mimeTypes.pop();
        expect(realmimeType).assertEqual("text/plain");
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0200
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0200
     * @tc.desc Test setProperty for plain text PasteData and verify tag attribute
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0200';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        systemPasteBoard.clearDataSync();
        let prop = pasteData.getProperty();
        prop.tag = "testTag";
        pasteData.setProperty(prop);
        let property = pasteData.getProperty();
        console.info(`${caseName} tag : ${property.tag}`);
        expect(property.tag).assertEqual("testTag");
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0300
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0300
     * @tc.desc Test setProperty for plain text PasteData and verify additions attribute
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Sets the Property`)
          let pasteDataProperty = pasteData1.getProperty();
          let object: ESObject = {
            bundleName: "pasteBoardEtsunitTest"
          };
          pasteDataProperty.additions["one"] = object;
          pasteData1.setProperty(pasteDataProperty);

          console.info(`${caseName} Checks the Property`)
          await systemPasteboard.setData(pasteData1);
          let hasDataAfter = await systemPasteboard.hasData();
          expect(hasDataAfter == true).assertTrue();
          let pasteData2 = await systemPasteboard.getData();
          let pasteDataProperty1 = pasteData2.getProperty();
          expect(pasteDataProperty1.tag == "").assertTrue();
          console.info(`${caseName} timestamp = ${pasteDataProperty1.timestamp}`);
          let tag1 = pasteData1.getTag();
          console.info(`${caseName} tag = ${tag1}`);
          console.info(`${caseName} additions = ${pasteDataProperty1.additions["one"]}`);
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
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0400
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0400
     * @tc.desc Test setProperty for plain text PasteData and verify tag after pasteboard persistence
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Sets the Property`);
          let pasteDataProperty = pasteData1.getProperty();
          console.info(`${caseName} timestamp = ${pasteDataProperty.timestamp}`);
          pasteDataProperty.tag = "Test";
          pasteData1.setProperty(pasteDataProperty);

          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Succeeded in setting PasteData`);
          let hasDataAfter = await systemPasteboard.hasData();
          console.info(`${caseName} Succeeded in checking the PasteData. Data: ${hasDataAfter}`);
          expect(hasDataAfter == true).assertTrue();
          let pasteData2 = await systemPasteboard.getData();
          let pasteDataProperty1 = pasteData2.getProperty();
          expect(pasteDataProperty1.tag == "Test").assertTrue();
          console.info(`${caseName} timestamp = ${pasteDataProperty1.timestamp}`);
          console.info(`${caseName} tag = ${pasteDataProperty1.tag}`);
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
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0500
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0500
     * @tc.desc Test setProperty with null parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0500';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
        try {
          pasteData.setProperty(null);
        } catch (err) {
          console.info(`${caseName} Set property error, err code is : ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0600
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0600
     * @tc.desc Test setProperty with undefined parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0600';
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
        console.info(`${caseName} start`);
        try {
          pasteData.setProperty(undefined);
        } catch (err) {
          console.info(`${caseName} Set property error, err code is : ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_SetProperty_0700
     * @tc.name ArKUIX_ArkTS_PasteData_SetProperty_0700
     * @tc.desc Test setProperty with invalid string parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_SetProperty_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_SetProperty_0700';
        let textData = "Hello World";
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
        console.info(`${caseName} start`);
        try {
          setPropertyFunc(pasteData.setProperty, "prop");
        } catch (err) {
          console.info(`${caseName} Set property error, err code is : ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0100
     * @tc.desc Test getRecord for plain text PasteData and verify record MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0100';
        console.info(`${caseName} start`);
        try {
          let textData = "Hello World";
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let pasteDataRecord = pasteData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0200
     * @tc.desc Test getRecord for HTML text PasteData and verify record MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0200';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let pasteDataRecord = pasteData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_HTML);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0300
     * @tc.desc Test getRecord for WANT PasteData and verify record MIME type
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0300';
        console.info(`${caseName} start`);
        try {
          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          let pasteDataRecord = pasteData.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_WANT);

        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0400
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0400
     * @tc.desc Test getRecord for URI text PasteData and verify record URI value
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0400';
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0500
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0500
     * @tc.desc Test getRecord for plain text PasteData in pasteboard and verify record plainText value
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          console.info(`${caseName} Checks the pasteboard content`);
          let recordText = pasteData1.getRecord(0).plainText;
          console.info(`${caseName} recordText = ${recordText}`);
          expect(recordText).assertEqual(textData);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0600
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0600
     * @tc.desc Test getRecord with string index parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0600';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello")
        console.info(`${caseName} start`);
        try {
          getRecord(pasteData, "0");
        } catch (err) {
          console.info(`${caseName} Get specified record failed,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecord_0700
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecord_0700
     * @tc.desc Test getRecord with out-of-bounds index and verify error code 12900001
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecord_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecord_0700';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello")
        console.info(`${caseName} start`);
        try {
          pasteData.getRecord(1)
        } catch (err) {
          console.info(`${caseName} Get specified record failed,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("12900001");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0100
     * @tc.desc Test getRecordCount for plain text PasteData in pasteboard and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0200
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0200
     * @tc.desc Test getRecordCount for PasteData with multiple plain text records and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = ''
          for (let i = 1; i < 2; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 2).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0300
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0300
     * @tc.desc Test getRecordCount for PasteData with 15 plain text records and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = ''
          for (let i = 1; i < 15; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 15).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0400
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0400
     * @tc.desc Test getRecordCount for PasteData with 30 plain text records and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = ''
          for (let i = 1; i < 30; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 30).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0500
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0500
     * @tc.desc Test getRecordCount for PasteData with 31 plain text records and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = '';
          for (let i = 1; i < 31; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 31).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetRecordCount_0600
     * @tc.name ArKUIX_ArkTS_PasteData_GetRecordCount_0600
     * @tc.desc Test getRecordCount for plain text PasteData before and after pasteboard clear and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetRecordCount_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetRecordCount_0600';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();

          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(0);
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
     * @tc.number ArKUIX_ArkTS_PasteData_GetTag_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetTag_0100
     * @tc.desc Test getTag for plain text PasteData and verify it matches the set tag value
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetTag_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetTag_0100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Sets the Property`);
          let pasteDataProperty = pasteData1.getProperty();
          console.info(`${caseName} timestamp = ${pasteDataProperty.timestamp}`);
          pasteDataProperty.tag = "Test";
          pasteData1.setProperty(pasteDataProperty);

          console.info(`${caseName} Checks the Property`);
          await systemPasteboard.setData(pasteData1);
          let hasDataAfter = await systemPasteboard.hasData();
          expect(hasDataAfter == true).assertTrue();
          let pasteData2 = await systemPasteboard.getData();
          let pasteDataProperty1 = pasteData2.getProperty();
          expect(pasteDataProperty1.tag == pasteData1.getTag()).assertTrue();
          console.info(`${caseName} timestamp = ${pasteDataProperty1.timestamp}`);
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
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0100
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0100
     * @tc.desc Test hasType for plain text PasteData with special characters and verify TEXT_PLAIN type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0100';
        console.info(`${caseName} start`);
        try {
          let textData = 'Hello 中国!@#$%^&*()_+{}\?.';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0200
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0200
     * @tc.desc Test hasType for plain text PasteData with simple text and verify TEXT_PLAIN type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0200';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0300
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0300
     * @tc.desc Test hasType for plain text PasteData with 300 'A's and verify TEXT_PLAIN type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0300';
        console.info(`${caseName} start`);
        try {
          let textData = '';
          for (let i = 0; i < 300; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0400
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0400
     * @tc.desc Test hasType for HTML text PasteData and verify TEXT_HTML type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0400';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0500
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0500
     * @tc.desc Test hasType for URI text PasteData (valid URL) and verify TEXT_URI type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0500';
        console.info(`${caseName} start`);
        try {
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0600
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0600
     * @tc.desc Test hasType for URI text PasteData (simple string) and verify TEXT_URI type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0600';
        console.info(`${caseName} start`);
        try {
          let uriText = 'Hello//';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0700
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0700
     * @tc.desc Test hasType for WANT PasteData and verify TEXT_WANT type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0700';
        console.info(`${caseName} start`);
        try {
          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(result).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0800
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0800
     * @tc.desc Test hasType for plain text PasteData and verify TEXT_HTML type does not exist
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0800';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          let result = pasteData.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(result).assertEqual(false);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_0900
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_0900
     * @tc.desc Test hasType with number-type mimeType parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_0900';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER);
        try {
          check(pasteData, 0);
        } catch (err) {
          console.info(`${caseName} Check fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_HasType_1000
     * @tc.name ArKUIX_ArkTS_PasteData_HasType_1000
     * @tc.desc Test hasType with invalid parameter handling and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_HasType_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_HasType_1000';
        let pasteData = pasteboard.createData("string", ARRAY_BUFFER)
        console.info(`${caseName} start`);
        try {
          checkFunc(pasteData.hasType, "string");
        } catch (err) {
          console.info(`${caseName} Check fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0100
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0100
     * @tc.desc Test removeRecord for plain text PasteData (special chars) and verify TEXT_PLAIN type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0100';
        console.info(`${caseName} start`);
        try {
          let textData = 'Hello 中国!@#$%^&*()_+{}\?.';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result).assertFalse();
        } catch (err) {
          console.info(`${caseName} Check fail,error code is: ${err.code}`);
          error = err;
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0200
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0200
     * @tc.desc Test removeRecord for plain text PasteData (301 'A's) and verify TEXT_PLAIN type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0200';
        console.info(`${caseName} start`);
        try {
          let textData = ''
          for (let i = 0; i < 301; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0300
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0300
     * @tc.desc Test removeRecord for HTML text PasteData and verify TEXT_HTML type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0300';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(result).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0400
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0400
     * @tc.desc Test removeRecord for URI text PasteData (valid URL) and verify TEXT_URI type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0400';
        console.info(`${caseName} start`);
        try {
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_URI);
          expect(result).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0500
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0500
     * @tc.desc Test removeRecord for WANT PasteData and verify TEXT_WANT type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0500';
        console.info(`${caseName} start`);
        try {
          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(result).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0600
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0600
     * @tc.desc Test removeRecord for multi-type PasteData (plain text/HTML/URI) and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0600';
        console.info(`${caseName} start`);
        try {
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let uriText = 'https://www.baidu.com/';
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          expect(pasteData.getRecordCount() == 3).assertTrue();
          pasteData.removeRecord(2);
          expect(pasteData.getRecordCount() == 2).assertTrue();
          pasteData.removeRecord(1);
          expect(pasteData.getRecordCount() == 1).assertTrue();
          pasteData.removeRecord(0);
          expect(pasteData.getRecordCount() == 0).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0700
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0700
     * @tc.desc Test removeRecord for 15 plain text records and verify all records are removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0700';
        console.info(`${caseName} start`);
        try {
          let textData0 = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let textData = '';
          for (let i = 1; i < 15; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }
          expect(pasteData.getRecordCount() == 15).assertTrue();
          for (let i = 0; i < 15; i++) {
            pasteData.removeRecord(14 - i);
          }
          expect(pasteData.getRecordCount() == 0).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0800
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0800
     * @tc.desc Test removeRecord for simple plain text PasteData and verify TEXT_PLAIN type is removed
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0800';
        console.info(`${caseName} start`);
        try {
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          pasteData.removeRecord(0);
          let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(result == false).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_0900
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_0900
     * @tc.desc Test removeRecord (plain text in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_0900';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1000
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1000
     * @tc.desc Test removeRecord (300 'A's in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1000';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = ''
          for (let i = 0; i < 300; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1100
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1100
     * @tc.desc Test removeRecord (30 plain text in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1100';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData0 = 'Hello World';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = '';
          for (let i = 1; i < 30; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 30).assertTrue();

          console.info(`${caseName} Removes the Record`);
          for (let i = 0; i < 30; i++) {
            pasteData1.removeRecord(29 - i);
          }
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} systemPasteboard.setPasteData promise`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1200
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1200
     * @tc.desc Test removeRecord (HTML in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1300
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1300
     * @tc.desc Test removeRecord (URI in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1400
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1400
     * @tc.desc Test removeRecord (WANT in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let want: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1500
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1500
     * @tc.desc Test removeRecord (multi-type in pasteboard) + re-add, verify count 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);

          let uriText = 'https://www.baidu.com/';
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText)

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 3).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(2);
          expect(pasteData1.getRecordCount() == 2).assertTrue();
          pasteData1.removeRecord(1);
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1600
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1600
     * @tc.desc Test removeRecord (out-of-range index) and verify error code 12900001
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1600';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
        try {
          pasteData.removeRecord(1);
        } catch (err) {
          console.info(`${caseName} Remove specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("12900001");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1700
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1700
     * @tc.desc Test removeRecord (string index) and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1700';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
        try {
          remove(pasteData, "0");
        } catch (err) {
          console.info(`${caseName} Remove specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_RemoveRecord_1800
     * @tc.name ArKUIX_ArkTS_PasteData_RemoveRecord_1800
     * @tc.desc Test removeRecord (invalid params) and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_RemoveRecord_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_RemoveRecord_1800';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
        console.info(`${caseName} start`);
        try {
          removeFunc(pasteData.removeRecord, 1);
        } catch (err) {
          console.info(`${caseName} Remove specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0100
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0100
     * @tc.desc Test replaceRecord to replace plain text record with URI record and verify TEXT_URI type exists
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0100';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
        let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, "uriData");
        pasteData.replaceRecord(0, pasteDataRecord);
        let result: boolean = pasteData.hasType(pasteboard.MIMETYPE_TEXT_URI);
        expect(result).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0200
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0200
     * @tc.desc Test replaceRecord to replace plain text record with another plain text record in pasteboard
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0200';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let textData1 = 'Hello World1';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Checks the number of records`);
          let pasteData2 = await systemPasteboard.getData();
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0300
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0300
     * @tc.desc Test replaceRecord to replace plain text record and verify primaryText matches new content
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0300';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let textData1 = 'Hello World1';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Checks the pasteboard content`);
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText).assertEqual(textData1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0400
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0400
     * @tc.desc Test replaceRecord to replace HTML record with another HTML record in pasteboard and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0400';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let htmlText1 = '<html><head></head><body>Hello World 1</body></html>';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0500
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0500
     * @tc.desc Test replaceRecord to replace URI record with another URI record in pasteboard and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0500';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let uriText1 = 'https://www.baidu.com/1';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, uriText1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0600
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0600
     * @tc.desc Test replaceRecord to replace WANT record with another WANT record in pasteboard and verify count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0600';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let wantText0: Want = {
            bundleName: "com.example.myapplication3",
            abilityName: "com.example.myapplication3.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, wantText0);

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let wantText1: Want = {
            bundleName: "com.example.myapplication30",
            abilityName: "com.example.myapplication30.MainAbility"
          };
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_WANT, wantText1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0700
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0700
     * @tc.desc Test replaceRecord to replace 300 'A's plain text with new plain text and verify primaryText matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0700';
        console.info(`${caseName} start`);
        try {
          let systemPasteboard = pasteboard.getSystemPasteboard();
          await systemPasteboard.clearData();
          let textData = ''
          for (let i = 0; i < 300; i++) {
            textData = textData + "A";
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let textData1 = 'Hello World1';
          let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          pasteData1.replaceRecord(0, pasteDataRecord);
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let primaryText = pasteData1.getPrimaryText();
          expect(primaryText).assertEqual(textData1);
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
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0800
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0800
     * @tc.desc Test replaceRecord with out-of-range index 1 and verify error code 12900001
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0800';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
        let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, "uriData");
        console.info(`${caseName} start`);
        try {
          pasteData.replaceRecord(1, pasteDataRecord);
        } catch (err) {
          console.info(`${caseName} Replace specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("12900001");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_0900
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_0900
     * @tc.desc Test replaceRecord with string-type index parameter "0" and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_0900';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
        let pasteDataRecord = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, "uriData");
        console.info(`${caseName} start`);
        try {
          replace(pasteData, "0", pasteDataRecord);
        } catch (err) {
          console.info(`${caseName} Replace specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_1000
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_1000
     * @tc.desc Test replaceRecord with string-type record parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_1000';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
        console.info(`${caseName} start`);
        try {
          replace(pasteData, 0, "pasteDataRecord");
        } catch (err) {
          console.info(`${caseName} Replace specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_ReplaceRecord_1100
     * @tc.name ArKUIX_ArkTS_PasteData_ReplaceRecord_1100
     * @tc.desc Test replaceRecord with invalid parameter handling and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_ReplaceRecord_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_ReplaceRecord_1100';
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "valueType");
        console.info(`${caseName} start`);
        try {
          replaceFunc(pasteData.replaceRecord, 0, "record");
        } catch (err) {
          console.info(`${caseName} Replace specified record fail,error code is: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_PasteData_GetPrimaryPixelMap_0100
     * @tc.name ArKUIX_ArkTS_PasteData_GetPrimaryPixelMap_0100
     * @tc.desc Test getPrimaryPixelMap for PixelMap-type PasteData and verify PixelMap is non-null with 60 pixel bytes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_PasteData_GetPrimaryPixelMap_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_PasteData_GetPrimaryPixelMap_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        try {
          let pixelMap = await image.createPixelMap(color, opt);
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_PIXELMAP, pixelMap);
          let pixelMapRecord = pasteData.getPrimaryPixelMap();
          expect(pixelMapRecord != null).assertTrue();
          expect(pixelMapRecord.getPixelBytesNumber()).assertEqual(60);
        } catch (err) {
          console.info(`${caseName} getPasteData error,error: ${err}`);
          expect().assertFail();
          done();
          return;
        }
        console.info(`${caseName} end`);
        done();
      })
  })
}