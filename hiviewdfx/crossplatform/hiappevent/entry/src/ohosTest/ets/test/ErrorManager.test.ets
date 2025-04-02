/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium'
import { BusinessError } from '@kit.BasicServicesKit'
import { errorManager } from '@kit.AbilityKit'

function createPromise(): Promise<string> {
  return new Promise((resolve, reject) => {
    throw new Error("uncaught exception")
  })
}

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ErrorManager() {
  describe('ErrorManagerTest', () => {
    let observerId: number = -1;
    beforeEach(async () => {
      try {
        await errorManager.off('error', observerId).then(() => {
        })
        errorManager.off("loopObserver");
        errorManager.off("unhandledRejection");
      } catch (err) {
        console.error("observer clean err");
      }
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Callback_0100
     * @tc.name testErrorManagerErrOnOffCallback0100
     * @tc.desc Verify on interface call, off interface call, set invalid observerId (non--1 value)
     * @tc.level Level2
     */
    it('testErrorManagerErrOnOffCallback0100', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffCallback0100";
      try {
        errorManager.off('error', -2, (err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
        await sleep(3000);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Callback_0200
     * @tc.name testErrorManagerErrOnOffCallback0200
     * @tc.desc Verify the on interface call, two consecutive calls off interface passed observerId (on return value)
     * @tc.level Level0
     */
    it('testErrorManagerErrOnOffCallback0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffCallback0200";
      try {
        let flag: boolean = false;
        let observer1: errorManager.ErrorObserver = {
          onUnhandledException: (errMsg) => {
            console.info('observer1 onUnhandledException trigger; errMsg is: ' + errMsg);
          },
          onException: (errorObj) => {
            console.info('observer1 onException trigger; errorObj is: ' + JSON.stringify(errorObj))
          }
        }
        observerId = errorManager.on('error', observer1);
        errorManager.off('error', observerId, (err: BusinessError) => {
          if (err) {
            expect().assertFail();
          } else {
            flag = true;
          }
        })
        await sleep(1000);
        expect(flag).assertTrue();
        errorManager.off('error', observerId, (err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Callback_0300
     * @tc.name testErrorManagerErrOnOffCallback0300
     * @tc.desc Verify on interface calls, off interface calls, set -1
     * @tc.level Level2
     */
    it('testErrorManagerErrOnOffCallback0300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffCallback0300";
      try {
        errorManager.off('error', -1, (err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
        await sleep(3000);
      } catch (err) {
        console.error(LOG_TAG + ` >observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Promise_0100
     * @tc.name testErrorManagerErrOnOffPromise0100
     * @tc.desc Verify on interface call, off interface call, set invalid observerId (non--1 value)
     * @tc.level Level2
     */
    it('testErrorManagerErrOnOffPromise0100', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffPromise0100";
      try {
        await errorManager.off('error', 0.1).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Promise_0200
     * @tc.name testErrorManagerErrOnOffPromise0200
     * @tc.desc Verify the on interface call, two consecutive calls off interface passed observerId (on return value)
     * @tc.level Level0
     */
    it('testErrorManagerErrOnOffPromise0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffPromise0200";
      try {
        let flag: boolean = false;
        let observer1: errorManager.ErrorObserver = {
          onUnhandledException: (errMsg) => {
            console.info('observer1 onUnhandledException trigger; errMsg is: ' + errMsg);
            expect(true).assertTrue();
          },
          onException: (errorObj) => {
            console.info('observer1 onException trigger; errorObj is: ' + JSON.stringify(errorObj))
            expect(true).assertTrue();
          }
        }
        observerId = errorManager.on('error', observer1);
        await errorManager.off('error', observerId).then(() => {
          flag = true;
        }).catch((err: BusinessError) => {
          expect().assertFail();
        })
        expect(flag).assertTrue();
        await errorManager.off('error', observerId).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_ErrOnOff_Promise_0300
     * @tc.name testErrorManagerErrOnOffPromise0300
     * @tc.desc Verify on interface call, off interface call, set -1
     * @tc.level Level2
     */
    it('testErrorManagerErrOnOffPromise0300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerErrOnOffPromise0300";
      try {
        await errorManager.off('error', -1).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(401);
        })
      } catch (err) {
        console.error(LOG_TAG + ` >observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0100
     * @tc.name testErrorManagerLoopOnOff0100
     * @tc.desc Verification on (type: 'loopObserver, timeout: number, the observer: loopObserver) of
     *          the timeout is set to 1
     * @tc.level Level0
     */
    it('testErrorManagerLoopOnOff0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0100";
      try {
        let flag: boolean = false;
        let LoopObserver: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver1 onLoopTimeOut trigger; timeout is: ' + timeout)
            flag = true;
          }
        }
        errorManager.on('loopObserver', 1, LoopObserver)
        for (let i = 0; i < 35; i++) {
          console.info("this is timeout test");
        }
        await sleep(3000);
        expect(flag).assertTrue();
        errorManager.off("loopObserver")
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0200
     * @tc.name testErrorManagerLoopOnOff0200
     * @tc.desc Verification on (type: 'loopObserver, timeout: number, the observer: loopObserver) of the
     *          timeout is set to 0
     * @tc.level Level2
     */
    it('testErrorManagerLoopOnOff0200', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0200";
      try {
        let LoopObserver: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver1 onLoopTimeOut trigger; timeout is: ' + timeout)
          }
        }
        errorManager.on('loopObserver', 0, LoopObserver)
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0300
     * @tc.name testErrorManagerLoopOnOff0300
     * @tc.desc Verification on (type: 'loopObserver, timeout: number, the observer: loopObserver) of
     *          the timeout is set to 1
     * @tc.level Level2
     */
    it('testErrorManagerLoopOnOff0300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0300";
      let observer: errorManager.LoopObserver = {
        onLoopTimeOut(timeout: number) {
          console.log('Duration timeout: ' + timeout);
        }
      };
      try {
        errorManager.on("loopObserver", -1, observer);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `>observer error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue()
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0400
     * @tc.name testErrorManagerLoopOnOff0400
     * @tc.desc Verify the call to the on interface twice and set different observers
     * @tc.level Level0
     */
    it('testErrorManagerLoopOnOff0400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0400";
      try {
        let flag1: boolean = false;
        let flag2: boolean = false;
        let LoopObserver1: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver1 onLoopTimeOut trigger; timeout is: ' + timeout);
            flag1 = true;
          }
        }
        let LoopObserver2: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver2 onLoopTimeOut trigger; timeout is: ' + timeout);
            flag2 = true;
          }
        }
        errorManager.on('loopObserver', 1, LoopObserver1)
        errorManager.on('loopObserver', 1, LoopObserver2)
        for (let i = 0; i < 35; i++) {
          console.info("this is timeout test");
        }
        await sleep(3000);
        expect(flag1).assertFalse();
        expect(flag2).assertTrue();
        errorManager.off("loopObserver")
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0500
     * @tc.name testErrorManagerLoopOnOff0500
     * @tc.desc Verify the invocation of the on interface twice and set the same observer
     * @tc.level Level0
     */
    it('testErrorManagerLoopOnOff0500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0500";
      try {
        let flag1: boolean = false;
        let LoopObserver: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver1 onLoopTimeOut trigger; timeout is: ' + timeout);
            flag1 = true;
          }
        }
        errorManager.on('loopObserver', 1, LoopObserver)
        errorManager.on('loopObserver', 1, LoopObserver)
        for (let i = 0; i < 35; i++) {
          console.info("this is timeout test");
        }
        await sleep(3000);
        expect(flag1).assertTrue();
        errorManager.off("loopObserver")
      } catch (err) {
        console.error(LOG_TAG + `>observer error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_LoopOnOff_0600
     * @tc.name testErrorManagerLoopOnOff0600
     * @tc.desc Verify off Unsubscribe
     * @tc.level Level0
     */
    it('testErrorManagerLoopOnOff0600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerLoopOnOff0600";
      try {
        let flag1: boolean = false;
        let LoopObserver: errorManager.LoopObserver = {
          onLoopTimeOut(timeout: number) {
            console.info(LOG_TAG + 'LoopObserver1 onLoopTimeOut trigger; timeout is: ' + timeout);
            flag1 = (flag1 == false) ? true : false;
          }
        }
        errorManager.on('loopObserver', 1, LoopObserver)
        for (let i = 0; i < 35; i++) {
          console.info("this is timeout test");
        }
        await sleep(3000);
        expect(flag1).assertTrue();
        errorManager.off("loopObserver")
        for (let i = 0; i < 35; i++) {
          console.info("this is timeout test");
        }
        expect(flag1).assertTrue();
      } catch (err) {
        console.error(LOG_TAG + `>observer error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_UnhandledRejection_0100
     * @tc.name testErrorManagerUnhandledRejection0100
     * @tc.desc Verify on subscription
     * @tc.level Level0
     */
    it('testErrorManagerUnhandledRejection0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerUnhandledRejection0100";
      try {
        let flag1: boolean = false;
        let UnhandledRejectionObserver1: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.message is: ' + reason.message);
            flag1 = true;
          }
        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        createPromise();
        await sleep(3000);
        expect(flag1).assertTrue();
        errorManager.off('unhandledRejection', UnhandledRejectionObserver1);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_UnhandledRejection_0200
     * @tc.name testErrorManagerUnhandledRejection0200
     * @tc.desc Verify the call to the on interface twice and set different observers
     * @tc.level Level0
     */
    it('testErrorManagerUnhandledRejection0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerUnhandledRejection0200";
      try {
        let flag1: boolean = false;
        let flag2: boolean = false;
        let UnhandledRejectionObserver1: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.message is: ' + reason.message);
            flag1 = true;
          }
        let UnhandledRejectionObserver2: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.message is: ' + reason.message);
            flag2 = true;
          }

        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        errorManager.on('unhandledRejection', UnhandledRejectionObserver2);
        createPromise();
        await sleep(3000);
        expect(flag1).assertTrue();
        expect(flag2).assertTrue();
        errorManager.off('unhandledRejection', UnhandledRejectionObserver1);
        errorManager.off('unhandledRejection', UnhandledRejectionObserver2);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_UnhandledRejection_0300
     * @tc.name testErrorManagerUnhandledRejection0300
     * @tc.desc Verify the invocation of the on interface twice and set the same observer
     * @tc.level Level0
     */
    it('testErrorManagerUnhandledRejection0300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerUnhandledRejection0300";
      try {
        let flag1: boolean = false;
        let UnhandledRejectionObserver1: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.message is: ' + reason.message);
            flag1 = true;
          }
        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        createPromise();
        await sleep(3000);
        expect(flag1).assertTrue();
        errorManager.off('unhandledRejection', UnhandledRejectionObserver1);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_UnhandledRejection_0400
     * @tc.name testErrorManagerUnhandledRejection0400
     * @tc.desc Verify the call to the on interface twice, set different observers, call to the off
     *          interface, pass in any observer
     * @tc.level Level0
     */
    it('testErrorManagerUnhandledRejection0400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerUnhandledRejection0400";
      try {
        let flag1: boolean = false;
        let flag2: boolean = false;
        let UnhandledRejectionObserver1: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.message is: ' + reason.message);
            flag1 = true;
          }
        let UnhandledRejectionObserver2: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.message is: ' + reason.message);
            flag2 = true;
          }

        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        errorManager.on('unhandledRejection', UnhandledRejectionObserver2);
        errorManager.off('unhandledRejection', UnhandledRejectionObserver1);
        createPromise();
        await sleep(3000);
        expect(flag1).assertFalse();
        expect(flag2).assertTrue();
        errorManager.off('unhandledRejection', UnhandledRejectionObserver2);
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_ErrorManager_UnhandledRejection_0500
     * @tc.name testErrorManagerUnhandledRejection0500
     * @tc.desc Verify that the on interface is invoked twice and different observers are set. The off
     *          interface is invoked and no observer is passed
     * @tc.level Level0
     */
    it('testErrorManagerUnhandledRejection0500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testErrorManagerUnhandledRejection0500";
      try {
        let flag1: boolean = false;
        let flag2: boolean = false;
        let UnhandledRejectionObserver1: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver1 trigger; reason.message is: ' + reason.message);
            flag1 = true;
          }
        let UnhandledRejectionObserver2: errorManager.UnhandledRejectionObserver =
          (reason: Error, promise: Promise<void>) => {
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.name is: ' + reason.name);
            console.info(LOG_TAG + 'UnhandledRejectionObserver2 trigger; reason.message is: ' + reason.message);
            flag2 = true;
          }

        errorManager.on('unhandledRejection', UnhandledRejectionObserver1);
        errorManager.on('unhandledRejection', UnhandledRejectionObserver2);
        errorManager.off('unhandledRejection')
        createPromise();
        await sleep(3000);
        expect(flag1).assertFalse();
        expect(flag2).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `>observer1 error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}