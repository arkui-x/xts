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
import { abilityAccessCtrl, PermissionRequestResult } from '@kit.AbilityKit';
import { Driver, ON } from '@kit.TestKit';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from "@kit.BasicServicesKit";
import image from '@ohos.multimedia.image';

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_500: number = 500
const WAIT_READY_MS_100: number = 100

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");
const delegator: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let isChange: boolean = false;

let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
const ARRAY_BUFFER = new ArrayBuffer(256);
let error: BusinessError | undefined = undefined;

function setDataWithCallback(systemPasteBoard: pasteboard.SystemPasteboard,
  pasteData: pasteboard.PasteData): Promise<boolean> {
  return new Promise<boolean>((resolve, reject) => {
    systemPasteBoard.setData(pasteData, (err: BusinessError) => {
      if (err != null) {
        reject(err);
      } else {
        resolve(true);
      }
    });
  });
}

function clearData(systemPasteBoard: pasteboard.SystemPasteboard, callback: ESObject) {
  systemPasteBoard.clearData(callback);
}

function getData(systemPasteBoard: pasteboard.SystemPasteboard, callback: ESObject) {
  systemPasteBoard.getData(callback);
}

function hasData(systemPasteBoard: pasteboard.SystemPasteboard, callback: ESObject) {
  systemPasteBoard.hasData(callback);
}

async function setData(systemPasteBoard: pasteboard.SystemPasteboard, pasteData: ESObject, callBack: ESObject) {
  await systemPasteBoard.setData(pasteData, callBack);
}

function setDataSync(systemPasteBoard: pasteboard.SystemPasteboard, pasteData: ESObject, callBack: ESObject) {
  systemPasteBoard.setData(pasteData, callBack);
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

/**
 *  The callback function is used for pasteboard content changes
 */
function contentChanges() {
  isChange = true;
  console.info('#EVENT: The content is changed in the pasteboard');
}

export default function systemPasteboardTest() {
  describe('systemPasteboardTest', () => {
    console.info('beforeAll PasteBoardTest start');
    beforeAll(async (done: Function) => {
      console.info('start################################start');
      await getPermission();
      await sleep(WAIT_READY_MS_1000);
      await drivenFn();
      await sleep(WAIT_READY_MS_1000);
      systemPasteboard.clearDataSync();
      done();
    })
    beforeEach(async () => {
      await systemPasteboard.clearData();
      await sleep(WAIT_READY_MS_100);
      isChange = false;
    })
    afterEach(async () => {
      systemPasteboard.off('update');
      await sleep(WAIT_READY_MS_100);
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0100
     * @tc.desc Test getMimeTypes (multi-type PasteData) and verify 3 MIME types
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0100';
        console.info(`${caseName} start`);
        let want: Want = {
          bundleName: "com.example.myapplication45",
          abilityName: "com.example.myapplication45.MainAbility"
        }
        let record: Record<string, pasteboard.ValueType> = {};
        record[pasteboard.MIMETYPE_TEXT_PLAIN] = 'hello';
        record[pasteboard.MIMETYPE_TEXT_URI] = 'https://www.baidu.com/';
        record[pasteboard.MIMETYPE_TEXT_WANT] = want;
        let pasteData: pasteboard.PasteData = pasteboard.createData(record);
        try {
          await systemPasteboard.setData(pasteData);
          expect(systemPasteboard.hasDataSync()).assertTrue();
          console.info(`${caseName} Succeeded in setting PasteData`);
          let data = await systemPasteboard.getMimeTypes();
          expect(data.length).assertEqual(3);
          expect(data).assertContain('text/want');
          expect(data).assertContain('text/uri');
          expect(data).assertContain('text/plain');
          console.info(`${caseName} Succeeded in getting mimeTypes. mimeTypes: ` + JSON.stringify(data));
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0200
     * @tc.desc Test getMimeTypes for empty SystemPasteboard (cleared data) and verify returns empty array
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetMimeTypes_0200';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        systemPasteboard.clearDataSync();
        try {
          let data = await systemPasteboard.getMimeTypes();
          expect(data.length).assertEqual(0);
          expect(data).assertDeepEquals([]);
          console.info(`${caseName} Succeeded in getting mimeTypes. mimeTypes: ` + JSON.stringify(data));
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetData_0100
     * @tc.desc Test setData to set ArrayBuffer-type PasteData to SystemPasteboard and verify hasData returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetData_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        let pasteData = pasteboard.createData('string', ARRAY_BUFFER);
        try {
          await systemPasteBoard.setData(pasteData);
          let data = await systemPasteBoard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetData_0200
     * @tc.desc Test hasData for empty SystemPasteboard (after clearData) and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetData_0200';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.clearData();
          let data = await systemPasteBoard.hasData();
          expect(data == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_On_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_On_0100
     * @tc.desc Test on('update') event (URI record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_On_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_On_0100';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          expect(isChange).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_On_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_On_0200
     * @tc.desc Test on('update') event (WANT record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_On_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_On_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          let want: Want = {
            bundleName: "com.example.myapplication45",
            abilityName: "com.example.myapplication45.MainAbility"
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          expect(isChange).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_On_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_On_0300
     * @tc.desc Test on('update') event (plain text record) and verify clearDataSync results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_On_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_On_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          await systemPasteboard.clearData();
          let pasteData2 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData2));
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(0);
          expect(isChange).assertTrue();
          console.info(`${caseName} end`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_On_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_On_0400
     * @tc.desc Test on('update') event (plain text record) and verify adding record results in 2 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_On_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_On_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);

          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let textData1 = 'Hello World1';
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          expect(pasteData1.getRecordCount() == 2).assertTrue();

          await systemPasteboard.setData(pasteData1);
          expect(pasteData1.getRecordCount() == 2).assertTrue();
          expect(isChange).assertTrue();
          systemPasteboard.off('update', contentChanges);
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_On_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_On_0500
     * @tc.desc Test on('update') event (HTML record) and verify adding plain text record results in 2 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_On_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_On_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);

          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          await systemPasteboard.setData(pasteData);

          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          let textData1 = 'Hello World1';
          pasteData1.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData1);
          expect(pasteData1.getRecordCount() == 2).assertTrue();

          await systemPasteboard.setData(pasteData1);
          expect(pasteData1.getRecordCount() == 2).assertTrue();
          expect(isChange).assertTrue();
          systemPasteboard.off('update', contentChanges);
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_Off_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_Off_0100
     * @tc.desc Test off('update') event (plain text record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_Off_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_Off_0100';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          systemPasteboard.off('update', contentChanges);

          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`)
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          expect(isChange).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_Off_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_Off_0200
     * @tc.desc Test off('update') event (HTML record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_Off_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_Off_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          systemPasteboard.off('update', contentChanges);

          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`)
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          expect(isChange).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_Off_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_Off_0300
     * @tc.desc Test off('update') event (URI record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_Off_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_Off_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          systemPasteboard.off('update', contentChanges);

          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`)
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Removes the Record`);
          pasteData1.removeRecord(0);
          expect(pasteData1.getRecordCount() == 0).assertTrue();
          expect(isChange).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_Off_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_Off_0400
     * @tc.desc Test off('update') event (WANT record) and verify record removal results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_Off_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_Off_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          systemPasteboard.off('update', contentChanges);

          let want: Want = {
            bundleName: "com.example.myapplication45",
            abilityName: "com.example.myapplication45.MainAbility"
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
          expect(isChange).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_Off_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_Off_0500
     * @tc.desc Test off('update') event (plain text record) and verify clearDataSync results in 0 records
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_Off_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_Off_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          systemPasteboard.off('update');
          systemPasteboard.on('update', contentChanges);
          systemPasteboard.off('update', contentChanges);

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
          let pasteData2 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData2));
          let recordCount = pasteData2.getRecordCount();
          expect(recordCount).assertEqual(0);
          expect(isChange).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0100
     * @tc.desc Test hasDataType for plain text MIME type after setting plain text data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0100';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard()
        try {
          await systemPasteboard.clearData();
          let dataText = 'hello';
          let PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, dataText);
          await systemPasteboard.setData(PasteData);
          let boolean: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(boolean).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0200
     * @tc.desc Test hasDataType for URI MIME type after setting plain text data and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard()
        try {
          await systemPasteboard.clearData();
          let dataText = 'hello';
          let PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, dataText);
          await systemPasteboard.setData(PasteData);
          let boolean: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          expect(boolean).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0300
     * @tc.desc Test hasDataType for HTML MIME type after setting HTML data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard()
        try {
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          await systemPasteboard.setData(PasteData);
          let boolean: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(boolean).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0400
     * @tc.desc Test hasDataType for URI MIME type after setting URI data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard()
        try {
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          await systemPasteboard.setData(PasteData);
          let boolean: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          expect(boolean).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0500
     * @tc.desc Test hasDataType for WANT MIME type after setting WANT data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard()
        try {
          await systemPasteboard.clearData();
          let want: Want = {
            bundleName: "com.example.myapplication3",
            abilityName: "com.example.myapplication3.MainAbility"
          };
          let PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          await systemPasteboard.setData(PasteData);
          let boolean: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(boolean).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0600
     * @tc.desc Test hasDataType for plain text MIME type with empty pasteboard and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0600';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        systemPasteboard.clearDataSync();
        try {
          let result: boolean = systemPasteboard.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          console.info(`${caseName} Succeeded in checking the RemoteData. Result: ${result}`);
          expect(result).assertEqual(false);
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataType_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataType_0700
     * @tc.desc Test hasDataType with undefined MIME type parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataType_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataType_0700';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        try {
          let result: boolean = systemPasteboard.hasDataType(undefined);
          expect().assertFail();
          done();
          return;
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0100
     * @tc.desc Test clearData with callback for ArrayBuffer-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        systemPasteBoard.clearDataSync();
        let pasteData = pasteboard.createData('string', ARRAY_BUFFER);
        await systemPasteBoard.setData(pasteData);
        systemPasteBoard.clearDataSync();
        console.info(`${caseName} Clear the data in the system pasteBoard finished`)
        let hasData = await systemPasteBoard.hasData();
        console.info(`${caseName} Succeeded in checking the PasteData. Data: ${hasData}`);
        expect(hasData).assertEqual(false);
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0200
     * @tc.desc Test clearData with callback for URI-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0200';
        console.info(`${caseName} start`);
        try {
          let uriText = 'https://www.baidu.com/';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          systemPb.clearDataSync();
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          expect(bool_set == true && bool_clear == false).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0300
     * @tc.desc Test clearData with callback for plain text-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0300';
        console.info(`${caseName} start`);
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          systemPb.clearDataSync();
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(bool_set == true && bool_clear == false).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0400
     * @tc.desc Test clearData with callback for HTML-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0400';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_HTML);
          systemPb.clearDataSync();
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(bool_set == true && bool_clear == false).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0500
     * @tc.desc Test clearData with callback for WANT-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0500';
        console.info(`${caseName} start`);
        try {
          let want: Want = {
            bundleName: "com.example.myapplication45",
            abilityName: "com.example.myapplication45.MainAbility"
          }
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_WANT);
          systemPb.clearDataSync();
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(bool_set == true && bool_clear == false).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0600
     * @tc.desc Test clearData with callback for mixed URI+plain text data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0600';
        console.info(`${caseName} start`);
        try {
          let uriText = 'https://www.baidu.com/';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          let bool_set1: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          systemPb.clearDataSync();
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          let bool_clear1: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(bool_set && bool_set1 && bool_clear == false && bool_clear1 == false).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
          return;
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0700
     * @tc.desc Test clearData with invalid "callback" parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0700';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          clearData(systemPasteBoard, "callback");
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0800
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0800
     * @tc.desc Test clearData with null callback parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_CallBack_0800';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        try {
          systemPasteboard.clearData(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_0100
     * @tc.desc Test clearData promise for custom-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let pasteData: pasteboard.PasteData = pasteboard.createData('string', ARRAY_BUFFER);
        let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        await systemPb.setData(pasteData);
        try {
          await systemPb.clearData();
          console.info("Clear the data in the system pasteBoard finished");
          let bHasType: boolean = systemPb.hasDataType('string');
          expect(bHasType).assertFalse();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_0200
     * @tc.desc Test clearData promise for Want-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_0200';
        console.info(`${caseName} start`);
        try {
          let want: Want = {
            bundleName: "com.example.myapplication45",
            abilityName: "com.example.myapplication45.MainAbility"
          }
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, want);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_WANT);
          await systemPb.clearData();
          console.info(`${caseName} Clear the data in the system pasteBoard finished`);
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_WANT);
          expect(bool_set == true && bool_clear == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_0300
     * @tc.desc Test clearData promise for plain text-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_0300';
        console.info(`${caseName} start`);
        try {
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "hello");
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          await systemPb.clearData();
          console.info(`${caseName} Clear the data in the system pasteBoard finished`);
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_PLAIN);
          expect(bool_set == true && bool_clear == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_0400
     * @tc.desc Test clearData promise for HTML-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_0400';
        console.info(`${caseName} start`);
        try {
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_HTML);
          await systemPb.clearData();
          console.info(`${caseName} Clear the data in the system pasteBoard finished`);
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_HTML);
          expect(bool_set == true && bool_clear == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearData_0500
     * @tc.desc Test clearData promise for URI-type data
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearData_0500';
        console.info(`${caseName} start`);
        try {
          let uriText = 'https://www.baidu.com/';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          let systemPb: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
          await systemPb.setData(pasteData);
          let bool_set: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          await systemPb.clearData();
          console.info(`${caseName} Clear the data in the system pasteBoard finished`);
          let bool_clear: boolean = systemPb.hasDataType(pasteboard.MIMETYPE_TEXT_URI);
          expect(bool_set == true && bool_clear == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0100
     * @tc.desc Test clearDataSync for plain text-type data and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0100';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData1));
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
          let pasteData2 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData2));
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0200
     * @tc.desc Test clearDataSync for URI-type data and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0300
     * @tc.desc Test clearDataSync for HTML-type data and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0400
     * @tc.desc Test clearDataSync for WANT-type data and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let myWant: Want = {
            bundleName: "com.example.myapplication55",
            abilityName: "com.example.myapplication55.MainAbility"
          }
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, myWant);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0500
     * @tc.desc Test clearDataSync for 30 plain text records and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
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

          console.info(`${caseName} Clears the pasteBoard`)
          systemPasteboard.clearDataSync();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0600
     * @tc.desc Test clearDataSync for 15 mixed (plain text/HTML/URI) records and verify record count changes
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_ClearDataSync_0600';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData0 = 'Hello World0';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = '';
          for (let i = 1; i < 5; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          let htmlText = '';
          for (let i = 0; i < 5; i++) {
            htmlText = '<html><head></head><body>Hello World!</body></html>';
            htmlText = htmlText + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          }

          let uriText = '';
          for (let i = 0; i < 5; i++) {
            uriText = 'https://www.baidu.com/';
            uriText = uriText + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText);
          }

          await systemPasteboard.setData(pasteData);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 15).assertTrue();
          systemPasteboard.clearDataSync()
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0100
     * @tc.desc Test getData with callback for ArrayBuffer-type data and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let pasteData = pasteboard.createData('string', ARRAY_BUFFER);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.setData(pasteData);
          systemPasteBoard.getData((err, data) => {
            if (err != null) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
              done();
              return;
            }
            let recordCount = data.getRecordCount();
            expect(recordCount).assertEqual(1);
            console.info(`${caseName} end`);
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0200
     * @tc.desc Test getData with null callback parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0200';
        console.info(`${caseName} start`);
        let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
        try {
          systemPasteboard.getData(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual('401');
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0300
     * @tc.desc Test getData with string-type "callback" parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_CallBack_0300';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          getData(systemPasteBoard, "callback");
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_0100
     * @tc.desc Test getData (Promise) for plain text-type data and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_0100';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasData = await systemPasteboard.hasData();
          expect(hasData).assertTrue();

          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData1));
          expect(pasteData1.getRecordCount() == 1).assertTrue();

          console.info(`${caseName} Clears the pasteBoard`);
          systemPasteboard.clearDataSync();
          let pasteData2 = await systemPasteboard.getData();
          console.info(`${caseName} systemPasteboard.getPasteData data = ` + JSON.stringify(pasteData2));
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_0200
     * @tc.desc Test getData (Promise) for plain text with special chars and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
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
          let pasteDataRecord = pasteData1.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);
          console.info(`${caseName} pasteDataRecord.toPlainText = ` + pasteDataRecord.toPlainText());
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_0300
     * @tc.desc Test getData (Promise) for 301-length plain text and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData = ''
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
          let pasteDataRecord = pasteData1.getRecord(0);
          expect(pasteDataRecord.mimeType).assertEqual(pasteboard.MIMETYPE_TEXT_PLAIN);
          console.info(`${caseName} pasteDataRecord.toPlainText = ` + pasteDataRecord.toPlainText());
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_0400
     * @tc.desc Test getData (Promise) for URI-type data and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
          console.info(`${caseName} Checks the number of records`);
          let pasteData1 = await systemPasteboard.getData();
          expect(pasteData1.getRecordCount() == 1).assertTrue();
          let pasteDataRecord = pasteData1.getRecord(0);
          console.info(`${caseName} pasteDataRecord.toPlainText = ` + pasteDataRecord.toPlainText());
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetData_0500
     * @tc.desc Test getData (Promise) for mixed plain text+URI records and verify record count
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetData_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData0 = 'Hello World0';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);
          let uriText = pasteboard.createRecord(pasteboard.MIMETYPE_TEXT_URI, "https://www.baidu.com/");
          pasteData.addRecord(uriText);
          await systemPasteboard.setData(pasteData);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
          let pasteData1 = await systemPasteboard.getData();
          let recordCount = pasteData1.getRecordCount();
          expect(recordCount == 2).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_GetDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_GetDataSync_0100
     * @tc.desc Test getDataSync for plain text-type data and verify primary text matches
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_GetDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_GetDataSync_0100';
        console.info(`${caseName} start`);
        let text = "pasteboard";
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, text);
        let systemPasteBoard = pasteboard.getSystemPasteboard();

        await systemPasteBoard.setData(pasteData);
        console.info(`${caseName} Succeeded in setting PasteData`);

        let resultFlg = systemPasteBoard.hasDataSync();
        expect(resultFlg).assertTrue();

        let pasteDataSync = systemPasteBoard.getDataSync();
        let resultText = pasteDataSync.getPrimaryText();
        expect(resultText).assertEqual(text);
        console.info(`${caseName} Get the pasteboard from system PasteBoard success. Result: ${resultText}`);
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0100
     * @tc.desc Test hasData with callback for empty pasteboard and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0100';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.clearData();
          systemPasteBoard.hasData((err, data: boolean) => {
            if (err != undefined) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
              done();
              return;
            }
            expect(data == false).assertTrue();
            console.info(`${caseName} end`);
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0200
     * @tc.desc Test hasData with callback for ArrayBuffer-type data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0200';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let pasteData = pasteboard.createData('string', ARRAY_BUFFER);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.setData(pasteData);
          systemPasteBoard.hasData((err, data: boolean) => {
            if (err != undefined) {
              console.error(`${caseName} failed, error: ${err.message}`);
              expect().assertFail();
              done();
              return;
            }
            expect(data).assertTrue();
            console.info(`${caseName} end`);
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0300
     * @tc.desc Test hasData with string-type "callback" parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_CallBack_0300';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          hasData(systemPasteBoard, "callback");
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0100
     * @tc.desc Test hasData (Promise) for empty pasteboard and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0100';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteBoard.clearData();
          let data = await systemPasteBoard.hasData();
          expect(data == false).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0200
     * @tc.desc Test hasData (Promise) for plain text-type data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0200';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0300
     * @tc.desc Test hasData (Promise) for URI-type data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0300';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let uriText = 'https://www.baidu.com/';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0400
     * @tc.desc Test hasData (Promise) for HTML-type data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0400';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0500
     * @tc.desc Test hasData (Promise) for WANT-type data and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0500';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let myWant: Want = {
            bundleName: "com.example.myapplication8",
            abilityName: "com.example.myapplication8.MainAbility"
          };
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_WANT, myWant);
          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0600
     * @tc.desc Test hasData (Promise) for 15 mixed (plain text/HTML/URI) records and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0600';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData0 = 'Hello World0';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData0);

          let textData = '';
          for (let i = 1; i < 5; i++) {
            textData = 'Hello World';
            textData = textData + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          }

          let htmlText = '';
          for (let i = 0; i < 5; i++) {
            htmlText = '<html><head></head><body>Hello World!</body></html>';
            htmlText = htmlText + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          }

          let uriText = '';
          for (let i = 0; i < 5; i++) {
            uriText = 'https://www.baidu.com/';
            uriText = uriText + i;
            pasteData.addRecord(pasteboard.MIMETYPE_TEXT_URI, uriText)
          }

          console.info(`${caseName} Writes PasteData to the pasteboard`);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Checks there is content in the pasteboard`);
          let data = await systemPasteboard.hasData();
          expect(data).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasData_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasData_0700
     * @tc.desc Test hasData (Promise) after replacing plain text record and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasData_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasData_0700';
        console.info(`${caseName} start`);
        let systemPasteboard = pasteboard.getSystemPasteboard();
        try {
          await systemPasteboard.clearData();
          let textData = 'Hello World!';
          let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textData);
          console.info(`${caseName} PasteData to the pasteboard`);
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

          console.info(`${caseName} Checks there is content in the pasteboard`);
          let hasDataAfterReplace = await systemPasteboard.hasData();
          expect(hasDataAfterReplace).assertTrue();
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0100
     * @tc.desc Test hasDataSync for plain text-type data (set via setDataSync) and verify returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0100';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        systemPasteBoard.clearDataSync();
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "pasteboard");

        systemPasteBoard.setDataSync(pasteData);
        console.info(`${caseName} Succeeded in setting PasteData`);
        let result = systemPasteBoard.hasDataSync();
        expect(result).assertTrue();

        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0200
     * @tc.desc Test hasDataSync for empty pasteboard (cleared via clearDataSync) and verify returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_HasDataSync_0200';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        systemPasteBoard.clearDataSync();
        let result = systemPasteBoard.hasDataSync();
        expect(result).assertEqual(false);
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0100
     * @tc.desc Test setData with callback for ArrayBuffer-type PasteData and verify hasData returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0100';
        console.info(`${caseName} start`);
        if (platform.includes("Android")) {
          expect(true).assertTrue();
          console.info(`${caseName} end`);
          done();
          return;
        }
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        let pasteData = pasteboard.createData('string', ARRAY_BUFFER);
        try {
          const result = await setDataWithCallback(systemPasteBoard, pasteData);
          expect(result).assertTrue();
          const hasData = await systemPasteBoard.hasData();
          expect(hasData).assertTrue();
          console.info(`${caseName} end`);
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0200
     * @tc.desc Test setData with callback for plain text-type PasteData and verify hasData returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0200';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "pasteboard");
        try {
          const result = await setDataWithCallback(systemPasteBoard, pasteData);
          expect(result).assertTrue();
          let hasData = await systemPasteBoard.hasData();
          expect(hasData).assertTrue();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0300
     * @tc.desc Test setData with string-type pasteData parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetData_CallBack_0300';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          await setData(systemPasteBoard, "pasteData", async (err: BusinessError, data: ESObject) => {
            if (err != null) {
              console.info(`${caseName} System pasteBoard set pastedata error, error: ${err.message}`);
              expect(err.code).assertEqual("401");
            } else {
              expect().assertFail();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect(err.code).assertEqual("401");
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0100
     * @tc.desc Test setDataSync for plain text-type PasteData and verify hasDataSync returns true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0100';
        console.info(`${caseName} start`);
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "pasteboard");
        let systemPasteBoard = pasteboard.getSystemPasteboard();

        systemPasteBoard.setDataSync(pasteData);
        console.info(`${caseName} Succeeded in setting PasteData`);
        let result = systemPasteBoard.hasDataSync();
        expect(result).assertTrue();
        console.info(`${caseName} Succeed in checking the PasteBoard. Result: ${result}`);
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0200
     * @tc.desc Test setDataSync with null pasteData parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0200';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          systemPasteBoard.setDataSync(null);
          expect().assertFail();
        } catch (err) {
          console.info(`${caseName} Put pastedata to system pasteBoard fail, error code: ${err.code}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0300
     * @tc.desc Test setDataSync with undefined pasteData parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0300';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();
        try {
          systemPasteBoard.setDataSync(undefined);
          expect().assertFail();
        } catch (err) {
          console.info(`${caseName} Put pastedata to system pasteBoard fail, error code: ${err.code}`);
          expect(err.code == 401).assertTrue();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0400
     * @tc.desc Test setDataSync with string-type pasteData parameter and verify error code 401
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_SetDataSync_0400';
        console.info(`${caseName} start`);
        let systemPasteBoard = pasteboard.getSystemPasteboard();

        try {
          setDataSync(systemPasteBoard, "pasteData", "callback");
        } catch (err) {
          console.info(`${caseName} Put pastedata to system pasteBoard fail, error code: ${err.code}`);
          error = err;
          expect(err.code).assertEqual("401");
        }
        expect(error != undefined).assertTrue();
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0100
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0100
     * @tc.desc Test getChangeCount after setting plain text data and verify count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0100';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, 'content1');
          await systemPasteboard.setData(pasteData);
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
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0200
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0200
     * @tc.desc Test getChangeCount after setting HTML data and verify count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0200';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);
          let htmlText = '<html><head></head><body>Hello World!</body></html>';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, htmlText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Succeeded in setting pasteData`);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0300
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0300
     * @tc.desc Test getChangeCount after setting URI data and verify count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0300';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);
          let uriText = 'https://www.baidu.com/';
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uriText);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Succeeded in setting pasteData`);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0400
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0400
     * @tc.desc Test getChangeCount after setting PixelMap data and verify count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0400';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

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
          let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_PIXELMAP, pixelMap)
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Succeeded in setting pasteData`);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0500
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0500
     * @tc.desc Test getChangeCount after setting ArrayBuffer data and verify count increases by 1
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0500';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result0:${result1}`);

          let dataXml = new ArrayBuffer(256);
          let pasteData: pasteboard.PasteData = pasteboard.createData('styleStr', dataXml);
          await systemPasteboard.setData(pasteData);
          console.info(`${caseName} Succeeded in setting pasteData`);

          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0600
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0600
     * @tc.desc Test getChangeCount after setting plain text twice and verify count increases by 1 each time
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0600';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let pasteData1: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, 'content1');
          await systemPasteboard.setData(pasteData1);
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result1}`);

          let pasteData2: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, 'content1');
          await systemPasteboard.setData(pasteData2);
          console.info(`${caseName} Succeeded in setting pasteData`);
          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);

          expect(result2).assertEqual(result1 + 1);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0700
     * @tc.name ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0700
     * @tc.desc Test getChangeCount after calling getDataSync and verify count remains unchanged
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_SystemPasteboard_getChangeCount_0700';
        console.info(`${caseName} start`);
        if (isAndroid) {
          expect(true).assertTrue();
          done();
          return;
        }
        try {
          let pasteData1: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, 'content1');
          await systemPasteboard.setData(pasteData1);
          console.info(`${caseName} Succeeded in setting pasteData`);
          let result1: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result1}`);
          systemPasteboard.getDataSync();
          let result2: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result2}`);
          expect(result2).assertEqual(result1);
          let result3: number = systemPasteboard.getChangeCount();
          console.info(`${caseName} Succeeded in getting the change count.Result1:${result3}`);
          expect(result3).assertEqual(result2);
          console.info(`${caseName} Pasteboard change success`);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);
        done();
      })
  })
}
