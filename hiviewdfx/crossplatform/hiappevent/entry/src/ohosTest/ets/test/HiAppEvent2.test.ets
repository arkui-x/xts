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

import hilog from '@ohos.hilog'
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium'
import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HiAppEvent2() {
  describe('HiAppEvent2Test', () => {
    let parameter_params: Record<string, string | number | boolean | Array<string> | Array<number> | Array<boolean>> =
      {};
    let promise_parameter_params: Record<string, string | number | boolean | Array<string> | Array<number> | Array<boolean>> =
      {};
    beforeEach(async () => {
      await sleep(2000);
    })
    afterEach(() => {
      hiAppEvent.removeWatcher({
        name: "writeTest"
      })
      hiAppEvent.clearData();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0100
     * @tc.name testHiAppEventWriteCallback0100
     * @tc.desc Verify that the callback method is used as the write asynchronous callback
     *          and that all parameters are valid values
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0200
     * @tc.name testHiAppEventWriteCallback0200
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the domain parameter set to the normal value 'appLaunchDomain'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "appLaunchDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'appLaunchDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("appLaunchDomain");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0300
     * @tc.name testHiAppEventWriteCallback0300
     * @tc.desc Verify that callback is used as write for the asynchronous callback, with domain
     *          set to normal 'app_launch_domain_01'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback0300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "app_launch_domain_01",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'app_launch_domain_01',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain("app_launch_domain_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0400
     * @tc.name testHiAppEventWriteCallback0400
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and
     *          the domain parameter is set to the outlier '123456'.
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback0400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0400";
      try {
        hiAppEvent.write({
          domain: '123456',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101001).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0500
     * @tc.name testHiAppEventWriteCallback0500
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the domain parameter set to the outlier 'appLaunchDomain_'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback0500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0500";
      try {
        hiAppEvent.write({
          domain: 'appLaunchDomain_',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101001).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0600
     * @tc.name testHiAppEventWriteCallback0600
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the domain parameter is set to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback0600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0600";
      try {
        hiAppEvent.write({
          domain: 'aa!@#$%&bb',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101001).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0700
     * @tc.name testHiAppEventWriteCallback0700
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the domain parameter is set to an outlier''.
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback0700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0700";
      try {
        hiAppEvent.write({
          domain: '',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101001).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0800
     * @tc.name testHiAppEventWriteCallback0800
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the domain parameter is set to the normal value: long string (32 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback0800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain("a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_0900
     * @tc.name testHiAppEventWriteCallback0900
     * @tc.desc Verify that the callback method is used as the write asynchronous callback, and
     *          the domain parameter is set to an outlier: a very long string (more than 32 bits)
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback0900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback0900";
      try {
        hiAppEvent.write({
          domain: 'overa1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101001).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1000
     * @tc.name testHiAppEventWriteCallback1000
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, with
     *          the name parameter set to the normal value 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback1000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'appLaunchDomainTest',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("appLaunchDomainTest");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1100
     * @tc.name testHiAppEventWriteCallback1100
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, with
     *          the name parameter set to the normal value 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback1100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'app_launch_domain_test_01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("app_launch_domain_test_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1200
     * @tc.name testHiAppEventWriteCallback1200
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the name parameter set to the normal value '$app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback1200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: '$app_launch_domain_test_01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("$app_launch_domain_test_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1300
     * @tc.name testHiAppEventWriteCallback1300
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the parameter name set to the outlier '123456'.
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback1300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1300";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: '123456',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101002).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1400
     * @tc.name testHiAppEventWriteCallback1400
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the parameter name set to the outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback1400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1400";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'appLaunchDomainTest_',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101002).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1500
     * @tc.name testHiAppEventWriteCallback1500
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the name parameter set to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback1500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1500";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'aa!@#$%&bb',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101002).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1600
     * @tc.name testHiAppEventWriteCallback1600
     * @tc.desc Verify that the callback method is used as the write for the asynchronous callback,
     *          with the parameter name set to the outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback1600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1600"
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: '',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101002).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1700
     * @tc.name testHiAppEventWriteCallback1700
     * @tc.desc Verify the use of callback method as asynchronous callback for write,
     *          with parameter name set to normal value: long string (48 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback1700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1700"
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let longstr: string = '';
      for (let i = 0; i < 48; i++) {
        longstr += 'a';
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: longstr,
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain(longstr);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1800
     * @tc.name testHiAppEventWriteCallback1800
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          and the parameter name is set to the exception value: a very long string (more than 48 bits).
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback1800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1800";
      let overstr: string = '';
      for (let i = 0; i < 50; i++) {
        overstr += 'a';
      }
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: overstr,
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101002).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_1900
     * @tc.name testHiAppEventWriteCallback1900
     * @tc.desc Validation using callback methods as the write of asynchronous callback,
     *          eventType parameters set to normal hiAppEvent. EventType. FAULT
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback1900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback1900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.FAULT]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.FAULT,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain('1');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2000
     * @tc.name testHiAppEventWriteCallback2000
     * @tc.desc Validation using callback methods as the write of asynchronous callback,
     *          eventType parameters set to normal hiAppEvent. EventType. STATISTIC
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback2000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.STATISTIC]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.STATISTIC,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("2");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2100
     * @tc.name testHiAppEventWriteCallback2100
     * @tc.desc Validation using callback methods as the write of asynchronous callback,
     *          eventType parameters set to normal hiAppEvent. EventType. SECURITY
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback2100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.SECURITY]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.SECURITY,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("3");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2200
     * @tc.name testHiAppEventWriteCallback2200
     * @tc.desc Validation using callback methods as the write of asynchronous callback,
     *          eventType parameters set to normal hiAppEvent. EventType. Behaviors
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback2200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("4");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2300
     * @tc.name testHiAppEventWriteCallback2300
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          with the eventType parameter set to the outlier 0
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback2300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2300";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: 0,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
        })
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect(err.code == 401).assertTrue();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2400
     * @tc.name testHiAppEventWriteCallback2400
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          with the eventType parameter set to outlier -1
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback2400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2400";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: -1,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
        })
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect(err.code == 401).assertTrue();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2500
     * @tc.name testHiAppEventWriteCallback2500
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and
     *          the params parameter sets the key to the normal value 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback2500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appLaunchDomainTest': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2600
     * @tc.name testHiAppEventWriteCallback2600
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the params parameter sets the key to the normal value 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback2600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'app_launch_domain_test_01': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect((JSON.parse(JSON.stringify(params)) as object)?.["app_launch_domain_test_01"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2700
     * @tc.name testHiAppEventWriteCallback2700
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          with the params parameter set to the key outlier '123456'.
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback2700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2700";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            '123456': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101005).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2800
     * @tc.name testHiAppEventWriteCallback2800
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and
     *          the params parameter sets the key to the outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback2800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2800";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appLaunchDomainTest_': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
              expect(err.code == 11101005).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_2900
     * @tc.name testHiAppEventWriteCallback2900
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback, and
     *          the params parameter sets the key to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback2900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback2900";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'aa!@#$%&bb': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101005).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3000
     * @tc.name testHiAppEventWriteCallback3000
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          and the params parameter sets the key to the outlier''.
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback3000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3000";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            '': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101005).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3100
     * @tc.name testHiAppEventWriteCallback3100
     * @tc.desc Validation using callback methods as the write of asynchronous callback, params
     *          setting the key parameters for normal 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3200
     * @tc.name testHiAppEventWriteCallback3200
     * @tc.desc Validation using callback methods as the write of asynchronous callback, params
     *          setting the key parameters for outliers'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback3200', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3200";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101005).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3300
     * @tc.name testHiAppEventWriteCallback3300
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          and the params parameter is set to the normal value 'Abc123!@#_'
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 'Abc123!@#_'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]).assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3400
     * @tc.name testHiAppEventWriteCallback3400
     * @tc.desc Verify that the callback mode is used as the write of the asynchronous callback, and
     *          the params parameter is set to a normal value of 8 x 1024 characters
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let temp: string = ''
      for (let i = 0; i < 8 * 1024; i++) {
        temp += 'a'
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': temp
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]).assertContain(temp);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3500
     * @tc.name testHiAppEventWriteCallback3500
     * @tc.desc Verify that the callback mode is used as the write of the asynchronous callback, and
     *          the params parameter is set to a value exceeding 8 x 1024 characters
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback3500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3500";
      let temp: string = ''
      for (let i = 0; i < 8 * 1025; i++) {
        temp += 'b'
      }
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': temp
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101004).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3600
     * @tc.name testHiAppEventWriteCallback3600
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and
     *          the parameter params is set to a normal value namber type 0
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 0
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(0));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3700
     * @tc.name testHiAppEventWriteCallback3700
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback, and
     *          the params parameter is set to a normal value namber type 123
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 123
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(123));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3800
     * @tc.name testHiAppEventWriteCallback3800
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, with the
     *          params parameter setting the value to the normal value of Number.MIN_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MIN_SAFE_INTEGER
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_3900
     * @tc.name testHiAppEventWriteCallback3900
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and the
     *          params parameter is set to the normal value of Number.MAX_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback3900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback3900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MAX_SAFE_INTEGER
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4000
     * @tc.name testHiAppEventWriteCallback4000
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, with
     *          the params parameter setting value to the outlier Number.MIN_SAFE_INTEGER-1
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback4000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MIN_SAFE_INTEGER - 1
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER - 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4100
     * @tc.name testHiAppEventWriteCallback4100
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the params parameter is set to the value of the outlier Number.MAX_SAFE_INTEGER + 1
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback4100', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MAX_SAFE_INTEGER + 1
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER + 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4200
     * @tc.name testHiAppEventWriteCallback4200
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the params parameter sets value to an outlier of type boolean true
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback4200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': true
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(true));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4300
     * @tc.name testHiAppEventWriteCallback4300
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback,
     *          and the params parameter sets value to an outlier of type boolean false
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback4300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': false
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(false));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4400
     * @tc.name testHiAppEventWriteCallback4400
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback,
     *          and the params parameter sets the value to the outlier Array<string> type
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback4400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4400";
      let temp: string = ''
      for (let i = 0; i < 8 * 1025; i++) {
        temp += 'b'
      }
      let array: Array<string> = ['Abc123!@#_', temp]
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }, (err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          expect(err.code == 11101004).assertTrue();
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4500
     * @tc.name testHiAppEventWriteCallback4500
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and the
     *          params parameter sets the value to the normal Array<number> type
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback4500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [0, 123, Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER]
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([0, 123,
            Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4600
     * @tc.name testHiAppEventWriteCallback4600
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback, and the
     *          params parameter is set to an outlier Array<number> type [123, Number.MIN_SAFE_INTEGER - 1]
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback4600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [123, Number.MIN_SAFE_INTEGER - 1]
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success')
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([123,
            Number.MIN_SAFE_INTEGER - 1]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4700
     * @tc.name testHiAppEventWriteCallback4700
     * @tc.desc Verify that the callback method is used as the write of the asynchronous callback, and
     *          the params parameter is set to an outlier Array<string> type [123, Number.MAX_SAFE_INTEGER + 1]
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback4700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [123, Number.MAX_SAFE_INTEGER + 1]
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([123,
            Number.MAX_SAFE_INTEGER + 1]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4800
     * @tc.name testHiAppEventWriteCallback4800
     * @tc.desc Verify that the callback method is used as write for the asynchronous callback, and
     *          the params parameter sets the value to a normal Array<boolean> type
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback4800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [true, true, false, false]
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([true, true, false, false]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_4900
     * @tc.name testHiAppEventWriteCallback4900
     * @tc.desc Verify that the callback method is used as the write asynchronous callback. Parameter
     *          params sets the value to a normal value. Array: Number of array elements 100
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback4900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback4900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let array: Array<number> = []
      for (let i = 0; i < 100; i++) {
        array[i] = i
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(array));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_5000
     * @tc.name testHiAppEventWriteCallback5000
     * @tc.desc Verify that the callback mode is used as the write of the asynchronous callback.
     *          Parameter params is set to an outlier. Array: indicates that the number of array elements exceeds 100
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback5000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback5000";
      let array: Array<number> = []
      for (let i = 0; i < 101; i++) {
        array[i] = i
      }
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
              expect(err.code == 11101006).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_5100
     * @tc.name testHiAppEventWriteCallback5100
     * @tc.desc Verify that the callback method is used as write for the asynchronous
     *          callback, and the parameter params is set to a custom parameter name constant
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback5100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback5100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      parameter_params[hiAppEvent.param.USER_ID] = 'USER_ID'
      parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME] = 'DISTRIBUTED_SERVICE_NAME'
      parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID] = 'DISTRIBUTED_SERVICE_INSTANCE_ID'
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: parameter_params
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.USER_ID])
          .assertContain('USER_ID');
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME])
          .assertContain('DISTRIBUTED_SERVICE_NAME');
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID])
          .assertContain('DISTRIBUTED_SERVICE_INSTANCE_ID');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_5200
     * @tc.name testHiAppEventWriteCallback5200
     * @tc.desc Verify that the callback mode is used as the write of the asynchronous
     *          callback, and the parameter params is set to 32 parameters
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback5200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback5200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      parameter_params = {}
      for (let i = 0; i < 32; i++) {
        parameter_params[`key${i + 1}`] = i + 1
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: parameter_params
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        for (let i = 0; i < 32; i++) {
          expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.[`key${i + 1}`]))
            .assertContain(JSON.stringify(i + 1));
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_5300
     * @tc.name testHiAppEventWriteCallback5300
     * @tc.desc Verify that the callback mode is used as the write of the asynchronous
     *          callback, and the parameter params is set to a maximum of 32 parameters
     * @tc.level Level2
     */
    it('testHiAppEventWriteCallback5300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback5300";
      parameter_params = {}
      for (let i = 0; i < 33; i++) {
        parameter_params[`key${i + 1}`] = i + 1
      }
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: parameter_params
        }, (err: BusinessError) => {
          try {
            if (err) {
              console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
              expect(err.code == 11101003).assertTrue();
            } else {
              console.info(LOG_TAG + 'call write with Callback success');
              expect().assertFail();
            }
          } catch (err) {
            console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
            expect().assertFail();
          }
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_callback_5400
     * @tc.name testHiAppEventWriteCallback5400
     * @tc.desc Validate write using callback mode as asynchronous callback, repeatedly
     *          calling write write event (same parameters)
     * @tc.level Level0
     */
    it('testHiAppEventWriteCallback5400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWriteCallback5400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0100
     * @tc.name testHiAppEventWritePromise0100
     * @tc.desc Verify that write uses Promise mode as an asynchronous callback, with all parameters being normal
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success')
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0200
     * @tc.name testHiAppEventWritePromise0200
     * @tc.desc Validate write using Promise mode as asynchronous callback with domain set to normal 'appLaunchDomain'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "appLaunchDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'appLaunchDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Callback success')
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("appLaunchDomain");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0300
     * @tc.name testHiAppEventWritePromise0300
     * @tc.desc Validate write using Promise mode as asynchronous callback with domain
     *          set to normal 'app_launch_domain_01'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise0300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "app_launch_domain_01",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'app_launch_domain_01',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Callback success')
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("app_launch_domain_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0400
     * @tc.name testHiAppEventWritePromise0400
     * @tc.desc Validate write using Promise mode as asynchronous callback with domain set to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise0400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0400";
      try {
        await hiAppEvent.write({
          domain: '123456',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0500
     * @tc.name testHiAppEventWritePromise0500
     * @tc.desc Validate write using Promise mode as asynchronous callback with the
     *          domain parameter set to outlier 'appLaunchDomain_'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise0500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0500";
      try {
        await hiAppEvent.write({
          domain: 'appLaunchDomain_',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0600
     * @tc.name testHiAppEventWritePromise0600
     * @tc.desc Validate write using Promise mode as an asynchronous callback with
     *          the domain parameter set to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise0600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0600";
      try {
        await hiAppEvent.write({
          domain: 'aa!@#$%&bb',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0700
     * @tc.name testHiAppEventWritePromise0700
     * @tc.desc Validate write using Promise mode as asynchronous callback with
     *          domain set to outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise0700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0700";
      try {
        await hiAppEvent.write({
          domain: '',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0800
     * @tc.name testHiAppEventWritePromise0800
     * @tc.desc Validate write using Promise mode as asynchronous callback with domain
     *          set to normal length string (32 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise0800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain("a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_0900
     * @tc.name testHiAppEventWritePromise0900
     * @tc.desc Validate write using Promise mode as an asynchronous callback, with
     *          domain set to an outlier extra-long string (more than 32 bits)
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise0900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise0900"
      try {
        await hiAppEvent.write({
          domain: 'overa1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1000
     * @tc.name testHiAppEventWritePromise1000
     * @tc.desc Validate write using Promise mode as asynchronous callback with name set to normal 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise1000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'appLaunchDomainTest',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("appLaunchDomainTest");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1100
     * @tc.name testHiAppEventWritePromise1100
     * @tc.desc Verify the write of the asynchronous callback using Promise mode, with
     *          the name parameter set to normal 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise1100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'app_launch_domain_test_01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("app_launch_domain_test_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1200
     * @tc.name testHiAppEventWritePromise1200
     * @tc.desc Verify write using Promise mode as asynchronous callback, with the name
     *          parameter set to normal '$app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise1200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: '$app_launch_domain_test_01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("$app_launch_domain_test_01");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1300
     * @tc.name testHiAppEventWritePromise1300
     * @tc.desc Validate write using Promise mode as asynchronous callback with parameter name set to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise1300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1300";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: '123456',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101002).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1400
     * @tc.name testHiAppEventWritePromise1400
     * @tc.desc Validate write using Promise mode as asynchronous callback with the
     *          parameter name set to outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise1400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1400";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'appLaunchDomainTest_',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101002).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1500
     * @tc.name testHiAppEventWritePromise1500
     * @tc.desc Verify write using Promise mode as an asynchronous callback, with the
     *          parameter name set to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise1500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1500";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'aa!@#$%&bb',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101002).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1600
     * @tc.name testHiAppEventWritePromise1600
     * @tc.desc Validate write using Promise mode as an asynchronous callback with
     *          the parameter name set to an outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise1600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1600";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: '',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101002).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1700
     * @tc.name testHiAppEventWritePromise1700
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter
     *          name set to normal length string (48 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise1700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let longstr: string = '';
      for (let i = 0; i < 48; i++) {
        longstr += 'a';
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: longstr,
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain(longstr);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1800
     * @tc.name testHiAppEventWritePromise1800
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter name
     *          set to normal value Extra-long string (more than 48 bits)
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise1800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1800";
      let overstr: string = '';
      for (let i = 0; i < 50; i++) {
        overstr += 'a';
      }
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: overstr,
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101002).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_1900
     * @tc.name testHiAppEventWritePromise1900
     * @tc.desc Validation as an asynchronous callback write with a Promise, the eventType
     *          parameters set to normal hiAppEvent. EventType. FAULT
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise1900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise1900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.FAULT]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.FAULT,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2000
     * @tc.name testHiAppEventWritePromise2000
     * @tc.desc Validation as an asynchronous callback write with a Promise, the eventType
     *          parameters set to normal hiAppEvent. EventType. STATISTIC
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise2000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.STATISTIC]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.STATISTIC,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("2");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2100
     * @tc.name testHiAppEventWritePromise2100
     * @tc.desc Validation as an asynchronous callback write with a Promise, the eventType
     *          parameters set to normal hiAppEvent. EventType. SECURITY
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise2100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.SECURITY]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.SECURITY,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("3");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2200
     * @tc.name testHiAppEventWritePromise2200
     * @tc.desc Validation as an asynchronous callback write with a Promise, the eventType
     *          parameters set to normal hiAppEvent. EventType. Behaviors
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise2200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain("4");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2300
     * @tc.name testHiAppEventWritePromise2300
     * @tc.desc Verify that the Promise mode is used as write for the asynchronous callback,
     *          with the eventType parameter set to the outlier 0
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise2300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2300";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: 0,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect().assertFail();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2400
     * @tc.name testHiAppEventWritePromise2400
     * @tc.desc Verify that the Promise mode is used as write for the asynchronous callback,
     *          with the eventType parameter set to outlier -1
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise2400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2400";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: -1,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect().assertFail();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2500
     * @tc.name testHiAppEventWritePromise2500
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter params
     *          sets key to normal 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise2500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appLaunchDomainTest': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2600
     * @tc.name testHiAppEventWritePromise2600
     * @tc.desc Verify that the Promise mode is used for write of the asynchronous callback, and
     *          the params parameter sets the key to the normal value 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise2600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'app_launch_domain_test_01': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["app_launch_domain_test_01"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2700
     * @tc.name testHiAppEventWritePromise2700
     * @tc.desc Validate write using Promise mode as asynchronous callback,
     *          parameter params sets key to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise2700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2700";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            '123456': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101005).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2800
     * @tc.name testHiAppEventWritePromise2800
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter
     *          params sets key to outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise2800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2800";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appLaunchDomainTest_': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101005).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_2900
     * @tc.name testHiAppEventWritePromise2900
     * @tc.desc Verify that the Promise mode is used as the write of the asynchronous
     *          callback, and the params parameter sets the key to the outlier 'aa!@#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise2900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise2900";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'aa!@#$%&bb': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101005).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3000
     * @tc.name testHiAppEventWritePromise3000
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter
     *          params sets key to outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise3000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3000";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            '': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101005).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3100
     * @tc.name testHiAppEventWritePromise3100
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter
     *          params set to key normal value string (32 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3200
     * @tc.name testHiAppEventWritePromise3200
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter params
     *          set key to outlier Very long string (more than 32 bits)
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise3200', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3200";
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101005).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3300
     * @tc.name testHiAppEventWritePromise3300
     * @tc.desc Verify that the Promise mode is used as the write of the asynchronous callback, and
     *          the params parameter sets the value to the normal value'Abc123!@#_'
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 'Abc123!@#_'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]).assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3400
     * @tc.name testHiAppEventWritePromise3400
     * @tc.desc Verify that write uses Promise mode as an asynchronous callback, and the params
     *          parameter sets the value to a normal value of 8*1024 characters
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let temp: string = ''
      for (let i = 0; i < 8 * 1024; i++) {
        temp += 'a'
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': temp
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]).assertContain(temp);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3500
     * @tc.name testHiAppEventWritePromise3500
     * @tc.desc Verify write using Promise mode as asynchronous callback, parameter params set
     *          value to outlier greater than 8*1024 characters
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise3500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3500";
      let temp: string = ''
      for (let i = 0; i < 8 * 1025; i++) {
        temp += 'b'
      }
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': temp
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101004).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3600
     * @tc.name testHiAppEventWritePromise3600
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter params
     *          sets value to normal number type 0
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 0
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(0));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3700
     * @tc.name testHiAppEventWritePromise3700
     * @tc.desc Verify that the Promise mode is used as write for the asynchronous callback, and the
     *          params parameter sets value to the normal number type 123
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': 123
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(123));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3800
     * @tc.name testHiAppEventWritePromise3800
     * @tc.desc Verify that the Promise mode is used as write for the asynchronous callback, and
     *          the params parameter sets value to the normal value of Number.MIN_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MIN_SAFE_INTEGER
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_3900
     * @tc.name testHiAppEventWritePromise3900
     * @tc.desc Verify that the Promise mode is used as write for the asynchronous callback, and the
     *          params parameter sets value to the normal value of Number.MAX_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise3900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise3900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MAX_SAFE_INTEGER
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4000
     * @tc.name testHiAppEventWritePromise4000
     * @tc.desc Verify that Promise mode is used as write for asynchronous callback, and the params
     *          parameter sets value to the outlierNumber.MIN_SAFE_INTEGER - 1
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise4000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MIN_SAFE_INTEGER - 1
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER - 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4100
     * @tc.name testHiAppEventWritePromise4100
     * @tc.desc Verify that Promise mode is used as write for asynchronous callback, and the params
     *          parameter sets value to the outlierNumber.MAX_SAFE_INTEGER + 1
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise4100', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': Number.MAX_SAFE_INTEGER + 1
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER + 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4200
     * @tc.name testHiAppEventWritePromise4200
     * @tc.desc Validate write using Promise mode as asynchronous callback, parameter params sets
     *          value to a normal value boolean type true
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise4200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': true
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(true));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4300
     * @tc.name testHiAppEventWritePromise4300
     * @tc.desc Validate write using Promise mode as an asynchronous callback, and the params parameter
     *          sets value to a normal value of boolean type false
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise4300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': false
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(false));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4400
     * @tc.name testHiAppEventWritePromise4400
     * @tc.desc Validate write using Promise mode as an asynchronous callback, and the params parameter
     *          sets value to an Array of type outliers Array<string>
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise4400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let temp: string = ''
      for (let i = 0; i < 8 * 1025; i++) {
        temp += 'b'
      }
      let array: Array<string> = ['Abc123!@#_', temp]
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101004).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4500
     * @tc.name testHiAppEventWritePromise4500
     * @tc.desc Validate write using Promise mode as an asynchronous callback, and the params parameter
     *          sets value to a normal Array of type Array<number>
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise4500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [0, 123, Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER]
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([0, 123,
            Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4600
     * @tc.name testHiAppEventWritePromise4600
     * @tc.desc Validate write using Promise mode as an asynchronous callback, and the params parameter
     *          sets value to an outlier Array<number> type
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise4600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [123, Number.MIN_SAFE_INTEGER - 1]
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([123,
            Number.MIN_SAFE_INTEGER - 1]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4700
     * @tc.name testHiAppEventWritePromise4700
     * @tc.desc Validate write using Promise mode as an asynchronous callback, and the params parameter
     *          sets value to an outlier Array<string> type
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise4700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [123, Number.MAX_SAFE_INTEGER + 1]
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([123,
            Number.MAX_SAFE_INTEGER + 1]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4800
     * @tc.name testHiAppEventWritePromise4800
     * @tc.desc Validate write that uses Promise mode as an asynchronous callback, and the domain parameter
     *          sets value to a normal Array<boolean> array of type
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise4800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': [true, true, false, false]
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify([true, true, false, false]));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_4900
     * @tc.name testHiAppEventWritePromise4900
     * @tc.desc Verify that write uses Promise mode as an asynchronous callback, and the params parameter
     *          sets the value to a normal value Array: number of array elements 100
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise4900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise4900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      let array: Array<number> = []
      for (let i = 0; i < 100; i++) {
        array[i] = i
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appDomainTest"]))
          .assertContain(JSON.stringify(array));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_5000
     * @tc.name testHiAppEventWritePromise5000
     * @tc.desc Verify that a Promise is used as the write of the asynchronous callback, and the params
     *          parameter sets the value to an outlier Array: The number of array elements exceeds 100
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise5000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise5000";
      let array: Array<number> = []
      for (let i = 0; i < 101; i++) {
        array[i] = i
      }
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'appDomainTest': array
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101006).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_5100
     * @tc.name testHiAppEventWritePromise5100
     * @tc.desc Validation uses Promise mode as write for asynchronous callback, and parameter params is set
     *          to a custom parameter name constant
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise5100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise5100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      hiAppEvent.clearData();
      promise_parameter_params[hiAppEvent.param.USER_ID] = 'USER_ID'
      promise_parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME] = 'DISTRIBUTED_SERVICE_NAME'
      promise_parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID] = 'DISTRIBUTED_SERVICE_INSTANCE_ID'
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: promise_parameter_params
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.USER_ID])
          .assertContain('USER_ID');
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME])
          .assertContain('DISTRIBUTED_SERVICE_NAME');
        expect((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID])
          .assertContain('DISTRIBUTED_SERVICE_INSTANCE_ID');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_5200
     * @tc.name testHiAppEventWritePromise5200
     * @tc.desc Verify that the write of the asynchronous callback uses Promise mode and the params parameter is
     *          set to 32 parameters
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise5200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise5200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      parameter_params = {}
      for (let i = 0; i < 32; i++) {
        parameter_params[`key${i + 1}`] = i + 1
      }
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: parameter_params
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        for (let i = 0; i < 32; i++) {
          expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.[`key${i + 1}`]))
            .assertContain(JSON.stringify(i + 1));
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_5300
     * @tc.name testHiAppEventWritePromise5300
     * @tc.desc Verify that Promise mode is used as write for asynchronous callback, and parameter params is set
     *          to more than 32 parameters
     * @tc.level Level2
     */
    it('testHiAppEventWritePromise5300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise5300";
      parameter_params = {}
      for (let i = 0; i < 33; i++) {
        parameter_params[`key${i + 1}`] = i + 1
      }
      try {
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: parameter_params
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101003).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`)
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_write_Promise_5400
     * @tc.name testHiAppEventWritePromise5400
     * @tc.desc Validate write using Promise mode as an asynchronous callback, repeatedly calling write write
     *          events (same parameters)
     * @tc.level Level0
     */
    it('testHiAppEventWritePromise5500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWritePromise5500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: "defaultDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            for (const eventGroup of appEventGroups) {
              hilog.info(0x0000, 'hiAppEvent', `eventName=${eventGroup.name}`);
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        })
        await hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams'
          }
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        })
        await sleep(3000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"]
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

  })
}