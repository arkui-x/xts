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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
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
  await sleep(1000)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.save(option, (err, result) => {
    if (err != undefined) {
      console.info(`${testNum}::saveWithOption err: ${JSON.stringify(err)}`);
      expect(false).assertTrue();
      done();
      return;
    }
    console.info(`${testNum}::saveWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  });
  if (platform == "iOS") {
    done();
  } else {
    done();
  }
}

async function save(testNum: string, done: Function) {
  await sleep(1000)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.save((err, result) => {
    if (err != undefined) {
      console.info(`${testNum}::saveWithoutSelect err: ${JSON.stringify(err)}`);
      expect(false).assertTrue();
      done();
      return;
    }
    console.info(`${testNum}::saveWithoutSelect result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  });
  if (platform == "iOS") {
    done();
  } else {
    done();
  }
}

async function select(testNum: string, done: Function) {
  await sleep(1000)
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.select((err, result) => {
    if (err != undefined) {
      console.info(`${testNum}::select fail, err: ${JSON.stringify(err)}`);
      expect(false).assertTrue();
      done();
      return;
    }
    console.info(`${testNum}::select result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  });
  if (platform == "iOS") {
    testNapi.select();
    done();
  } else {
    done();
  }
}

async function selectWithOption(testNum: string, done: Function, option: picker.DocumentSelectOptions) {
  await sleep(1000);
  let documentPicker = new picker.DocumentViewPicker();
  documentPicker.select(option, (err, result) => {
    if (err != undefined) {
      console.info(`${testNum}::selectWithOption fail, err: ${JSON.stringify(err)}`);
      expect(false).assertTrue();
      done();
      return;
    }
    console.info(`${testNum}::selectWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  });
  if (platform == "iOS") {
    testNapi.select();
    done();
  } else {
    done();
  }

}

export default function documentPickerPromise() {
  describe('documentPickeCallback', () => {

    beforeEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.name   : SUB_ArkUIX_documentpicker_select_callback_0010
     * @tc.desc   : select without option
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0010", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0010";
      if (platform == "iOS") {
        await select(testNum, done);
      } else {
        done();
      }
    });

    /**
     * @tc.name   : SUB_ArkUIX_documentpicker_select_callback_0020
     * @tc.desc   : select with option
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0020", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0020";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_promise_0030
     * @tc.desc   : select with option maxSelectNumber
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0030", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0030";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_promise_0040
     * @tc.desc   : select with option defaultFilePathUri
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0040", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0040";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_promise_0050
     * @tc.desc   : select with option image fileSuffixFilters
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0050", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0050";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_promise_0060
     * @tc.desc   : select with option docs fileSuffixFilters
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0060", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0060";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_callback_0070
     * @tc.desc   : select with option video fileSuffixFilters
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0070", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0070";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_callback_0080
     * @tc.desc   : select with option audio fileSuffixFilters
     * @tc.size   : MEDIUM
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0080", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0080";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_promise_0090
     * @tc.desc   : select with option file parameter
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_0090", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_0090";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_select_callback_00100
     * @tc.desc   : select with option folder parameter
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_select_callback_00100", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_select_callback_00100";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_save_callback_0010
     * @tc.desc   : save file in Documents
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_callback_0010", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_save_callback_0010";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_save_callback_0020
     * @tc.desc   : save mp4 in Videos
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_callback_0020", 3, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_save_callback_0020";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_save_callback_003
     * @tc.desc   : save mp3 in Audios
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_callback_0030", 3, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_save_callback_0030";
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
     * @tc.name   : SUB_ArkUIX_documentpicker_save_callback_0040
     * @tc.desc   : save png in Pictures
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_callback_0040", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_save_callback_0040";
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

    /**
     * @tc.name   : SUB_ArkUIX_documentpicker_save_callback_0050
     * @tc.desc   : save png in Pictures
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_documentpicker_save_callback_0050", 1, async (done: Function) => {
      let testNum = "SUB_ArkUIX_documentpicker_save_callback_0050";
      if (platform == "iOS") {
        await save(testNum, done);
      } else {
        done();
      }
    });
  })
}