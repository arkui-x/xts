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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Size, Level, TestType } from '@ohos/hypium';
import { taskpool } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function TaskpoolStateTest() {
  describe('TaskpoolStateTest', () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_STATE_0100
     * @tc.name      : testTaskPoolState0001
     * @tc.desc      : Get taskPooL state
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskPoolState0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      console.info('testTaskPoolState0001 start')
      let taskState = taskpool.State.WAITING;
      console.log('testTaskPoolState0001 taskState: ' + taskState);
      expect(taskState).assertEqual(1);
      taskState = taskpool.State.RUNNING;
      console.log('testTaskPoolState0001 taskState: ' + taskState);
      expect(taskState).assertEqual(2);
      taskState = taskpool.State.CANCELED;
      console.log('testTaskPoolState0001 taskState: ' + taskState);
      expect(taskState).assertEqual(3);
      console.info('testTaskPoolState0001 end')
    });
  })
}