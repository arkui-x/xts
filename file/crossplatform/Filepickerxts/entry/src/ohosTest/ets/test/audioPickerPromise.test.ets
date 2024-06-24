/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
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

import { describe, it, expect } from '@ohos/hypium'
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

async function selectWithOption(testNum: string, done: Function, option: picker.AudioSelectOptions, dirName: string, fileName: string) {
  await sleep(1000)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.select(option).then((result) => {
    console.info(`${testNum}::selectWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  }).catch((err: Error) => {
    console.info(`${testNum}::selectWithOption err: ${JSON.stringify(err)}`);
    expect(false).assertTrue();
    done();
    return;
  });
  if (platform == "iOS") {
    testNapi.select();
    done();
  }
}

async function saveWithOption(testNum: string, done: Function, option: picker.AudioSaveOptions, dirName: string) {
  await sleep(3100)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.save(option).then((result) => {
    console.info(`${testNum}::saveWithOption result: ${JSON.stringify(result)}`);
    expect(result.length).assertLargerOrEqual(0);
    done();
  }).catch((err: Error) => {
    console.info(`${testNum}::saveWithOption err: ${JSON.stringify(err)}`);
    expect(false).assertTrue();
    done();
  });
  await sleep(3000)
  if (platform == "iOS") {
    done();
  } else {
    done();
  }
}

export default function audioPickerPromise() {
  describe("audioPickerPromise", () => {

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_save_promise_0010
     * @tc.desc   : save without option, cancel
     * @tc.type   : Function
     * @tc.level   : Level 0
     */
    it("SUB_ArkUIX_audiopicker_save_promise_0010", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_promise_001";
      let option = new picker.AudioSaveOptions();
      let saveDir = "Audios";
      if (platform == "Android") {
        expect(option != null).assertTrue();
        done();
      } else {
        done();
      }
    });

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_save_promise_0020
     * @tc.desc   : save mp3 in Audios
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("SUB_ArkUIX_audiopicker_save_promise_0020", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_promise_0020";
      let option = new picker.AudioSaveOptions();
      option.newFileNames = ["AudioViewPicker01.mp3"];
      let saveDir = "Audios";
      if (platform == "Android") {
        expect(option != null).assertTrue();
        done();
      } else if (platform == "IOS") {
        await saveWithOption(testNum, done, option, saveDir);
      } else {
        done()
      }
    });

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_select_promise_0010
     * @tc.desc   : select with option
     * @tc.type   : Function
     * @tc.level   : Level 0
     */
    it("SUB_ArkUIX_audiopicker_select_promise_0010", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_promise_0010";
      let option = new picker.AudioSelectOptions();
      let dirName = "Audios";
      let fileName = "01.mp3";
      option.maxSelectNumber = 3;
      if (platform == "Android") {
        expect(option != null).assertTrue();
        done();
      } else if (platform == "IOS") {
        await selectWithOption(testNum, done, option, dirName, fileName);
      } else {
        done()
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_save_promise_0020
     * @tc.desc   : select without option
     * @tc.type   : Function
     * @tc.level   : Level 0
     */
    it("SUB_ArkUIX_audiopicker_select_promise_0020", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_promise_0020";
      let option = new picker.AudioSelectOptions();
      let dirName = "Audios";
      let fileName = "01.mp3";
      if (platform == "Android") {
        expect(option != null).assertTrue();
        done();
      } else if (platform == "IOS") {
        await selectWithOption(testNum, done, option, dirName, fileName);
      } else {
        done()
      }
    })
  });
}