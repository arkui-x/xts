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

const TAG = 'NotificationActs';
const TEST_SUITE_NAME = 'testNotificationEmitterNotification';

export default function EmitterOnceTest() {
  describe('EmitterOnceTest', () => {
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0100
     * @tc.name   : testEmitterOnceeventIdforstring0001
     * @tc.desc   : test once interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnceeventIdforstring0001', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnceeventIdforstring';
      let eventId18 = 'eventId18'
      let onCallback18 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId18, onCallback18);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(eventId18);
        setTimeout(() => {
          let num: number = notificationemitter.getListenerCount(eventId18);
          hilog.info(0x000, `${TAG}`,
            `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s',
            JSON.stringify(num));
          expect(num).assertEqual(0);
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
          done();
        }, 200)
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + 'emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + 'test case end');
        done();
      }
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0200
     * @tc.name   : testEmitterOnceeventIdfortwostring0002
     * @tc.desc   : test once interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnceeventIdfortwostring0002', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnceeventIdfortwostring';
      let eventId19 = 'eventId19'
      let onCallback19 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId19, onCallback19);
        notificationemitter.once(eventId19, onCallback19);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(eventId19);
        setTimeout(() => {
          let num: number = notificationemitter.getListenerCount(eventId19);
          hilog.info(0x000, `${TAG}`,
            `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s',
            JSON.stringify(num));
          expect(num).assertEqual(0);
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
          done();
        }, 200)
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + 'emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + 'test case end');
        done();
      }
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0300
     * @tc.name   : testEmitterOnceeventIdforempty0003
     * @tc.desc   : test once interface fail
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnceeventIdforempty0003', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnceeventIdforempty';
      let eventId20 = ''
      let onCallback20 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId20, onCallback20);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId20);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(undefined);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0400
     * @tc.name   : testEmitterOnceeventIdforwhitespace0004
     * @tc.desc   : test once interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnceeventIdforwhitespace0004', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnceeventIdforwhitespace';
      let eventId21 = ' '
      let onCallback21 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId21, onCallback21);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(eventId21);
        setTimeout(() => {
          let num: number = notificationemitter.getListenerCount(eventId21);
          hilog.info(0x000, `${TAG}`,
            `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s',
            JSON.stringify(num));
          expect(num).assertEqual(0);
          hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
          done();
        }, 200)
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0500
     * @tc.name   : testEmitterOncetwoEmittwo0005
     * @tc.desc   : test once interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEmitterOncetwoEmittwo0005', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL0, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOncetwoEmittwo';
      let eventId22 = 'eventId22'
      let innerEvent22: notificationemitter.InnerEvent = {
        eventId: 22
      }
      let onCallback22 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId22, onCallback22);
        notificationemitter.once(innerEvent22, onCallback22);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(eventId22);
        notificationemitter.emit(innerEvent22);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      setTimeout(() => {
        let num: number = notificationemitter.getListenerCount(eventId22);
        hilog.info(0x000, `${TAG}`,
          `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
        expect(num).assertEqual(0);
        let num1: number = notificationemitter.getListenerCount(innerEvent22.eventId);
        hilog.info(0x000, `${TAG}`,
          `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s',
          JSON.stringify(num1));
        expect(num1).assertEqual(0);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 3000)
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_ONCEINTERNETEVENT_0600
     * @tc.name   : testEmitterOnceoneEmitonenumber0006
     * @tc.desc   : test once interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnceoneEmitonenumber0006', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnceoneEmitonenumber';
      let eventId23 = 'eventId23'
      let innerEvent23: notificationemitter.InnerEvent = {
        eventId: 23
      }
      let onCallback23 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.once(eventId23, onCallback23);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId23);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit success');
        notificationemitter.emit(innerEvent23);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' emit failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      setTimeout(() => {
        let num1: number = notificationemitter.getListenerCount(eventId23);
        hilog.info(0x000, `${TAG}`,
          `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s',
          JSON.stringify(num1));
        expect(num1).assertEqual(1);
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' No subscription message');
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }, 3000)
    });
  });
}