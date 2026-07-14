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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level } from '@ohos/hypium'
import { abilityDelegatorRegistry } from '@kit.TestKit'
import storageStatistics from '@ohos.file.storageStatistics'
import fileIo from '@ohos.file.fs'
import { BusinessError } from '@ohos.base'

const context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test')

const TAG: string = '[FileStorageStatistics][storageStatisticsTest] '
const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300
const CACHE_FILE: string = context.cacheDir + '/cache.txt'
const CACHE_DATA: string = 'a'.repeat(5000)

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function isNum(val: number): boolean {
  return typeof val === 'number' && !Number.isNaN(val) && Number.isFinite(val)
}

function isNegativeNum(val: number): boolean {
  return val < 0
}

function isValidPositiveNum(val: number): boolean {
  return isNum(val) && val >= 0
}

export default function storageStatisticsTest() {
  describe('storageStatisticsTest', (): void => {
    beforeAll(async () => {
      console.info(TAG + 'cacheFile is :' + CACHE_FILE)
      try {
        let file = fileIo.openSync(CACHE_FILE, fileIo.OpenMode.CREATE | fileIo.OpenMode.WRITE_ONLY)
        let writeLen = fileIo.writeSync(file.fd, CACHE_DATA)
        fileIo.closeSync(file)
        console.info(TAG + 'cache.txt created successfully, writeLen: ' + writeLen)
      } catch (err) {
        console.error(TAG + 'create cache.txt failed: ' + JSON.stringify(err))
        expect().assertFail()
      }
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      try {
        fileIo.unlinkSync(CACHE_FILE)
      } catch (err) {
        console.error(TAG + 'unlinkSync cache.txt failed: ' + JSON.stringify(err))
      }
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getCurrentBundleStats_0100
     * @tc.name ArkUIX_File_storageStatistics_getCurrentBundleStats_0100
     * @tc.desc Test getCurrentBundleStats() interfaces, returned in promise mode.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getCurrentBundleStats_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleStats_0100 start')
      try {
        let bundleStat: storageStatistics.BundleStats = await storageStatistics.getCurrentBundleStats()
        console.info(
          TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleStats_0100 bundleStat: ' + JSON.stringify(bundleStat))
        expect(bundleStat != null).assertTrue()
        expect(isValidPositiveNum(bundleStat.appSize)).assertTrue()
        expect(isValidPositiveNum(bundleStat.cacheSize)).assertTrue()
        expect(isValidPositiveNum(bundleStat.dataSize)).assertTrue()
      } catch (e) {
        console.error(
          TAG + "ArkUIX_File_storageStatistics_getCurrentBundleStats_0100 has failed for " + JSON.stringify(e))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleStats_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getCurrentBundleStats_0200
     * @tc.name ArkUIX_File_storageStatistics_getCurrentBundleStats_0200
     * @tc.desc Test getCurrentBundleStats() interfaces, returned in callback mode.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getCurrentBundleStats_0200', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleStats_0200 start')
      storageStatistics.getCurrentBundleStats((error: BusinessError, bundleStat: storageStatistics.BundleStats) => {
        try {
          if (error && error.code !== 0) {
            console.error(
              TAG + "ArkUIX_File_storageStatistics_getCurrentBundleStats_0200 failed for " + JSON.stringify(error))
            expect().assertFail()
          } else {
            console.info(TAG +
              'ArkUIX_File_storageStatistics_getCurrentBundleStats_0200 bundleStat: ' + JSON.stringify(bundleStat))
            expect(bundleStat != null).assertTrue()
            expect(isValidPositiveNum(bundleStat.appSize)).assertTrue()
            expect(isValidPositiveNum(bundleStat.cacheSize)).assertTrue()
            expect(isValidPositiveNum(bundleStat.dataSize)).assertTrue()
          }
          console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleStats_0200 end')
        } catch (e) {
          console.error(
            TAG + "ArkUIX_File_storageStatistics_getCurrentBundleStats_0200 has failed for " + JSON.stringify(e))
          expect().assertFail()
        } finally {
          done()
        }
      })
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getTotalSize_0100
     * @tc.name ArkUIX_File_storageStatistics_getTotalSize_0100
     * @tc.desc Test getTotalSize() interfaces, Promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getTotalSize_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSize_0100 start')
      try {
        let number: number = await storageStatistics.getTotalSize()
        console.info(
          TAG + "ArkUIX_File_storageStatistics_getTotalSize_0100 getTotalSize: " + JSON.stringify(number))
        expect(isValidPositiveNum(number) && number > 0).assertTrue()
      } catch (error) {
        console.error(TAG + "ArkUIX_File_storageStatistics_getTotalSize_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSize_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getTotalSize_0200
     * @tc.name ArkUIX_File_storageStatistics_getTotalSize_0200
     * @tc.desc Test getTotalSize() interfaces, callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getTotalSize_0200', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSize_0200 start')
      storageStatistics.getTotalSize((error: BusinessError, number: number) => {
        try {
          if (error && error.code !== 0) {
            console.error(TAG +
              "ArkUIX_File_storageStatistics_getTotalSize_0200 getTotalSize failed with error:" + JSON.stringify(error))
            expect().assertFail()
          } else {
            console.info(TAG + "ArkUIX_File_storageStatistics_getTotalSize_0200 getTotalSize: " + number)
            expect(isValidPositiveNum(number) && number > 0).assertTrue()
          }
          console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSize_0200 end')
        } catch (error) {
          console.error(TAG + "ArkUIX_File_storageStatistics_getTotalSize_0200 has failed for " + JSON.stringify(error))
          expect().assertFail()
        } finally {
          done()
        }
      })
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getTotalSizeSync_0100
     * @tc.name ArkUIX_File_storageStatistics_getTotalSizeSync_0100
     * @tc.desc Test getTotalSizeSync() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getTotalSizeSync_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSizeSync_0100 start')
      try {
        let number = storageStatistics.getTotalSizeSync()
        console.info(
          TAG + "ArkUIX_File_storageStatistics_getTotalSizeSync_0100 getTotalSizeSync: " + number)
        expect(isValidPositiveNum(number) && number > 0).assertTrue()
      } catch (error) {
        console.error(
          TAG + "ArkUIX_File_storageStatistics_getTotalSizeSync_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalSizeSync_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getFreeSize_0100
     * @tc.name ArkUIX_File_storageStatistics_getFreeSize_0100
     * @tc.desc Test getFreeSize() interfaces, Promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getFreeSize_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSize_0100 start')
      try {
        let number: number = await storageStatistics.getFreeSize()
        console.info(
          TAG + "ArkUIX_File_storageStatistics_getFreeSize_0100 getFreeSize: " + JSON.stringify(number))
        expect(isValidPositiveNum(number) && number > 0).assertTrue()
      } catch (error) {
        console.error(TAG + "ArkUIX_File_storageStatistics_getFreeSize_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSize_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getFreeSize_0200
     * @tc.name ArkUIX_File_storageStatistics_getFreeSize_0200
     * @tc.desc Test getFreeSize() interfaces, callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getFreeSize_0200', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSize_0200 start')
      storageStatistics.getFreeSize((error: BusinessError, number: number) => {
        try {
          if (error && error.code !== 0) {
            console.error(TAG +
              "ArkUIX_File_storageStatistics_getFreeSize_0200 getFreeSize failed with error:" + JSON.stringify(error))
            expect().assertFail()
          } else {
            console.info(TAG + "ArkUIX_File_storageStatistics_getFreeSize_0200 getFreeSize: " + number)
            expect(isValidPositiveNum(number) && number > 0).assertTrue()
          }
          console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSize_0200 end')
        } catch (error) {
          console.error(TAG + "ArkUIX_File_storageStatistics_getFreeSize_0200 has failed for " + JSON.stringify(error))
          expect().assertFail()
        } finally {
          done()
        }
      })
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getFreeSizeSync_0100
     * @tc.name ArkUIX_File_storageStatistics_getFreeSizeSync_0100
     * @tc.desc Test getFreeSizeSync() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getFreeSizeSync_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSizeSync_0100 start')
      try {
        let number = storageStatistics.getFreeSizeSync()
        console.info(TAG + "ArkUIX_File_storageStatistics_getFreeSizeSync_0100 getFreeSizeSync: " + number)
        expect(isValidPositiveNum(number) && number > 0).assertTrue()
      } catch (error) {
        console.error(
          TAG + "ArkUIX_File_storageStatistics_getFreeSizeSync_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeSizeSync_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getFreeInodes_0100
     * @tc.name ArkUIX_File_storageStatistics_getFreeInodes_0100
     * @tc.desc Test getFreeInodes() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getFreeInodes_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeInodes_0100 start')
      try {
        let freeInodes: number = await storageStatistics.getFreeInodes()
        console.info(TAG + "ArkUIX_File_storageStatistics_getFreeInodes_0100 freeInodes: " + freeInodes)
        expect(isValidPositiveNum(freeInodes)).assertTrue()
      } catch (error) {
        console.error(TAG + "ArkUIX_File_storageStatistics_getFreeInodes_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getFreeInodes_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getTotalInodes_0100
     * @tc.name ArkUIX_File_storageStatistics_getTotalInodes_0100
     * @tc.desc Test getTotalInodes() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getTotalInodes_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalInodes_0100 start')
      try {
        let totalInodes: number = await storageStatistics.getTotalInodes()
        console.info(TAG + "ArkUIX_File_storageStatistics_getTotalInodes_0100 totalInodes: " + totalInodes)
        expect(isValidPositiveNum(totalInodes)).assertTrue()
      } catch (error) {
        console.error(TAG + "ArkUIX_File_storageStatistics_getTotalInodes_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getTotalInodes_0100 end')
      done()
    })

    /**
     * @tc.number ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100
     * @tc.name ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100
     * @tc.desc Test getCurrentBundleInodes() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100', Level.LEVEL3, async (done: Function) => {
      console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100 start')
      try {
        let curInodes: number = await storageStatistics.getCurrentBundleInodes()
        console.info(TAG + "ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100 curInodes: " + curInodes)
        expect(isValidPositiveNum(curInodes)).assertTrue()
      } catch (error) {
        console.error(
          TAG + "ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100 has failed for " + JSON.stringify(error))
        expect().assertFail()
      }
      console.info(TAG + 'ArkUIX_File_storageStatistics_getCurrentBundleInodes_0100 end')
      done()
    })
  })
}
