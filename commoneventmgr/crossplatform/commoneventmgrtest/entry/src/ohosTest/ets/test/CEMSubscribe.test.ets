/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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

import CommonEventManager from '@ohos.commonEventManager';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import { publishEvent, publishEventWithoutOpt, sleep } from '../utils/index';

export default function commonEventMgrSubscribeTest() {
  describe('commonEventMgrSubscribeTest', () => {
    console.log('====>################################commonEventMgr.subscribe Test start*************');

    /**
     * beforeAll: PreCommonEventMgrSubscribeTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(() => {
      console.info("====>beforeAll: PreCommonEventMgrSubscribeTest are executed.");
    });

    /**
     * beforeEach: PreCommonEventMgrSubscribeTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(() => {
      console.info("====>beforeEach: PreCommonEventMgrSubscribeTest is executed.");
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(() => {
      console.info("====>afterEach: Test case-level clearance conditions is executed.");
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(() => {
      console.info("====>afterAll: Test suite-level cleanup condition is executed");
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Subscribe_Func_0100
     * @tc.name  : SUB_Notification_Common_Event_Manager_Subscribe_Func_0100
     * @tc.desc  : Test CommonEventManager.subscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Subscribe_Func_0100', 0, async (done: Function) => {
      try {
        const EVENT: string = 'SUBSCRIBE_MY_EVENT_001';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          const event: string = result.event;
          expect(event).assertEqual(EVENT);
          console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0100 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('SUB_Notification_Common_Event_Manager_Subscribe_Func_0100 SUCCESS');
          done();
        });
        await sleep();
        publishEventWithoutOpt(EVENT, done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0100 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Subscribe_Func_0200
     * @tc.name  : SUB_Notification_Common_Event_Manager_Subscribe_Func_0200
     * @tc.desc  : Test CommonEventManager.subscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Subscribe_Func_0200', 0, async (done: Function) => {
      try {
        const EVENT: string = 'SUBSCRIBE_MY_EVENT_002';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          const event: string = result.event;
          const result_data: string | undefined = result.data;
          expect(event).assertEqual(EVENT);
          expect(result_data).assertEqual('test');
          console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0200 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('SUB_Notification_Common_Event_Manager_Subscribe_Func_0200 SUCCESS');
          done();
        });
        await sleep();
        const publish_data: CommonEventManager.CommonEventPublishData = {
          data: 'test'
        };
        publishEvent(EVENT, publish_data, done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0200 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Subscribe_Func_0300
     * @tc.name  : SUB_Notification_Common_Event_Manager_Subscribe_Func_0300
     * @tc.desc  : Test CommonEventManager.subscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Subscribe_Func_0300', 0, async (done: Function) => {
      try {
        const EVENT: string = 'SUBSCRIBE_MY_EVENT_009';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_008', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          const event: string = result.event;
          const result_data: string | undefined = result.data;
          expect(event).assertEqual(EVENT);
          expect(result_data).assertEqual('MY_EVENT');
          console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0300 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('SUB_Notification_Common_Event_Manager_Subscribe_Func_0300 SUCCESS');
          done();
        });
        await sleep();
        const publish_data: CommonEventManager.CommonEventPublishData = {
          data: 'MY_EVENT'
        };
        publishEvent(EVENT, publish_data, done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0300 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Subscribe_Func_0400
     * @tc.name  : SUB_Notification_Common_Event_Manager_Subscribe_Func_0400
     * @tc.desc  : Test CommonEventManager.subscribe in callback mode throw 401 code
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Subscribe_Func_0400', 0, async (done: Function) => {
      try {
        CommonEventManager.subscribe(null, (error: BusinessError, data: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0400 error msg: ${error.message}, error code: ${error.code}`);
            expect(false).assertTrue();
            done();
          } else {
            console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0400 SUCCESS, ${JSON.stringify(data)}`);
            expect(null !== data).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Subscribe_Func_0400 catch error msg: ${e.message}, code: ${e.code}`);
        expect(e.code).assertEqual(401);
        done();
      }
    });
  });
}