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
import { describe, beforeAll, it, expect, TestType, Size, Level } from "@ohos/hypium";
import ohosWindow from '@ohos.window';
import display from '@ohos.display';
import { BusinessError } from '@ohos.base';
import { Context } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';
import settings from '@ohos.settings';
import image from '@ohos.multimedia.image';
import window from "@ohos.window";

function expectedError(TRUE_FLAG: boolean, error: BusinessError, caseName: string, apiName: string, done: Function,
  code: number) {
  let msgStr: string = 'jsUnittest ' + caseName + ' ' + apiName + ' failed, err: ';
  console.log(msgStr + JSON.stringify(error));
  try {
    expect(TRUE_FLAG).assertTrue();
    expect(error.code === code).assertTrue();
  } catch (error) {
    console.info(`ohosWindow.on ${JSON.stringify(error)}`)
  }
  done();
}

function unexpectedError(TRUE_FLAG: boolean, error: BusinessError, caseName: string, apiName: string, done: Function,) {
  let msgStr: string = 'jsUnittest ' + caseName + ' ' + apiName + ' failed, err: ';
  console.log(msgStr + JSON.stringify(error));
  try {
    expect(TRUE_FLAG).assertFail();
  } catch (error) {
    console.info(`ohosWindow.on ${JSON.stringify(error)}`)
  }
  done();
}

async function sleep(time: number) {
  let timeoutId: number = 0;
  let promise = new Promise<string>(resolve => {
    timeoutId = setTimeout(() => {
      resolve('sleep finished');
    }, time);
  })
  await promise;
  clearTimeout(timeoutId)
}

export default function windowCallbackTest() {
  describe('windowCallback_test', () => {
    let windowStage: window.WindowStage;
    let abilityStorage: LocalStorage
    beforeAll(async () => {
      windowStage = AppStorage.get('windowStage') as window.WindowStage;
      abilityStorage = AppStorage.get('localStorage') as LocalStorage;
    })

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_LoadContentByName_Callback_WithStorage_0100
     * @tc.name   : testGraphicWindowStageLoadContentByNameCallbackWithStorage0100
     * @tc.desc   : Test the function of loadContentByName withstorage callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowStageLoadContentByNameCallbackWithStorage0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        let msg = "testGraphicWindowStageLoadContentByNameCallbackWithStorage0100";
        try {
          windowStage.loadContentByName("Index1", abilityStorage, (err: BusinessError) => {
            let errCode = err.code;
            if (errCode) {
              console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
              expect().assertFail();
              done();
            } else {
              console.info(msg + 'Succeeded in loading the content.');
              expect(true).assertTrue();
              done();
            }
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_LoadContentByName_Callback_WithoutStorage_0200
     * @tc.name   : testGraphicWindowStageLoadContentByNameCallbackWithoutStorage0200
     * @tc.desc   : Test the function of loadContentByName withoutstorage callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowStageLoadContentByNameCallbackWithoutStorage0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        let msg = "testGraphicWindowStageLoadContentByNameCallbackWithoutStorage0200"
        try {
          windowStage.loadContentByName("Index1", (err: BusinessError) => {
            let errCode = err.code;
            if (errCode) {
              console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
              expect().assertFail();
              done();
            } else {
              console.info(msg + 'Succeeded in loading the content.');
              expect(true).assertTrue();
              done();
            }
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_LoadContentByName_Promise_0300
     * @tc.name   : testGraphicWindowStageLoadContentByNamePromise0300
     * @tc.desc   : Test the function of loadContentByName Promise
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowStageLoadContentByNamePromise0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let msg = "testGraphicWindowStageLoadContentByNamePromise0300";
        try {
          let promise = windowStage.loadContentByName("Index1", abilityStorage);
          promise.then(() => {
            console.info(msg + 'Succeeded in loading the content.');
            expect(true).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
            expect().assertFail();
            done();
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_Window_LoadContentByName_Callback_WithStorage_0400
     * @tc.name   : testGraphicWindowLoadContentByNameCallbackWithStorage0400
     * @tc.desc   : Test the function of windowClass windowClassLoadContentByName withstorage callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowLoadContentByNameCallbackWithStorage0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      () => {
        let msg = "testGraphicWindowLoadContentByNameCallbackWithStorage0400";
        let windowClass: ohosWindow.Window = windowStage.getMainWindowSync();
        let storage: LocalStorage = new LocalStorage();
        storage.setOrCreate('storageSimpleProp', 121);
        console.log(msg + ' begin');
        try {
          windowClass.loadContentByName("Index1", storage, (err: BusinessError) => {
            let errCode: number = err.code;
            if (errCode) {
              console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
              expect().assertFail();
            } else {
              console.info(msg + 'Succeeded in loading the content.');
              expect(true).assertTrue();
            }
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_Window_LoadContentByName_Callback_WithoutStorage_0500
     * @tc.name   : testGraphicWindowLoadContentByNameCallbackWithoutStorage0500
     * @tc.desc   : Test the function of windowClassLoadContentByName withoutstorage callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowLoadContentByNameCallbackWithoutStorage0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
        let msg = "testGraphicWindowLoadContentByNameCallbackWithoutStorage0500";
        let windowClass: ohosWindow.Window = windowStage.getMainWindowSync();
        console.log(msg + ' begin');
        try {
          windowClass.loadContentByName("Index1", (err: BusinessError) => {
            let errCode = err.code;
            if (errCode) {
              console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
              expect().assertFail();
            } else {
              console.info(msg + 'Succeeded in loading the content.');
              expect(true).assertTrue();
            }
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_Window_LoadContentByName_Promise_0600
     * @tc.name   : testGraphicWindowLoadContentByNamePromise0600
     * @tc.desc   : Test the function of windowClassLoadContentByName Promise
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowLoadContentByNamePromise0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      () => {
        let msg = "testGraphicWindowLoadContentByNamePromise0600";
        let windowClass: ohosWindow.Window = windowStage.getMainWindowSync();
        let storage: LocalStorage = new LocalStorage();
        console.log(msg + ' begin');
        try {
          let promise = windowClass.loadContentByName("Index1", storage);
          promise.then(() => {
            console.info(msg + 'Succeeded in loading the content.');
            expect(true).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(err));
            expect().assertFail();
          });
        } catch (exception) {
          console.error(msg + 'Failed to load the content. Cause:' + JSON.stringify(exception));
          expect().assertFail();
        }
      });
  })
}
