/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium'
import { abilityDelegatorRegistry } from '@kit.TestKit'
import deviceInfo from '@ohos.deviceInfo'
import window from '@ohos.window'
import { BusinessError } from '@ohos.base'

import { WAIT_READY_MS_2000, WAIT_READY_MS_300, WANT } from './Constant'

const TAG: string = '[WindowsAdapt][WindowsTest3] '
let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
let platform: string = deviceInfo.osFullName.split(' ')[0]

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function WindowsTest3() {
  describe('WindowsTest3', () => {
    let windowStage: window.WindowStage
    beforeAll(async () => {
      console.info(TAG + 'the device platform is :' + platform)
      await sleep(WAIT_READY_MS_2000)
      windowStage = globalThis.windowStage
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
     * @tc.number ArkUIX_Windows_setWindowFocusable_0100
     * @tc.name ArkUIX_Windows_setWindowFocusable_0100
     * @tc.desc Test setWindowFocusable of API function, callback, in MainWindow, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0100 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(true, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              expect().assertFail()
              done()
            } else {
              if (platform.includes('Android')) {
                await delegator.startAbility(WANT).then(() => {
                }).catch(() => {
                  expect().assertFail()
                })
              }
              expect(tempWnd.isFocused()).assertTrue()
              console.info(TAG + caseName + 'END')
              done()
            }
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1000
     * @tc.name ArkUIX_Windows_setWindowFocusable_1000
     * @tc.desc Test setWindowFocusable of API function, promise, in MainWindow, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1000 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true).then(async () => {
            await tempWnd.setUIContent('testability/pages/Index')
            if (platform.includes('OpenHarmony')) {
              await tempWnd.showWindow()
            } else {
              await delegator.startAbility(WANT).then(() => {
              }).catch(() => {
                expect().assertFail()
              })
            }
            await sleep(WAIT_READY_MS_2000)
            const focused: boolean = (tempWnd as window.Window).isFocused()
            console.info(TAG + caseName + 'isFocused result is ' + focused)
            expect(focused).assertTrue()
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promisecatch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0100
     * @tc.name ArkUIX_Windows_isFocused_0100
     * @tc.desc Test isFocused of API function, in MainWindow, return true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0100 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true)
          if (platform.includes('OpenHarmony')) {
            await tempWnd.showWindow()
          } else {
            await delegator.startAbility(WANT).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
          }
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0200
     * @tc.name ArkUIX_Windows_setWindowFocusable_0200
     * @tc.desc Test setWindowFocusable of API function, callback, in MainWindow, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0200 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(false, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              expect().assertFail()
              done()
            } else {
              expect(tempWnd.isFocused()).assertFalse()
              console.info(TAG + caseName + 'END')
              await tempWnd.setWindowFocusable(true)
              done()
            }
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1100
     * @tc.name ArkUIX_Windows_setWindowFocusable_1100
     * @tc.desc Test setWindowFocusable of API function, promise, in MainWindow, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1100 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false).then(async () => {
            await sleep(WAIT_READY_MS_300)
            expect((tempWnd as window.Window).isFocused()).assertFalse()
            console.info(TAG + caseName + 'END')
            await tempWnd.setWindowFocusable(true)
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promisecatch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0200
     * @tc.name ArkUIX_Windows_isFocused_0200
     * @tc.desc Test isFocused of API function, in MainWindow, return false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0200 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false)
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertFalse()
          console.info(TAG + caseName + 'END')
          await tempWnd.setWindowFocusable(true)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })
  })
}
