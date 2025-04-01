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
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

export default function commonEventMgrUnsubscribeTest() {
  describe('commonEventMgrUnsubscribeTest', () => {
    console.log('====>################################commonEventMgr.unsubscribe Test start*************');

    /**
     * beforeAll: PreCommonEventMgrUnsubscribeTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(() => {
      console.info("====>beforeAll: PreCommonEventMgrUnsubscribeTest are executed.");
    });

    /**
     * beforeEach: PreCommonEventMgrUnsubscribeTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      await sleep(1000);
      console.info("====>beforeEach: PreCommonEventMgrUnsubscribeTest is executed.");
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
     * @tc.number: SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100
     * @tc.name  : SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100
     * @tc.desc  : Test CommonEventManager.unsubscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100', 0, async (done: Function) => {
      if (platform == 'iOS') {
        expect(true).assertTrue();
        done();
      }

      try {
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['UNSUBSCRIBE_MY_EVENT_001']
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, async (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100 SUBSCRIBE CALLBACK');
          const event: string = result.event;
          expect(event).assertEqual('UNSUBSCRIBE_MY_EVENT_001');
          console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100 SUBSCRIBE CALLBACK EVENT: ${event}`);
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100 UNSUBSCRIBE');
          CommonEventManager.unsubscribe(subscriber, (error: BusinessError) => {
            console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100 UNSUBSCRIBE CALLBACK');
          });
          await sleep();
          publishEventWithoutOpt('UNSUBSCRIBE_MY_EVENT_001', done);
          done();
        });
        await sleep();
        publishEventWithoutOpt('UNSUBSCRIBE_MY_EVENT_001', done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0100 catch error msg: ${e.message}, error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200
     * @tc.name  : SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200
     * @tc.desc  : Test CommonEventManager.unsubscribe in callback mode throw 401 code
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200', 0, async (done: Function) => {
      try {
        CommonEventManager.unsubscribe(null, (error: BusinessError) => {
          if (error) {
            console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200 error msg: ${error.message}, error code: ${error.code}`);
            expect(false).assertTrue();
            done();
          } else {
            console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200 SUCCESS');
            expect(error).assertNull();
            done();
          }
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0200 catch error msg: ${e.message}, error code: ${e.code}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300
     * @tc.name  : SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300
     * @tc.desc  : Test CommonEventManager.unsubscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300', 0, async (done: Function) => {
      try {
        const EVENTS: string[] = ['UNSUBSCRIBE_MY_EVENT_002', 'UNSUBSCRIBE_MY_EVENT_003'];
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: EVENTS
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, async (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300 SUBSCRIBE CALLBACK');
          const event: string = result.event;
          expect(EVENTS).assertContain(event);
          console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300 SUBSCRIBE CALLBACK EVENT: ${event}`);
        });
        publishEventWithoutOpt(EVENTS[0], done);
        await sleep();
        CommonEventManager.unsubscribe(subscriber, (error: BusinessError) => {
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300 UNSUBSCRIBE CALLBACK');
          sleep(4500).then(() => {
            expect(error).assertNull();
            done();
          });
        });
        publishEventWithoutOpt(EVENTS[1], done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0300 catch error msg: ${e.message}, error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400
     * @tc.name  : SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400
     * @tc.desc  : Test CommonEventManager.unsubscribe in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    /*IOS does not support the publish method and cannot publish custom events,
      which cannot be verified in the automated testing process of the test suite.
      （ios不支持publish方法，无法发布自定义事件，测试套自动化测试流程中无法验证）*/
    it('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400', 0, async (done: Function) => {
      try {
        const EVENT: string = 'UNSUBSCRIBE_MY_EVENT_004';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, async (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400 SUBSCRIBE CALLBACK');
          const event: string = result.event;
          expect(event).assertEqual(EVENT);
          console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400 SUBSCRIBE CALLBACK EVENT: ${event}`);
        });
        await sleep();
        CommonEventManager.unsubscribe(subscriber, (error: BusinessError) => {
          console.log('SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400 UNSUBSCRIBE CALLBACK');
          sleep(4500).then(() => {
            expect(error).assertNull();
            done();
          });
        });
        await sleep();
        publishEventWithoutOpt(EVENT, done);
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Manager_Unsubscribe_Func_0400 catch error msg: ${e.message}, error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });
  });
}