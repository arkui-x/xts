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

import { describe, it, expect, Level, TestType, Size } from '@ohos/hypium';
import hilog from '@ohos.hilog';
import notificationemitter from '@ohos.events.emitter';
import emitter from '@ohos.events.emitter';

const TAG = 'NotificationActs';
const TEST_SUITE_NAME = 'testNotificationEmitterNotification';

export default function EmitterOnTest() {
  describe('EmitterOnTest', () => {
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0100
     * @tc.name   : testEmitterOneventIdforstring0001
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforstring0001', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforstring';
      let eventId06 = 'eventId06';
      let onCallback06 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId06, onCallback06);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ` on failed,data is %{public}s`,
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId06);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ` getListenerCount success,data is %{public}s`, JSON.stringify(num));
      expect(num).assertEqual(1);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0200
     * @tc.name   : testEmitterOneventIdfortwostring0002
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdfortwostring0002', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdfortwostring';
      let eventId07 = 'eventId07';
      let onCallback07 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId07, onCallback07);
        notificationemitter.on(eventId07, onCallback07);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId07);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0300
     * @tc.name   : testEmitterOneventIdforempty0003
     * @tc.desc   : test on interface fail
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforempty0003', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforempty';
      let eventId08 = '';
      let onCallback08 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId08, onCallback08);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId08);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(undefined);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0400
     * @tc.name   : testEmitterOneventIdforwhitespace0004
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforwhitespace0004', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforwhitespace';
      let eventId09 = ' ';
      let onCallback09 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId09, onCallback09);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId09);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
      notificationemitter.off(eventId09);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0500
     * @tc.name   : testEmitterOneventIdforstringfornumber0005
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforstringfornumber0005', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforstringfornumber';
      let eventId10 = 'eventId10';
      let innerEvent10: notificationemitter.InnerEvent = {
        eventId: 10
      }
      let onCallback10 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(innerEvent10, onCallback10);
        notificationemitter.on(eventId10, onCallback10);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId10);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      let num1: number = notificationemitter.getListenerCount(innerEvent10.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(1);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0600
     * @tc.name   : testEmitterOnoneEmitterone0006
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnoneEmitterone0006', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnoneEmitterone';
      let eventId11 = 'eventId11';
      let option11: notificationemitter.Options = {
        priority: 0
      }
      let onCallback11 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(true).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId11, onCallback11);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(eventId11, option11);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0700
     * @tc.name   : testEmitterOnonestringEmitonenumber0007
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnonestringEmitonenumber0007', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnonestringEmitonenumber';
      let eventId56 = 'eventId56';
      let innerEvent56: notificationemitter.InnerEvent = {
        eventId: 56
      }
      let onCallback56 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId56, onCallback56);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(innerEvent56);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      setTimeout(() => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' No subscription message');
        expect(true).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 3000)
    });
    
    /**
     * @tc.number : Sub_Notification_Emitter_Subscribe_Capabilities_0800
     * @tc.name   : testEmitterOnonestringonenumber0008
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnonestringonenumber0008', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnonestringonenumber';
      let eventId57 = 'eventId57';
      let innerEvent57: notificationemitter.InnerEvent = {
        eventId: 57
      }
      let onCallback57 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId57, onCallback57);
        notificationemitter.on(innerEvent57, onCallback57);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num1: number = notificationemitter.getListenerCount(eventId57);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(1);
      let num2 = notificationemitter.getListenerCount(innerEvent57.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num2));
      expect(num2).assertEqual(1);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_0900
     * @tc.name   : testEmitterOntwocallback0009
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOntwocallback0009', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOntwocallback';
      let eventId58 = 'eventId58';
      let onCallback58 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let onCallback158 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId58, onCallback58);
        notificationemitter.on(eventId58, onCallback158);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num1: number = notificationemitter.getListenerCount(eventId58);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(2);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1000
     * @tc.name   : testDeserializeEmitterCallbackNoPar0010
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterCallbackNoPar0010', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterCallbackNoPar';
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", () => {
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success,data is %{public}s');
          expect(true).assertTrue();
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
          done();
        })
        emitter.emit('eventid');
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1100
     * @tc.name   : testDeserializeEmitterCallback0011
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterCallback0011', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterCallback';
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      const re = new RegExp("\\w+");
      const buffer: ArrayBuffer = new ArrayBuffer(8);
      const view: Int32Array = new Int32Array(buffer);
      const buffer1: ArrayBuffer = new ArrayBuffer(16);
      const view1: DataView = new DataView(buffer1, 0);
      const birthday: Date = new Date("December 17,1995 03:24:00");
      let a = view1.setInt16(1, 42);
      let b = view1.getInt16(1);
      const aa = new Set([1, 2, 3]);
      const errtypes = new Error('Whoops!');
      const bmaps = new Map([
        [1, 'one'], [2, 'two'], [3, 'three']
      ]);
      let testObject: emitter.EventData = {
        data: {
          'test': 1
        }
      };
      let eventData: emitter.EventData = {
        data: {
          "number": 1,
          "string": "str",
          "boolean": false,
          "reg": re,
          "set": aa,
          "date": birthday,
          "view": view,
          "map": bmaps,
          "error": errtypes,
          "la": b,
          "obk": testObject
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", (eventData: emitter.EventData) => {
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success,data is %{public}s',
            JSON.stringify(eventData));
          expect(true).assertTrue();
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
          done();
        })
        emitter.emit('eventid', eventData);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1200
     * @tc.name   : testDeserializeEmitterTwoOnCallbackNoPar0012
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnCallbackNoPar0012', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoCallbackNoPar';
      let count: number = 0;
      let oncallback1 = () => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s');
        count++;
      };
      let oncallback2 = () => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s');
        count++;
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventid", oncallback2);
        emitter.emit("eventid");
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1300
     * @tc.name   : testDeserializeEmitterTwoOnCallback0013
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnCallback0013', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnCallback';
      let count: number = 0;
      let oncallback1 = (data: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      const re = new RegExp("\\w+");
      const buffer: ArrayBuffer = new ArrayBuffer(8);
      const view: Int32Array = new Int32Array(buffer);
      const buffer1: ArrayBuffer = new ArrayBuffer(16);
      const view1: DataView = new DataView(buffer1, 0);
      const birthday: Date = new Date("December 17,1995 03:24:00");
      let a = view1.setInt16(1, 42);
      let b = view1.getInt16(1);
      const aa = new Set([1, 2, 3]);
      const errtypes = new Error('Whoops!');
      const bmaps = new Map([
        [1, 'one'], [2, 'two'], [3, 'three']
      ]);
      let testObject: emitter.EventData = {
        data: {
          'test': 1
        }
      };
      let eventData: emitter.EventData = {
        data: {
          "number": 1,
          "string": "str",
          "boolean": false,
          "reg": re,
          "set": aa,
          "date": birthday,
          "view": view,
          "map": bmaps,
          "error": errtypes,
          "la": b,
          "obk": testObject
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventid", oncallback2);
        emitter.emit("eventid", eventData);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1400
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitNoEventData0014
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testDeserializeEmitterTwoOnTwoEmitNoEventData0014', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL0, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitNoEventData';
      let count: number = 0;
      let oncallback1 = () => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = () => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid");
        emitter.emit("eventids");
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1500
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitStrignAndArray0015
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitStrignAndArray0015', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitStrignAndArray';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let data1: emitter.EventData = {
        data: {
          'string': 'string'
        }
      };
      let data2: emitter.EventData = {
        data: {
          'Array': [1, 2, 7, 8]
        }
      }
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1600
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitNumberAndBoolean0016
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitNumberAndBoolean0016', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitNumberAndBoolean';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s');
        expect(true).assertTrue();
        count++;
      };
      let data1: emitter.EventData = {
        data: {
          'number': 1
        }
      };
      let data2: emitter.EventData = {
        data: {
          'Boolean': true
        }
      }
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1700
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitArrayAndBuffer0017
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitArrayAndBuffer0017', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitArrayAndBuffer';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s',
          JSON.stringify(data1));
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s',
          JSON.stringify(data2));
        expect(true).assertTrue();
        count++;
      };
      let data1: emitter.EventData = {
        data: {
          'Array': [1, 2, 3]
        }
      };
      const buffer1: ArrayBuffer = new ArrayBuffer(16);
      let data2: emitter.EventData = {
        data: {
          'Arraybuffer1': buffer1
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1800
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitDateAndDateView0018
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitDateAndDateView0018', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitDateAndDateView';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s',
          JSON.stringify(data1));
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s',
          JSON.stringify(data2));
        expect(true).assertTrue();
        count++;
      };
      let birthday: Date = new Date('Decenmber 17,1995 03:24:00');
      let data1: emitter.EventData = {
        data: {
          'Date': birthday
        }
      };
      const buffer: ArrayBuffer = new ArrayBuffer(16);
      const view = new DataView(buffer, 0);
      let data2: emitter.EventData = {
        data: {
          'Arraybuffer': view
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_1900
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitMapAndSet0019
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitMapAndSet0019', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitMapAndSet';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s',
          JSON.stringify(data1));
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s',
          JSON.stringify(data2));
        expect(true).assertTrue();
        count++;
      };
      const Sets = new Set([1, 2, 3]);
      let data1: emitter.EventData = {
        data: {
          'Sets': Sets
        }
      };
      const Maps = new Map([
        [1, 'one'], [2, 'two'], [3, 'three']
      ]);
      let data2: emitter.EventData = {
        data: {
          'Map': Maps
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_2000
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitErrorTypesAndTypedArray0020
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitErrorTypesAndTypedArray0020', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitErrorTypesAndTypedArray';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s',
          JSON.stringify(data1));
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s',
          JSON.stringify(data2));
        expect(true).assertTrue();
        count++;
      };
      const errtypes = new Error('Whoops!');
      let data1: emitter.EventData = {
        data: {
          'errtypes': errtypes
        }
      };
      const buffer = new ArrayBuffer(8);
      const view = new Int32Array(buffer);
      let data2: emitter.EventData = {
        data: {
          'TypeArray': view
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
    
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ON_INTERNETEVENT_2100
     * @tc.name   : testDeserializeEmitterTwoOnTwoEmitRegExpAndPrimitivetypes0021
     * @tc.desc   : test on interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testDeserializeEmitterTwoOnTwoEmitRegExpAndPrimitivetypes0021', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testDeserializeEmitterTwoOnTwoEmitRegExpAndPrimitivetypes';
      let count: number = 0;
      let oncallback1 = (data1: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success,data1 is %{public}s',
          JSON.stringify(data1));
        expect(true).assertTrue();
        count++;
      };
      let oncallback2 = (data2: emitter.EventData) => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success,data2 is %{public}s',
          JSON.stringify(data2));
        expect(true).assertTrue();
        count++;
      };
      const re = new RegExp('\\w+');
      let data1: emitter.EventData = {
        data: {
          'RegExp': re
        }
      };
      const Primitivetypes = 1;
      let data2: emitter.EventData = {
        data: {
          'Primitivetypes': Primitivetypes
        }
      };
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
      try {
        emitter.on("eventid", oncallback1);
        emitter.on("eventids", oncallback2);
        emitter.emit("eventid", data1);
        emitter.emit("eventids", data2);
      } catch (e) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(e));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      ;
      setTimeout(() => {
        expect(count).assertEqual(2);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 1000);
    });
  });
}