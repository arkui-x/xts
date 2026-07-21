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
import deviceInfo from '@ohos.deviceInfo'
import display from '@ohos.display'
import { window } from '@kit.ArkUI'

let platform = deviceInfo.osFullName.split(' ')[0]

const TAG: string = '[DisplayFold][DisplayModel] '
const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function DisplayModel() {
  describe('DisplayModel', (): void => {
    let windowStage: window.WindowStage
    beforeAll(async () => {
      console.info(TAG + 'the device platform is :' + platform)
      windowStage = globalThis.windowStage
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
     * @tc.number ArkUIX_Display_Display_rotation_0100
     * @tc.name ArkUIX_Display_Display_rotation_0100
     * @tc.desc Test Display rotation interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_Display_rotation_0100", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_Display_rotation_0100 '
      console.info(TAG + caseName + 'START')
      try {
        let displayClass: display.Display = display.getDefaultDisplaySync()
        let rotation: number = displayClass.rotation
        console.info(TAG + caseName + 'rotation is ' + rotation)
        let res: boolean = [0, 1, 2, 3].includes(rotation)
        expect(res).assertTrue()
        console.info(TAG + caseName + 'END')
        done()
      } catch (e) {
        console.error(TAG + caseName + 'try-catch error: ' + JSON.stringify(e))
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number ArkUIX_Display_getFoldStatus_0100
     * @tc.name ArkUIX_Display_getFoldStatus_0100
     * @tc.desc Test getFoldStatus interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_getFoldStatus_0100", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_getFoldStatus_0100 '
      console.info(TAG + caseName + 'START')
      if (platform.includes('iOS')) {
        console.info(TAG + caseName + 'Skipped: getFoldStatus is not supported on iOS')
        done()
        return
      }
      try {
        let isValidFoldStatus: boolean = false
        let isFoldable = display.isFoldable()
        console.info(TAG + caseName + 'isFoldable is ' + JSON.stringify(isFoldable))
        let foldStatus: display.FoldStatus = display.getFoldStatus()
        console.info(TAG + caseName + 'foldStatus is ' + JSON.stringify(foldStatus))
        if (isFoldable) {
          isValidFoldStatus = (foldStatus === display.FoldStatus.FOLD_STATUS_EXPANDED ||
            foldStatus === display.FoldStatus.FOLD_STATUS_FOLDED ||
            foldStatus === display.FoldStatus.FOLD_STATUS_HALF_FOLDED)
        } else {
          isValidFoldStatus = (foldStatus === display.FoldStatus.FOLD_STATUS_UNKNOWN)
        }
        await sleep(WAIT_READY_MS_300)
        expect(isValidFoldStatus).assertTrue()
        console.info(TAG + caseName + 'END')
        done()
      } catch (e) {
        console.error(TAG + caseName + 'try-catch error: ' + JSON.stringify(e))
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number ArkUIX_Display_getAllDisplays_0100
     * @tc.name ArkUIX_Display_getAllDisplays_0100
     * @tc.desc Test getAllDisplays() interfaces, callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_getAllDisplays_0100", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_getAllDisplays_0100 '
      console.info(TAG + caseName + 'START')
      let isDone = false
      let callbackFired = false
      const finish = (err?: Error) => {
        if (!isDone) {
          isDone = true
          if (err) {
            console.error(TAG + caseName + 'error: ' + JSON.stringify(err))
            expect().assertFail()
          }
          done()
        }
      }
      try {
        display.getAllDisplays((err, data) => {
          callbackFired = true
          try {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + 'Failed to obtain all the display objects. Code: ' + JSON.stringify(err))
              expect().assertFail()
              finish()
              return
            }
            console.info(TAG + caseName + 'AllDisplays Data: ' + JSON.stringify(data))
            for (let i = 0; i < data.length; i++) {
              expect(data[i].id).assertLargerOrEqual(0)
              expect(data[i].width > 0).assertTrue()
              expect(data[i].height > 0).assertTrue()
              expect([0, 1, 2, 3].includes(data[i].rotation)).assertTrue()
              expect([0, 1, 2, 3].includes(data[i].orientation)).assertTrue()
              expect(data[i].xDPI).assertLargerOrEqual(0)
              expect(data[i].yDPI).assertLargerOrEqual(0)
            }
            console.info(TAG + caseName + 'END')
            finish()
          } catch (e) {
            finish(e as Error)
          }
        })
        await sleep(WAIT_READY_MS_2000)
        if (!callbackFired) {
          console.error(TAG + caseName + 'Callback was not invoked within ' + WAIT_READY_MS_2000 + 'ms')
          finish(new Error('getAllDisplays callback timeout'))
        } else {
          finish()
        }
      } catch (e) {
        finish(e as Error)
      }
    })

    /**
     * @tc.number ArkUIX_Display_getAllDisplays_0200
     * @tc.name ArkUIX_Display_getAllDisplays_0200
     * @tc.desc Test getAllDisplays() interfaces, promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_getAllDisplays_0200", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_getAllDisplays_0200 '
      console.info(TAG + caseName + 'START')
      try {
        const data = await display.getAllDisplays()
        console.info(TAG + caseName + 'Succeeded in obtaining all the display objects. Data: ' + JSON.stringify(data))
        for (let i = 0; i < data.length; i++) {
          expect(data[i].id).assertLargerOrEqual(0)
          expect(data[i].width > 0).assertTrue()
          expect(data[i].height > 0).assertTrue()
          expect([0, 1, 2, 3].includes(data[i].rotation)).assertTrue()
          expect([0, 1, 2, 3].includes(data[i].orientation)).assertTrue()
          expect(data[i].xDPI).assertLargerOrEqual(0)
          expect(data[i].yDPI).assertLargerOrEqual(0)
        }
        console.info(TAG + caseName + 'END')
        done()
      } catch (e) {
        console.error(TAG + caseName + 'try-catch error: ' + JSON.stringify(e))
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number ArkUIX_Display_getLiveCreaseRegion_0100
     * @tc.name ArkUIX_Display_getLiveCreaseRegion_0100
     * @tc.desc Test getLiveCreaseRegion() interfaces
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_getLiveCreaseRegion_0100", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_getLiveCreaseRegion_0100 '
      console.info(TAG + caseName + 'START')
      if (platform.includes('iOS')) {
        console.info(TAG + caseName + 'Skipped: getLiveCreaseRegion is not supported on iOS')
        done()
        return
      }
      try {
        let isFoldable = display.isFoldable()
        console.info(TAG + caseName + 'isFoldable: ' + isFoldable)
        if (isFoldable) {
          console.info(TAG + caseName + 'The device is foldable.')
          let defaultDisplay = display.getDefaultDisplaySync()
          let region = defaultDisplay.getLiveCreaseRegion()
          console.info(TAG + caseName + 'region is ' + JSON.stringify(region))
          for (let i = 0; i < region.creaseRects.length; i++) {
            expect(region.creaseRects[i].left).assertLargerOrEqual(0)
            expect(region.creaseRects[i].top).assertLargerOrEqual(0)
            expect(region.creaseRects[i].width).assertLargerOrEqual(0)
            expect(region.creaseRects[i].height).assertLargerOrEqual(0)
          }
        } else {
          console.info(TAG + caseName + '[ENV-DEPENDENT] The device is not foldable; crease region check skipped ' +
            '(no assertion, environment-related)')
        }
        console.info(TAG + caseName + 'END')
        done()
      } catch (e) {
        console.error(TAG + caseName + 'try-catch error: ' + JSON.stringify(e))
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number ArkUIX_Display_getLiveCreaseRegion_0200
     * @tc.name ArkUIX_Display_getLiveCreaseRegion_0200
     * @tc.desc Test getLiveCreaseRegion() interfaces，when orientation changed
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it("ArkUIX_Display_getLiveCreaseRegion_0200", Level.LEVEL3, async (done: Function) => {
      const caseName: string = 'ArkUIX_Display_getLiveCreaseRegion_0200 '
      console.info(TAG + caseName + 'START')
      if (platform.includes('iOS')) {
        console.info(TAG + caseName + 'Skipped: getLiveCreaseRegion is not supported on iOS')
        done()
        return
      }
      let tempWnd: window.Window | undefined = windowStage!.getMainWindowSync()
      await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE)
      try {
        let isFoldable = display.isFoldable()
        console.info(TAG + caseName + 'isFoldable: ' + isFoldable)
        if (isFoldable) {
          console.info(TAG + caseName + 'The device is foldable.')
          let defaultDisplay = display.getDefaultDisplaySync()
          let region = defaultDisplay.getLiveCreaseRegion()
          console.info(TAG + caseName + 'region is ' + JSON.stringify(region))
          for (let i = 0; i < region.creaseRects.length; i++) {
            expect(region.creaseRects[i].left).assertLargerOrEqual(0)
            expect(region.creaseRects[i].top).assertLargerOrEqual(0)
            expect(region.creaseRects[i].width).assertLargerOrEqual(0)
            expect(region.creaseRects[i].height).assertLargerOrEqual(0)
          }
        } else {
          console.info(TAG + caseName + '[ENV-DEPENDENT] The device is not foldable; crease region check skipped ' +
            '(no assertion, environment-related)')
        }
        console.info(TAG + caseName + 'END')
        done()
      } catch (e) {
        console.error(TAG + caseName + 'try-catch error: ' + JSON.stringify(e))
        expect().assertFail()
        done()
      }
    })
  })
}
