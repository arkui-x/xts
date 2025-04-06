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

import { describe, beforeEach, it, expect, afterEach } from '@ohos/hypium'
import common from '@ohos.app.ability.common';

export function getContext(): common.UIAbilityContext {
    let context = AppStorage.get('context') as common.UIAbilityContext;
    console.info('getContext is ' + context);
    return context;
}

export function getApplicationContext(): common.ApplicationContext  {
    let context = AppStorage.get('applicationContext') as common.ApplicationContext;
    console.info('getApplicationContext is ' + context);
    return context;
}

export function getAbilityStageContext(): common.AbilityStageContext   {
    let context = AppStorage.get('abilityStageContext') as common.AbilityStageContext;
    console.info('getAbilityStageContext is ' + context);
    return context;
}


async function sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
}

export default function actsEventHubTest() {
    describe('actsEventHubTest', () => {
        afterEach(async () => {
            await sleep(300);
        });

        let count1 = 0;
        let count2 = 0;
        let count3 = 0;
        let callback1 = ()=>{
            console.info("===callback1 called");
            count1++;
        }
        let callback2 = ()=>{
            console.info("===callback2 called");
            count2++;
        }
        let callback3 = ()=>{
            console.info("===callback3 called");
            count3++;
        }

        beforeEach(() => {
            count1 = 0;
            count2 = 0;
            count3 = 0;
        })
        /*
        * @tc.number    : ACTS_UIAbilityContext_0100
        * @tc.name      : test EventHub
        * @tc.desc      : test basic on/off/emit
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0100',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0200
        * @tc.name      : test EventHub
        * @tc.desc      : test multiple callbacks
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0200',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback2);
            eventHub.on("event1", callback3);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(1)
            eventHub.off("event1", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            eventHub.off("event1");
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0300
        * @tc.name      : test EventHub
        * @tc.desc      : test different events
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0300',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event2", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            eventHub.off("event1");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            eventHub.off("event2");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0400
        * @tc.name      : test EventHub
        * @tc.desc      : test repeat on/off
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0400',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0500
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0500',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback);
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0600
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0600',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1");
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_UIAbilityContext_0700
        * @tc.name      : test EventHub
        * @tc.desc      : test call on/off in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_UIAbilityContext_0700',0, async (done:Function) => {
            const eventHub = getContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback1);
                    eventHub.on("event1", callback2);
                }
                eventHub.on("event1", callback);
            }
            func();
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count).assertEqual(1);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event1");
            expect(count).assertEqual(2);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0100
        * @tc.name      : test EventHub
        * @tc.desc      : test basic on/off/emit
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0100',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0200
        * @tc.name      : test EventHub
        * @tc.desc      : test multiple callbacks
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0200',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback2);
            eventHub.on("event1", callback3);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(1)
            eventHub.off("event1", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            eventHub.off("event1");
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0300
        * @tc.name      : test EventHub
        * @tc.desc      : test different events
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0300',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event2", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            eventHub.off("event1");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            eventHub.off("event2");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0400
        * @tc.name      : test EventHub
        * @tc.desc      : test repeat on/off
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0400',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0500
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0500',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback);
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0600
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0600',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1");
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_ApplicationContext_0700
        * @tc.name      : test EventHub
        * @tc.desc      : test call on/off in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_ApplicationContext_0700',0, async (done:Function) => {
            const eventHub = getApplicationContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback1);
                    eventHub.on("event1", callback2);
                }
                eventHub.on("event1", callback);
            }
            func();
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count).assertEqual(1);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event1");
            expect(count).assertEqual(2);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0100
        * @tc.name      : test EventHub
        * @tc.desc      : test basic on/off/emit
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0100',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0200
        * @tc.name      : test EventHub
        * @tc.desc      : test multiple callbacks
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0200',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback2);
            eventHub.on("event1", callback3);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(1)
            eventHub.off("event1", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            eventHub.off("event1");
            eventHub.emit("event1");
            expect(count1).assertEqual(2);
            expect(count2).assertEqual(1);
            expect(count3).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0300
        * @tc.name      : test EventHub
        * @tc.desc      : test different events
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0300',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event2", callback2);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            eventHub.off("event1");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            eventHub.off("event2");
            eventHub.emit("event1");
            eventHub.emit("event2");
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(2);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0400
        * @tc.name      : test EventHub
        * @tc.desc      : test repeat on/off
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0400',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            eventHub.on("event1", callback1);
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            eventHub.off("event1", callback1);
            eventHub.emit("event1");
            expect(count1).assertEqual(1);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0500
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0500',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback);
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0600
        * @tc.name      : test EventHub
        * @tc.desc      : test call off() in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0600',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1");
                }
                eventHub.on("event1", callback);
            }
            func();
            func();
            func();
            func();
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            eventHub.emit("event1");
            expect(count).assertEqual(4);
            done();
        })

        /*
        * @tc.number    : ACTS_AbilityStageContext_0700
        * @tc.name      : test EventHub
        * @tc.desc      : test call on/off in callback
        * @tc.size      : MediumTest
        * @tc.type      : Func
        * @tc.level     : Level 0
        */
        it('ACTS_AbilityStageContext_0700',0, async (done:Function) => {
            const eventHub = getAbilityStageContext().eventHub;
            let count = 0;
            let func = ()=>{
                let callback = ()=>{
                    count++;
                    eventHub.off("event1", callback1);
                    eventHub.on("event1", callback2);
                }
                eventHub.on("event1", callback);
            }
            func();
            eventHub.on("event1", callback1);
            eventHub.emit("event1");
            expect(count).assertEqual(1);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(0);
            eventHub.emit("event1");
            expect(count).assertEqual(2);
            expect(count1).assertEqual(1);
            expect(count2).assertEqual(1);
            done();
        })
        
        /*
        * @tc.number    : ACTS_Context_0100
        * @tc.name      : test EventHub
        * @tc.desc      : test is there any impact between these context
        */
        it('ACTS_Context_0100',0, async (done:Function) => {            
            const eventHb_a = getApplicationContext().eventHub;
            const eventHub_b = getAbilityStageContext().eventHub;
            eventHb_a.on("event1", callback1);
            eventHub_b.emit("event1");
            expect(count1).assertEqual(0);
            eventHb_a.off("event1", callback1);
            eventHub_b.emit("event1");
            expect(count1).assertEqual(0);
            done();
        })
    })
}
