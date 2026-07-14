/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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
import CommonEventManager from '@ohos.commonEventManager';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

async function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function CommonEventManagerTest() {
  let bundle_name: string = "com.example.testcommoneventmanager"
  const SUBSCRIPTION_READY_DELAY = 2000;
  const LONG_STRING_LENGTH = 10000;
  const INT_MAX = 2147483647;

  describe('CommonEventManagerTest', () => {

    beforeEach(async () => {
      await sleep(300);
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0100
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0100
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with normal parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0100', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_001';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_001', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0100 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0100 SUCCESS');
          expect(result.bundleName).assertEqual('com.example.testcommoneventmanager')
          expect(result.code).assertEqual(0)
          expect(result.data).assertEqual('initial_data')
          expect(result?.parameters?.['key1']).assertEqual('parameters_0100')
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          code: 0,
          data: "initial_data",
          bundleName: bundle_name,
          parameters: {
            'key1': 'parameters_0100'
          }
        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0100  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0100 publish SUCCESS');
              expect(publish_data.bundleName).assertEqual('com.example.testcommoneventmanager')
              expect(publish_data.code).assertEqual(0)
              expect(publish_data.data).assertEqual('initial_data')
              expect(publish_data?.parameters?.['key1']).assertEqual('parameters_0100')
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0100 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0100 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0200
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0200
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData with undefined parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0200', 2, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      const EVENT_NAME: string = 'cross.app.custom.event'
      let CommonEventPublishData: CommonEventManager.CommonEventPublishData = {
        code: 0,
        data: undefined,
        bundleName: undefined,
        parameters: undefined
      }
      await sleep(SUBSCRIPTION_READY_DELAY)
      try {
        CommonEventManager.publish(EVENT_NAME, CommonEventPublishData, (err: BusinessError | null) => {
          if (err) {
            console.log('ARKUIX_SUB_Notification_CommonEventMgr_0200 publish err msg: ' + err.message + 'err code: ' +
              err.code);
            expect(err.code).assertEqual(401)
            done()
          } else {
            console.log('ARKUIX_SUB_Notification_CommonEventMgr_0200 publish success, bundleName: ' +
              CommonEventPublishData?.bundleName + ' code: ' + CommonEventPublishData?.code + ' data: ' +
              CommonEventPublishData?.data + ' parameters: ' + JSON.stringify(CommonEventPublishData?.parameters));
            expect(false).assertTrue();
            done()
          }
        })
      } catch (error) {
        console.log('ARKUIX_SUB_Notification_CommonEventMgr_0200 Step 2 FAIL: createSubscriber error msg: ' +
          JSON.stringify(error));
        expect(error.code).assertEqual(401)
        done()
      }
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0300
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0300
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData CommonEventData with null and boolean type parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0300', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_002';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_002', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0300 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0300 SUCCESS');
          expect(result.data).assertEqual('')
          expect(result.parameters).assertDeepEquals({ '': '', 'key': null, 'key1': true, })
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          bundleName: bundle_name,
          data: '',
          parameters: { '': '', 'key': null, 'key1': true, }

        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0300  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0300 publish SUCCESS');
              expect(publish_data.data).assertEqual('')
              expect(publish_data.parameters).assertDeepEquals({ '': '', 'key': null, 'key1': true })
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0300 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0300 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0400
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0400
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with special characters in parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0400', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_003';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_003', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0400 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0400 SUCCESS');
          expect(result.data).assertEqual('!@#$%^&*()')
          expect(result?.parameters?.['!@#$%^&*()']).assertEqual('!@#$%^&*()')
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          data: "!@#$%^&*()",
          bundleName: bundle_name,
          parameters: { '!@#$%^&*()': '!@#$%^&*()' }

        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0400  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0400 publish SUCCESS');
              expect(publish_data.data).assertEqual('!@#$%^&*()')
              expect(publish_data?.parameters?.['!@#$%^&*()']).assertEqual('!@#$%^&*()')
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0400 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0400 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0500
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0500
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with large data in parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0500', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_004';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_004', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0500 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0500 SUCCESS');
          expect(result.code).assertEqual(INT_MAX)
          expect(result.data).assertEqual('1234890')
          expect(result.parameters?.['key1']).assertEqual(1234890)
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          code: INT_MAX,
          data: "1234890",
          bundleName: bundle_name,
          parameters: {
            'key1': 1234890
          }
        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0500  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0500 publish SUCCESS');
              expect(publish_data.code).assertEqual(INT_MAX)
              expect(publish_data.data).assertEqual('1234890')
              expect(publish_data.parameters?.['key1']).assertEqual(1234890)
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0500 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0500 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })


    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0600
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0600
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with long string type parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0600', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_005';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_005', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0600 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0600 SUCCESS');
          expect(result.data).assertEqual('x'.repeat(LONG_STRING_LENGTH))
          expect(result?.parameters?.['key']).assertEqual('x'.repeat(LONG_STRING_LENGTH))
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          data: 'x'.repeat(LONG_STRING_LENGTH),
          bundleName: bundle_name,
          parameters: { 'key': 'x'.repeat(LONG_STRING_LENGTH) }
        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0600  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0600 publish SUCCESS');
              expect(publish_data.data).assertEqual('x'.repeat(LONG_STRING_LENGTH))
              expect(publish_data?.parameters?.['key']).assertEqual('x'.repeat(LONG_STRING_LENGTH))
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0600 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0600 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })


    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0700
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0700
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with negative number type parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0700', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_006';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_006', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0700 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0700 SUCCESS');
          expect(result.code).assertEqual(-1)
          expect(result.data).assertEqual('initial_data')
          expect(result?.parameters?.['key1']).assertEqual('value')
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          code: -1,
          data: "initial_data",
          bundleName: bundle_name,
          parameters: { 'key1': 'value' }
        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0700  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0700 publish SUCCESS');
              expect(publish_data.code).assertEqual(-1)
              expect(publish_data.data).assertEqual('initial_data')
              expect(publish_data?.parameters?.['key1']).assertEqual('value')
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0700 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0700 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: ARKUIX_SUB_Notification_CommonEventMgr_0800
     * @tc.name  : ARKUIX_SUB_Notification_CommonEventMgr_0800
     * @tc.desc  : Test CommonEventManager.CommonEventPublishData and CommonEventManager.CommonEventData with various type parameters
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */

    it('ARKUIX_SUB_Notification_CommonEventMgr_0800', 1, async (done: Function) => {
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        const EVENT: string = 'PUBLISH_MY_EVENT_007';
        const subscriberInfo: CommonEventManager.CommonEventSubscribeInfo = {
          events: ['SUBSCRIBE_MY_EVENT_007', EVENT]
        };
        const subscriber: CommonEventManager.CommonEventSubscriber =
          await CommonEventManager.createSubscriber(subscriberInfo);
        CommonEventManager.subscribe(subscriber, (error: BusinessError, result: CommonEventManager.CommonEventData) => {
          if (error) {
            console.log(`subscribe callback error: ${error.code} ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0800 SUBSCRIBE CALLBACK, COMMON EVENT DATA: ${JSON.stringify(result)}`);
          console.log('ARKUIX_SUB_Notification_CommonEventMgr_0800 SUCCESS');
          expect(result.code).assertEqual(99999)
          expect(result.data).assertEqual('stress_test_data')
          expect(result.parameters)
            .assertDeepEquals({
              k1: 'v1',
              k2: 2,
              k3: true,
              k4: null
            })
          done();
        });
        await sleep(SUBSCRIPTION_READY_DELAY);
        const publish_data: CommonEventManager.CommonEventPublishData = {
          code: 99999,
          data: "stress_test_data",
          bundleName: bundle_name,
          parameters: {
            k1: 'v1',
            k2: 2,
            k3: true,
            k4: null
          }
        }
        try {
          CommonEventManager.publish(EVENT, publish_data, (error: BusinessError) => {
            if (error) {
              console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0800  error msg: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.log('ARKUIX_SUB_Notification_CommonEventMgr_0800 publish SUCCESS');
              expect(publish_data.code).assertEqual(99999)
              expect(publish_data.data).assertEqual('stress_test_data')
              expect(publish_data.parameters)
                .assertDeepEquals({
                  k1: 'v1',
                  k2: 2,
                  k3: true,
                  k4: null
                })
            }
          })
        } catch (error) {
          console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0800 publish catch error msg: ${error.message}, code: ${error.code}`);
          expect(false).assertTrue();
          done();
        }
      } catch (e) {
        console.log(`ARKUIX_SUB_Notification_CommonEventMgr_0800 catch error msg: ${e.message}, code: ${e.code}`);
        expect(false).assertTrue();
        done();
      }
    })
  })
}