/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it } from '@ohos/hypium'
import { abilityDelegatorRegistry } from '@kit.TestKit'
import { ApplicationStateChangeCallback, UIAbility, Want } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import deviceInfo from '@ohos.deviceInfo'

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

const LOG_TAG: string = 'ApplicationContextTest'
const AWAIT_SLEEP_MS_1000: number = 1000
const AWAIT_SLEEP_MS_2000: number = 2000
const AWAIT_SLEEP_MS_6000: number = 6000
const WANT: Want = {
  bundleName: 'com.example.assisttest',
  moduleName: 'entry',
  abilityName: 'EntryAbility'
}
let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
let context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test')
let platform = deviceInfo.osFullName.split(' ')[0]

export default function applicationContextTest() {
  describe('ApplicationContextTest', () => {
    beforeAll(async () => {
      await sleep(AWAIT_SLEEP_MS_2000)
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number : ACTS_ARKUIX_applicationStateChange_Func_0100
     * @tc.name   : ACTS_ARKUIX_applicationStateChange_Func_0100
     * @tc.desc   : Test Func off('applicationStateChange') with no callback
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_applicationStateChange_Func_0100', 0, async (done: Function) => {
      try {
        let resForCallback1Foreground: number = 0
        let resForCallback1Background: number = 0
        let resForCallback2Foreground: number = 0
        let resForCallback2Background: number = 0
        let applicationStateChangeCallback1: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationForeground called')
            resForCallback1Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationBackground called')
            resForCallback1Background += 1
          }
        }
        let applicationStateChangeCallback2: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationForeground called')
            resForCallback2Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationBackground called')
            resForCallback2Background += 1
          }
        }
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback2)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().off('applicationStateChange')
        await sleep(AWAIT_SLEEP_MS_1000)
        if (platform.includes('OpenHarmony')) {
          delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
            await delegator.doAbilityBackground(data).then(() => {
              console.info(LOG_TAG + 'Func_0100 doAbilityBackground')
            }).catch(() => {
              expect().assertFail()
            })
            await sleep(AWAIT_SLEEP_MS_2000)
            await delegator.doAbilityForeground(data).then(() => {
              console.info(LOG_TAG + 'Func_0100 doAbilityForeground')
            }).catch(() => {
              expect().assertFail()
            })
          })
        } else {
          await delegator.startAbility(WANT).then(() => {
          }).catch(() => {
            expect().assertFail()
          })
        }
        await sleep(AWAIT_SLEEP_MS_6000)
        expect(resForCallback1Foreground == 0).assertTrue()
        expect(resForCallback1Background == 0).assertTrue()
        expect(resForCallback2Foreground == 0).assertTrue()
        expect(resForCallback2Background == 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_applicationStateChange_Func_0200
     * @tc.name   : ACTS_ARKUIX_applicationStateChange_Func_0200
     * @tc.desc   : Test Func off('applicationStateChange') with callback
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_applicationStateChange_Func_0200', 0, async (done: Function) => {
      try {
        let resForCallback1Foreground: number = 0
        let resForCallback1Background: number = 0
        let resForCallback2Foreground: number = 0
        let resForCallback2Background: number = 0
        let applicationStateChangeCallback1: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationForeground called')
            resForCallback1Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationBackground called')
            resForCallback1Background += 1
          }
        }
        let applicationStateChangeCallback2: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationForeground called')
            resForCallback2Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationBackground called')
            resForCallback2Background += 1
          }
        }
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback2)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().off('applicationStateChange', applicationStateChangeCallback2)
        await sleep(AWAIT_SLEEP_MS_1000)
        if (platform.includes('OpenHarmony')) {
          delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
            await delegator.doAbilityBackground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
            await sleep(AWAIT_SLEEP_MS_2000)
            await delegator.doAbilityForeground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
          })
        } else {
          await delegator.startAbility(WANT).then(() => {
          }).catch(() => {
            expect().assertFail()
          })
        }
        await sleep(AWAIT_SLEEP_MS_6000)
        expect(resForCallback1Foreground == 1).assertTrue()
        expect(resForCallback1Background == 1).assertTrue()
        expect(resForCallback2Foreground == 0).assertTrue()
        expect(resForCallback2Background == 0).assertTrue()
        context.getApplicationContext().off('applicationStateChange')
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_applicationStateChange_Func_0300
     * @tc.name   : ACTS_ARKUIX_applicationStateChange_Func_0300
     * @tc.desc   : Test Func on('applicationStateChange')
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_applicationStateChange_Func_0300', 0, async (done: Function) => {
      try {
        let resForCallback1Foreground: number = 0
        let resForCallback1Background: number = 0
        let applicationStateChangeCallback1: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationForeground called')
            resForCallback1Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationBackground called')
            resForCallback1Background += 1
          }
        }
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        await sleep(AWAIT_SLEEP_MS_1000)
        if (platform.includes('OpenHarmony')) {
          delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
            await delegator.doAbilityBackground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
            await sleep(AWAIT_SLEEP_MS_2000)
            await delegator.doAbilityForeground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
          })
        } else {
          await delegator.startAbility(WANT).then(() => {
          }).catch(() => {
            expect().assertFail()
          })
        }
        await sleep(AWAIT_SLEEP_MS_6000)
        expect(resForCallback1Foreground == 1).assertTrue()
        expect(resForCallback1Background == 1).assertTrue()
        context.getApplicationContext().off('applicationStateChange')
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_applicationStateChange_Func_0400
     * @tc.name   : ACTS_ARKUIX_applicationStateChange_Func_0400
     * @tc.desc   : Test Func on('applicationStateChange') twice with different callback
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_applicationStateChange_Func_0400', 0, async (done: Function) => {
      try {
        let resForCallback1Foreground: number = 0
        let resForCallback1Background: number = 0
        let resForCallback2Foreground: number = 0
        let resForCallback2Background: number = 0
        let applicationStateChangeCallback1: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationForeground called')
            resForCallback1Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback1 onApplicationBackground called')
            resForCallback1Background += 1
          }
        }
        let applicationStateChangeCallback2: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationForeground called')
            resForCallback2Foreground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0100 applicationStateChangeCallback2 onApplicationBackground called')
            resForCallback2Background += 1
          }
        }
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback2)
        await sleep(AWAIT_SLEEP_MS_1000)
        if (platform.includes('OpenHarmony')) {
          delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
            await delegator.doAbilityBackground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
            await sleep(AWAIT_SLEEP_MS_2000)
            await delegator.doAbilityForeground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
          })
        } else {
          await delegator.startAbility(WANT).then(() => {
          }).catch(() => {
            expect().assertFail()
          })
        }
        await sleep(AWAIT_SLEEP_MS_6000)
        expect(resForCallback1Foreground == 1).assertTrue()
        expect(resForCallback1Background == 1).assertTrue()
        expect(resForCallback2Foreground == 1).assertTrue()
        expect(resForCallback2Background == 1).assertTrue()
        context.getApplicationContext().off('applicationStateChange')
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_applicationStateChange_Func_0500
     * @tc.name   : ACTS_ARKUIX_applicationStateChange_Func_0500
     * @tc.desc   : Test Func on('applicationStateChange') twice with same callback
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_applicationStateChange_Func_0500', 0, async (done: Function) => {
      try {
        let resForCallbackForeground: number = 0
        let resForCallbackBackground: number = 0
        let applicationStateChangeCallback1: ApplicationStateChangeCallback = {
          onApplicationForeground() {
            console.info(LOG_TAG + 'Func_0400 applicationStateChangeCallback1 onApplicationForeground called')
            resForCallbackForeground += 1
          },
          onApplicationBackground() {
            console.info(LOG_TAG + 'Func_0400 applicationStateChangeCallback1 onApplicationBackground called')
            resForCallbackBackground += 1
          }
        }
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        context.getApplicationContext().on('applicationStateChange', applicationStateChangeCallback1)
        await sleep(AWAIT_SLEEP_MS_1000)
        if (platform.includes('OpenHarmony')) {
          delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
            await delegator.doAbilityBackground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
            await sleep(AWAIT_SLEEP_MS_2000)
            await delegator.doAbilityForeground(data).then(() => {
            }).catch(() => {
              expect().assertFail()
            })
          })
        } else {
          await delegator.startAbility(WANT).then(() => {
          }).catch(() => {
            expect().assertFail()
          })
        }
        await sleep(AWAIT_SLEEP_MS_6000)
        expect(resForCallbackForeground == 2).assertTrue()
        expect(resForCallbackBackground == 2).assertTrue()
        context.getApplicationContext().off('applicationStateChange')
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}