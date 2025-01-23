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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError, systemDateTime } from '@kit.BasicServicesKit';
import process from '@ohos.process';

const waitReadyMs_1000 = 1000;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function systemDateTimeTest() {
  describe('systemDateTimeTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {

      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTime_Func_0100
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTime_Func_0100
     * @tc.desc   : set systemDateTime getTime without parameter
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTime_Func_0100', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let systemTime = systemDateTime.getTime();
      let DataTime = new Date();
      let actualTime = DataTime.getTime();
      let timeDifference = Math.abs(systemTime - actualTime);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimeFalse_Func_0200
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimeFalse_Func_0200
     * @tc.desc   : Set the systemDateTime getTime parameter to false
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTimeFalse_Func_0200', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let systemTime: number = systemDateTime.getTime(false);
      let DataTime = new Date();
      let actualTime = DataTime.getTime();
      let timeDifference = Math.abs(systemTime - actualTime);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimeNull_Func_0300
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimeNull_Func_0300
     * @tc.desc   : Set the systemDateTime getTime parameter to null
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getTimeNull_Func_0300', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let systemTime = systemDateTime.getTime(null)
      let DataTime = new Date();
      let actualTime = DataTime.getTime();
      let timeDifference = Math.abs(systemTime - actualTime);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimeUndefined_Func_0400
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimeUndefined_Func_0400
     * @tc.desc   : Set the systemDateTime getTime parameter to undefined
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getTimeUndefined_Func_0400', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let systemTime = systemDateTime.getTime(undefined);
      let DataTime = new Date();
      let actualTime = DataTime.getTime();
      let timeDifference = Math.abs(systemTime - actualTime);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimeTure_Func_0500
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimeTure_Func_0500
     * @tc.desc   : Set the systemDateTime getTime parameter to true
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTimeTure_Func_0500', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let systemTime = systemDateTime.getTime(true) / 1000000
      let DataTime = new Date();
      let actualTime = DataTime.getTime();
      let timeDifference = Math.abs(systemTime - actualTime);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeNull_Func_0100
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeNull_Func_0100
     * @tc.desc   : Set the systemDateTime getUptime parameter to null
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeNull_Func_0100', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(null);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeUndefined_Func_0200
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeUndefined_Func_0200
     * @tc.desc   : Set the systemDateTime getUptime parameter to undefined
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeUndefined_Func_0200', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(undefined);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeNullAndTure_Func_0300
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeNullAndTure_Func_0300
     * @tc.desc   : Set the systemDateTime getUptime parameter to null and true
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeNullAndTure_Func_0300', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(null, true);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeNullAndFalse_Func_0400
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeNullAndFalse_Func_0400
     * @tc.desc   : Set the systemDateTime getUptime parameter to null and false
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeNullAndFalse_Func_0400', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(null, false);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeNullAndNull_Func_0500
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeNullAndNull_Func_0500
     * @tc.desc   : Set the systemDateTime getUptime parameter to null and null
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeNullAndNull_Func_0500', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(null, null);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401)
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeNullAndUndefined_Func_0600
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeNullAndUndefined_Func_0600
     * @tc.desc   : Set the systemDateTime getUptime parameter to null and undefined
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeNullAndUndefined_Func_0600', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(null, undefined);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndTure_Func_0700
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndTure_Func_0700
     * @tc.desc   : Set the systemDateTime getUptime parameter to undefined and true
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndTure_Func_0700', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(undefined, true);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndFalse_Func_0800
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndFalse_Func_0800
     * @tc.desc   : Set the systemDateTime getUptime parameter to undefined and false
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndFalse_Func_0800', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(undefined, false);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndNull_Func_0900
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndNull_Func_0900
     * @tc.desc   : Set the systemDateTime getUptime parameter to undefined and null
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeUndefinedAndNull_Func_0900', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(undefined, null);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_Array_constructor_Func_1000
     * @tc.name   : ACTS_ARKUIX_Array_constructor_Func_1000
     * @tc.desc   : Set the systemDateTime getUptime parameter to undefined and undefined
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_Array_constructor_Func_1000', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        systemDateTime.getUptime(undefined, undefined);
        throw new Error;
      } catch (error) {
        expect(error.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeACTIVE_Func_1100
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeACTIVE_Func_1100
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.ACTIVE
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeACTIVE_Func_1100', 0, async (done: Function) => {
      let zeroMs = 0;
      await sleep(waitReadyMs_1000);
      let time = process.uptime() * 1000;
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE);
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference >= zeroMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndFalse_Func_1200
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndFalse_Func_1200
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.ACTIVE and false
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndFalse_Func_1200', 0, async (done: Function) => {
      let zeroMs = 0;
      await sleep(waitReadyMs_1000);
      let time = process.uptime() * 1000;
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, false);
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference >= zeroMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndTure_Func_1300
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndTure_Func_1300
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.ACTIVE and true
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndTure_Func_1300', 0, async (done: Function) => {
      let zeroMs = 0;
      await sleep(waitReadyMs_1000);
      let time = process.uptime() * 1000;
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference >= zeroMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndNull_Func_1400
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndNull_Func_1400
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.ACTIVE and null
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndNull_Func_1400', 0, async (done: Function) => {
      let zeroMs = 0;
      await sleep(waitReadyMs_1000);
      let time = process.uptime() * 1000;
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, null);
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference >= zeroMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndUndefined_Func_1500
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndUndefined_Func_1500
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.ACTIVE and undefined
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeACTIVEAndUndefined_Func_1500', 0, async (done: Function) => {
      let zeroMs = 0;
      await sleep(waitReadyMs_1000);
      let time = process.uptime() * 1000;
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, undefined);
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference >= zeroMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUP_Func_1600
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUP_Func_1600
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.STARTUP
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeSTARTUP_Func_1600', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let time = process.uptime();
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.STARTUP) / 1000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndFalse_Func_1700
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndFalse_Func_1700
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.STARTUP and false
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndFalse_Func_1700', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let time = process.uptime();
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.STARTUP, false) / 1000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndTure_Func_1800
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndTure_Func_1800
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.STARTUP and true
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndTure_Func_1800', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let time = process.uptime();
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.STARTUP, true) / 1000000000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndNull_Func_1900
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndNull_Func_1900
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.STARTUP and null
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndNull_Func_1900', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let time = process.uptime();
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.STARTUP, null) / 1000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndUndefined_Func_2000
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndUndefined_Func_2000
     * @tc.desc   : Set the systemDateTime getUptime parameter to TimeType.STARTUP and undefined
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getUptimeSTARTUPAndUndefined_Func_2000', 0, async (done: Function) => {
      let oneThousandMs = 1000;
      await sleep(waitReadyMs_1000);
      let time = process.uptime();
      let time1 = systemDateTime.getUptime(systemDateTime.TimeType.STARTUP, undefined) / 1000;
      let timeDifference = Math.abs(time - time1);
      expect(timeDifference <= oneThousandMs).assertTrue();
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimezone_callback_Func_0100
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimezone_callback_Func_0100
     * @tc.desc   : Set the systemDateTime getTimezone callback
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTimezone_callback_Func_0100', 0, async (done: Function) => {
      let timezone: string;
      await sleep(waitReadyMs_1000);
      systemDateTime.getTimezone((error: BusinessError, data: string) => {
        if (error) {
          console.info(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
          expect().assertFail();
          done();
        }
        timezone = data;
        console.info(`Succeeded in get timezone : ${data}`);
        expect(!!timezone).assertTrue();
        done();
      });
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimezone_Promise_Func_0200
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimezone_Promise_Func_0200
     * @tc.desc   : Set the systemDateTime getTimezone Promise
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTimezone_Promise_Func_0200', 0, async (done: Function) => {
      let timezone: string;
      await sleep(waitReadyMs_1000);
      systemDateTime.getTimezone().then((data: string) => {
        timezone = data;
        console.info(`Succeeded in getting timezone: ${data}`);
        expect(!!timezone).assertTrue();
      }).catch((error: BusinessError) => {
        console.info(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
        expect().assertFail();
      });
      done();
    })

    /**
     * @tc.number : ACTS_ARKUIX_systemDateTime_getTimezoneSync_Func_0100
     * @tc.name   : ACTS_ARKUIX_systemDateTime_getTimezoneSync_Func_0100
     * @tc.desc   : Set the systemDateTime getTimezoneSync
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_systemDateTime_getTimezoneSync_Func_0100', 0, async (done: Function) => {
      try {
        await sleep(waitReadyMs_1000);
        let timezone = systemDateTime.getTimezoneSync();
        expect(!!timezone).assertTrue();
      } catch (e) {
        let error = e as BusinessError;
        console.info(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
        expect().assertFail();
      }
      done();
    })

  })
}