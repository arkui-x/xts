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
import { Driver, ON } from '@ohos.UiTest'
import deviceInfo from '@ohos.deviceInfo'
import window from '@ohos.window'
import { BusinessError } from '@ohos.base'

import { LONG_STRING, WAIT_READY_MS_2000, WAIT_READY_MS_300, WAIT_READY_MS_700 } from './Constant'

const TAG: string = '[WindowsAdapt][WindowsTest1] '

let platform: string = deviceInfo.osFullName.split(' ')[0]

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function WindowsTest1() {
  describe('WindowsTest1', () => {
    let windowStage: window.WindowStage
    let driver: Driver
    beforeAll(async () => {
      console.info(TAG + 'the device platform is :' + platform)
      await sleep(WAIT_READY_MS_2000)
      windowStage = globalThis.windowStage
      driver = Driver.create()
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
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is SubWindowWithOptions
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0100',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions('SubWindowWithOptions', options).then(async (tempWnd) => {
            if (!tempWnd) {
              console.error(TAG + caseName + ' tempWnd is null or undefined')
              expect().assertFail()
              done()
              return
            }
            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let res = windowProperties.name
            expect(res === 'SubWindowWithOptions').assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is '中文  ABCDefgh  123456  !@#！//、\\￥%、ZZZZ'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0200',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions('中文  ABCDefgh  123456  !@#！//、\\\\￥%、ZZZZ', options)
            .then(async (tempWnd: window.Window) => {
              if (!tempWnd) {
                console.error(TAG + caseName + ' tempWnd is null or undefined')
                expect().assertFail()
                done()
                return
              }
              let windowProperties = tempWnd.getWindowProperties()
              console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
              let res = windowProperties.name
              expect(res === '中文  ABCDefgh  123456  !@#！//、\\\\￥%、ZZZZ').assertTrue()
              console.info(TAG + caseName + 'END')
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              done()
            }).catch((e: BusinessError) => {
              console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
              expect().assertFail()
              done()
            })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0300
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0300
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is empty string, errCode 1300002
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0300 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0300',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions('', options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect(e.code === 1300002).assertTrue()
            expect(e.message.length > 0).assertTrue()
            console.info(TAG + caseName + 'END')
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0400
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0400
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is long string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0400 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0400',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(LONG_STRING, options).then(async (tempWnd: window.Window) => {
            if (!tempWnd) {
              console.error(TAG + caseName + ' tempWnd is null or undefined')
              expect().assertFail()
              done()
              return
            }
            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let res = windowProperties.name
            expect(res === LONG_STRING).assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0500
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0500
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0500 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0500',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(null, options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0600
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0600
     * @tc.desc Test createSubWindowWithOptions of API function, params name, value is undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0600 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0600',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(undefined, options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_name_0700
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_name_0700
     * @tc.desc Test createSubWindowWithOptions of API function, Create multiple child windows and assign the same name to them
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_name_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_name_0700 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        let options: window.SubWindowOptions = {
          title: 'ArkUIX_Windows_createSubWindowWithOptions_name_0700',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (data: window.Window) => {
            tempWnd = data
            await windowStage.createSubWindowWithOptions(caseName, options).then(async (data: window.Window) => {
              expect().assertFail()
              done()
            }).catch(async (e: BusinessError) => {
              expect(e.code === 1300002).assertTrue()
              expect(e.message.length > 0).assertTrue()
              await (tempWnd as window.Window).destroyWindow()
              console.info(TAG + caseName + 'END')
              done()
            })
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_title_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_title_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.title, value is SubWindowWithOptions
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_title_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_title_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: 'SubWindowWithOptions',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect(tempWnd != null).assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_title_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_title_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.title, value is '中文  ABCDefgh  123456  !@#！//、\\￥%、ZZZZ'
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_title_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_title_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: '中文  ABCDefgh  123456  !@#！//、\\\\￥%、ZZZZ',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect(tempWnd != null).assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_title_0300
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_title_0300
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.title, value is empty string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_title_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_title_0300 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: '',
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect(tempWnd != null).assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_title_0400
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_title_0400
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.title, value is long string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_title_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_title_0400 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: LONG_STRING,
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect(tempWnd != null).assertTrue()
            console.info(TAG + caseName + 'END')
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_title_0500
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_title_0500
     * @tc.desc Test createSubWindowWithOptions of API function, Create multiple child windows and assign the same title to them
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_title_0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_title_0500 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName + '1', options).then(async (tempWnd: window.Window) => {
            expect(tempWnd != null).assertTrue()
            await windowStage.createSubWindowWithOptions(caseName + '2', options).then(async (data: window.Window) => {
              expect(data != null).assertTrue()
              if (data) {
                await (data as window.Window).destroyWindow()
              }
              if (tempWnd) {
                await (tempWnd as window.Window).destroyWindow()
              }
              console.info(TAG + caseName + 'END')
              done()
            }).catch((err: BusinessError) => {
              console.error(TAG + caseName + 'createSubWindowWithOptions1 catch error for ' + JSON.stringify(err))
              expect().assertFail()
              done()
            })
          }).catch((err: BusinessError) => {
            console.error(TAG + caseName + 'createSubWindowWithOptions2 catch error for ' + JSON.stringify(err))
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
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.decorEnabled, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: true
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await sleep(WAIT_READY_MS_2000)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            if (platform.includes('iOS')) {
              expect(Math.abs(windowRect.width - 500)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.height - 500)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.left - 100)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.top - 100)).assertLessOrEqual(1)
            } else {
              expect(Math.abs(windowRect.width - 1000)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.height - 1000)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.left - 100)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.top - 100)).assertLessOrEqual(1)
            }
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.decorEnabled, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_decorEnabled_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            if (platform.includes('iOS')) {
              expect(Math.abs(windowRect.width - 500)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.height - 500)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.left - 100)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.top - 100)).assertLessOrEqual(1)
            } else {
              expect(Math.abs(windowRect.width - 1000)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.height - 1000)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.left - 100)).assertLessOrEqual(1)
              expect(Math.abs(windowRect.top - 100)).assertLessOrEqual(1)
            }

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, do not set windowRect And do not call showWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 0).assertTrue()
            expect(windowRect.top === 0).assertTrue()
            expect(windowRect.width === 0).assertTrue()
            expect(windowRect.height === 0).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, do not set windowRect And call showWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            let mainWindowProperties = windowStage.getMainWindowSync().getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 0).assertTrue()
            expect(windowRect.top === 0).assertTrue()
            expect(windowRect.width === mainWindowProperties.windowRect.width).assertTrue()
            expect(windowRect.height === mainWindowProperties.windowRect.height).assertTrue()
            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0300
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0300
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, set windowRect And do not call showWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0300 '
        console.info(TAG + caseName + 'START')
        let testWidth = vp2px(px2vp(325))
        console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
        let testHeight = vp2px(px2vp(325))
        console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          windowRect: {
            left: 0,
            top: 0,
            width: testWidth,
            height: testHeight
          }
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 0).assertTrue()
            expect(windowRect.top === 0).assertTrue()
            expect(windowRect.width === 0).assertTrue()
            expect(windowRect.height === 0).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0400
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0400
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, set windowRect And call showWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0400 '
        console.info(TAG + caseName + 'START')
        let testWidth = vp2px(px2vp(325))
        console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
        let testHeight = vp2px(px2vp(325))
        console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          windowRect: {
            left: 0,
            top: 0,
            width: testWidth,
            height: testHeight,
          }
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 0).assertTrue()
            expect(windowRect.top === 0).assertTrue()
            expect(windowRect.width === testWidth).assertTrue()
            expect(windowRect.height === testHeight).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0500
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0500
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is NaN
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0500 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          windowRect: {
            left: NaN,
            top: NaN,
            width: NaN,
            height: NaN,
          }
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0600
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0600
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is 0
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0600 '
        console.info(TAG + caseName + 'START')
        try {
          let options: window.SubWindowOptions = {
            title: caseName,
            decorEnabled: false,
            windowRect: {
              left: 0,
              top: 0,
              width: 0,
              height: 0
            }
          }
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0700
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0700
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is left/top is 10, width/height is 1000
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0700 '
        console.info(TAG + caseName + 'START')
        try {
          let testWidth: number = Math.floor(vp2px(px2vp(Math.round(1000))))
          console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
          let testHeight: number = Math.floor(vp2px(px2vp(Math.round(1000))))
          console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
          let options: window.SubWindowOptions = {
            title: caseName,
            decorEnabled: false,
            windowRect: {
              left: 10,
              top: 10,
              width: testWidth,
              height: testHeight,
            }
          }
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 10).assertTrue()
            expect(windowRect.top === 10).assertTrue()
            expect(windowRect.width === testWidth).assertTrue()
            expect(windowRect.height === testHeight).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0800
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0800
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is left/top is -3.1415, width/height is -1000.5
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0800 '
        console.info(TAG + caseName + 'START')
        try {
          let testWidth = Math.floor(vp2px(px2vp(-1000.5)))
          console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
          let testHeight: number = Math.floor(vp2px(px2vp(-1000.5)))
          console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
          let options: window.SubWindowOptions = {
            title: caseName,
            decorEnabled: false,
            windowRect: {
              left: -3.1415,
              top: -3.1415,
              width: testWidth,
              height: testHeight
            }
          }
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0900
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0900
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is left/top is +3.1415 and -3.145, width/height is 1000.5
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_0900 '
        console.info(TAG + caseName + 'START')
        try {
          let testWidth = Math.floor(vp2px(px2vp(1000.5)))
          console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
          let testHeight = Math.floor(vp2px(px2vp(1000.5)))
          console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
          let options: window.SubWindowOptions = {
            title: caseName,
            decorEnabled: false,
            windowRect: {
              left: 3.1415,
              top: -3.1415,
              width: testWidth,
              height: testHeight
            }
          }
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 3).assertTrue()
            expect(windowRect.top === -3).assertTrue()
            expect(windowRect.width === testWidth).assertTrue()
            expect(windowRect.height === testHeight).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_1000
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_1000
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.windowRect, value is left/top is +3.1415 , width/height is 1000.5
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_1000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_windowRect_1000 '
        console.info(TAG + caseName + 'START')
        try {
          let testWidth = Math.floor(vp2px(px2vp(1000.5)))
          console.info(TAG + caseName + 'testWidth is ' + JSON.stringify(testWidth))
          let testHeight = Math.floor(vp2px(px2vp(1000.5)))
          console.info(TAG + caseName + 'testHeight is ' + JSON.stringify(testHeight))
          let options: window.SubWindowOptions = {
            title: caseName,
            decorEnabled: false,
            windowRect: {
              left: 3.1415,
              top: 3.1415,
              width: testWidth,
              height: testHeight
            }
          }
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index2')
            await tempWnd.showWindow()
            await sleep(WAIT_READY_MS_300)

            let windowProperties = tempWnd.getWindowProperties()
            console.info(TAG + caseName + 'windowProperties is ' + JSON.stringify(windowProperties))
            let windowRect = windowProperties.windowRect
            expect(windowRect.left === 3).assertTrue()
            expect(windowRect.top === 3).assertTrue()
            expect(windowRect.width === testWidth).assertTrue()
            expect(windowRect.height === testHeight).assertTrue()

            await sleep(WAIT_READY_MS_2000)
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0100
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0100
     * @tc.desc Test getPreferredOrientation of API function, MainWindow, value is UNSPECIFIED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0100 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setPreferredOrientation(window.Orientation.UNSPECIFIED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(0)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0200
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0200
     * @tc.desc Test getPreferredOrientation of API function, MainWindow, value is PORTRAIT
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0200 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(1)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0300
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0300
     * @tc.desc Test getPreferredOrientation of API function, MainWindow, value is LANDSCAPE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0300 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(2)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0400
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0400
     * @tc.desc Test getPreferredOrientation of API function, MainWindow, value is PORTRAIT_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0400 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(3)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0500
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0500
     * @tc.desc Test getPreferredOrientation of API function, MainWindow, value is LANDSCAPE_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0500 '
        console.info(TAG + caseName + 'START')
        let tempWnd: window.Window | undefined = undefined
        try {
          tempWnd = windowStage!.getMainWindowSync()
          if (!tempWnd) {
            console.error(TAG + caseName + ' tempWnd is null or undefined')
            expect().assertFail()
            done()
            return
          }
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(4)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0600
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0600
     * @tc.desc Test getPreferredOrientation of API function, SubWindow, value is UNSPECIFIED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0600 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.UNSPECIFIED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(0)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0700
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0700
     * @tc.desc Test getPreferredOrientation of API function, SubWindow, value is PORTRAIT
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0700 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(1)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0800
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0800
     * @tc.desc Test getPreferredOrientation of API function, SubWindow, value is LANDSCAPE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0800 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(2)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_0900
     * @tc.name ArkUIX_Windows_getPreferredOrientation_0900
     * @tc.desc Test getPreferredOrientation of API function, SubWindow, value is PORTRAIT_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_0900 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(3)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1000
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1000
     * @tc.desc Test getPreferredOrientation of API function, SubWindow, value is LANDSCAPE_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1000 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(4)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1100
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1100
     * @tc.desc Test getPreferredOrientation of API function, SubWindowWithOptions,  value is UNSPECIFIED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1100 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.UNSPECIFIED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(0)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1200
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1200
     * @tc.desc Test getPreferredOrientation of API function, SubWindowWithOptions,  value is PORTRAIT
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1200 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(1)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1300
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1300
     * @tc.desc Test getPreferredOrientation of API function, SubWindowWithOptions,  value is LANDSCAPE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1300 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(2)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1400
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1400
     * @tc.desc Test getPreferredOrientation of API function, SubWindowWithOptions,  value is PORTRAIT_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1400 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(3)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1500
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1500
     * @tc.desc Test getPreferredOrientation of API function, SubWindowWithOptions, value is LANDSCAPE_INVERTED
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_getPreferredOrientation_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1500 '
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
          await tempWnd.setPreferredOrientation(window.Orientation.LANDSCAPE_INVERTED)
          await sleep(WAIT_READY_MS_700)
          let CurrentOrientation = tempWnd.getPreferredOrientation()
          console.info(TAG + caseName + ' CurrentOrientation: ' + CurrentOrientation)
          expect(CurrentOrientation).assertEqual(4)
          console.info(TAG + caseName + 'END')
          await tempWnd.setPreferredOrientation(window.Orientation.PORTRAIT)
          if (tempWnd) {
            await (tempWnd as window.Window).destroyWindow()
          }
          await sleep(WAIT_READY_MS_2000)
          done()
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          if (tempWnd) {
            await (tempWnd as window.Window).setPreferredOrientation(window.Orientation.PORTRAIT)
          }
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_getPreferredOrientation_1600
     * @tc.name ArkUIX_Windows_getPreferredOrientation_1600
     * @tc.desc Test getPreferredOrientation of API function, errorCode 1300002
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_getPreferredOrientation_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_Windows_getPreferredOrientation_1600 '
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
          tempWnd.getPreferredOrientation()
          expect().assertFail()
          done()
        } catch (e) {
          let error = e as BusinessError
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(error.code === 1300002).assertTrue()
          expect(error.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.isModal, value is default Value
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          modalityType: window.ModalityType.WINDOW_MODALITY
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await sleep(WAIT_READY_MS_2000)
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.isModal, value is false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          isModal: false,
          modalityType: window.ModalityType.WINDOW_MODALITY
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await sleep(WAIT_READY_MS_2000)
            expect().assertFail()
            done()
          }).catch((e: BusinessError) => {
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect(e.code === 401).assertTrue()
          expect(e.message.length > 0).assertTrue()
          console.info(TAG + caseName + 'END')
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0300
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0300
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.isModal, value is true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_isModal_0300 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          isModal: true,
          modalityType: window.ModalityType.WINDOW_MODALITY
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index3')
            await tempWnd.showWindow()
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await sleep(WAIT_READY_MS_2000)

            let btn = await driver.findComponent(ON.id('SUB_ARKUIX_Page1_Button_0010'))
            if (!btn) {
              console.error(TAG + caseName + 'findComponent failed for SUB_ARKUIX_Page1_Button_0010')
              expect().assertFail()
              done()
              return
            }
            await btn.click()
            await sleep(WAIT_READY_MS_300)
            let btnText = await btn.getText()
            await sleep(WAIT_READY_MS_2000)
            if (platform.includes('Android') || platform.includes('iOS')) {
              await btn.click()
              await sleep(WAIT_READY_MS_300)
            }
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            expect(btnText === 'Modality').assertTrue()
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0100
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0100
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.modalityType, value is Default Value
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0100 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          isModal: true
        }
        try {
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index3')
            await tempWnd.showWindow()
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)
            await sleep(WAIT_READY_MS_2000)

            let btn = await driver.findComponent(ON.id('SUB_ARKUIX_Page1_Button_0010'))
            if (!btn) {
              console.error(TAG + caseName + 'findComponent failed for SUB_ARKUIX_Page1_Button_0010')
              expect().assertFail()
              done()
              return
            }
            await btn.click()
            await sleep(WAIT_READY_MS_300)
            let btnText = await btn.getText()
            await sleep(WAIT_READY_MS_2000)
            if (platform.includes('Android') || platform.includes('iOS')) {
              await btn.click()
              await sleep(WAIT_READY_MS_300)
            }
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            expect(btnText === 'Modality').assertTrue()
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })

    /**
     * @tc.number ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0200
     * @tc.name ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0200
     * @tc.desc Test createSubWindowWithOptions of API function, params SubWindowOptions.modalityType, value is WINDOW_MODALITY
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     */
    it('ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
        const caseName = 'ArkUIX_Windows_createSubWindowWithOptions_options_modalityType_0200 '
        console.info(TAG + caseName + 'START')
        let options: window.SubWindowOptions = {
          title: caseName,
          decorEnabled: false,
          isModal: true,
          modalityType: window.ModalityType.WINDOW_MODALITY
        }
        try {
          await sleep(WAIT_READY_MS_2000)
          await windowStage.createSubWindowWithOptions(caseName, options).then(async (tempWnd: window.Window) => {
            await tempWnd.setUIContent('testability/pages/Index3')
            await tempWnd.showWindow()
            if (platform.includes('iOS')) {
              await tempWnd.resize(500, 500)
            } else {
              await tempWnd.resize(1000, 1000)
            }
            await tempWnd.moveWindowTo(100, 100)

            let btn = await driver.findComponent(ON.id('SUB_ARKUIX_Page1_Button_0010'))
            if (!btn) {
              console.error(TAG + caseName + 'findComponent failed for SUB_ARKUIX_Page1_Button_0010')
              expect().assertFail()
              done()
              return
            }
            await btn.click()
            await sleep(WAIT_READY_MS_300)
            let btnText = await btn.getText()
            await sleep(WAIT_READY_MS_2000)
            if (platform.includes('Android') || platform.includes('iOS')) {
              await btn.click()
              await sleep(WAIT_READY_MS_300)
            }
            if (tempWnd) {
              await (tempWnd as window.Window).destroyWindow()
            }
            expect(btnText === 'Modality').assertTrue()
            console.info(TAG + caseName + 'END')
            done()
          }).catch((e: BusinessError) => {
            console.error(TAG + caseName + 'promise catch error for ' + JSON.stringify(e))
            expect().assertFail()
            done()
          })
          await sleep(WAIT_READY_MS_2000)
        } catch (e) {
          console.error(TAG + caseName + 'catch error for ' + JSON.stringify(e))
          expect().assertFail()
          done()
        }
      })
  })
}
