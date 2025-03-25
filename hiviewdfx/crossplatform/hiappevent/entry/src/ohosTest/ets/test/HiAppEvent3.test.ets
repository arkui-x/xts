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

export default function HiAppEvent3() {
  describe('HiAppEvent3Test', () => {
    let parameter_params: Record<string, hiAppEvent.ParamType> = {
      'defaultEventParams': 'defaultEventParams'
    };
    afterEach(() => {
      hiAppEvent.removeWatcher({
        name: "writeTest"
      })
      hiAppEvent.clearData();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0100
     * @tc.name testHiAppEventsetEventParam0100
     * @tc.desc Verify that setEventParam is valid
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
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
            'defaultEventParams': 'defaultEventParams2'
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
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0200
     * @tc.name testHiAppEventsetEventParam0200
     * @tc.desc Verify setEventParam and set domain to normal 'appLaunchDomain'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'appLaunchDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
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
            'defaultEventParams': 'defaultEventParams2'
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
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0300
     * @tc.name testHiAppEventsetEventParam0300
     * @tc.desc Validate setEventParam and set the domain parameter to normal 'app_launch_domain_01'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam0300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'app_launch_domain_01',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
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
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain("app_launch_domain_01");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0400
     * @tc.name testHiAppEventsetEventParam0400
     * @tc.desc Validate setEventParam and set parameter domain to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam0400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0400";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          '123456',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0500
     * @tc.name testHiAppEventsetEventParam0500
     * @tc.desc Validate setEventParam and set parameter domain to outlier 'appLaunchDomain_'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam0500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0500";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'appLaunchDomain_',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0600
     * @tc.name testHiAppEventsetEventParam0600
     * @tc.desc Verify setEventParam and set the domain parameter to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam0600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0600";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'aa!@#$%&bb',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0700
     * @tc.name testHiAppEventsetEventParam0700
     * @tc.desc Verify that the setEventParam parameter domain is an outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam0700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0700";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          '',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          expect(err.code == 11101001).assertTrue();
        })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0800
     * @tc.name testHiAppEventsetEventParam0800
     * @tc.desc Verify setEventParam and set the domain parameter to a normal length string (32 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam0800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let temp: string = '';
        for (let i = 0; i < 32; i++) {
          temp += 'a';
        }
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          temp,
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
        hiAppEvent.addWatcher({
          name: "writeTest",
          appEventFilters: [
            {
              domain: temp,
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
          domain: temp,
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain(temp);
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_0900
     * @tc.name testHiAppEventsetEventParam0900
     * @tc.desc Verify setEventParam and set the domain parameter to an outlier Very long string (more than 32 bits)
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam0900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam0900";
      try {
        let temp: string = '';
        for (let i = 0; i < 33; i++) {
          temp += 'b';
        }
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          temp,
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
            expect(err.code == 11101001).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1000
     * @tc.name testHiAppEventsetEventParam1000
     * @tc.desc Validate setEventParam, set parameter name to normal 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          'appLaunchDomainTest'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("appLaunchDomainTest");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1100
     * @tc.name testHiAppEventsetEventParam1100
     * @tc.desc Verify that the setEventParam parameter name is a healthy value 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          'app_launch_domain_test_01'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("app_launch_domain_test_01");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1200
     * @tc.name testHiAppEventsetEventParam1200
     * @tc.desc Verify that the setEventParam parameter name is a healthy value '$app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          '$app_launch_domain_test_01'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("$app_launch_domain_test_01");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1300
     * @tc.name testHiAppEventsetEventParam1300
     * @tc.desc Validate setEventParam, set parameter name to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam1300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1300";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'defaultDomain',
          '123456'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101002).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1400
     * @tc.name testHiAppEventsetEventParam1400
     * @tc.desc Validate setEventParam, set parameter name to outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam1400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1400";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'defaultDomain',
          'appLaunchDomainTest_'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101002).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1500
     * @tc.name testHiAppEventsetEventParam1500
     * @tc.desc Verify that the setEventParam parameter name is the outlier 'aa!@#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam1500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1500";
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'defaultDomain',
          'aa!@#$%&bb'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101002).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1600
     * @tc.name testHiAppEventsetEventParam1600
     * @tc.desc Verify setEventParam and set the parameter name to the normal value ''
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          ''
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          })
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
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"])
          .assertContain("app_launch_domain_test_01");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1700
     * @tc.name testHiAppEventsetEventParam1600
     * @tc.desc Verify setEventParam and set parameter name to a normal length string (48 bits)
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let temp: string = '';
        for (let i = 0; i < 48; i++) {
          temp += 'a';
        }
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams1'
          },
          'defaultDomain',
          temp
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message);
          })
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
          name: temp,
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'defaultEventParams': 'defaultEventParams2'
          }
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
          } else {
            console.info(LOG_TAG + 'call write with Callback success');
          }
        })
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain(temp);
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["defaultEventParams"])
          .assertContain("defaultEventParams1");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1800
     * @tc.name testHiAppEventsetEventParam1800
     * @tc.desc Verify that setEventParam parameter name is an outlier Very long string (more than 48 bits)
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam1800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1800";
      try {
        let temp: string = '';
        for (let i = 0; i < 49; i++) {
          temp += 'a';
        }
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'defaultDomain',
          temp
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101002).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_1900
     * @tc.name testHiAppEventsetEventParam1900
     * @tc.desc Validate setEventParam and set the key of parameter params to normal 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam1900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam1900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
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
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2000
     * @tc.name testHiAppEventsetEventParam2000
     * @tc.desc Validate setEventParam and set the key of parameter params to normal 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam2000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'app_launch_domain_test_01': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["app_launch_domain_test_01"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    }) /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2100
     * @tc.name testHiAppEventsetEventParam2100
     * @tc.desc Validate setEventParam and set the key of parameter params to a normal
     *          value '$app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam2100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            '$app_launch_domain_test_01': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["$app_launch_domain_test_01"])
          .assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2200
     * @tc.name testHiAppEventsetEventParam2200
     * @tc.desc Validate setEventParam and set the key of parameter params to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam2200', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2200";
      try {
        await hiAppEvent.setEventParam(
          {
            '123456': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101005).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2300
     * @tc.name testHiAppEventsetEventParam2300
     * @tc.desc Validate setEventParam and set the key of parameter params to the outlier 'appLaunchDomainTest_'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam2300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2300";
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest_': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101005).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2400
     * @tc.name testHiAppEventsetEventParam2400
     * @tc.desc Verify setEventParam and set the key of parameter params to the outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam2400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2400";
      try {
        await hiAppEvent.setEventParam(
          {
            'aa!@#$%&bb': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101005).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2500
     * @tc.name testHiAppEventsetEventParam2500
     * @tc.desc Validate setEventParam and set the key of parameter params to outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam2500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2500";
      try {
        await hiAppEvent.setEventParam(
          {
            '': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101005).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2600
     * @tc.name testHiAppEventsetEventParam2600
     * @tc.desc Validation setEventParam, set parameter params key to normal long-term value
     *          string (32-bit) 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam2600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
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
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2700
     * @tc.name testHiAppEventsetEventParam2700
     * @tc.desc Verify setEventParam and set the key of parameter params to an outlier Very long
     *          string (more than 32 bits)'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam2700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2700";
      try {
        await hiAppEvent.setEventParam(
          {
            'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101005).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2800
     * @tc.name testHiAppEventsetEventParam2800
     * @tc.desc Verify setEventParam and set the value of parameter params to the normal value 'Abc123!@#_'
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam2800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': 'Abc123!@#_'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]).assertContain("Abc123!@#_");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_2900
     * @tc.name testHiAppEventsetEventParam2900
     * @tc.desc Verify setEventParam and set the value of parameter params to a normal
     *          value. string: Contains 1024 characters
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam2900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam2900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let temp: string = '';
        for (let i = 0; i < 1024; i++) {
          temp += 'a';
        }
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': temp
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]).assertContain(temp);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3000
     * @tc.name testHiAppEventsetEventParam3000
     * @tc.desc Verify setEventParam and set the value of parameter params to an outlier. string The
     *          value is a string of more than 1024 characters
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam3000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3000";
      try {
        let temp: string = '';
        for (let i = 0; i < 1025; i++) {
          temp += 'b';
        }
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': temp
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101004).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3100
     * @tc.name testHiAppEventsetEventParam3100
     * @tc.desc Validate setEventParam and set the value of parameter params to a normal value number type 0
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': 0
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(0));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3200
     * @tc.name testHiAppEventsetEventParam3200
     * @tc.desc Verify setEventParam and set the value of parameter params to a normal value number type 123
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': 123
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(123));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3300
     * @tc.name testHiAppEventsetEventParam3300
     * @tc.desc Validate setEventParam and set the value of parameter params to the normal value Number.MIN_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': Number.MIN_SAFE_INTEGER
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3400
     * @tc.name testHiAppEventsetEventParam3400
     * @tc.desc Validate setEventParam and set the value of parameter params to the normal value Number.MAX_SAFE_INTEGER
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': Number.MAX_SAFE_INTEGER
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3500
     * @tc.name testHiAppEventsetEventParam3500
     * @tc.desc Verify setEventParam and set the value of parameter params to the outlier Number.MIN_SAFE_INTEGER - 1
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam3500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': Number.MIN_SAFE_INTEGER - 1
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(Number.MIN_SAFE_INTEGER - 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3600
     * @tc.name testHiAppEventsetEventParam3600
     * @tc.desc Verify setEventParam and set the value of parameter params to the outlier Number.MAX_SAFE_INTEGER + 1
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam3600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': Number.MAX_SAFE_INTEGER + 1
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(Number.MAX_SAFE_INTEGER + 1));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3700
     * @tc.name testHiAppEventsetEventParam3700
     * @tc.desc Validate setEventParam and set the value of parameter params to the normal value true
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': true
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(true));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3800
     * @tc.name testHiAppEventsetEventParam3800
     * @tc.desc Validate setEventParam and set the value of parameter params to the normal value false
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': false
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(false));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_3900
     * @tc.name testHiAppEventsetEventParam3900
     * @tc.desc Verify setEventParam and set the value of parameter params to a normal value. Array<string>: indicates
     *          that the accumulated element length does not exceed 1024 characters
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam3900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam3900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': ['Abc123!@#_', 'Abc123!@#_', 'Abc123!@#_', 'Abc123!@#_']
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(['Abc123!@#_', 'Abc123!@#_', 'Abc123!@#_', 'Abc123!@#_']));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_4000
     * @tc.name testHiAppEventsetEventParam4000
     * @tc.desc Verify setEventParam and set the value of parameter params to a normal value. Array<string>: indicates
     *          the accumulated element length of 1024 characters
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam4000', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam4000";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let array: Array<string> = []
        for (let i = 0; i < 256; i++) {
          array[i] = 'Ab12'
        }
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': array
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.["appLaunchDomainTest"]))
          .assertContain(JSON.stringify(array));
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_4100
     * @tc.name testHiAppEventsetEventParam4100
     * @tc.desc Verify setEventParam and set the value of parameter params to an outlier. Array<string>: indicates
     *          that the accumulated element length exceeds 1024 characters
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam4100', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam4100";
      try {
        let array: Array<string> = []
        for (let i = 0; i < 257; i++) {
          array[i] = 'Ab12'
        }
        await hiAppEvent.setEventParam(
          {
            'appLaunchDomainTest': array
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101004).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_4200
     * @tc.name testHiAppEventsetEventParam4200
     * @tc.desc Verify that the setEventParam parameter params is normal and the number of parameters does not exceed 64
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam4200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam4200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_params = {};
        for (let i = 0; i < 64; i++) {
          parameter_params[`key${i + 1}`] = i + 1;
        }
        await hiAppEvent.setEventParam(
          parameter_params,
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        for (let i = 0; i < 64; i++) {
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
     * @tc.number ARKUIX_HiAppEvent_setEventParam_4300
     * @tc.name testHiAppEventsetEventParam4300
     * @tc.desc Verify that the setEventParam parameter params is normal. The number of parameters is 64
     * @tc.level Level2
     */
    it('testHiAppEventsetEventParam4300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam4300";
      try {
        parameter_params = {};
        for (let i = 0; i < 65; i++) {
          parameter_params[`key${i + 1}`] = i + 1;
        }
        await hiAppEvent.setEventParam(
          parameter_params,
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
            expect(err.code == 11101007).assertTrue();
          })
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_setEventParam_4400
     * @tc.name testHiAppEventsetEventParam4400
     * @tc.desc Verify the setEventParam parameter params to set the event customization information
     * @tc.level Level0
     */
    it('testHiAppEventsetEventParam4400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventsetEventParam4400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_params = {};
        parameter_params[hiAppEvent.param.USER_ID] = 'USER_ID'
        parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME] = 'DISTRIBUTED_SERVICE_NAME'
        parameter_params[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID] = 'DISTRIBUTED_SERVICE_INSTANCE_ID'
        await hiAppEvent.setEventParam(
          parameter_params,
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
        })
          .catch((err: BusinessError) => {
            console.error(LOG_TAG + 'call setEventParam failed, err.code: ' + err.code + ' err.message: ' +
            err.message);
          })
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
        await sleep(4000);
        expect(eventInfo != null).assertTrue();
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.USER_ID]))
          .assertContain("USER_ID");
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_NAME]))
          .assertContain("DISTRIBUTED_SERVICE_NAME");
        expect(JSON.stringify((JSON.parse(JSON.stringify(params)) as object)?.[hiAppEvent.param.DISTRIBUTED_SERVICE_INSTANCE_ID]))
          .assertContain("DISTRIBUTED_SERVICE_INSTANCE_ID");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}