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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import fileUri from '@ohos.file.fileuri';
import deviceInfo from '@ohos.deviceInfo';
import fs from '@ohos.file.fs';

const TAG: string = '[fileuri][fileuriTest] '
const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

const context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test')
const platform = deviceInfo.osFullName.split(' ')[0]
const TEST_FILE_NAME: string = 'test.txt'
const TEST_DIR_PATH: string = context.filesDir + '/TestDir'
const TEST_FILE_PATH: string = TEST_DIR_PATH + '/test.txt'
const TEST_FILE_URI_1: string = 'file://' + TEST_FILE_PATH
const TEST_FILE_URI_2: string = 'file://' + '/TestDir' + '/test.txt'
const LONG_STRING_LENGTH: number = 500
const LONG_STRING: string = '/' + 'a'.repeat(LONG_STRING_LENGTH)
const LONG_STRING_PATH: string = '/' + 'a'.repeat(LONG_STRING_LENGTH) + '/test.txt'
const LONG_STRING_NAME: string = '/' + 'a'.repeat(LONG_STRING_LENGTH) + 'test.txt'
const TEST_RELATIVE_PATH: string = '..' + '/TestDir' + '/test.txt'

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function expectByPlatform(actual: string, oh: string, android: string, ios: string): void {
  let expected: string
  if (platform.includes('iOS')) {
    expected = ios
  } else if (platform.includes('Android')) {
    expected = android
  } else {
    console.warn(TAG + 'the device platform is :' + platform)
    expected = oh
  }
  expect(actual).assertEqual(expected)
}

function mkdirSafe(dirPath: string): void {
  try {
    fs.mkdirSync(dirPath)
  } catch (e) {
    if (!JSON.stringify(e).includes('13900014')) {
      console.error(TAG + `mkdirSafe failed for ${JSON.stringify(e)}`)
      expect().assertFail()
    }
  }
}

export default function fileuriTest() {
  describe('fileuriTest', (): void => {
    beforeAll(async () => {
      console.info(TAG + 'the device platform is :' + platform)
      console.info(TAG + 'the device context.filesDir is :' + context.filesDir)
      console.info(TAG + 'TEST_DIR_PATH is :' + TEST_DIR_PATH)
      console.info(TAG + 'TEST_FILE_PATH is :' + TEST_FILE_PATH)
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0100
     * @tc.name ArkUIX_FileUri_getUriFromPath_0100
     * @tc.desc Test getUriFromPath of API function, value is '/ABCD/abcd/中文/12345/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0100 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          const resultForiOS = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          let testValue = '/ABCD/abcd/中文/12345/test.txt'
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0200
     * @tc.name ArkUIX_FileUri_getUriFromPath_0200
     * @tc.desc Test getUriFromPath of API function, value is '/AB!@@#$%^&*()-=/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0200 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          let testValue = '/AB!@@#$%^&*()-=/test.txt'
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0300
     * @tc.name ArkUIX_FileUri_getUriFromPath_0300
     * @tc.desc Test getUriFromPath of API function, value is '/AB！@#￥%……&/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0300 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          const resultForAndroid =
            'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          let testValue = '/AB！@#￥%……&/test.txt'
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0400
     * @tc.name ArkUIX_FileUri_getUriFromPath_0400
     * @tc.desc Test getUriFromPath of API function, value is '/AB\\  Csd2w/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0400 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          let testValue = '/AB\\\\  Csd2w/test.txt'
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0500
     * @tc.name ArkUIX_FileUri_getUriFromPath_0500
     * @tc.desc Test getUriFromPath of API function, value is empty string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0500 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri'
          const resultForAndroid = 'file://com.example.fileuri'
          const resultForiOS = 'file://com.example.fileuri'
          let testValue = ''
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0600
     * @tc.name ArkUIX_FileUri_getUriFromPath_0600
     * @tc.desc Test getUriFromPath of API function, value is LONG_STRING
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0600 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/' + 'a'.repeat(LONG_STRING_LENGTH)
          const resultForAndroid = 'file://com.example.fileuri/' + 'a'.repeat(LONG_STRING_LENGTH)
          const resultForiOS = 'file://com.example.fileuri/' + 'a'.repeat(LONG_STRING_LENGTH)
          let testValue = LONG_STRING
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0700
     * @tc.name ArkUIX_FileUri_getUriFromPath_0700
     * @tc.desc Test getUriFromPath of API function, value is '/TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0700 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/TestDir/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/TestDir/test.txt'
          const resultForiOS = 'file://com.example.fileuri/TestDir/test.txt'
          let testValue = '/TestDir/test.txt'
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0800
     * @tc.name ArkUIX_FileUri_getUriFromPath_0800
     * @tc.desc Test getUriFromPath of API function, value is sandBox path + "/TestDir/test.txt"
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0800 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid =
            'file://com.example.fileuri/data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = 'file://com.example.fileuri' + context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_PATH
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })


    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_0900
     * @tc.name ArkUIX_FileUri_getUriFromPath_0900
     * @tc.desc Test getUriFromPath of API function, value is TEST_FILE_URI_1
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_0900 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file:///data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid = 'file:///data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = 'file://' + context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_URI_1
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_1000
     * @tc.name ArkUIX_FileUri_getUriFromPath_1000
     * @tc.desc Test getUriFromPath of API function, value is TEST_FILE_URI_2
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getUriFromPath_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_1000 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file:///TestDir/test.txt'
          const resultForAndroid = 'file:///TestDir/test.txt'
          const resultForiOS = 'file:///TestDir/test.txt'
          let testValue = TEST_FILE_URI_2
          let uri = fileUri.getUriFromPath(testValue)
          console.info(TAG + caseName + 'uri: ' + uri)
          expectByPlatform(uri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_1100
     * @tc.name ArkUIX_FileUri_getUriFromPath_1100
     * @tc.desc Test getUriFromPath of API function, value is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_FileUri_getUriFromPath_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_1100 '
        console.info(TAG + caseName + 'START')
        try {
          let uri = fileUri.getUriFromPath(null)
          expect().assertFail()
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect(JSON.stringify(e).includes('401')).assertTrue()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_1200
     * @tc.name ArkUIX_FileUri_getUriFromPath_1200
     * @tc.desc Test getUriFromPath of API function, value is undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_FileUri_getUriFromPath_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_1200 '
        console.info(TAG + caseName + 'START')
        try {
          let uri = fileUri.getUriFromPath(undefined)
          expect().assertFail()
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect(JSON.stringify(e).includes('401')).assertTrue()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getUriFromPath_1300
     * @tc.name ArkUIX_FileUri_getUriFromPath_1300
     * @tc.desc Test getUriFromPath of API function, value is '../TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_FileUri_getUriFromPath_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getUriFromPath_1300 '
        console.info(TAG + caseName + 'START')
        try {
          let uri = fileUri.getUriFromPath(TEST_RELATIVE_PATH)
          expect().assertFail()
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect(JSON.stringify(e).includes('401')).assertTrue()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0100
     * @tc.name ArkUIX_FileUri_path_0100
     * @tc.desc Test path of FileUri, value is '/ABCD/abcd/中文/12345/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0100 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/ABCD/abcd/中文/12345/test.txt'
          const resultForAndroid = '/ABCD/abcd/中文/12345/test.txt'
          const resultForiOS = '/ABCD/abcd/中文/12345/test.txt'
          let testValue = '/ABCD/abcd/中文/12345/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0200
     * @tc.name ArkUIX_FileUri_path_0200
     * @tc.desc Test path of FileUri, value is '/AB!@@#$%^&*()-=/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0200 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/AB!@@#$%^&*()-=/test.txt'
          const resultForAndroid = '/AB!@@#$%^&*()-=/test.txt'
          const resultForiOS = '/AB!@@#$%^&*()-=/test.txt'
          let testValue = '/AB!@@#$%^&*()-=/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0300
     * @tc.name ArkUIX_FileUri_path_0300
     * @tc.desc Test path of FileUri, value is '/AB！@#￥%……&/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0300 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/AB！@#￥%……&/test.txt'
          const resultForAndroid = '/AB！@#￥%……&/test.txt'
          const resultForiOS = '/AB！@#￥%……&/test.txt'
          let testValue = '/AB！@#￥%……&/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0400
     * @tc.name ArkUIX_FileUri_path_0400
     * @tc.desc Test path of FileUri, value is '/AB\\  Csd2w/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0400 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/AB\\\\  Csd2w/test.txt'
          const resultForAndroid = '/AB\\\\  Csd2w/test.txt'
          const resultForiOS = '/AB\\\\  Csd2w/test.txt'
          let testValue = '/AB\\\\  Csd2w/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0500
     * @tc.name ArkUIX_FileUri_path_0500
     * @tc.desc Test path of FileUri, value is empty string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0500 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = ''
          const resultForAndroid = ''
          const resultForiOS = ''
          let testValue = ''
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0600
     * @tc.name ArkUIX_FileUri_path_0600
     * @tc.desc Test path of FileUri, value is LONG_STRING
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0600 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = LONG_STRING
          const resultForAndroid = LONG_STRING
          const resultForiOS = LONG_STRING
          let testValue = LONG_STRING
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0700
     * @tc.name ArkUIX_FileUri_path_0700
     * @tc.desc Test path of FileUri, value is '/TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0700 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/TestDir/test.txt'
          const resultForAndroid = '/TestDir/test.txt'
          const resultForiOS = '/TestDir/test.txt'
          let testValue = '/TestDir/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_0800
     * @tc.name ArkUIX_FileUri_path_0800
     * @tc.desc Test path of FileUri, value is sandBox path + "/TestDir/test.txt"
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0800 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid = '/data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })


    /**
     * @tc.number ArkUIX_FileUri_path_0900
     * @tc.name ArkUIX_FileUri_path_0900
     * @tc.desc Test path of FileUri, value is TEST_FILE_URI_1
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_0900 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid = '/data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_URI_1
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_1000
     * @tc.name ArkUIX_FileUri_path_1000
     * @tc.desc Test path of FileUri, value is TEST_FILE_URI_2
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_1000 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = '/TestDir/test.txt'
          const resultForAndroid = '/TestDir/test.txt'
          const resultForiOS = '/TestDir/test.txt'
          let testValue = TEST_FILE_URI_2
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expectByPlatform(path, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_path_1100
     * @tc.name ArkUIX_FileUri_path_1100
     * @tc.desc Test path of FileUri, value is '../TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_path_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_path_1100 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_RELATIVE_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let path = fileUriObject.path
          console.info(TAG + caseName + 'path: ' + path)
          expect(path).assertEqual('')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0100
     * @tc.name ArkUIX_FileUri_name_0100
     * @tc.desc Test name of FileUri, test value is '/ABCD/abcd/中文/12345/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0100 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/ABCD/abcd/中文/12345/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0200
     * @tc.name ArkUIX_FileUri_name_0200
     * @tc.desc Test name of FileUri, test value is '/AB!@@#$%^&*()-=/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0200 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/AB!@@#$%^&*()-=/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0300
     * @tc.name ArkUIX_FileUri_name_0300
     * @tc.desc Test name of FileUri, test value is '/AB！@#￥%……&/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0300 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/AB！@#￥%……&/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0400
     * @tc.name ArkUIX_FileUri_name_0400
     * @tc.desc Test name of FileUri, test value is '/AB\\  Csd2w/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0400 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/AB\\\\  Csd2w/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0500
     * @tc.name ArkUIX_FileUri_name_0500
     * @tc.desc Test name of FileUri, test value is empty string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0500 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = ''
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0600
     * @tc.name ArkUIX_FileUri_name_0600
     * @tc.desc Test name of FileUri, test value is LONG_STRING
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0600 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = LONG_STRING_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0700
     * @tc.name ArkUIX_FileUri_name_0700
     * @tc.desc Test name of FileUri, test value is '/TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0700 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/TestDir/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_0800
     * @tc.name ArkUIX_FileUri_name_0800
     * @tc.desc Test name of FileUri, test value is sandBox path + "/TestDir/test.txt"
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0800 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_FILE_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })


    /**
     * @tc.number ArkUIX_FileUri_name_0900
     * @tc.name ArkUIX_FileUri_name_0900
     * @tc.desc Test name of FileUri, test value is TEST_FILE_URI_1
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_0900 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_FILE_URI_1
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1000
     * @tc.name ArkUIX_FileUri_name_1000
     * @tc.desc Test name of FileUri, test value is TEST_FILE_URI_2
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1000 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_FILE_URI_2
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual(TEST_FILE_NAME)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1100
     * @tc.name ArkUIX_FileUri_name_1100
     * @tc.desc Test name of FileUri, test value is dir not file
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1100 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('TestDir')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1200
     * @tc.name ArkUIX_FileUri_name_1200
     * @tc.desc Test name of FileUri, test name is 'ABCDabcd中文12345test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1200 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/TestDir/ABCDabcd中文12345test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('ABCDabcd中文12345test.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1300
     * @tc.name ArkUIX_FileUri_name_1300
     * @tc.desc Test name of FileUri, test name is 'AB!@@#$%^&*()-=testAB！@#￥%……&test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1300 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = '/TestDir/AB!@@#$%^&*()-=testAB！@#￥%……&test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('AB!@@#$%^&*()-=testAB！@#￥%……&test.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1400
     * @tc.name ArkUIX_FileUri_name_1400
     * @tc.desc Test name of FileUri, test name is ('a'.repeat(500) + 'test.txt')
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1400 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH + LONG_STRING_NAME
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('a'.repeat(LONG_STRING_LENGTH) + 'test.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1500
     * @tc.name ArkUIX_FileUri_name_1500
     * @tc.desc Test name of FileUri, test name is 'te  st.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1500 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH + '/te  st.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('te  st.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1600
     * @tc.name ArkUIX_FileUri_name_1600
     * @tc.desc Test name of FileUri, test name is 'te\st.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1600 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH + '/te\\st.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('te\\st.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1700
     * @tc.name ArkUIX_FileUri_name_1700
     * @tc.desc Test name of FileUri, test name is 'te/st.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1700 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH + '/te/st.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('st.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1800
     * @tc.name ArkUIX_FileUri_name_1800
     * @tc.desc Test name of FileUri, test name is 'test.txt.txt.txt.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1800 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_DIR_PATH + '/test.txt.txt.txt.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('test.txt.txt.txt.txt')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_1900
     * @tc.name ArkUIX_FileUri_name_1900
     * @tc.desc Test name of FileUri, test name is Common File Extensions
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_1900 '
        console.info(TAG + caseName + 'START')
        try {
          const extensions: Array<string> = ['txt', 'pdf', 'docx', 'xlsx', 'jpg', 'png', 'mp3', 'mp4',
            'zip', 'exe', 'html', 'cpp', 'py', 'json', 'log']
          for (const ext of extensions) {
            const testValue: string = TEST_DIR_PATH + '/test.' + ext
            const fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
            const name: string = fileUriObject.name
            const expected: string = 'test.' + ext
            console.info(TAG + `${caseName}ext=${ext}, name=${name}`)
            expect(name).assertEqual(expected)
          }
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_name_2000
     * @tc.name ArkUIX_FileUri_name_2000
     * @tc.desc Test name of FileUri, test dir is '../TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_name_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_name_2000 '
        console.info(TAG + caseName + 'START')
        try {
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(TEST_RELATIVE_PATH)
          let name = fileUriObject.name
          console.info(TAG + caseName + 'name: ' + name)
          expect(name).assertEqual('')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0100
     * @tc.name ArkUIX_FileUri_toString_0100
     * @tc.desc Test toString of FileUri function, value is '/ABCD/abcd/中文/12345/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0100 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          const resultForiOS = 'file://com.example.fileuri/ABCD/abcd/%E4%B8%AD%E6%96%87/12345/test.txt'
          let testValue = '/ABCD/abcd/中文/12345/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + fileUriObject.toString())
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0200
     * @tc.name ArkUIX_FileUri_toString_0200
     * @tc.desc Test toString of FileUri function, value is '/AB!@@#$%^&*()-=/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0200 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB!%40%40%23%24%25%5E%26*()-%3D/test.txt'
          let testValue = '/AB!@@#$%^&*()-=/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0300
     * @tc.name ArkUIX_FileUri_toString_0300
     * @tc.desc Test toString of FileUri function, value is '/AB！@#￥%……&/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0300 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          const resultForAndroid =
            'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB%EF%BC%81%40%23%EF%BF%A5%25%E2%80%A6%E2%80%A6%26/test.txt'
          let testValue = '/AB！@#￥%……&/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0400
     * @tc.name ArkUIX_FileUri_toString_0400
     * @tc.desc Test toString of FileUri function, value is '/AB\\  Csd2w/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0400 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          const resultForiOS = 'file://com.example.fileuri/AB%5C%5C%20%20Csd2w/test.txt'
          let testValue = '/AB\\\\  Csd2w/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0500
     * @tc.name ArkUIX_FileUri_toString_0500
     * @tc.desc Test toString of FileUri function, value is empty string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0500 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri'
          const resultForAndroid = 'file://com.example.fileuri'
          const resultForiOS = 'file://com.example.fileuri'
          let testValue = ''
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0600
     * @tc.name ArkUIX_FileUri_toString_0600
     * @tc.desc Test toString of FileUri function, value is LONG_STRING
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0600 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri' + LONG_STRING
          const resultForAndroid = 'file://com.example.fileuri' + LONG_STRING
          const resultForiOS = 'file://com.example.fileuri' + LONG_STRING
          let testValue = LONG_STRING
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0700
     * @tc.name ArkUIX_FileUri_toString_0700
     * @tc.desc Test toString of FileUri function, value is '/TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0700 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/TestDir/test.txt'
          const resultForAndroid = 'file://com.example.fileuri/TestDir/test.txt'
          const resultForiOS = 'file://com.example.fileuri/TestDir/test.txt'
          let testValue = '/TestDir/test.txt'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_0800
     * @tc.name ArkUIX_FileUri_toString_0800
     * @tc.desc Test toString of FileUri function, value is sandBox path + "/TestDir/test.txt"
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0800 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file://com.example.fileuri/data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid =
            'file://com.example.fileuri/data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = 'file://com.example.fileuri' + context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })


    /**
     * @tc.number ArkUIX_FileUri_toString_0900
     * @tc.name ArkUIX_FileUri_toString_0900
     * @tc.desc Test toString of FileUri function, value is TEST_FILE_URI_1
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_0900 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file:///data/storage/el2/base/files/TestDir/test.txt'
          const resultForAndroid = 'file:///data/user/0/com.example.fileuri/files/files/TestDir/test.txt'
          const resultForiOS = 'file://' + context.filesDir + '/TestDir/test.txt'
          let testValue = TEST_FILE_URI_1
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_1000
     * @tc.name ArkUIX_FileUri_toString_1000
     * @tc.desc Test toString of FileUri function, value is TEST_FILE_URI_2
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_1000 '
        console.info(TAG + caseName + 'START')
        try {
          const resultForOH = 'file:///TestDir/test.txt'
          const resultForAndroid = 'file:///TestDir/test.txt'
          const resultForiOS = 'file:///TestDir/test.txt'
          let testValue = TEST_FILE_URI_2
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'result: ' + res)
          expectByPlatform(res, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_toString_1100
     * @tc.name ArkUIX_FileUri_toString_1100
     * @tc.desc Test toString of FileUri function, value is '../TestDir/test.txt'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_toString_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_toString_1100 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = TEST_RELATIVE_PATH
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let res = fileUriObject.toString()
          console.info(TAG + caseName + 'path: ' + res)
          expect(res).assertEqual('')
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getFullDirectoryUri_0100
     * @tc.name ArkUIX_FileUri_getFullDirectoryUri_0100
     * @tc.desc Test getFullDirectoryUri of FileUri function, value is exists dir
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getFullDirectoryUri_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getFullDirectoryUri_0100 '
        console.info(TAG + caseName + 'START')
        const resultForOH = 'file://com.example.fileuri/data/storage/el2/base/files/TestDir1'
        const resultForAndroid = 'file://com.example.fileuri/data/user/0/com.example.fileuri/files/files/TestDir1'
        const resultForiOS = 'file://com.example.fileuri' + context.filesDir + '/TestDir1'
        let testValue = context.filesDir + '/TestDir1'
        try {
          mkdirSafe(testValue)
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let fullDirectoryUri: string = fileUriObject.getFullDirectoryUri()
          console.info(TAG + caseName + 'fullDirectoryUri:' + fullDirectoryUri)
          expectByPlatform(fullDirectoryUri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        } finally {
          console.info(TAG + caseName + 'in finally')
          try {
            fs.rmdirSync(testValue)
          } catch (e) {
            console.error(TAG + caseName + `rmdirSync failed for ${JSON.stringify(e)}`)
          }
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getFullDirectoryUri_0200
     * @tc.name ArkUIX_FileUri_getFullDirectoryUri_0200
     * @tc.desc Test getFullDirectoryUri of FileUri function, value is non-exists dir
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_FileUri_getFullDirectoryUri_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getFullDirectoryUri_0200 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = context.filesDir + '/TestDir2'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let fullDirectoryUri: string = fileUriObject.getFullDirectoryUri()
          console.info(TAG + caseName + 'fullDirectoryUri: ' + fullDirectoryUri)
          expect().assertFail()
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect(JSON.stringify(e).includes('13900002')).assertTrue()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getFullDirectoryUri_0300
     * @tc.name ArkUIX_FileUri_getFullDirectoryUri_0300
     * @tc.desc Test getFullDirectoryUri of FileUri function, value is exists file
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_getFullDirectoryUri_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getFullDirectoryUri_0300 '
        console.info(TAG + caseName + 'START')
        const resultForOH = 'file://com.example.fileuri/data/storage/el2/base/files/TestDir3'
        const resultForAndroid = 'file://com.example.fileuri/data/user/0/com.example.fileuri/files/files/TestDir3'
        const resultForiOS = 'file://com.example.fileuri' + context.filesDir + '/TestDir3'
        let testValue = context.filesDir + '/TestDir3' + '/test.txt'
        let testFile: fs.File | undefined = undefined
        try {
          mkdirSafe(context.filesDir + '/TestDir3')
          testFile = fs.openSync(testValue, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE)
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let fullDirectoryUri: string = fileUriObject.getFullDirectoryUri()
          console.info(TAG + caseName + 'fullDirectoryUri: ' + fullDirectoryUri)
          expectByPlatform(fullDirectoryUri, resultForOH, resultForAndroid, resultForiOS)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        } finally {
          console.info(TAG + caseName + 'in finally')
          try {
            if (testFile != undefined) {
              fs.closeSync(testFile)
            }
            fs.unlinkSync(context.filesDir + '/TestDir3' + '/test.txt')
            fs.rmdirSync(context.filesDir + '/TestDir3')
          } catch (e) {
            console.error(TAG + caseName + `rmdirSync failed for ${JSON.stringify(e)}`)
          }
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_getFullDirectoryUri_0400
     * @tc.name ArkUIX_FileUri_getFullDirectoryUri_0400
     * @tc.desc Test getFullDirectoryUri of FileUri function, value is non-exists file
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_FileUri_getFullDirectoryUri_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_getFullDirectoryUri_0400 '
        console.info(TAG + caseName + 'START')
        try {
          let testValue = context.filesDir + '/TestDir4'
          let fileUriObject: fileUri.FileUri = new fileUri.FileUri(testValue)
          let fullDirectoryUri: string = fileUriObject.getFullDirectoryUri()
          console.info(TAG + caseName + 'fullDirectoryUri: ' + fullDirectoryUri)
          expect().assertFail()
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect(JSON.stringify(e).includes('13900002')).assertTrue()
        }
        console.info(TAG + caseName + 'END')
        done()
      })

    /**
     * @tc.number ArkUIX_FileUri_fileio_0100
     * @tc.name ArkUIX_FileUri_fileio_0100
     * @tc.desc Test FileUri with file I/O
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_FileUri_fileio_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_FileUri_fileio_0100 '
        console.info(TAG + caseName + 'START')
        const testDirPath = context.filesDir + '/fileioDir'
        const testFilePath = context.filesDir + '/fileioDir' + '/fileio.txt'
        const testFileInfo: string = 'Hello, FileUri! This is a test file for FileUri I/O operations.'
        let testFile: fs.File | undefined = undefined
        let fileUriForTestDirPath: fileUri.FileUri = new fileUri.FileUri('')
        let fileUriForTestFilePath: fileUri.FileUri = new fileUri.FileUri('')
        try {
          fileUriForTestDirPath = new fileUri.FileUri(testDirPath)
          mkdirSafe(fileUriForTestDirPath.path)
          fileUriForTestFilePath = new fileUri.FileUri(testFilePath)
          testFile = fs.openSync(fileUriForTestFilePath.path, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE)
          expect(fs.accessSync(fileUriForTestFilePath.path)).assertTrue()
          console.info(TAG + caseName + 'create dir and file success')
          fs.writeSync(testFile.fd, testFileInfo)
          let readTextFormTestFile = fs.readTextSync(fileUriForTestFilePath.path)
          console.info(TAG + caseName + 'read file data: ' + readTextFormTestFile)
          expect(readTextFormTestFile).assertEqual(testFileInfo)
        } catch (e) {
          console.error(TAG + caseName + `has failed for ${JSON.stringify(e)}`)
          expect().assertFail()
        } finally {
          try {
            if (testFile != undefined) {
              fs.closeSync(testFile)
            }
            fs.unlinkSync(fileUriForTestFilePath.path)
            fs.rmdirSync(fileUriForTestDirPath.path)
          } catch (e) {
            console.error(TAG + caseName + `failed for ${JSON.stringify(e)}`)
          }
        }
        console.info(TAG + caseName + 'END')
        done()
      })
  })
}
