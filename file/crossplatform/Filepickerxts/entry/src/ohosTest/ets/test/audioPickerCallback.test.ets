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
import picker from '@ohos.file.picker'
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

async function select(testNum: string, done: Function) {
  await sleep(1000)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.select((err, result) => {
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

async function selectWithOption(testNum: string, done: Function, option: picker.AudioSelectOptions) {
  await sleep(1000)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.select(option, (err, result) => {
    if (err != undefined) {
      console.info(`${testNum}::selectWithOption 1111 fail, err: ${JSON.stringify(err)}`);
      expect(false).assertTrue();
      done();
      return;
    }
    console.info(`${testNum}::selectWithOption 222 result: ${JSON.stringify(result)}`);
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

async function save(testNum: string, done: Function) {
  await sleep(3100)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.save((err, result) => {
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
  await sleep(3000)
  if (platform == "iOS") {
    done();
  } else {
    done();
  }
}

async function saveWithOption(testNum: string, done: Function, option: picker.AudioSaveOptions, dirName: string) {
  await sleep(3100)
  let audioPicker = new picker.AudioViewPicker();
  audioPicker.save(option, (err, result) => {
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
  await sleep(3000)
  if (platform == "iOS") {
    done();
  } else {
    done();
  }
}

export default function audioPickerCallback() {
  describe("audioPickerCallback", () => {

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_select_callback_0010
     * @tc.desc   : select without option
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_audiopicker_select_callback_0010", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_select_callback_0010";
      if (platform == "iOS") {
        await select(testNum, done);
      } else {
        done();
      }
    });

    /**
     * @tc.name   : SUB_ArkUIX_audiopicker_select_callback_0020
     * @tc.desc   : select with option
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_audiopicker_select_callback_0020", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_select_callback_0020";
      let option = new picker.AudioSelectOptions();
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
     * @tc.name   : SUB_ArkUIX_audiopicker_save_callback_0010
     * @tc.desc   : save mp3 in Audios
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_audiopicker_save_callback_0010", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_callback_0010";
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
     * @tc.name   : SUB_ArkUIX_audiopicker_save_callback_0020
     * @tc.desc   : save without option, cancel
     * @tc.type   : Function
     * @tc.level   : Level 1
     */
    it("SUB_ArkUIX_audiopicker_save_callback_0020", 0, async (done: Function) => {
      let testNum = "SUB_ArkUIX_audiopicker_save_callback_0020";
      if (platform == "iOS") {
        await save(testNum, done);
      } else {
        done();
      }
    });
  });
}