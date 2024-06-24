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

export default function ActsEmitterTest() {
  describe('testEmitterNotification', () => {
    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0100
     * @tc.name   : testEmitterOnEventIdForIDELPriority
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnEventIdForIDELPriority', 0, (done: Function) => {
      let targetEventId : number = 1;
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
        console.log(' testEmitterOnEventIdForIDELPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0200
     * @tc.name   : testEmitterOnEventIdForHIGHPriority
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnEventIdForHIGHPriority', 0, (done: Function) => {
      let targetEventId : number = 1;
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
        console.log(' testEmitterOnEventIdForHIGHPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0300
     * @tc.name   : testEmitterOnEventIdForIMMEDIATEPriority
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnEventIdForIMMEDIATEPriority', 0, (done: Function) => {
      let targetEventId : number = 1;
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
      let onCallback = (): void => {
        console.log(' testEmitterOnEventIdForIMMEDIATEPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0400
     * @tc.name   : testEmitterOnEventIdForLOWPriority
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnEventIdForLOWPriority', 0, (done: Function) => {
      let targetEventId : number = 1;
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
      let onCallback = (): void => {
        console.log(' testEmitterOnEventIdForLOWPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0500
     * @tc.name   : testEmitterOnEventIdForStringEventIdMultipleCalled
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterOnEventIdForStringEventIdMultipleCalled', 0, (done: Function) => {
      let targetEventId : string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onCallback = (): void => {
        console.log(' testEmitterOnEventIdForStringEventIdMultipleCalled on callback called ');
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0600
     * @tc.name   : testEmitterOnEventIdForString
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnEventIdForString', 0, (done: Function) => {
      let targetEventId : string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onCallback = (): void => {
        console.log(' testEmitterOnEventIdForString on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_On_0700
     * @tc.name   : testEmitterOnEventIdForEmptyStringEventId
     * @tc.desc   : test on interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterOnEventIdForEmptyStringEventId', 0, (done: Function) => {
      let targetEventId : string = '';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onCallback = (): void => {
        console.log(' testEmitterOnEventIdForEmptyStringEventId on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0100
     * @tc.name   : testEmitterOnceEventIdForIDELPriority
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnceEventIdForIDELPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterOnEventIdForIDELPriority on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0200
     * @tc.name   : testEmitterOnceEventIdForHIGHPriority
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnceEventIdForHIGHPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterOnceEventIdForHIGHPriority on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0300
     * @tc.name   : testEmitterOnceEventIdForIMMEDIATEPriority
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnceEventIdForIMMEDIATEPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterOnceEventIdForIMMEDIATEPriority on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0400
     * @tc.name   : testEmitterOnceEventIdForLOWPriority
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnceEventIdForLOWPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterOnceEventIdForLOWPriority on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0500
     * @tc.name   : testEmitterOnceEventIdForStringEventIdMultipleCalled
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterOnceEventIdForStringEventIdMultipleCalled', 0, (done: Function) => {
      let targetEventId : string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onceCallback = (): void => {
        console.log(' testEmitterOnceEventIdForStringEventIdMultipleCalled on callback called ');
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0600
     * @tc.name   : testEmitterOnceEventIdForString
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOnceEventIdForString', 0, (done: Function) => {
      let targetEventId : string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_10",
          "id": 10,
        }
      };
      let onceCallback = (): void => {
        console.log(' testEmitterOnceEventIdForString on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Once_0700
     * @tc.name   : testEmitterOnceEventIdForEmptyStringEventId
     * @tc.desc   : test once interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterOnceEventIdForEmptyStringEventId', 0, (done: Function) => {
      let targetEventId : string = '';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_4",
          "id": 4,
        }
      };
      let onceCallback = (): void => {
        console.log(' testEmitterOnceEventIdForEmptyStringEventId on callback called ');
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_GetListenerCount_0100
     * @tc.name   : testEmitterGetListenerCount
     * @tc.desc   : test getListenerCount interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterGetListenerCount', 0, (done: Function) => {
      let targetEventId : string = '1';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_10",
          "id": 10,
        }
      };
      let onceCallback = (): void => {
        console.log(' testEmitterGetListenerCount on callback called ');
        done();
      };
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0100
     * @tc.name   : testEmitterEmitEventIdForIDELPriority
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitEventIdForIDELPriority', 0, (done: Function) => {
      let targetEventId : number = 1;
      let targetInnerEvent: emitter.InnerEvent = {
        eventId: targetEventId,
        priority: emitter.EventPriority.IDLE
      };
      let num: number = -1;
      let count: number = 0;
      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_0",
          "id": 1,
        }
      };
      let onceCallback = (eventDataValue: emitter.EventData): void => {
        console.log(' testEmitterEmitEventIdForIDELPriority on callback called ');
        ++count;
        expect(true).assertTrue();
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      setTimeout(() => {
        expect(count).assertEqual(1);
        done();
      }, 1000);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0200
     * @tc.name   : testEmitterEmitEventIdForHIGHPriority
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitEventIdForHIGHPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterEmitEventIdForHIGHPriority on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      setTimeout(() => {
        expect(count).assertEqual(1);
        done();
      }, 1000);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0300
     * @tc.name   : testEmitterEmitEventIdForIMMEDIATEPriority
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitEventIdForIMMEDIATEPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterEmitEventIdForIMMEDIATEPriority on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDatavalue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      setTimeout(() => {
        expect(count).assertEqual(1);
        done();
      }, 1000);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0400
     * @tc.name   : testEmitterEmitEventIdForLOWPriority
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitEventIdForLOWPriority', 0, (done: Function) => {
      let targetEventId : number = 2;
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
        console.log(' testEmitterEmitEventIdForLOWPriority on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.once(targetInnerEvent, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetInnerEvent, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      setTimeout(() => {
        expect(count).assertEqual(1);
        done();
      }, 1000);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0500
     * @tc.name   : testEmitterEmitEventIdWithoutOnEvent
     * @tc.desc   : test emit interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterEmitEventIdWithoutOnEvent', 0, (done: Function) => {
      let targetEventId : number = 1;
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0600
     * @tc.name   : testEmitterEmitStringEventId
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitStringEventId', 0, (done: Function) => {
      let targetEventId : string = '1';
      let num: number = -1;
      let count: number = 0;
      let eventDataValue: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let onceCallback = (eventDataValue: emitter.EventData): void => {
        console.log(' testEmitterEmitStringEventId on callback called ');
        expect(true).assertTrue();
        ++count;
        done();
      };
      try {
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(0);
        emitter.once(targetEventId, onceCallback);
        num = emitter.getListenerCount(targetEventId);
        expect(num).assertEqual(1);
        emitter.emit(targetEventId, eventDataValue);
      } catch (err) {
        expect(false).assertTrue();
        done();
      }
      setTimeout(() => {
        expect(count).assertEqual(1);
        done();
      }, 1000);
      emitter.off(targetEventId);
      done();
    })

    /*
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0700
     * @tc.name   : testEmitterEmitStringEventIdWithoutOnce
     * @tc.desc   : test emit interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterEmitStringEventIdWithoutOnce', 0, (done: Function) => {
      let targetEventId : string = '1';
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0800
     * @tc.name   : testEmitterEmitForOptionIDLE
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitForOptionIDLE', 0, (done: Function) => {
      let targetEventId : string = '1';
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
        console.log(' testEmitterEmitForOptionIDLE on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_0900
     * @tc.name   : testEmitterEmitForOptionHIGH
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitForOptionHIGH', 0, (done: Function) => {
      let targetEventId : string = '2';
      let eventData: emitter.EventData = {
        data: {
          "content": "message_6",
          "id": 6,
        }
      };
      let option: emitter.Options = {
        priority: emitter.EventPriority.HIGH
      }
      let onceCallback = (): void => {
        console.log(' testEmitterEmitForOptionHIGH on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_1000
     * @tc.name   : testEmitterEmitForOptionIMMEDIATE
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitForOptionIMMEDIATE', 0, (done: Function) => {
      let targetEventId : string = '2';
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
        console.log(' testEmitterEmitForOptionHIGH on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Emit_1100
     * @tc.name   : testEmitterEmitForOptionLOW
     * @tc.desc   : test emit interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterEmitForOptionLOW', 0, (done: Function) => {
      let targetEventId : string = '2';
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
        console.log(' testEmitterEmitForOptionHIGH on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0100
     * @tc.name   : testEmitterOffNumberEventId
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffNumberEventId', 0, (done: Function) => {
      let targetEventId : string = '1';
      let num : number = -1;
      let onCallback = (): void => {
        console.log(' testEmitterOffNumberEventId on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0200
     * @tc.name   : testEmitterOffStringEventId
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffStringEventId', 0, (done: Function) => {
      let targetEventId : string = '1';
      let num : number = -1;
      let onCallback = (): void => {
        console.log(' testEmitterOffNumberEventId on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0300
     * @tc.name   : testEmitterOffTargetCallbackIDLEEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffTargetCallbackIDLEEventPriority', 0, (done: Function) => {
      let targetEventId : number = 3;
      let num : number = -1;
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
        console.log(' testEmitterOffTargetCallbackIDLEEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0400
     * @tc.name   : testEmitterOffTargetCallbackHIGHEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffTargetCallbackHIGHEventPriority', 0, (done: Function) => {
      let targetEventId : number = 3;
      let num : number = -1;
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
        console.log(' testEmitterOffTargetCallbackHIGHEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0500
     * @tc.name   : testEmitterOffTargetCallbackIMMEDIATEEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffTargetCallbackIMMEDIATEEventPriority', 0, (done: Function) => {
      let targetEventId : number = 3;
      let num : number = -1;
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
        console.log(' testEmitterOffTargetCallbackIMMEDIATEEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0600
     * @tc.name   : testEmitterOffTargetCallbackLOWEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffTargetCallbackLOWEventPriority', 0, (done: Function) => {
      let targetEventId : number = 3;
      let num : number = -1;
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
        console.log(' testEmitterOffTargetCallbackLOWEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0700
     * @tc.name   : testEmitterOffStringEventIdIDLEEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffStringEventIdIDLEEventPriority', 0, (done: Function) => {
      let targetEventId : string = '3';
      let num : number = -1;
      let onCallback = (): void => {
        console.log(' testEmitterOffStringEventIdIDLEEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0800
     * @tc.name   : testEmitterOffStringEventIdHIGHEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffStringEventIdHIGHEventPriority', 0, (done: Function) => {
      let targetEventId : string = '3';
      let num : number = -1;
      let eventData: emitter.EventData = {
        data: {
          "content": "message_16",
          "id": 3,
        }
      };
      let onCallback = (): void => {
        console.log(' testEmitterOffStringEventIdHIGHEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_0900
     * @tc.name   : testEmitterOffStringEventIdIMMEDIATEEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffStringEventIdIMMEDIATEEventPriority', 0, (done: Function) => {
      let targetEventId : string = '3';
      let num : number = -1;

      let onCallback = (): void => {
        console.log(' testEmitterOffStringEventIdIMMEDIATEEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_1000
     * @tc.name   : testEmitterOffStringEventIdLOWEventPriority
     * @tc.desc   : test off interface success
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 0
     */
    it('testEmitterOffStringEventIdLOWEventPriority', 0, (done: Function) => {
      let targetEventId : string = '3';
      let num : number = -1;
      let onCallback = (): void => {
        console.log(' testEmitterOffStringEventIdLOWEventPriority on callback called ');
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
     * @tc.number : Sub_Notification_Emitter_Subscribe_Off_1100
     * @tc.name   : testEmitterOffStringWithoutOnEventId
     * @tc.desc   : test off interface failed
     * @tc.size   : Large-scaleTest
     * @tc.type   : Interface
     * @tc.level  : Level 2
     */
    it('testEmitterOffStringWithoutOnEventId', 0, (done: Function) => {
      let targetEventId : string = '3';
      let num : number = -1;
      let onCallback = (): void => {
        console.log(' testEmitterOffStringWithoutOnEventId on callback called ');
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