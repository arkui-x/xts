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

export default function EmitterOffTest() {
  describe('EmitterOffTest', () => {
    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0100
     * @tc.name   : testEmitterOnoneOffone0001
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnoneOffone0001', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnoneOffone';
      let eventId30 = 'eventId30'
      let onCallback30 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId30, onCallback30);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId30);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      notificationemitter.off(eventId30, onCallback30);
      let num1: number = notificationemitter.getListenerCount(eventId30);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0200
     * @tc.name   : testEmitterOnthreeOfftwo0002
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOnthreeOfftwo0002', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOnthreeOfftwo';
      let eventId31 = 'eventId31'
      let onCallback31 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId31, onCallback31);
        notificationemitter.on(eventId31, onCallback31);
        notificationemitter.on(eventId31, onCallback31);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId31);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      notificationemitter.off(eventId31, onCallback31);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off1 success');
      let num1: number = notificationemitter.getListenerCount(eventId31);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(0);
      notificationemitter.off(eventId31, onCallback31);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off2 success');
      let num2 = notificationemitter.getListenerCount(eventId31);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num2));
      expect(num2).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0300
     * @tc.name   : testEmitterOneventIdforemptyOffeventIdforempty0003
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforemptyOffeventIdforempty0003', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforemptyOffeventIdforempty';
      let eventId32 = ''
      let onCallback32 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId32, onCallback32);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      notificationemitter.off(eventId32, onCallback32);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
      let num: number = notificationemitter.getListenerCount(eventId32);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(undefined);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0400
     * @tc.name   : testEmitterOneventIdforwhitespaceOffeventIdforwhitespace0004
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdforwhitespaceOffeventIdforwhitespace0004', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdforwhitespaceOffeventIdforwhitespace';
      let eventId33 = ' '
      let onCallback33 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId33, onCallback33);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId33);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      notificationemitter.off(eventId33, onCallback33);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
      let num1: number = notificationemitter.getListenerCount(eventId33);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0500
     * @tc.name   : testEmitterOntwoOfftwo0005
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testEmitterOntwoOfftwo0005', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL0, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOntwoOfftwo';
      let eventId34 = 'eventId34'
      let innerEvent34: notificationemitter.InnerEvent = {
        eventId: 34
      }
      let onCallback34 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let onCallback134 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId34, onCallback34);
        notificationemitter.on(innerEvent34, onCallback134);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(innerEvent34.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(1);
      let num1: number = notificationemitter.getListenerCount(eventId34);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(1);
      notificationemitter.off(innerEvent34.eventId, onCallback134);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off1 success');
      notificationemitter.off(eventId34, onCallback34);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off2 success');
      let num2 = notificationemitter.getListenerCount(eventId34);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num2));
      expect(num2).assertEqual(0);
      let num3 = notificationemitter.getListenerCount(innerEvent34.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num3));
      expect(num3).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0600
     * @tc.name   : testEmitterOntwocallbackOfftwocallback0006
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOntwocallbackOfftwocallback0006', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOntwocallbackOfftwocallback';
      let eventId61 = 'eventId61'
      let onCallback161 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let onCallback261 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' once2 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId61, onCallback161);
        notificationemitter.on(eventId61, onCallback261);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId61, onCallback161);
        notificationemitter.off(eventId61, onCallback261);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId61);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0700
     * @tc.name   : testEmitterOneventIdonestringOffeventIdonestring0007
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdonestringOffeventIdonestring0007', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdonestringOffeventIdonestring';
      let eventId65 = 'eventId65'
      let onCallback165 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId65, onCallback165);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId65);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId65);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0800
     * @tc.name   : testEmitterOntwostringOfftwo0008
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOntwostringOfftwo0008', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOntwostringOfftwo';
      let eventId66 = 'eventId66'
      let onCallback166 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId66, onCallback166);
        notificationemitter.on(eventId66, onCallback166);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num1: number = notificationemitter.getListenerCount(eventId66);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(1);
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId66);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num2 = notificationemitter.getListenerCount(eventId66);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num2));
      expect(num2).assertEqual(0);
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId66);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num3 = notificationemitter.getListenerCount(eventId66);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num3));
      expect(num3).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_0900
     * @tc.name   : testEmitterOneventIdemptyOffeventIdonestring0009
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdemptyOffeventIdonestring0009', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdemptyOffeventIdonestring';
      let eventId67 = ''
      let onCallback167 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId67, onCallback167)
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId67);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId67);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(undefined);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_1000
     * @tc.name   : testEmitterOneventIdwhitespaceOffeventIdonestring0010
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdwhitespaceOffeventIdonestring0010', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdwhitespaceOffeventIdonestring';
      let eventId68 = ' '
      let onCallback168 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId68, onCallback168);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId68);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId68);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_1100
     * @tc.name   : testEmitterOneventIdonestringonenumberOfftwo0011
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdonestringonenumberOfftwo0011', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdonestringonenumberOfftwo';
      let eventId69 = 'eventId69'
      let innerEvent69: notificationemitter.InnerEvent = {
        eventId: 69
      }
      let onCallback169 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId69, onCallback169);
        notificationemitter.on(innerEvent69, onCallback169);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId69);
        notificationemitter.off(innerEvent69.eventId);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId69);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(0);
      let num1: number = notificationemitter.getListenerCount(innerEvent69.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });

    /**
     * @tc.number : SUB_NOTIFICATION_EMITTER_OFFINTERNETEVENT_1200
     * @tc.name   : testEmitterOneventIdstrnumOffstrnum0012
     * @tc.desc   : test off interface success
     * @tc.size   : LargeTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testEmitterOneventIdstrnumOffstrnum0012', TestType.FUNCTION | Size.LARGETEST | Level.LEVEL3, (done: Function) => {
      let TEST_CASE_NAME = 'testEmitterOneventIdstrnumOffstrnum';
      let eventId86 = 'eventId86'
      let innerEvent86: notificationemitter.InnerEvent = {
        eventId: 86
      }
      let onCallback186 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on1 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let onCallback286 = (): void => {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on2 success');
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case start');
        notificationemitter.on(eventId86, onCallback186);
        notificationemitter.on(innerEvent86, onCallback286);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' on failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      try {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off success');
        notificationemitter.off(eventId86);
        notificationemitter.off(innerEvent86.eventId);
      } catch (err) {
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' off failed,data is %{public}s',
          JSON.stringify(err));
        expect(false).assertTrue();
        hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
        done();
      }
      let num: number = notificationemitter.getListenerCount(eventId86);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num));
      expect(num).assertEqual(0);
      let num1: number = notificationemitter.getListenerCount(innerEvent86.eventId);
      hilog.info(0x000, `${TAG}`,
        `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' getListenerCount success,data is %{public}s', JSON.stringify(num1));
      expect(num1).assertEqual(0);
      hilog.info(0x000, `${TAG}`, `${TEST_SUITE_NAME}#${TEST_CASE_NAME}` + ' test case end');
      done();
    });
  });
}