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

export default function HiAppEvent5() {
  describe('HiAppEvent5Test', () => {
    let appEventPackageHolder: hiAppEvent.AppEventPackageHolder =
      new hiAppEvent.AppEventPackageHolder('TestDefaultWatch')
    beforeEach(async () => {
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch'
      });
      appEventPackageHolder = hiAppEvent.addWatcher({
        name: 'TestDefaultWatch',
        appEventFilters: [{
          domain: 'defaultDomain',
          names: ['defaultName'],
          eventTypes: [hiAppEvent.EventType.FAULT, hiAppEvent.EventType.STATISTIC, hiAppEvent.EventType.SECURITY,
            hiAppEvent.EventType.BEHAVIOR]
        }]
      })
      await sleep(2000);
    })
    afterEach(() => {
      hiAppEvent.removeWatcher({
        name: 'TestDefaultWatch'
      });
      hiAppEvent.clearData();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0100
     * @tc.name testHiAppEventAppEventPackageHolder0100
     * @tc.desc Verify that AppEventPackageHolder does not call setSize and setRow
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0100', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0100";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        if (appEventPackage != null) {
          expect(appEventPackage.row == 1).assertTrue();
        } else {
          expect().assertFail();
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0200
     * @tc.name testHiAppEventAppEventPackageHolder0200
     * @tc.desc Verify AppEventPackageHolder to only call setSize with an argument of 0
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0200', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0200";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        appEventPackageHolder.setSize(0);
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        expect(appEventPackage).assertNull();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0300
     * @tc.name testHiAppEventAppEventPackageHolder0300
     * @tc.desc Verify that AppEventPackageHolder only calls setSize with an argument of 350
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0300', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0300";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setSize(350);
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        if (appEventPackage != null) {
          expect(appEventPackage.size).assertLess(350);
        } else {
          expect().assertFail();
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0400
     * @tc.name testHiAppEventAppEventPackageHolder0400
     * @tc.desc Verify AppEventPackageHolder to call only setSize with argument -1
     * @tc.level Level2
     */
    it('testHiAppEventAppEventPackageHolder0400', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0400";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setSize(-1);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11104001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0500
     * @tc.name testHiAppEventAppEventPackageHolder0500
     * @tc.desc Verify AppEventPackageHolder to call only setRow with parameter 0
     * @tc.level Level2
     */
    it('testHiAppEventAppEventPackageHolder0500', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0500";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setRow(0);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11104001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0600
     * @tc.name testHiAppEventAppEventPackageHolder0600
     * @tc.desc Verify AppEventPackageHolder to call only setRow with parameter 3
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0600', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0600";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setRow(3);
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        if (appEventPackage != null) {
          expect(appEventPackage.row).assertEqual(3);
        } else {
          expect().assertFail();
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0700
     * @tc.name testHiAppEventAppEventPackageHolder0700
     * @tc.desc Verify AppEventPackageHolder to call only setRow with argument -1
     * @tc.level Level2
     */
    it('testHiAppEventAppEventPackageHolder0700', Level.LEVEL2, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0700";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setRow(-1);
        expect().assertFail();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect(err.code == 11104001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0800
     * @tc.name testHiAppEventAppEventPackageHolder0800
     * @tc.desc Verify that AppEventPackageHolder calls both setSize and setRow with arguments 1 and 1
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0800', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0800";
      try {
        hiAppEvent.write({
          domain: 'defaultDomain',
          name: 'defaultName',
          eventType: hiAppEvent.EventType.BEHAVIOR,
          params: {
            'DWriteParams': 'DWriteParams'
          },
        }).then(() => {
          console.info(LOG_TAG + 'call write success');
        }).catch((err: BusinessError) => {
          console.error(LOG_TAG + 'call write failed, err.code: ' + err.code + ' err.message: ' + err.message)
        })
        await sleep(2000);
        appEventPackageHolder.setSize(1);
        appEventPackageHolder.setRow(1);
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        if (appEventPackage != null) {
          expect(appEventPackage.row).assertEqual(1);
        } else {
          expect().assertFail();
        }
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_HiAppEvent_AppEventPackageHolder_0900
     * @tc.name testHiAppEventAppEventPackageHolder0900
     * @tc.desc Returns null when verifying that the AppEventPackageHolder event data is null
     * @tc.level Level0
     */
    it('testHiAppEventAppEventPackageHolder0900', Level.LEVEL0, async (done: Function) => {
      let LOG_TAG = "testHiAppEventAppEventPackageHolder0900";
      try {
        let appEventPackage: hiAppEvent.AppEventPackage = appEventPackageHolder.takeNext();
        expect(appEventPackage).assertNull();
      } catch (err) {
        console.error(LOG_TAG + `> error code: ${err.code}, error msg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}