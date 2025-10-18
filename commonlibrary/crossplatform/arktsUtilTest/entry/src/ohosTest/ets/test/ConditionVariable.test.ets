/*
 * Copyright (c) 2025 SwanLink (Jiangsu) Technology Development Co., LTD.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { ArkTSUtils } from '@kit.ArkTS';
import taskpool from '@ohos.taskpool';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

@Concurrent
function threadWaitNotAwait(conditionVariable: ArkTSUtils.locks.ConditionVariable): boolean {
  console.log(`TaskPool Thread Wait: Waiting...`);
  conditionVariable.wait().then(() => {
    console.log(`TaskPool Thread Wait: Then continue...`);
  });
  console.log(`TaskPool Thread Wait: Notified and continuing...`);
  return true;
}

export default function ConditionVariableTest() {
  describe('ConditionVariableTest', () => {

    /**
     * @tc.number    : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_CONSTRUCTOR_0100
     * @tc.name      : testConditionVariableConstructor0001
     * @tc.desc      : check create wait thread
     * @tc.level     : Level 1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     */
    it('testConditionVariableConstructor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testConditionVariableConstructor0001";
        try {
          let lock: ArkTSUtils.locks.ConditionVariable = new ArkTSUtils.locks.ConditionVariable();
          expect(lock).assertNotNull();
          done()
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          done()
        }
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_REQUEST_0100
     * @tc.name       : testConditionVariableRequest0001
     * @tc.desc       : Test the Buffer interface includes request with input emoji \ud83d\ude0a.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testConditionVariableRequest0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testConditionVariableRequest0001';
      try {
        let lockName = '\ud83d\ude0a';
        let lock: ArkTSUtils.locks.AsyncLock = ArkTSUtils.locks.AsyncLock.request(lockName);
        expect(lock.name).assertNotNull();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_REQUEST_0200
     * @tc.name       : testConditionVariableRequest0002
     * @tc.desc       : Test the Buffer interface includes request with input emoji \ud83d\ude0a.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testConditionVariableRequest0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testConditionVariableRequest0002';
      try {
        let lockName = '\ud83e\udd3c\u200d\u2642\ufe0f';
        let lock: ArkTSUtils.locks.AsyncLock = ArkTSUtils.locks.AsyncLock.request(lockName);
        let lock2: ArkTSUtils.locks.AsyncLock = ArkTSUtils.locks.AsyncLock.request(lockName);
        expect(lock.name).assertEqual(lockName);
        expect(lock2.name).assertEqual(lockName);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_WAITFOR_0100
     * @tc.name      : testConditionVariableWaitFor0001
     * @tc.desc      : check create wait thread
     * @tc.level     : Level 1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     */
    it('testConditionVariableWaitFor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testConditionVariableWaitFor0001";
        try {
          let conditionVariable: ArkTSUtils.locks.ConditionVariable = new ArkTSUtils.locks.ConditionVariable();
          let time: number = 3000;
          let bool: boolean = false;
          setTimeout(() => {
            conditionVariable.notifyOne();
          }, 1000);
          await conditionVariable.waitFor(time).then(() => {
            bool = true;
          })
          expect(bool).assertEqual(true);
          done()
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_WAIT_0100
     * @tc.name      : testConditionVariableWait0001
     * @tc.desc      : check create wait thread
     * @tc.level     : Level 1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     */
    it('testConditionVariableWait0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const CASE: string = 'testConditionVariableWait0001';
      console.info(`${CASE} START`);
      try {
        let result = false;
        const conditionVariable: ArkTSUtils.locks.ConditionVariable = new ArkTSUtils.locks.ConditionVariable();
        await taskpool.execute(threadWaitNotAwait, conditionVariable).then((data) => {
          result = data as boolean;
        });
        expect(result).assertTrue();
      } catch (err) {
        console.error(`${CASE} error:` + err);
        expect().assertFail();
      }
      console.info(`${CASE} END`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_ARKTSUTILS_CONDITIONVARIABLE_NOTIFYALL_0100
     * @tc.name      : testConditionVariableNotifyAll0001
     * @tc.desc      : check notify use
     * @tc.level     : Level 1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     */
    it('testConditionVariableNotifyAll0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const CASE: string = 'testConditionVariableNotifyAll0001';
        console.info(`${CASE} START`);
        let cv = ArkTSUtils.locks.ConditionVariable.request(CASE);
        let count = 0;
        cv.wait().then(() => {
          ++count;
          cv.wait().then(() => {
            ++count;
            cv.wait().then(() => {
              ++count;
            })
          });
        })
        let id = setInterval(() => {
          cv.notifyAll();
        }, 100)
        while (count < 3) {
          await sleep(100);
        }
        clearInterval(id);
        expect(count).assertEqual(3);
        done();
      });
  })
}