/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import picker from '@ohos.file.picker';
import testNapi from 'libentry.so'

import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)


async function sleep(times: number) {
  if (!times) {
    times = 10;
  }
  await new Promise<number>((res: Function | string) => setTimeout(res, times));
}

async function saveWithOption(testNum: string, done: Function, option: picker.DocumentSelectOptions) {
  await sleep(3100)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.save(option).then((result) => {
    console.info(`${testNum}::saveWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  }).catch((err: Error) => {
    console.info(`${testNum}::saveWithOption err: ${JSON.stringify(err)}`);
    expect(false).assertTrue();
    done();
    return;
  })
  await sleep(3000)
  if (platform == "iOS") {
    done();
  }
}

async function select(testNum: string, done: Function) {
  await sleep(3100)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.select().then((result) => {
    console.info(`${testNum}::select result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  }).catch((err: Error) => {
    console.info(`${testNum}::select err: ${JSON.stringify(err)}`);
    expect(false).assertTrue();
    done();
    return;
  })
  await sleep(3000)
  if (platform == "iOS") {
    testNapi.select();
    done();
  }
}

async function selectWithOption(testNum: string, done: Function, option: picker.DocumentSelectOptions) {
  await sleep(3100)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.select(option).then((result) => {
    console.info(`${testNum}::selectWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  }).catch((err: Error) => {
    console.info(`${testNum}::selectWithOption err: ${JSON.stringify(err)}`);
    expect(false).assertTrue();
    done();
    return;
  })
  await sleep(3000)
  if (platform == "iOS") {
    testNapi.select();
    done();
  }
}

export default function documentPickerPromise() {
  describe('documentPickerPromise', () => {

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0010
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0010
     * @tc.desc      : select with option
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0010";
        let option = new picker.DocumentSelectOptions();
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0020
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0020
     * @tc.desc      : select without option
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0020", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0020";
        if (platform == "IOS") {
          await select(testNum, done);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0030
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0030
     * @tc.desc      : select with option maxSelectNumber
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0030", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0030";
        let option = new picker.DocumentSelectOptions();
        option.maxSelectNumber = 3;
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0040
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0040
     * @tc.desc      : select with option defaultFilePathUri
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0040", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0040";
        let option = new picker.DocumentSelectOptions();
        option.defaultFilePathUri = "";
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0050
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0050
     * @tc.desc      : select with option image fileSuffixFilters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */

    it("SUB_ArkUIX_documentpicker_select_promise_0050", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0050";
        let option = new picker.DocumentSelectOptions();
        option.fileSuffixFilters = ['.png', '.jpg'];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0060
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0060
     * @tc.desc      : select with option docs fileSuffixFilters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0060", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0060";
        let option = new picker.DocumentSelectOptions();
        option.fileSuffixFilters = ['.pptx', '.docx', '.xlsx', '.txt'];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0070
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0070
     * @tc.desc      : select with option video fileSuffixFilters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0070", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0070";
        let option = new picker.DocumentSelectOptions();
        option.fileSuffixFilters = ['.mp4'];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number   : SUB_ArkUIX_documentpicker_select_promise_0080
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0080
     * @tc.desc      : select with option audio fileSuffixFilters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0080", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0080";
        let option = new picker.DocumentSelectOptions();
        option.fileSuffixFilters = ['.mp3'];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_0090
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_0090
     * @tc.desc      : select with option file parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_0090", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_0090";
        let option = new picker.DocumentSelectOptions();
        option.selectMode = picker.DocumentSelectMode.FILE;
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_select_promise_00100
     * @tc.name      : SUB_ArkUIX_documentpicker_select_promise_00100
     * @tc.desc      : select with option folder parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_promise_00100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_select_promise_00100";
        let option = new picker.DocumentSelectOptions();
        option.selectMode = picker.DocumentSelectMode.FOLDER;
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await selectWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_save_promise_0010
     * @tc.name      : SUB_ArkUIX_documentpicker_save_promise_0010
     * @tc.desc      : save file in Documents
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("SUB_ArkUIX_documentpicker_save_promise_0010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_save_promise_0010";
        let option = new picker.DocumentSaveOptions();
        option.newFileNames = ["DocumentViewPicker01.jpg"];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await saveWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_save_promise_0020
     * @tc.name      : SUB_ArkUIX_documentpicker_save_promise_0020
     * @tc.desc      : save mp4 in Videos
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it("SUB_ArkUIX_documentpicker_save_promise_0020", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_save_promise_0020";
        let option = new picker.DocumentSaveOptions();
        option.newFileNames = ["DocumentViewPicker01.mp4"];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await saveWithOption(testNum, done, option);
        } else {
          done()
        }
      });

    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_save_promise_003
     * @tc.name      : SUB_ArkUIX_documentpicker_save_promise_003
     * @tc.desc      : save mp3 in Audios
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it("SUB_ArkUIX_documentpicker_save_promise_0030", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_save_promise_0030";
        let option = new picker.DocumentSaveOptions();
        option.newFileNames = ["DocumentViewPicker01.mp3"];
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await saveWithOption(testNum, done, option);
        } else {
          done()
        }
      });


    /**
     * @tc.number    : SUB_ArkUIX_documentpicker_save_promise_0040
     * @tc.name      : SUB_ArkUIX_documentpicker_save_promise_0040
     * @tc.desc      : save png in Pictures
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_promise_0040", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testNum = "SUB_ArkUIX_documentpicker_save_promise_0040";
        let option = new picker.DocumentSaveOptions();
        option.defaultFilePathUri = "";
        if (platform == "Android") {
          expect(option != null).assertTrue();
          done();
        } else if (platform == "IOS") {
          await saveWithOption(testNum, done, option);
        } else {
          done()
        }
      });
  })
}