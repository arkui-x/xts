/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import hilog from '@ohos.hilog';
import emitter from '@ohos.events.emitter';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ActsEmitterTest() {
  describe('testEmitterNotification', () => {


    beforeEach(async () => {
      await sleep(2000);

    })
    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0100
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_On_0100', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IDLE
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0100 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.on(targetInnerEvent, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0200
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_On_0200', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.HIGH
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0200 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.on(targetInnerEvent, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0300
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_On_0300', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      await sleep(1000)
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0300 on callback called ');
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0400
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_On_0400', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.LOW
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      await sleep(1000)
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0400 on callback called ');
        done();
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0500
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_On_0500', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0500 on callback called ');
      };
      await sleep(1000)
      try {
        emitter.on(targetEventId, onCallback);
        emitter.on(targetEventId, onCallback);
        done();
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0600
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_On_0600', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0600 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.on(targetEventId, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_On_0700
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_On_0700', 0, async (done: Function) => {
      let targetEventId: string = '';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_On_0700 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.on(targetEventId, onCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(undefined);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0100
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0100', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IDLE
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0100 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetInnerEvent, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0200
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0200', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.HIGH
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0200 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetInnerEvent, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0300
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0300', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0300 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetInnerEvent, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0400
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0400', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };

      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0400 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetInnerEvent, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0500
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0500', 0, async (done: Function) => {
      let targetEventId: string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0500 on callback called ');
      };
      await sleep(1000)
      try {
        emitter.once(targetEventId, onceCallback);
        emitter.once(targetEventId, onceCallback);
        done();
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0600
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0600', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_10",
          "id": 10,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0600 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetEventId, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Once_0700
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_Once_0700', 0, async (done: Function) => {
      let targetEventId: string = '';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Once_0700 on callback called ');
      };
      await sleep(1000)
      try {
        emitter.once(targetEventId, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(undefined);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_GetListenerCount_0100
     * @tc.desc   : test getListenerCount interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_GetListenerCount_0100', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_10",
          "id": 10,
        }
      };
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_GetListenerCount_0100 on callback called ');
        done();
      };
      await sleep(1000)
      try {
        emitter.once(targetEventId, onceCallback);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      let num: number = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0100
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0100', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let num: number = -1;
      let count: number = 0;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.HIGH
      };

      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };

      let onceCallback = (eventDataValue: emitter.EventData): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0100 on callback called');
        ++count;
        expect(true).assertTrue();
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        await sleep(2000)
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      await sleep(2000)
      expect(count).assertEqual(1)
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0200
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0200', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let count: number = 0;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.HIGH
      };
      let num: number = -1;
      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (eventDatavalue: emitter.EventData): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0200 on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        await sleep(2000)
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0200 on callback called 7777+  ' + num);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      await sleep(2000)
      expect(count).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0300
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0300', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let count: number = 0;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };
      let num: number = -1;
      let eventDatavalue: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (eventDatavalue: emitter.EventData): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0300 on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        await sleep(2000)
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDatavalue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      await sleep(2000)
      expect(count).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })


    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0400
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0400', 0, async (done: Function) => {
      let targetEventId: number = 2;
      let count: number = 0;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.LOW
      };
      let num: number = -1;
      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (eventDataValue: emitter.EventData): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0400 on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };

      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        await sleep(2000)
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      await sleep(2000)
      expect(count).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0500
     * @tc.desc   : test emit interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0500', 0, async (done: Function) => {
      let targetEventId: number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.LOW
      };
      let num: number = -1;
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };

      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.emit(targetInnerEvent);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0600
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0600', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let num: number = -1;
      let count: number = 0;
      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (eventDataValue: emitter.EventData): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0600 on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        await sleep(2000)
        emitter.once(targetEventId, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetEventId, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      await sleep(2000)
      expect(count).assertEqual(1);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0700
     * @tc.desc   : test emit interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0700', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let num: number = -1;
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.emit(targetEventId);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0800
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0800', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let option: emitter.Options = {
        priority: emitter.EventPriority.IDLE
      }
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0800 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.once(targetEventId, onceCallback);
        emitter.emit(targetEventId, option, eventData);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_0900
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_0900', 0, async (done: Function) => {
      let targetEventId: string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let option: emitter.Options = {
        priority: emitter.EventPriority.IDLE
      }
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_0900 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.once(targetEventId, onceCallback);
        emitter.emit(targetEventId, option, eventData);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_1000
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_1000', 0, async (done: Function) => {
      let targetEventId: string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let option: emitter.Options = {
        priority: emitter.EventPriority.IMMEDIATE
      }
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_1000 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.once(targetEventId, onceCallback);
        emitter.emit(targetEventId, option, eventData);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Emit_1100
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Emit_1100', 0, async (done: Function) => {
      let targetEventId: string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let option: emitter.Options = {
        priority: emitter.EventPriority.LOW
      }
      let onceCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Emit_1100 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.once(targetEventId, onceCallback);
        emitter.emit(targetEventId, option, eventData);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0100
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0100', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let num: number = -1;
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0100 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.off(targetEventId);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }

      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0200
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0200', 0, async (done: Function) => {
      let targetEventId: string = '1';
      let num: number = -1;
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0200 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0300
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0300', 0, async (done: Function) => {
      let targetEventId: number = 3;
      let num: number = -1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IDLE
      };
      let eventData: emitter.EventData = {
        data: {
          "content": "message_12",
          "id": 12,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0300 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0400
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0400', 0, async (done: Function) => {
      let targetEventId: number = 3;
      let num: number = -1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.HIGH
      };
      let eventData: emitter.EventData = {
        data: {
          "content": "message_12",
          "id": 12,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0400 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0500
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0500', 0, async (done: Function) => {
      let targetEventId: number = 3;
      let num: number = -1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };
      let eventData: emitter.EventData = {
        data: {
          "content": "message_12",
          "id": 12,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0500 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0600
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0600', 0, async (done: Function) => {
      let targetEventId: number = 3;
      let num: number = -1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IMMEDIATE
      };
      let eventData: emitter.EventData = {
        data: {
          "content": "message_12",
          "id": 12,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0600 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetInnerEvent, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0700
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0700', 0, async (done: Function) => {
      let targetEventId: string = '3';
      let num: number = -1;
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0700 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })
    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0800
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0800', 0, async (done: Function) => {
      let targetEventId: string = '3';
      let num: number = -1;
      let eventData: emitter.EventData = {
        data: {
          "content": "message_16",
          "id": 3,
        }
      };
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0800 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off('3', onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_0900
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_0900', 0, async (done: Function) => {
      let targetEventId: string = '3';
      let num: number = -1;

      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_0900 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off('3', onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_1000
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('Sub_Notification_Emitter_Subscribe_Off_1000', 0, async (done: Function) => {
      let targetEventId: string = '3';
      let num: number = -1;
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_1000 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        emitter.on(targetEventId, onCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off('3', onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })

    /*
     * @tc.name   : Sub_Notification_Emitter_Subscribe_Off_1100
     * @tc.desc   : test off interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('Sub_Notification_Emitter_Subscribe_Off_1100', 0, async (done: Function) => {
      let targetEventId: string = '3';
      let num: number = -1;
      let onCallback = (): void => {
        console.log(' Sub_Notification_Emitter_Subscribe_Off_1100 on callback called ');
        expect(true).assertTrue();
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      emitter.off(targetEventId, onCallback);
      num = emitter.getListenerCount(targetEventId);
      expect(num).assertEqual(0);
      done();
    })
  })
}