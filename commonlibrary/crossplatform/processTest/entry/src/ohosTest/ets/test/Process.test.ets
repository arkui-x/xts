/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect} from '@ohos/hypium'
import process from '@ohos.process'
export default function ProcessTest() {
describe('ProcessTest', function () {

    function delay(duration) {
        return new Promise(resolve => setTimeout(resolve, duration));
    }

    /**
     * @tc.number:TEST_Uid_001
     * @tc.name: testUid001
     * @tc.desc: returns the digital user id of the process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testUid001', 0, function () {
        let result = process.uid;
        if (result > 0) {
            var flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_Uid_002
     * @tc.name: testUid002
     * @tc.desc: returns the digital user id of the process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testUid002', 0, function () {
        for (let i = 0; i < 3; i++) {
            let result = process.uid;
            if (result != null) {
                if (result > 0) {
                    var flag = true;
                }
                expect(flag).assertEqual(true);
            }
        }
    })

    /**
    * @tc.number:TEST_Uid_003
     * @tc.name: testUid003
     * @tc.desc: returns the digital user id of the process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testUid003', 0, function () {
        for (let i = 0; i < 6; i++) {
            let result = process.uid;
            if (result != null) {
                if (result > 0) {
                    var flag = true;
                }
                expect(flag).assertEqual(true);
            }
        }
    })

    /**
    * @tc.number:TEST_Uid_004
     * @tc.name: testUid004
     * @tc.desc: returns the digital user id of the process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testUid004', 0, function () {
        for (let i = 0; i < 8; i++) {
            let result = process.uid;
            if (result != null) {
                if (result > 0) {
                    var flag = true;
                }
                expect(flag).assertEqual(true);
            }
        }
    })

    /**
    * @tc.number:TEST_Uid_005
     * @tc.name: testUid005
     * @tc.desc: returns the digital user id of the process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testUid005', 0, function () {
        for (let i = 0; i < 5; i++){
            let result = process.uid;
            if (result != null) {
                if (result > 0) {
                    var flag = true;
                }
                expect(flag).assertEqual(true);
            }
        }
    })


     /**
     * @tc.number:TEST_PID_001
     * @tc.name: testPid001
     * @tc.desc: Return pid is the pid of the current process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testPid001', 0, function () {
        let result = process.pid;
        if (result > 0) {
            var flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_PID_002
     * @tc.name: testPid002
     * @tc.desc: Return pid is the pid of the current process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testPid002', 0, function () {
        for (let i = 0; i < 3; i++) {
            let result = process.pid;
            if (result > 0) {
                var flag = true;
            }
            expect(flag).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_PID_003
     * @tc.name: testPid003
     * @tc.desc: Return pid is the pid of the current process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testPid003', 0, function () {
        for (let i = 0; i < 5; i++) {
            let result = process.pid;
            if (result > 0) {
                var flag = true;
            }
            expect(flag).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_PID_004
     * @tc.name: testPid004
     * @tc.desc: Return pid is the pid of the current process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testPid004', 0, function () {
        for (let i = 0; i < 6; i++) {
            let result = process.pid;
            if (result > 0) {
                var flag = true;
            }
            expect(flag).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_PID_005
     * @tc.name: testPid005
     * @tc.desc: Return pid is the pid of the current process.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testPid005', 0, function () {
        for (let i = 0; i < 8; i++) {
            let result = process.pid;
            if (result > 0) {
                var flag = true;
            }
            expect(flag).assertEqual(true);
        }
    })

     /**
     * @tc.number:TEST_TID_001
     * @tc.name: testTid001
     * @tc.desc: Returns the tid of the current thread.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testTid001', 0, function () {
        let pres = process.tid;
        if (pres > 0) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
    * @tc.number:TEST_TID_002
     * @tc.name: testTid002
     * @tc.desc: Returns the tid of the current thread.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testTid002', 0, function () {
        for (let i=0; i < 5; i++) {
            let pres = process.tid;
            if (pres > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_TID_003
     * @tc.name: testTid003
     * @tc.desc: Returns the tid of the current thread.
     * @tc.size:  MediumTest
     * @tc.type:  Constant
     * @tc.level: level 2
     */
    it('testTid003', 0, function () {
        for (let i=0; i < 3; i++) {
            let pres = process.tid;
            if (pres > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_IS64BIT_001
     * @tc.name: testIs64Bit001
     * @tc.desc: Returns a boolean whether the process is running in a 64-bit environment.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testIs64Bit001', 0, function () {
        let isorno = process.is64Bit();
        if (isorno) {
            expect(isorno).assertEqual(true);
        } else {
            expect(isorno).assertEqual(false);
        }
    })

    /**
    * @tc.number:TEST_IS64BIT_002
     * @tc.name: testIs64Bit002
     * @tc.desc: Returns a boolean whether the process is running in a 64-bit environment.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testIs64Bit002', 0, function () {
        for (let i=0; i<3; i++) {
            let isorno = process.is64Bit();
            if (isorno) {
                expect(isorno).assertEqual(true);
            } else {
            expect(isorno).assertEqual(false);
         }
        }
    })

    /**
    * @tc.number:TEST_IS64BIT_003
     * @tc.name: testIs64Bit003
     * @tc.desc: Returns a boolean whether the process is running in a 64-bit environment.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testIs64Bit003', 0, function () {
        for (let i=0; i<5; i++) {
            let isorno = process.is64Bit();
            if (isorno) {
                expect(isorno).assertEqual(true);
            } else {
            expect(isorno).assertEqual(false);
            }
        }
    })


    /**
    * @tc.number:TEST_GET_START_REALTIME_001
     * @tc.name: testGetStartRealtime001
     * @tc.desc: Returns the elapsed real time (in milliseconds) taken from the start of
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetStartRealtime001', 0, function () {
        for (let i=0; i<3; i++) {
            let pri = process.getStartRealtime();
            if (pri !== null) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_GET_START_REALTIME_002
     * @tc.name: testGetStartRealtime002
     * @tc.desc: Returns the elapsed real time (in milliseconds) taken from the start of
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetStartRealtime002', 0, function () {
        let pri = process.getStartRealtime();
        if (pri !== null) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
    * @tc.number:TEST_GET_START_REALTIME_003
     * @tc.name: testGetStartRealtime003
     * @tc.desc: Returns the elapsed real time (in milliseconds) taken from the start of
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetStartRealtime003', 0, function () {
        for (let i=0; i<5; i++) {
            let pri = process.getStartRealtime();
            if (pri !== null) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_GET_START_REALTIME_004
     * @tc.name: testGetStartRealtime004
     * @tc.desc: Returns the elapsed real time (in milliseconds)
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetStartRealtime004', 0, function () {
        for (let i=0; i<8; i++) {
            let pri = process.getStartRealtime();
            if (pri !== null) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }  
    })

    /**
    * @tc.number:TEST_GET_START_REALTIME_005
     * @tc.name: testGetStartRealtime005
     * @tc.desc: Returns the elapsed real time (in milliseconds) taken from the start of
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetStartRealtime005', 0, function () {
        for (let i=0; i<6; i++) {
            let pri = process.getStartRealtime();
            if (pri !== null) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })


      /**
     * @tc.number:TEST_GET_PAST_CPU_TIME_001
     * @tc.name: testGetpastCpuTime001
     * @tc.desc: Returns the cpu time (in milliseconds) from the time when the process starts to the current time.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetpastCpuTime001', 0, function () {
        for (let i=0; i<3; i++) {
            let pri = process.getPastCpuTime();
            if (pri > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_GET_PAST_CPU_TIME_002
     * @tc.name: testGetpastCpuTime002
     * @tc.desc: Returns the cpu time (in milliseconds) from the time when the process starts to the current time.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetpastCpuTime002', 0, function () {
        let pri = process.getPastCpuTime();
        if (pri > 0) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
    * @tc.number:TEST_GET_PAST_CPU_TIME_003
     * @tc.name: testGetpastCpuTime003
     * @tc.desc: Returns the cpu time (in milliseconds) from the time when the process starts to the current time.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetpastCpuTime003', 0, function () {
        for (let i=0; i<5; i++) {
            let pri = process.getPastCpuTime();
            if (pri > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
    * @tc.number:TEST_GET_PAST_CPU_TIME_004
     * @tc.name: testGetpastCpuTime004
     * @tc.desc: Returns the cpu time (in milliseconds) from the time when the process starts to the current time.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testGetpastCpuTime004', 0, function () {
        for (let i=0; i<8; i++) {
            let pri = process.getPastCpuTime();
            if (pri > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })


     /**
     * @tc.number:TEST_UPTIME_001
     * @tc.name: testUptime001
     * @tc.desc: Returns the running time of the system.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testUptime001', 0, function () {
        let result1 = process.uptime();
        function sleep(d){
            while(process.uptime() - result1 <= d);
        }
        sleep(3);
        let result2 = process.uptime();
        var flag = false;
        if ((result2 - result1) >= 3) {
            flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_UPTIME_002
     * @tc.name: testUptime002
     * @tc.desc: Returns the running time of the system.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testUptime002', 0, async function () {
        let result1 = process.uptime();
        await delay(4000);
        let result2 = process.uptime();
        var flag = false;
        if ((result2 - result1) >= 4) {
            flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_UPTIME_003
     * @tc.name: testUptime003
     * @tc.desc: Returns the running time of the system.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testUptime003', 0, async function () {
        let result1 = process.uptime();
        await delay(2000);
        let result2 = process.uptime();
        var flag = false;
        if ((result2 - result1) >= 2) {
            flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_UPTIME_004
     * @tc.name: testUptime004
     * @tc.desc: Returns the running time of the system.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testUptime004', 0, async function () {
        let result1 = process.uptime();
        await delay(3000);
        let result2 = process.uptime();
        var flag = false;
        if ((result2 - result1) >= 3) {
            flag = true;
        }
        expect(flag).assertEqual(true);
    })

    /**
    * @tc.number:TEST_UPTIME_005
     * @tc.name: testUptime005
     * @tc.desc: Returns the running time of the system.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testUptime005', 0, async function () {
        let result1 = process.uptime();
        await delay(2000);
        let result2 = process.uptime();
        var flag = false;
        if ((result2 - result1) >= 5) {
            flag = true;
        }
        expect(flag).assertEqual(false);
    })
})
}
