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

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function HiAppEvent6() {
  describe('HiAppEvent6Test', () => {
    let appEventPackageHolder: hiAppEvent.AppEventPackageHolder =
      new hiAppEvent.AppEventPackageHolder('TestDefaultWatch2')
    let triggerCondition: hiAppEvent.TriggerCondition | null = null;
    beforeEach(() => {
      hiAppEvent.configure({
        disable: false
      })
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch1'
      })
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch2'
      })
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch3'
      })
      hiAppEvent.clearData()
    })
    afterEach(() => {
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch'
      });
      hiAppEvent.clearData();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_TriggerCondition_0100
     * @tc.name testHiAppEventTriggerCondition0100
     * @tc.desc Verify that all three conditions of triggerCondition are set at the same time, and set the onTrigger
     *          callback. Verify that row conditions are met to trigger a callback
     * @tc.level Level0
     */
    it('testHiAppEventTriggerCondition0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventTriggerCondition0100";
      try {
        let flag: boolean = false;
        triggerCondition = {
          row: 1,
          size: 300,
          timeOut: 1
        }
        hiAppEvent.configure({
          disable: false
        })
        hiAppEvent.clearData()
        hiAppEvent.addWatcher({
          name: 'TestDefaultWatch1',
          appEventFilters: [{
            domain: 'DomainTest01',
            names: ['NameTest01'],
            eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC,
              hiAppEvent.EventType.SECURITY, hiAppEvent.EventType.BEHAVIOR]
          }],
          triggerCondition: triggerCondition,
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
            if (appEventPackage != null) {
              expect(appEventPackage.row).assertEqual(1);
              expect(appEventPackage.size).assertLess(triggerCondition?.size);
            } else {
              expect().assertFail();
            }
          }
        })
        hiAppEvent.write({
          domain: 'DomainTest01',
          name: 'NameTest01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'testFunc1EventParams': 'testFunc1EventParams'
          },
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write success');
          }
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
     * @tc.number ARKUIX_HiAppEvent_TriggerCondition_0200
     * @tc.name testHiAppEventTriggerCondition0200
     * @tc.desc Verify that all three conditions of triggerCondition are set at the same time, and set the
     *          onTrigger callback. Verify that the size condition is met to trigger a callback
     * @tc.level Level0
     */
    it('testHiAppEventTriggerCondition0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventTriggerCondition0200";
      try {
        let flag: boolean = false;
        triggerCondition = {
          row: 3,
          size: 2,
          timeOut: 1
        }
        hiAppEvent.configure({
          disable: false
        })
        hiAppEvent.clearData()
        hiAppEvent.addWatcher({
          name: 'TestDefaultWatch1',
          appEventFilters: [{
            domain: 'DomainTest01',
            names: ['NameTest01'],
            eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC,
              hiAppEvent.EventType.SECURITY, hiAppEvent.EventType.BEHAVIOR]
          }],
          triggerCondition: triggerCondition,
          onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
            let appEventPackage = holder.takeNext();
            flag = true;
            if (appEventPackage != null) {
              expect(appEventPackage.row).assertLess(triggerCondition?.row);
              expect(triggerCondition?.size).assertLess(appEventPackage.size);
            } else {
              expect().assertFail();
            }
          }
        })
        hiAppEvent.write({
          domain: 'DomainTest01',
          name: 'NameTest01',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'testFunc1EventParams': 'testFunc1EventParams'
          },
        }, (err: BusinessError) => {
          if (err) {
            console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
          } else {
            console.info(LOG_TAG + 'call write success');
          }
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
     * @tc.number ARKUIX_HiAppEvent_clearData_0100
     * @tc.name testHiAppEventClearData0100
     * @tc.desc Validation call clearData; After call write, use AppEventPackageHolder again.
     *          TakeNext return value is null
     * @tc.level Level0
     */
    it('testHiAppEventClearData0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventClearData0100";
      try {
        hiAppEvent.configure({
          disable: false
        })
        hiAppEvent.clearData()
        hiAppEvent.removeWatcher({
          name: 'TestDefaultWatch2'
        })
        appEventPackageHolder = hiAppEvent.addWatcher({
          name: 'TestDefaultWatch2',
          appEventFilters: [{
            domain: 'DomainTest02',
            names: ['NameTest02'],
            eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
              hiAppEvent.EventType.BEHAVIOR]
          }]
        })
        hiAppEvent.write({
          domain: 'DomainTest02',
          name: 'NameTest02',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'testFunc2EventParams': 'testFunc2EventParams'
          },
        }, (err: BusinessError) => {
          hiAppEvent.clearData();
          let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext()
          expect(appEventPackage).assertNull();
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_clearData_0200
     * @tc.name testHiAppEventClearData0200
     * @tc.desc Verify after calling write; Using AppEventPackageHolder. TakeNext return values for the
     *          event data is not null
     * @tc.level Level0
     */
    it('testHiAppEventClearData0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventClearData0200";
      try {
        hiAppEvent.configure({
          disable: false
        })
        hiAppEvent.removeWatcher({
          name: 'Test0DefaultWatch2'
        })
        hiAppEvent.clearData();
        appEventPackageHolder = hiAppEvent.addWatcher({
          name: 'Test0DefaultWatch2',
          appEventFilters: [{
            domain: 'DomainTest02',
            names: ['NameTest02'],
            eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
              hiAppEvent.EventType.BEHAVIOR]
          }]
        })
        hiAppEvent.write({
          domain: 'DomainTest02',
          name: 'NameTest02',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'testFunc2EventParams': 'testFunc2EventParams'
          },
        }, (err: BusinessError) => {
          let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext()
          if (appEventPackage != null) {
            expect(appEventPackage.row).assertEqual(1);
          } else {
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
     * @tc.number ARKUIX_HiAppEvent_configure_0100
     * @tc.name testHiAppEventConfigure0100
     * @tc.desc Verify that ConfigOption.disable is set to true
     * @tc.level Level0
     */
    it('testHiAppEventConfigure0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventConfigure0100";
      try {
        hiAppEvent.clearData();
        hiAppEvent.configure({
          disable: true
        })
        await hiAppEvent.setEventParam(
          {
            'defaultEventParams': 'defaultEventParams'
          },
          'defaultDomain',
          'defaultName'
        ).then(() => {
          console.info(LOG_TAG + 'call setEventParam success');
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + ' call setEventParam failed, err.code: ' + err.code + ' err.message: ' + err.message)
          expect(err.code == 11100001).assertTrue;
        })
        hiAppEvent.write({
          domain: 'DomainTest03',
          name: 'NameTest03',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'write_disable': true
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success')
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + ' call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
          expect(err.code == 11100001).assertTrue;
        })
        await sleep(2000);
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_configure_0200
     * @tc.name testHiAppEventConfigure0200
     * @tc.desc Verify that ConfigOption.disable is set to false
     * @tc.level Level0
     */
    it('testHiAppEventConfigure0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventConfigure0200";
      try {
        let flag: boolean = false;
        hiAppEvent.clearData();
        hiAppEvent.addWatcher({
          name: "TestDefaultWatch3",
          appEventFilters: [
            {
              domain: "DomainTest03",
              eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
                hiAppEvent.EventType.BEHAVIOR]
            }
          ],
          onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
            flag = true;
          }
        })
        hiAppEvent.configure({
          disable: false
        })
        hiAppEvent.write({
          domain: 'DomainTest03',
          name: 'NameTest03',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'write_disable': false
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success')
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        expect(flag).assertTrue();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

  }
  )
}