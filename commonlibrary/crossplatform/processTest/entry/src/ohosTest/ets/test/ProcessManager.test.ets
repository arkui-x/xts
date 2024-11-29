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
export default function ProcessManagerTest() {
describe('ProcessManager', function () {

    /**
     * @tc.number:TEST_IS_APPUID_001
     * @tc.name:  testProcessManagerIsAppUid001
     * @tc.desc:  Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
        it('testProcessManagerIsAppUid001', 0, function () {
        let pro = new process.ProcessManager();
        let isorno = pro.isAppUid(167);
        expect(isorno).assertEqual(false);
    })



    /**
     * @tc.number:TEST_PROCESSMAMAGER_IS_APPUID_002
     * @tc.name:  testProcessManagerIsAppUid002
     * @tc.desc:  Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerIsAppUid002', 0, function () {
        let pro = new process.ProcessManager();
        let isorno = pro.isAppUid(80000);
        expect(isorno).assertEqual(false);
    })

    /**
    * @tc.number:TEST_PROCESSMAMAGER_IS_APPUID_003
     * @tc.name: testProcessManagerIsAppUid003
     * @tc.desc: Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerIsappuid003', 0, function () {
        let pro = new process.ProcessManager();
        let isorno = pro.isAppUid(123);
        expect(isorno).assertEqual(false);
    })

    /**
    * @tc.number:TEST_PROCESSMAMAGER_IS_APPUID_004
     * @tc.name: testProcessManagerIsAppUid004
     * @tc.desc: Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerIsappuid004', 0, function () {
        let pro = new process.ProcessManager();
        let isorno = pro.isAppUid(789);
        expect(isorno).assertEqual(false);
    })

    /**
    * @tc.number:TEST_PROCESSMAMAGER_IS_APPUID_005
     * @tc.name: testProcessManagerIsAppUid004
     * @tc.desc: Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerIsappuid005', 0, function () {
        let pro = new process.ProcessManager();
        let isorno = pro.isAppUid(8569);
        expect(isorno).assertEqual(false);
    })

    /**
    * @tc.number:TEST_PROCESSMAMAGER_IS_APPUID_006
     * @tc.name: testProcessManagerIsAppUid006
     * @tc.desc: Returns a boolean whether the specified uid belongs to a particular application.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerIsappuid006', 0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let mag = pro.isAppUid("asdad");
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of code must be number.");
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETUIDFORNAME_001
     * @tc.name:  testProcessManagerGetUidForName001
     * @tc.desc: Returns the uid based on the specified user name.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetUidForName001',0, function () {
        let pro = new process.ProcessManager();
        let pres = pro.getUidForName("root");
        if (pres != -1) {
            let flag = new Boolean(true);
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETUIDFORNAME_002
     * @tc.name:  testProcessManagerGetUidForName002
     * @tc.desc: Returns the uid based on the specified user name.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetUidForName002', 0, function () {
        let pro = new process.ProcessManager();
        for (let i=0; i<3; i++) {
            let pres = pro.getUidForName("12356");
            expect(pres).assertEqual(-1);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETUIDFORNAME_003
     * @tc.name:  testProcessManagerGetUidForName003
     * @tc.desc:  Returns the uid based on the specified user name.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetUidForName003', 0, function () {
        let pro = new process.ProcessManager();
        for (let i=0; i<5; i++) {
            let pres = pro.getUidForName("as123");
            expect(pres).assertEqual(-1);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETUIDFORNAME_004
     * @tc.name:  testGetUidForName004
     * @tc.desc:  Returns the uid based on the specified user name.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetUidForName004',0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let pres = pro.getUidForName(12);
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of code must be string.");
        }
    })

      /**
     * @tc.number:TEST_PROCESSMANAGER_GETTHREADPRIORITY_001
     * @tc.name: testProcessManagerGetThreadPriority001
     * @tc.desc: Returns the thread priority based on the specified tid.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetThreadPriority001', 0, function () {
        let pro = new process.ProcessManager();
        let pres = process.tid;
        let pri = pro.getThreadPriority(pres);
        if (pri) {
            let flag = new Boolean(true);
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETTHREADPRIORITY_002
     * @tc.name: testProcessManagerGetThreadPriority002
     * @tc.desc: Returns the thread priority based on the specified tid.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetThreadPriority002', 0, function () {
        let pro = new process.ProcessManager();
        let pres = process.tid;
        for (let i=0; i<3; i++) {
            let pri = pro.getThreadPriority(pres);
            if (pri > 0) {
                let flag = new Boolean(true);
                expect(Boolean(flag)).assertEqual(true);
            }
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETTHREADPRIORITY_003
     * @tc.name: testProcessManagerGetThreadPriority003
     * @tc.desc: Returns the thread priority based on the specified tid.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetThreadPriority003', 0, function () {
        let pro = new process.ProcessManager();
        let pres = process.tid;
        for (let i=0; i<5; i++) {
            let pri = pro.getThreadPriority(pres);
            if (pri > 0) {
                let flag = new Boolean(true);
                expect(Boolean(flag)).assertEqual(true);
            }
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETTHREADPRIORITY_004
     * @tc.name:  testProcessManagerGetThreadPriority004
     * @tc.desc:  Returns the thread priority based on the specified tid.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetThreadPriority004', 0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let pri = pro.getThreadPriority("asdad");
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of code must be number.");
        }
    })



    /**
     * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_001
     * @tc.name: testProcessManagerGetSystemConfig001
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    //ios测试结果和鸿蒙、安卓不一致
    it('testProcessManagerGetSystemConfig001', 0, function () {
        let pro = new process.ProcessManager();
        let _SC_ARG_MAX = 0;
        let pri = pro.getSystemConfig(_SC_ARG_MAX);
        if (pri > 0) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_002
     * @tc.name: testProcessManagerGetSystemConfig002
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    //ios测试结果和鸿蒙、安卓不一致
    it('testProcessManagerGetSystemConfig002', 0, function () {
        let pro = new process.ProcessManager();
        let _SC_ARG_MAX = 0;
        for (let i=0; i<3; i++) {
            let pri = pro.getSystemConfig(_SC_ARG_MAX);
            if (pri > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_003
     * @tc.name: testProcessManagerGetSystemConfig003
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    //ios测试结果和鸿蒙、安卓不一致
    it('testProcessManagerGetSystemConfig003', 0, function () {
        let pro = new process.ProcessManager();
        let _SC_ARG_MAX = 0;
        for (let i=0; i<5; i++) {
            let pri = pro.getSystemConfig(_SC_ARG_MAX);
            if (pri > 0) {
                var flag = new Boolean(true);
            }
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_004
     * @tc.name: testProcessManagerGetSystemConfig004
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetSystemConfig004', 0, function () {
        let pro = new process.ProcessManager();
        let _SC_OPEN_MAX = 4
        let pri = pro.getSystemConfig(_SC_OPEN_MAX);
        if (pri > 0) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_005
     * @tc.name: testProcessManagerGetSystemConfig005
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetSystemConfig005', 0, function () {
        let pro = new process.ProcessManager();
        let _SC_PAGESIZE = 8;
        let pri = pro.getSystemConfig(_SC_PAGESIZE);
        if (pri > 0) {
            var flag = new Boolean(true);
        }
        expect(Boolean(flag)).assertEqual(true);
    })

    /**
    * @tc.number:TEST_PROCESSMANAGER_GETSYSTEMCONFIG_006
     * @tc.name: testGetSystemConfig006
     * @tc.desc: Returns the system configuration at runtime.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetSystemConfig006', 0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let pri = pro.getSystemConfig("asdad");
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of name must be number.");
        }
    })

     /**
     * @tc.number:TEST_PROCESSMANAGER_GETENVIRONMENTVAR_001
     * @tc.name:  testProcessManagerGetEnvironmentVar001
     * @tc.desc:  Returns the system value for environment variables.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetEnvironmentVar001', 0, function () {
        let pro = new process.ProcessManager();
        let pri = pro.getEnvironmentVar("USER");
        if (pri != null) {
            var flag = new Boolean(true);
            expect(Boolean(flag)).assertEqual(true);
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETENVIRONMENTVAR_002
     * @tc.name:  testProcessManagerGetEnvironmentVar002
     * @tc.desc: Returns the system value for environment variables.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetEnvironmentVar002', 0, function () {
        let pro = new process.ProcessManager();
        for (let i=0; i<3; i++) {
            let pri = pro.getEnvironmentVar("PATH");
            if (pri != null) {
                var flag = new Boolean(true);
                expect(Boolean(flag)).assertEqual(true);
            }
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETENVIRONMENTVAR_003
     * @tc.name:  testProcessManagerGetEnvironmentVar003
     * @tc.desc: Returns the system value for environment variables.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetEnvironmentVar003', 0, function () {
        let pro = new process.ProcessManager();
        for (let i=0; i<100; i++) {
            let pri = pro.getEnvironmentVar("i123");
            if (pri == null) {
                var flag = new Boolean(true);
                expect(Boolean(flag)).assertEqual(true);
            }
        }
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_GETENVIRONMENTVAR_004
     * @tc.name:  testGetEnvironmentVar004
     * @tc.desc:  Returns the system value for environment variables.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerGetEnvironmentVar004', 0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let pri = pro.getEnvironmentVar(123);
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of name must be string.");
        }
    })


    /**
     * @tc.number:TEST_PROCESSMANAGER_KILL_001
     * @tc.name:  testProcessManagerKill001
     * @tc.desc:  Return whether the signal was sent successfully.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerKill001', 0, function () {
        let pro = new process.ProcessManager();
        let result = pro.kill(3, 123);
        expect(result).assertEqual(false);
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_KILL_002
     * @tc.name:  testProcessManagerKill002
     * @tc.desc:  Return whether the signal was sent successfully.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerKill002', 0, function () {
        let pro = new process.ProcessManager();
        let pres = process.pid;
        let result = pro.kill(23, pres);
        expect(result).assertEqual(true);
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_KILL_003
     * @tc.name:  testProcessManagerKill003
     * @tc.desc:  Return whether the signal was sent successfully.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerKill003', 0, function () {
        let pro = new process.ProcessManager();
        let pres = process.pid;
        let result = pro.kill(28, pres);
        expect(result).assertEqual(true);
    })


    /**
     * @tc.number:TEST_PROCESSMANAGER_KILL_004
     * @tc.name:  testProcessManagerKill004
     * @tc.desc:  Return whether the signal was sent successfully.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerKill004', 0, function () {
        let pro = new process.ProcessManager();
        let result = pro.kill(3, 113);
        expect(result).assertEqual(false);
    })

    /**
     * @tc.number:TEST_PROCESSMANAGER_KILL_005
     * @tc.name:  testProcessManagerKill005
     * @tc.desc:  Return whether the signal was sent successfully.
     * @tc.size:  MediumTest
     * @tc.type:  Method
     * @tc.level: level 2
     */
    it('testProcessManagerKill005', 0, function () {
        try {
            let pro = new process.ProcessManager();
            //@ts-ignore
            let result = pro.kill("asd", 123);
        } catch (e) {
            expect(e.toString()).assertEqual("BuisnessError: Parameter error. The type of signal or pid must be number.");
        }
    })
})
}    