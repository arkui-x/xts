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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium'
import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HiAppEvent4() {
  describe('HiAppEvent4Test', () => {
    let parameter_triggerCondition: hiAppEvent.TriggerCondition | null = null;
    let parameter_name: string = 'TestDefaultWatch';
    let write_domain: string = 'defaultDomain';
    let write_name: string = 'defaultName';
    let write_eventTypes: hiAppEvent.EventType = hiAppEvent.EventType.BEHAVIOR;
    let parameter_appEventFilter: hiAppEvent.AppEventFilter = {
      domain: 'defaultDomain',
      names: ['defaultName'],
      eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
        hiAppEvent.EventType.BEHAVIOR]
    } as hiAppEvent.AppEventFilter;
    let watcher: hiAppEvent.Watcher = {
      name: parameter_name,
      onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
        let appEventPackage = holder.takeNext();
      }
    }
    beforeEach(async () => {
      parameter_name = 'TestDefaultWatch';
      write_domain = 'defaultDomain';
      write_name = 'defaultName';
      write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
      watcher = {
        name: parameter_name,
        onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
          let appEventPackage = holder.takeNext();
        }
      }
      await sleep(2000);
    })
    afterEach(() => {
      hiAppEvent.removeWatcher({
        name: parameter_name
      })
      hiAppEvent.clearData()
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0100
     * @tc.name testHiAppEventWatcher0100
     * @tc.desc Verify addWatcher, each parameter is normal value
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["DWriteParams"])
          .assertContain("DWriteParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0200
     * @tc.name testHiAppEventWatcher0200
     * @tc.desc Verify addWatcher, parameter name set to normal 'TestDefaultWatch'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        watcher.name = 'TestDefaultWatch';
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("defaultDomain");
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain("defaultName");
        let params: String = (JSON.parse(JSON.stringify(eventInfo)) as object)?.["params"];
        expect((JSON.parse(JSON.stringify(params)) as object)?.["DWriteParams"]).assertContain("DWriteParams");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0300
     * @tc.name testHiAppEventWatcher0300
     * @tc.desc Validate addWatcher with parameter name set to outlier '@#$%^&*()123'
     * @tc.level Level2
     */
    it('testHiAppEventWatcher0300', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0300";
      try {
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.name = '@#$%^&*()123'
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0400
     * @tc.name testHiAppEventWatcher0400
     * @tc.desc Verify addWatcher, parameter name set to outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWatcher0400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0400";
      try {
        watcher.name = '';
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0500
     * @tc.name testHiAppEventWatcher0500
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets row to a normal value of 0
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0500";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            row: 0
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(flag).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0600
     * @tc.name testHiAppEventWatcher0600
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets row to a normal value of 2
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0600";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            row: 2
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(flag).assertTrue();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0700
     * @tc.name testHiAppEventWatcher0700
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets row to outlier -1
     * @tc.level Level2
     */
    it('testHiAppEventWatcher0700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0700";
      try {
        parameter_triggerCondition = {
          row: -1
        } as hiAppEvent.TriggerCondition;
        watcher.triggerCondition = parameter_triggerCondition;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102003).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0800
     * @tc.name testHiAppEventWatcher0800
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets size to the normal value of 0
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0800";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            size: 0
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        sleep(2000);
        expect(flag).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_0900
     * @tc.name testHiAppEventWatcher0900
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets size to the normal value 2
     * @tc.level Level0
     */
    it('testHiAppEventWatcher0900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher0900";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            size: 2
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(3000);
        expect(flag).assertTrue();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1000
     * @tc.name testHiAppEventWatcher1000
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets size to outlier -1
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1000";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            size: -1
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102004).assertTrue();

      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1100
     * @tc.name testHiAppEventWatcher1100
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets timeOut to a normal value of 0
     * @tc.level Level0
     */
    it('testHiAppEventWatcher1100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1100";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            timeOut: 0
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        sleep(2000);
        expect(flag).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1200
     * @tc.name testHiAppEventWatcher1200
     * @tc.desc Verify that the addWatcher parameter triggerCondition sets timeOut to outlier -1
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1200', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1200";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: parameter_name,
          triggerCondition: {
            timeOut: -1
          },
          appEventFilters: [parameter_appEventFilter],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102005).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1300
     * @tc.name testHiAppEventWatcher1300
     * @tc.desc Verify addWatcher, appEventFilters set domain to normal 'appLaunchDomain'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher1300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'appLaunchDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'appLaunchDomain';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;

        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain("appLaunchDomain");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1400
     * @tc.name testHiAppEventWatcher1400
     * @tc.desc Validate addWatcher, appEventFilters with domain set to normal 'app_launch_domain_01'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher1400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'app_launch_domain_01',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'app_launch_domain_01';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
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
     * @tc.number ARKUIX_HiAppEvent_Watcher_1500
     * @tc.name testHiAppEventWatcher1500
     * @tc.desc Verify addWatcher, appEventFilters set domain to outlier '123456'
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1500";
      try {
        parameter_appEventFilter = {
          domain: '123456',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1600
     * @tc.name testHiAppEventWatcher1600
     * @tc.desc Verify addWatcher, appEventFilters with domain set to outlier 'appLaunchDomain_'
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1600', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1600";
      try {
        parameter_appEventFilter = {
          domain: 'appLaunchDomain_',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1700
     * @tc.name testHiAppEventWatcher1700
     * @tc.desc Verify addWatcher, appEventFilters with domain set to outlier 'aa! @#$%&bb'
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1700";
      try {
        parameter_appEventFilter = {
          domain: 'aa!@#$%&bb',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1800
     * @tc.name testHiAppEventWatcher1800
     * @tc.desc Verify addWatcher, appEventFilters set domain to outlier ''
     * @tc.level Level2
     */
    it('testHiAppEventWatcher1800', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1800";
      try {
        parameter_appEventFilter = {
          domain: '',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_1900
     * @tc.name testHiAppEventWatcher1900
     * @tc.desc Verify addWatcher, appEventFilters sets domain to a string of normal length (32 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWatcher1900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher1900";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"])
          .assertContain("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2000
     * @tc.name testHiAppEventWatcher2000
     * @tc.desc Verify addWatcher, parameter appEventFilters sets domain to outliers Very long strings (32 bits)
     * @tc.level Level2
     */
    it('testHiAppEventWatcher2000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2000";
      try {
        parameter_appEventFilter = {
          domain: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11102002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2100
     * @tc.name testHiAppEventWatcher2100
     * @tc.desc Verify addWatcher, appEventFilters with names set to normal 'appLaunchDomainTest'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['appLaunchDomainTest'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'defaultDomain';
        write_name = 'appLaunchDomainTest';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
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
     * @tc.number ARKUIX_HiAppEvent_Watcher_2200
     * @tc.name testHiAppEventWatcher2200
     * @tc.desc Verify addWatcher, appEventFilters set names to a normal value 'app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2200";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['app_launch_domain_test_01'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'defaultDomain';
        write_name = 'app_launch_domain_test_01';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
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
     * @tc.number ARKUIX_HiAppEvent_Watcher_2300
     * @tc.name testHiAppEventWatcher2300
     * @tc.desc Verify addWatcher, appEventFilters set names to a normal value '$app_launch_domain_test_01'
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2300";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['$app_launch_domain_test_01'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'defaultDomain';
        write_name = '$app_launch_domain_test_01';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
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
     * @tc.number ARKUIX_HiAppEvent_Watcher_2400
     * @tc.name testHiAppEventWatcher2400
     * @tc.desc Verify addWatcher, set names to normal in the appEventFilters parameter: long string (48 bits)
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2400";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        let temp1: string = '';
        for (let i = 0; i < 48; i++) {
          temp1 += 'a'
        }
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: [temp1],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'defaultDomain';
        write_name = temp1;
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["name"]).assertContain(temp1);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2500
     * @tc.name testHiAppEventWatcher2500
     * @tc.desc Validation addWatcher, parameter appEventFilters set eventTypes to normal hiAppEvent.EventType.FAULT
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2500', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2500";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT]
        }
        write_domain = 'defaultDomain';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.FAULT;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain('1');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2600
     * @tc.name testHiAppEventWatcher2600
     * @tc.desc Validation addWatcher, parameter appEventFilters set eventTypes to normal hiAppEvent.EventType.STATISTIC
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2600";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.STATISTIC]
        }
        write_domain = 'defaultDomain';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.STATISTIC;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain('2');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2700
     * @tc.name testHiAppEventWatcher2700
     * @tc.desc Validation addWatcher, parameter appEventFilters set eventTypes to normal hiAppEvent.EventType.SECURITY
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2700', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2700";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.SECURITY]
        }
        write_domain = 'defaultDomain';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.SECURITY;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain('3');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2800
     * @tc.name testHiAppEventWatcher2800
     * @tc.desc Validation addWatcher, parameter appEventFilters set eventTypes to normal hiAppEvent.EventType.BEHAVIOR
     * @tc.level Level0
     */
    it('testHiAppEventWatcher2800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2800";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.BEHAVIOR]
        }
        write_domain = 'defaultDomain';
        write_name = 'defaultName';
        write_eventTypes = hiAppEvent.EventType.BEHAVIOR;
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            for (const data of eventGroup.appEventInfos) {
              eventInfo = data;
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: write_domain,
          name: write_name,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect(JSON.stringify((JSON.parse(JSON.stringify(eventInfo)) as object)?.["eventType"])).assertContain('4');
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_2900
     * @tc.name testHiAppEventWatcher2900
     * @tc.desc Verify addWatcher, set eventTypes to outlier 0 in the appEventFilters parameter
     * @tc.level Level2
     */
    it('testHiAppEventWatcher2900', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher2900";
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [0]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_3000
     * @tc.name testHiAppEventWatcher3000
     * @tc.desc Verify addWatcher, set eventTypes to outlier -1 in the appEventFilters parameter
     * @tc.level Level2
     */
    it('testHiAppEventWatcher3000', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher3000";
      try {
        parameter_appEventFilter = {
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [-1]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        }
        hiAppEvent.addWatcher(watcher);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_3100
     * @tc.name testHiAppEventWatcher3100
     * @tc.desc Verify that addWatcher, the appEventFilters parameter is set as a system event
     * @tc.level Level0
     */
    it('testHiAppEventWatcher3100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher3100";
      let eventInfo: hiAppEvent.AppEventInfo | null = null;
      try {
        parameter_appEventFilter = {
          domain: hiAppEvent.domain.OS,
          names: [hiAppEvent.event.APP_CRASH],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }
        let temp: hiAppEvent.AppEventFilter[] = [];
        temp[0] = parameter_appEventFilter;
        watcher.appEventFilters = temp;
        watcher.onReceive = (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          for (const eventGroup of appEventGroups) {
            if (eventGroup.name == hiAppEvent.event.APP_CRASH) {
              for (const data of eventGroup.appEventInfos) {
                eventInfo = data;
              }
            }
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: hiAppEvent.domain.OS,
          name: hiAppEvent.event.APP_CRASH,
          eventType: write_eventTypes,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(eventInfo != null).assertTrue();
        expect((JSON.parse(JSON.stringify(eventInfo)) as object)?.["domain"]).assertContain(hiAppEvent.domain.OS);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_3200
     * @tc.name testHiAppEventWatcher3200
     * @tc.desc If addWatcher is not triggerCondition, the onTrigger callback is not triggered
     * @tc.level Level0
     */
    it('testHiAppEventWatcher3200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher3200";
      try {
        let flag: boolean = false;
        let watcher1: hiAppEvent.Watcher = {
          name: 'TestFuncWatch',
          appEventFilters: [
            {
              domain: "TestFuncWatchTestDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            flag = true;
          }
        }
        hiAppEvent.addWatcher(watcher1);
        await hiAppEvent.write({
          domain: 'TestFuncWatchTestDomain',
          name: 'TestFuncWatchTestName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'TestFuncWatchTestDomain': 'TestFuncWatchTestName'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          hiAppEvent.removeWatcher({
            name: 'TestFuncWatch'
          })
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(flag).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_3300
     * @tc.name testHiAppEventWatcher3300
     * @tc.desc Verify addWatcher and set the onReceive callback. The onTrigger callback is not triggered
     * @tc.level Level0
     */
    it('testHiAppEventWatcher3300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher3300";
      try {
        let flag: boolean = false;
        let watcher: hiAppEvent.Watcher = {
          name: 'TestFuncWatch',
          triggerCondition: {
            row: 2
          },
          appEventFilters: [
            {
              domain: "TestFuncWatchTestDomain",
              eventTypes: [hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            flag = true;
          },
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
          }
        }
        hiAppEvent.addWatcher(watcher);
        await hiAppEvent.write({
          domain: 'TestFuncWatchTestDomain',
          name: 'TestFuncWatchTestName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'TestFuncWatchTestDomain': 'TestFuncWatchTestName'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write with Promise success');
          hiAppEvent.removeWatcher({
            name: 'TestFuncWatch'
          })
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'failed, err.code: ' + err.code + ' err.message: ' + err.message);
        })
        await sleep(2000);
        expect(flag).assertFalse();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_Watcher_3400
     * @tc.name testHiAppEventWatcher3400
     * @tc.desc Verify that calls to the removeWatcher function for a non-existent Watcher execute properly,
     *          without error codes and exception throws
     * @tc.level Level0
     */
    it('testHiAppEventWatcher3400', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventWatcher3400";
      try {
        hiAppEvent.removeWatcher({
          name: 'TestDefaultWatch'
        })
        hiAppEvent.removeWatcher({
          name: 'TestDefaultWatch123456'
        })
        expect(true).assertTrue();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}