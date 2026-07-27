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
import deviceInfo from '@ohos.deviceInfo'
import window from '@ohos.window'
import { BusinessError } from '@ohos.base'

import { WAIT_READY_MS_2000, WAIT_READY_MS_300 } from './Constant'

const TAG: string = '[WindowsAdapt][WindowsTest2] '
let platform: string = deviceInfo.osFullName.split(' ')[0]

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function WindowsTest2() {
  describe('WindowsTest2', () => {
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
     * @tc.number ArkUIX_Windows_setWindowFocusable_0300
     * @tc.name ArkUIX_Windows_setWindowFocusable_0300
     * @tc.desc Test setWindowFocusable of API function, callback, in SubWindow, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0300 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(true, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              expect().assertFail()
              done()
              return
            }
          })
          await tempWnd.setUIContent('testability/pages/Index2')
          if (platform.includes('iOS')) {
            await tempWnd.resize(500, 500)
          } else {
            await tempWnd.resize(1000, 1000)
          }
          await tempWnd.moveWindowTo(100, 100)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const focused: boolean = (tempWnd as window.Window).isFocused()
          console.info(TAG + caseName + 'isFocused result is ' + focused)
          expect(focused).assertTrue()
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          console.info(TAG + caseName + 'END')
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0400
     * @tc.name ArkUIX_Windows_setWindowFocusable_0400
     * @tc.desc Test setWindowFocusable of API function, callback, in SubWindow, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0400 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(false, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              expect().assertFail()
              done()
            } else {
              expect((tempWnd as window.Window).isFocused()).assertFalse()
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              console.info(TAG + caseName + 'END')
              done()
            }
          })
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0500
     * @tc.name ArkUIX_Windows_setWindowFocusable_0500
     * @tc.desc Test setWindowFocusable of API function, callback, in SubWindowWithOptions, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0500 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(true, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              expect().assertFail()
              done()
              return
            }
          })
          await tempWnd.setUIContent('testability/pages/Index2')
          if (platform.includes('iOS')) {
            await tempWnd.resize(500, 500)
          } else {
            await tempWnd.resize(1000, 1000)
          }
          await tempWnd.moveWindowTo(100, 100)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const focused: boolean = (tempWnd as window.Window).isFocused()
          console.info(TAG + caseName + 'isFocused result is ' + focused)
          expect(focused).assertTrue()
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          console.info(TAG + caseName + 'END')
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0600
     * @tc.name ArkUIX_Windows_setWindowFocusable_0600
     * @tc.desc Test setWindowFocusable of API function, callback, in SubWindowWithOptions, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0600 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(false, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              expect().assertFail()
              done()
            } else {
              expect((tempWnd as window.Window).isFocused()).assertFalse()
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              console.info(TAG + caseName + 'END')
              done()
            }
          })
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0700
     * @tc.name ArkUIX_Windows_setWindowFocusable_0700
     * @tc.desc Test setWindowFocusable of API function, callback, errCode 1300002
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0700 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          tempWnd.setWindowFocusable(true, async (err: BusinessError) => {
            if (err && err.code !== 0) {
              console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
              expect(err.code === 1300002).assertTrue()
              expect(err.message.length > 0).assertTrue()
              console.info(TAG + caseName + 'END')
              done()
            } else {
              expect().assertFail()
              done()
            }
          })
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0800
     * @tc.name ArkUIX_Windows_setWindowFocusable_0800
     * @tc.desc Test setWindowFocusable of API function, callback, errCode 401, value is undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0800 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(undefined, (err: BusinessError) => {
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_0900
     * @tc.name ArkUIX_Windows_setWindowFocusable_0900
     * @tc.desc Test setWindowFocusable of API function, callback, errCode 401, value is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_0900 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          tempWnd.setWindowFocusable(null, (err: BusinessError) => {
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1200
     * @tc.name ArkUIX_Windows_setWindowFocusable_1200
     * @tc.desc Test setWindowFocusable of API function, promise, in SubWindow, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1200 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true).then(async () => {
            if (!tempWnd) {
              console.error(TAG + caseName + ' tempWnd is null or undefined')
              expect().assertFail()
              done()
              return
            }
            await tempWnd.setUIContent('testability/pages/Index2')
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_2000)
            const focused: boolean = (tempWnd as window.Window).isFocused()
            console.info(TAG + caseName + 'isFocused result is ' + focused)
            expect(focused).assertTrue()
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1300
     * @tc.name ArkUIX_Windows_setWindowFocusable_1300
     * @tc.desc Test setWindowFocusable of API function, promise, in SubWindow, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1300 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false).then(async () => {
            expect((tempWnd as window.Window).isFocused()).assertFalse()
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1400
     * @tc.name ArkUIX_Windows_setWindowFocusable_1400
     * @tc.desc Test setWindowFocusable of API function, promise, in SubWindowWithOptions, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1400 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true).then(async () => {
            if (!tempWnd) {
              console.error(TAG + caseName + ' tempWnd is null or undefined')
              expect().assertFail()
              done()
              return
            }
            await tempWnd.setUIContent('testability/pages/Index2')
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_2000)
            const focused: boolean = (tempWnd as window.Window).isFocused()
            console.info(TAG + caseName + 'isFocused result is ' + focused)
            expect(focused).assertTrue()
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1500
     * @tc.name ArkUIX_Windows_setWindowFocusable_1500
     * @tc.desc Test setWindowFocusable of API function, promise, in SubWindowWithOptions, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_setWindowFocusable_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1500 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false).then(async () => {
            expect((tempWnd as window.Window).isFocused()).assertFalse()
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1600
     * @tc.name ArkUIX_Windows_setWindowFocusable_1600
     * @tc.desc Test setWindowFocusable of API function, promise, errCode 1300002
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1600 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await tempWnd.setWindowFocusable(true).then(() => {
            expect().assertFail()
          }).catch((err: BusinessError) => {
            console.error(TAG + caseName + `setWindowFocusable Failed. ${JSON.stringify(err)}`)
            expect(err.code === 1300002).assertTrue()
            expect(err.message.length > 0).assertTrue()
          })
          console.info(TAG + caseName + 'END')
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1700
     * @tc.name ArkUIX_Windows_setWindowFocusable_1700
     * @tc.desc Test setWindowFocusable of API function, promise, errCode 401, value is undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1700 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(undefined).then(() => {
            expect().assertFail()
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_setWindowFocusable_1800
     * @tc.name ArkUIX_Windows_setWindowFocusable_1800
     * @tc.desc Test setWindowFocusable of API function, promise, errCode 401, value is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_setWindowFocusable_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_setWindowFocusable_1800 '
        console.info(TAG + caseName + 'START')
        try {
          let tempWnd: window.Window = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(null).then(() => {
            expect().assertFail()
            done()
          }).catch((err: BusinessError) => {
            expect().assertFail()
            done()
          })
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0300
     * @tc.name ArkUIX_Windows_isFocused_0300
     * @tc.desc Test isFocused of API function, in SubWindow, return true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0300 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertTrue()
          console.info(TAG + caseName + 'END')
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0400
     * @tc.name ArkUIX_Windows_isFocused_0400
     * @tc.desc Test isFocused of API function, in SubWindow, return false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0400 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = await windowStage.createSubWindow(caseName)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertFalse()
          console.info(TAG + caseName + 'END')
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0500
     * @tc.name ArkUIX_Windows_isFocused_0500
     * @tc.desc Test isFocused of API function, in SubWindowWithOptions, return true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0500 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(true)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertTrue()
          console.info(TAG + caseName + 'END')
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0600
     * @tc.name ArkUIX_Windows_isFocused_0600
     * @tc.desc Test isFocused of API function, in SubWindowWithOptions, return false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_isFocused_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0600 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setWindowFocusable(false)
          await tempWnd.showWindow()
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect(isFocused).assertFalse()
          console.info(TAG + caseName + 'END')
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_isFocused_0700
     * @tc.name ArkUIX_Windows_isFocused_0700
     * @tc.desc Test isFocused of API function, errCode 1300002
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_isFocused_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function): Promise<void> => {
        const caseName = 'ArkUIX_Windows_isFocused_0700 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'Sub Window title',
          decorEnabled: true
        }
        try {
          tempWnd = await windowStage.createSubWindowWithOptions(caseName, options)
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await sleep(WAIT_READY_MS_300)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          const isFocused = tempWnd.isFocused()
          expect().assertFail()
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 1300002).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })
  })
}
