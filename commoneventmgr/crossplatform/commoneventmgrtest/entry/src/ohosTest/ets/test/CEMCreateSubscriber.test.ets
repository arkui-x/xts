/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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

import CommonEventManager from '@ohos.commonEventManager';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import { publishEvent, publishEventWithoutOpt, sleep } from '../utils';

export default function commonEventMgrCreateSubscriberTest() {
  describe('commonEventMgrCreateSubscriberTest', () => {
    console.log('====>################################commonEventMgr.createSubscriber Test start*************');

    /**
     * beforeAll: PreCommonEventMgrCreateSubscriberTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(() => {
      console.info("====>beforeAll: PreCommonEventMgrCreateSubscriberTest are executed.");
    });

    /**
     * beforeEach: PreCommonEventMgrCreateSubscriberTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      await sleep(200);
      console.info("====>beforeEach: PreCommonEventMgrCreateSubscriberTest is executed.");
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
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0100
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0100
     * @tc.desc  : Test CommonEventManager.createSubscriber in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0100', 0, async (done: Function) => {
      try {
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['MY_OWN_EVENT_001']
        };
        CommonEventManager.createSubscriber(subscriberInfo, async (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          const subscriberInfo_callback: CommonEventManager.CommonEventSubscribeInfo = await subscriber.getSubscribeInfo();
          expect(subscriberInfo_callback.events[0]).assertEqual('MY_OWN_EVENT_001');
          console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0100 SUCCESS');
          done();
        });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0100 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200
     * @tc.desc  : Test CommonEventManager.createSubscriber in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200', 0, async (done: Function) => {
      try {
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['MY_OWN_EVENT_002', 'MY_OWN_EVENT_003']
        };
        CommonEventManager.createSubscriber(subscriberInfo, async (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          const subscriber_priority_info: CommonEventManager.CommonEventSubscribeInfo = await subscriber.getSubscribeInfo();
          expect(subscriber_priority_info.events[0]).assertEqual('MY_OWN_EVENT_002');
          expect(subscriber_priority_info.events[1]).assertEqual('MY_OWN_EVENT_003');
          console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200 SUBSCRIBE INFO:' + JSON.stringify(subscriber_priority_info));
          console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200 SUCCESS');
          done();
        });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0200 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300
     * @tc.desc  : Test CommonEventManager.createSubscriber in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300', 0, async (done: Function) => {
      try {
        const subscriberInfo_003: CommonEventManager.CommonEventSubscribeInfo = {
          events: []
        };
        for (let i: number = 0; i < 5; i++) {
          subscriberInfo_003.events.push(`MY_OWN_EVENT_00${i + 4}`);
        }
        CommonEventManager.createSubscriber(subscriberInfo_003, async (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          const info: CommonEventManager.CommonEventSubscribeInfo = await subscriber.getSubscribeInfo();
          const flag: boolean = info.events.every((item: string) => item.includes('MY_OWN_EVENT'));
          expect(flag).assertTrue();
          console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300 SUCCESS');
          done();
        });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0400
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0400
     * @tc.desc  : Test CommonEventManager.createSubscriber in callback mode throw 401 code
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0400', 0, async (done: Function) => {
      try {
        CommonEventManager.createSubscriber(null, (error: BusinessError, commonEventSubscriber: CommonEventManager.CommonEventSubscriber) => {
          expect(commonEventSubscriber).not().assertNull();
          console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0400 SUCCESS, ' + JSON.stringify(commonEventSubscriber));
          done();
        });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0400 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500
     * @tc.desc  : Test CommonEventManager.createSubscriber in promise mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500', 0, async (done: Function) => {
      try {
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['MY_PROMISE_EVENT_001']
        };
        CommonEventManager.createSubscriber(subscriberInfo)
          .then(async (subscriber: CommonEventManager.CommonEventSubscriber) => {
            const info: CommonEventManager.CommonEventSubscribeInfo = await subscriber.getSubscribeInfo();
            expect(info.events[0]).assertEqual('MY_PROMISE_EVENT_001');
            console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500 SUCCESS');
            done();
          })
          .catch((error: BusinessError) => {
            console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500 createSubscriber error msg: ' + error.message + 'error code: ' + error.code);
            expect(false).assertTrue();
            done();
          });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0500 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0600
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0600
     * @tc.desc  : Test CommonEventManager.createSubscriber in promise mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0600', 0, async (done: Function) => {
      try {
        const subscriberInfo_1: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['MY_PROMISE_EVENT_002']
        };
        const subscriberInfo_2: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['MY_PROMISE_EVENT_003']
        };
        const subscriber_1: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo_1);
        const subscriber_2: CommonEventManager.CommonEventSubscriber = await CommonEventManager.createSubscriber(subscriberInfo_2);
        const info1: CommonEventManager.CommonEventSubscribeInfo = await subscriber_1.getSubscribeInfo();
        const info2: CommonEventManager.CommonEventSubscribeInfo = await subscriber_2.getSubscribeInfo();
        expect(info1.events[0]).assertEqual('MY_PROMISE_EVENT_002');
        expect(info2.events[0]).assertEqual('MY_PROMISE_EVENT_003');
        console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0600 SUCCESS');
        done();
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0600 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0700
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0700
     * @tc.desc  : Test CommonEventManager.createSubscriber in promise mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0700', 0, async (done: Function) => {
      try {
        const subscriberInfo_003: CommonEventManager.CommonEventSubscribeInfo = {
          events: []
        };
        for (let i: number = 0; i < 5; i++) {
          subscriberInfo_003.events.push(`MY_PROMISE_EVENT_00${i + 4}`);
        }
        CommonEventManager.createSubscriber(subscriberInfo_003)
          .then(async (subscriber: CommonEventManager.CommonEventSubscriber) => {
            const info: CommonEventManager.CommonEventSubscribeInfo = await subscriber.getSubscribeInfo();
            const flag: boolean = info.events.every((item: string) => item.includes('MY_PROMISE_EVENT'));
            expect(flag).assertTrue();
            console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0300 SUCCESS');
            done();
          })
          .catch((error: BusinessError) => {
            console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0700 createSubscriber error msg: ' + error.message + 'error code: ' + error.code);
            expect(false).assertTrue();
            done();
          });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0700 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800
     * @tc.name  : SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800
     * @tc.desc  : Test CommonEventManager.createSubscriber in promise mode throw 401 code
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800', 0, async (done: Function) => {
      try {
        CommonEventManager.createSubscriber(null)
          .then((commonEventSubscriber: CommonEventManager.CommonEventSubscriber) => {
            expect(commonEventSubscriber).not().assertNull();
            console.log('SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800 SUCCESS, ' + JSON.stringify(commonEventSubscriber));
            done();
          })
          .catch((error: BusinessError) => {
            console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800 createSubscriber error msg: ${error.message},error code: ${error.code}`);
            expect(error.code == 401).assertTrue();
            done();
          });
      } catch (e) {
        console.log(`SUB_Notification_CommonEventMgr_Create_Subscriber_Func_0800 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100
     * @tc.name  : SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100
     * @tc.desc  : Test CommonEventSubscriber.getSubscribeInfo in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100', 0, (done: Function) => {
      try {
        const event: string = 'SUBSCRIBE_INFO_EVENT_1';
        const subscribeInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [event]
        };
        CommonEventManager.createSubscriber(subscribeInfo, (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          subscriber.getSubscribeInfo((err: BusinessError, subInfo: CommonEventManager.CommonEventSubscribeInfo) => {
            const events: string[] = subInfo.events;
            expect(events).assertContain(event);
            console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100 getSubscribeInfo: ${JSON.stringify(subInfo)}`);
            done();
          });
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0200
     * @tc.name  : SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0200
     * @tc.desc  : Test CommonEventSubscriber.getSubscribeInfo in callback mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0200', 0, (done: Function) => {
      try {
        const event: string = 'SUBSCRIBE_INFO_EVENT_2';
        const subscribeInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [event]
        };
        CommonEventManager.createSubscriber(subscribeInfo, (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          subscriber.getSubscribeInfo((err: BusinessError, subInfo: CommonEventManager.CommonEventSubscribeInfo) => {
            const events: string[] = subInfo.events;
            expect(events).assertContain(event);
            console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0200 getSubscribeInfo: ${JSON.stringify(subInfo)}`);
            done();
          });
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0300
     * @tc.name  : SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0300
     * @tc.desc  : Test CommonEventSubscriber.getSubscribeInfo in promise mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0300', 0, (done: Function) => {
      try {
        const event: string = 'SUBSCRIBE_INFO_EVENT_3';
        const subscribeInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [event]
        };
        CommonEventManager.createSubscriber(subscribeInfo, (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          subscriber.getSubscribeInfo()
            .then((subInfo: CommonEventManager.CommonEventSubscribeInfo) => {
              const events: string[] = subInfo.events;
              expect(events).assertContain(event);
              console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0300 getSubscribeInfo: ${JSON.stringify(subInfo)}`);
              done();
            })
            .catch((err: BusinessError) => {
              console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0300 getSubscribeInfo error msg: ${err.message}, error code: ${err.code}`);
              expect(false).assertTrue();
              done();
            });
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number: SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0400
     * @tc.name  : SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0400
     * @tc.desc  : Test CommonEventSubscriber.getSubscribeInfo in promise mode
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0400', 0, (done: Function) => {
      try {
        const event: string = 'SUBSCRIBE_INFO_EVENT_4';
        const subscribeInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: [event]
        };
        CommonEventManager.createSubscriber(subscribeInfo, (error: BusinessError, subscriber: CommonEventManager.CommonEventSubscriber) => {
          subscriber.getSubscribeInfo()
            .then((subInfo: CommonEventManager.CommonEventSubscribeInfo) => {
              const events: string[] = subInfo.events;
              expect(events).assertContain(event);
              console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0400 getSubscribeInfo: ${JSON.stringify(subInfo)}`);
              done();
            })
            .catch((err: BusinessError) => {
              console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0400 getSubscribeInfo error msg: ${err.message}, error code: ${err.code}`);
              expect(false).assertTrue();
              done();
            });
        });
      } catch (e) {
        console.log(`SUB_Notification_Common_Event_Subscriber_Get_Subscribe_Info_Func_0100 catch error msg: ${e.message} ,error code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    });
  });
}