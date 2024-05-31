/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { describe, it, expect } from '@ohos/hypium';
import request from '@ohos.request';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';

export default function requestDownTest() {
  describe('requestDownTest', () => {
    let baseContext: common.Context = AppStorage.get('context') as common.Context;
    console.info('====>baseContext:'+JSON.stringify(baseContext))

    /*
     * @tc.number: SUB_Request_RequestDown_Action_Func_0100
     * @tc.name: SUB_Request_RequestDown_Action_Func_0100
     * @tc.desc: request.agent.Action
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_Action_Func_0100', 0, (done: Function) => {
      let download: Number = request.agent.Action.DOWNLOAD;
      let upload: Number = request.agent.Action.UPLOAD;
      expect(download).assertEqual(0);
      expect(upload).assertEqual(1);
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_Mode_Func_0200
     * @tc.name: SUB_Request_RequestDown_Mode_Func_0200
     * @tc.desc: request.agent.Mode
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_Mode_Func_0200', 0, (done: Function) => {
      let foreground: Number = request.agent.Mode.FOREGROUND;
      expect(foreground).assertEqual(1);
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_Network_Func_0300
     * @tc.name: SUB_Request_RequestDown_Network_Func_0300
     * @tc.desc: request.agent.Network
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_Network_Func_0300', 0, (done: Function) => {
      let any: Number = request.agent.Network.ANY;
      let wifi: Number = request.agent.Network.WIFI;
      let cellular: Number = request.agent.Network.CELLULAR;
      expect(any).assertEqual(0);
      expect(wifi).assertEqual(1);
      expect(cellular).assertEqual(2);
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_State_Func_0400
     * @tc.name: SUB_Request_RequestDown_State_Func_0400
     * @tc.desc: request.agent.State
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_State_Func_0400', 0, (done: Function) => {
      let initialized: Number = request.agent.State.INITIALIZED;
      let waiting: Number = request.agent.State.WAITING;
      let running: Number = request.agent.State.RUNNING;
      let retrying: Number = request.agent.State.RETRYING;
      let paused: Number = request.agent.State.PAUSED;
      let stopped: Number = request.agent.State.STOPPED;
      let completed: Number = request.agent.State.COMPLETED;
      let failed: Number = request.agent.State.FAILED;
      let removed: Number = request.agent.State.REMOVED;
      expect(initialized).assertEqual(0x00);
      expect(waiting).assertEqual(0x10);
      expect(running).assertEqual(0x20);
      expect(retrying).assertEqual(0x21);
      expect(paused).assertEqual(0x30);
      expect(stopped).assertEqual(0x31);
      expect(completed).assertEqual(0x40);
      expect(failed).assertEqual(0x41);
      expect(removed).assertEqual(0x50);
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_Faults_Func_0500
     * @tc.name: SUB_Request_RequestDown_Faults_Func_0500
     * @tc.desc: request.agent.Faults
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_Faults_Func_0500', 0, (done: Function) => {
      let others: Number = request.agent.Faults.OTHERS;
      let disconnected: Number = request.agent.Faults.DISCONNECTED;
      let timeout: Number = request.agent.Faults.TIMEOUT;
      let protocol: Number = request.agent.Faults.PROTOCOL;
      let fsio: Number = request.agent.Faults.FSIO;
      expect(others).assertEqual(0xFF);
      expect(disconnected).assertEqual(0x00);
      expect(timeout).assertEqual(0x10);
      expect(protocol).assertEqual(0x20);
      expect(fsio).assertEqual(0x40);
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_create_remove_Func_0600
     * @tc.name: SUB_Request_RequestDown_create_remove_Func_0600
     * @tc.desc: request.agent.create and request.agent.remove (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_create_remove_Func_0600', 0, async (done: Function) => {
      console.info('====>====>SUB_Request_RequestDown_create_remove_Func_0600 start:')
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_create_remove_Func_0600',
        overwrite: true,
      };
      console.info('====>SUB_Request_RequestDown_create_remove_Func_0600 docPath:'+JSON.stringify(config))
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest006 create Task success:${JSON.stringify(task)}`);
        expect(typeof task === 'object').assertTrue();
        // remove Task
        await request.agent.remove(task.tid);
        console.info(`====>remove requestTest006 task success!`);
        done();
      } catch (err) {
        console.info(`====>requestTest006 Catch: ${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_create_remove_Func_0700
     * @tc.name: SUB_Request_RequestDown_create_remove_Func_0700
     * @tc.desc: request.agent.create and request.agent.remove (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_create_remove_Func_0700', 0, async (done: Function) => {
      
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_create_remove_Func_0700',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      // create Task
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.error(`====>requestTest007 create Task fail:${err}`);
            expect(err).assertFail();
          } else {
            console.log(`====>requestTest007 create Task success:${task.tid}`);
            expect(typeof task === 'object').assertTrue();
            // remove Task
            request.agent.remove(task.tid, (err: BusinessError) => {
              try {
                if (err) {
                  console.error(`====>requestTest007 task fail:${JSON.stringify(err)}`);
                  expect(err).assertFail();
                  done();
                }
                console.log(`====>requestTest007 task success!:${err}`);
                expect(true).assertTrue();
                done();
              } catch (err) {
                console.log(`====>requestTest007 remove catch:${JSON.stringify(err)}`);
                done();
              };
            });
          };
        } catch (err) {
          console.log(`====>requestTest007 create catch:${JSON.stringify(err)}`);
          done();
        };
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_remove_Func_0800
     * @tc.name: SUB_Request_RequestDown_remove_Func_0800
     * @tc.desc: request.agent.remove /task not found (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_remove_Func_0800', 0, async (done: Function) => {
      try {
        await request.agent.remove('task.tid');
        console.info('====>remove requestTest008 task success!');
        expect().assertFail();
        done();
      } catch (err) {
        console.error(`====>remove requestTest008 task fail:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(21900006);
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_remove_Func_0900
     * @tc.name: SUB_Request_RequestDown_remove_Func_0900
     * @tc.desc: request.agent.remove /task not found (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_remove_Func_0900', 0, async (done: Function) => {
      request.agent.remove('task.tid', (err: BusinessError) => {
        try {
          if (err) {
            console.error(`====>remove requestTest009 task fail:${JSON.stringify(err)}`);
            expect(err.code).assertEqual(21900006);
            done();
          } else {
            console.info('====>remove requestTest009 task success!');
            expect(err).assertFail();
            done();
          }
          ;
        } catch (err) {
          console.info('remove requestTest009 task catch!');
          done();
        }
        ;
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_show_Func_1000
     * @tc.name: SUB_Request_RequestDown_show_Func_1000
     * @tc.desc: request.agent.show (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_show_Func_1000', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_show_Func_1000',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        network: request.agent.Network.WIFI
      };
      let task: request.agent.Task;
      try {
        task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest010 create Task success:${task.tid}`);
        let taskInfo: request.agent.TaskInfo = await request.agent.show(task.tid);
        console.info(`====>requestTest010 showTask success:${JSON.stringify(taskInfo)}`);
        expect(typeof taskInfo === 'object').assertTrue();
        // remove Task
        await request.agent.remove(task.tid);
        done();
      } catch (err) {
        console.error(`====>requestTest010 showTask fail:${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_show_Func_1100
     * @tc.name: SUB_Request_RequestDown_show_Func_1100
     * @tc.desc: request.agent.show (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_show_Func_1100', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_show_Func_1100',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.log(`====>requestTest011 create Task success:${task.tid}`);
      request.agent.show(task.tid, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
        try {
          if (err) {
            console.error(`====>requestTest011 showTask fail:${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          } else {
            console.log(`====>requestTest011 showTask success:${JSON.stringify(taskInfo)}`);
            expect(typeof taskInfo === 'object').assertTrue();
            // remove Task
            await request.agent.remove(task.tid);
            done();
          };
        } catch (err) {
          console.log(`====>requestTest011 showTask catch:${err}`);
          done();
        };
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_show_Func_1200
     * @tc.name: SUB_Request_RequestDown_show_Func_1200
     * @tc.desc: request.agent.show /task not found (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_show_Func_1200', 0, async (done: Function) => {
      try {
        await request.agent.show('task.tid');
        console.info('====>requestTest012 showTask success');
        expect().assertFail();
        done();
      } catch (err) {
        console.error(`====>requestTest012 showTask fail:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(21900006);
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_show_Func_1300
     * @tc.name: SUB_Request_RequestDown_show_Func_1300
     * @tc.desc: request.agent.show /task not found (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_show_Func_1300', 0, async (done: Function) => {
      request.agent.show('task.tid', (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
        try {
          if (err) {
            console.error(`====>requestTest013 showTask fail:${JSON.stringify(err)}`);
            expect(err.code).assertEqual(21900006);
            done();
          } else {
            console.info(`====>requestTest013 showTask success:${taskInfo.tid}`);
            expect().assertFail();
            done();
          };
        } catch (err) {
          console.info(`====>requestTest013 showTask success:${err}`);
          done();
        };
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_touch_Func_1400
     * @tc.name: SUB_Request_RequestDown_touch_Func_1400
     * @tc.desc:request.agent.touch (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_touch_Func_1400', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_touch_Func_1400',
        overwrite: true,
        mode:request.agent.Mode.FOREGROUND,
        token: "is test014"
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest014 create Task success:${task.tid}`);
      console.info(`====>requestTest014 create typeof Task tid:${typeof task.tid}`);
      console.info(`====>requestTest014 create config.token:${config.token}`);
      console.info(`====>requestTest014 create typeof config.token:${typeof config.token}`);
      try{
        let token: string = '';
        let tokenConfig: string = token + config.token;
        let taskInfo: request.agent.TaskInfo = await request.agent.touch(task.tid, tokenConfig);
        expect(typeof taskInfo).assertEqual('object');
        done();
      }catch(err){
        console.error(`====>requestTest014 touchTask fail:${JSON.stringify(err)}`);
        await request.agent.remove(task.tid);
        expect(err).assertFail();
        done();
      }
    });
    
    /*
     * @tc.number: SUB_Request_RequestDown_touch_Func_1500
     * @tc.name: SUB_Request_RequestDown_touch_Func_1500
     * @tc.desc:request.agent.touch (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_touch_Func_1500', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_touch_Func_1500',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        token: 'is test015'
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.log(`====>requestTest015 create Task success:${task.tid}`);
      request.agent.touch(task.tid, config.token, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
        try {
          if (err) {
            console.log(`====>requestTest015 touchTask fail:${JSON.stringify(err)}`);
            await request.agent.remove(task.tid);
            expect().assertFail();
            done();
          } else {
            console.log(`====>requestTest015 touchTask success:${taskInfo.tid}`);
            expect(typeof taskInfo === 'object').assertTrue();
            // remove Task
            await request.agent.remove(task.tid);
            done();
          };
        } catch (err) {
          console.log(`====>requestTest015 touchTask catch:${err}`);
          await request.agent.remove(task.tid);
          done();
        };
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_touch_Func_1600
     * @tc.name: SUB_Request_RequestDown_touch_Func_1600
     * @tc.desc: request.agent.touch /token is wrong (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_touch_Func_1600', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_touch_Func_1600',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        token: "is test016"
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest016 create Task success:${task.tid}`);
      try {
        let taskInfo: request.agent.TaskInfo = await request.agent.touch(task.tid, 'wrong');
        console.info(`====>requestTest016 touchTask success:${taskInfo}`);
        expect().assertFail();
        await request.agent.remove(task.tid);
        done();
      } catch (err) {
        console.error(`====>'requestTest016 touchTask catch:' ${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
        await request.agent.remove(task.tid);
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_touch_Func_1700
     * @tc.name: SUB_Request_RequestDown_touch_Func_1700
     * @tc.desc: request.agent.touch /token is wrong (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_touch_Func_1700', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_touch_Func_1700',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        token: "is test017"
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest017 create Task success: ${task.tid}`);
      try {
        request.agent.touch(task.tid, 'wrong', async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
          if (err) {
            console.error(`====>requestTest017 touchTask fail:${JSON.stringify(err)}`);
            expect().assertFail();
            await request.agent.remove(task.tid);
            done();
          } else {
            console.info(`====>requestTest017 touchTask success:${taskInfo.tid}`);
            expect().assertFail();
            await request.agent.remove(task.tid);
            done();
          }
          ;
        });
      } catch (err) {
        console.error(`====>requestTest017 touchTask catch:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
        await request.agent.remove(task.tid);
        done();
      }
      ;
    });

    /*
     * @tc.number: SUB_Request_RequestDown_touch_Func_1800
     * @tc.name: SUB_Request_RequestDown_touch_Func_1800
     * @tc.desc: request.agent.touch /task not found (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_touch_Func_1800', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_touch_Func_1800',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        token: "is test018"
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest018 create Task success:${task.tid}`);
      request.agent.touch('task.tid', config.token, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {          
        try {
          if (err) {
            console.error(`====>requestTest018 touchTask fail:${JSON.stringify(err)}`);
            expect(err.code).assertEqual(21900006);
            await request.agent.remove(task.tid);
            done();
          } else {
            console.info(`====>requestTest018 touchTask success:${taskInfo.tid}`);
            await request.agent.remove(task.tid);
            expect().assertFail();
            done();
          };
        } catch (err) {
          console.error(`====>requestTest018 touchTask catch:${JSON.stringify(err)}`);
          await request.agent.remove(task.tid);
          done();
        };
      });
      
    });

    /*
     * @tc.number: SUB_Request_RequestDown_search_Func_1900
     * @tc.name: SUB_Request_RequestDown_search_Func_1900
     * @tc.desc: request.agent.search /default Filter (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_search_Func_1900', 0, async (done: Function) => {
      request.agent.search((err: BusinessError, data: Array<string>) => {
        try {
          if (err) {
            console.error(`====>requestTest019 searchTask fail:${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          } else {
            console.log(`====>requestTest019 searchTask success: ${typeof data}`);
            expect(typeof data === 'object').assertTrue();
            done();
          };
        } catch (err) {
          console.error(`====>requestTest019 searchTask catch:${JSON.stringify(err)}`);
          done();
        };
      });
    });

    /*
      * @tc.number: SUB_Request_RequestDown_search_Func_2000
      * @tc.name: SUB_Request_RequestDown_search_Func_2000
      * @tc.desc: request.agent.search /set Filter (callback)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_search_Func_2000', 0, async (done: Function) => {
      let filter: request.agent.Filter = {
        state: request.agent.State.INITIALIZED,
        action: request.agent.Action.DOWNLOAD,
        mode: request.agent.Mode.FOREGROUND,
      };
      request.agent.search(filter, (err: BusinessError, data: Array<string>) => {
        try {
          if (err) {
            console.error(`====>requestTest020 searchTask fail:${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          } else {
            console.log('====>requestTest020 searchTask success');
            expect(typeof data === 'object').assertTrue();
            done();
          };
        } catch (err) {
          console.error(`====>requestTest020 searchTask catch:${JSON.stringify(err)}`);
          done();
        };
      });
    });

    /*
      * @tc.number: SUB_Request_RequestDown_search_Func_2100
      * @tc.name: SUB_Request_RequestDown_search_Func_2100
      * @tc.desc: request.agent.search /set Filter (promise)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_search_Func_2100', 0, async (done: Function) => {
      let filter: request.agent.Filter = {
        state: request.agent.State.INITIALIZED,
        action: request.agent.Action.DOWNLOAD,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        let data: Array<string> = await request.agent.search(filter);
        console.info('====>requestTest021 searchTask success');
        expect(typeof data === 'object').assertTrue();
        done();
      } catch (err) {
        console.error(`====>requestTest021 searchTask catch:${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      }
    });

    /*
      * @tc.number: SUB_Request_RequestDown_start_Func_2200
      * @tc.name: SUB_Request_RequestDown_start_Func_2200
      * @tc.desc: task.start (promise)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_start_Func_2200', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_start_Func_2200',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        // create Task
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest022 create Task success:${task.tid}`);
        await task.start();
        console.info(`====>requestTest022 start success!`);
        // remove Task
        await request.agent.remove(task.tid);
        done();
      } catch (err) {
        console.error(`====>requestTest022 start fail:${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      }
    });

    /*
      * @tc.number: SUB_Request_RequestDown_start_Func_2300
      * @tc.name: SUB_Request_RequestDown_start_Func_2300
      * @tc.desc: task.start (callback)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_start_Func_2300', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_start_Func_2300',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.log(`requestTest023 create Task success:${task.tid}`);
      task.start(async (err: BusinessError) => {
        try {
          if (err) {
            console.error(`====>requestTest023 start fail:${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          }
          console.log(`====>requestTest023 start success`);
          expect(true).assertTrue();
          await request.agent.remove(task.tid);
          done();
        } catch (err) {
          console.log(`====>requestTest023 start catch:${err}`);
          await request.agent.remove(task.tid);
          done();
        };
      });
    });

    /*
      * @tc.number: SUB_Request_RequestDown_stop_Func_2400
      * @tc.name: SUB_Request_RequestDown_stop_Func_2400
      * @tc.desc: task.stop (promise)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_stop_Func_2400', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_stop_Func_2400',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        // create Task
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest024 create Task success:${task.tid}`);
        await task.start();
        console.info('====>requestTest024 start success');
        await task.stop();
        done();
      } catch (err) {
        console.error(`====>requestTest024 stop fail:${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      }
    });

    /*
      * @tc.number: SUB_Request_RequestDown_stop_Func_2500
      * @tc.name: SUB_Request_RequestDown_stop_Func_2500
      * @tc.desc: task.stop (callback)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 1
      */
    it('SUB_Request_RequestDown_stop_Func_2500', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_stop_Func_2500',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
        // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest025 create Task success:${task.tid}`);
      await task.start();
      console.info('====>requestTest025 start success');
      task.stop((err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>requestTest025 stop fail:${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          } else {
            console.info('====>requestTest025 stop success');
            expect(true).assertTrue();
            done();
          };
        }
        catch (err) {
          console.info(`====>requestTest025 catch: ${JSON.stringify(err)}`);
          done();
        };
      });
    });

    /*
      * @tc.number: SUB_Request_RequestDown_start_Func_2600
      * @tc.name: SUB_Request_RequestDown_start_Func_2600
      * @tc.desc: task.start()  /task state error. (promise)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 2
      */
    it('SUB_Request_RequestDown_start_Func_2600', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_start_Func_2600',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        // create Task
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest026 create Task success:${task.tid}`);
        await request.agent.remove(task.tid);
        console.info('====>requestTest026 remove success');
        await task.start();
        expect().assertFail();
        done();
      } catch (err) {
        console.info(`====>requestTest026 start fail:${err}--${err.code}`);
        expect(err.code).assertEqual(21900007);
        done();
      }
    });

    /*
      * @tc.number: SUB_Request_RequestDown_start_Func_2700
      * @tc.name: SUB_Request_RequestDown_start_Func_2700
      * @tc.desc: task.start()  /task state error. (callback)
      * @tc.size: MediumTest
      * @tc.type: Method
      * @tc.level: Level 2
      */
    it('SUB_Request_RequestDown_start_Func_2700', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_start_Func_2700',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      // create Task
      
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest027 create Task success:${task.tid}`);
      await request.agent.remove(task.tid);
      console.info('====>requestTest027 remove success');
      task.start((err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>requestTest027 start fail:${err.code}`);
            expect(err.code).assertEqual(21900007);
            done();
          } else {
            console.info('====>requestTest027 start success');
            expect().assertFail();
            done();
          }
          ;
        } catch (err) {
          console.info(`====>requestTest027 start catch:${err.code}`);
          done();
        };
      });
    });

    /*
     * @tc.number: SUB_Request_RequestDown_stop_Func_2800
     * @tc.name: SUB_Request_RequestDown_stop_Func_2800
     * @tc.desc: task.stop()  /task state error. (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_stop_Func_2800', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_stop_Func_2800',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      let task: request.agent.Task;
      try {
        // create Task
        task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest028 create Task success:${task.tid}`);
        await task.stop();
        console.info(`====>requestTest028 stop success!`);
        await request.agent.remove(task.tid);
        expect().assertFail();
        done();
      } catch (err) {
        console.info(`====>requestTest028 stop fail:${err.code}`);
        expect(err.code).assertEqual(21900007);
        // remove Task
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_stop_Func_2900
     * @tc.name: SUB_Request_RequestDown_stop_Func_2900
     * @tc.desc: task.stop()  /task state error. (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestDown_stop_Func_2900', 0, async (done: Function) => {
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_stop_Func_2900',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
        // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest029 create Task success:${task.tid}`);
      task.stop(async (err: BusinessError) => {          
        try {
          if (err) {
            console.info(`====>requestTest029 stop fail:${err}`);
            expect(err.code).assertEqual(21900007);
            // remove Task
            await request.agent.remove(task.tid);
            done();
          } else {
            console.info('====>requestTest029 stop success');
            await request.agent.remove(task.tid);
            expect().assertFail();
            done();
          };
        } catch (err) {
          console.info(`====>requestTest029 stop catch:${err} `);
          done();
        }
      });
    })

    /*
     * @tc.number: SUB_Request_RequestDown_on_Func_3000
     * @tc.name: SUB_Request_RequestDown_on_Func_3000
     * @tc.desc: task.on('progress')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_on_Func_3000', 0, async (done: Function) => {
      let flag: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        saveas: './SUB_Request_RequestDown_on_Func_3000',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      let callbackProgress1 = (progress: request.agent.Progress): void => {
        flag = true;
        console.info(`====>requestTest030 progress1:${progress.state}`);
      };
      let callbackProgress2 = (progress: request.agent.Progress): void => {
        if (flag) {
          console.info(`====>requestTest030 progress2:${progress.state}`);
          console.info(`====>flag----${flag}`);
          expect(flag).assertTrue();
          task.off('progress')
          done();
        };
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest030 create Task success:${task.tid}`);
      task.on('progress', callbackProgress1);
      task.on('progress', callbackProgress2);
      await task.start();
      console.info('====>requestTest030 start success');
    });

    /*
     * @tc.number: SUB_Request_RequestDown_on_Func_3100
     * @tc.name: SUB_Request_RequestDown_on_Func_3100
     * @tc.desc: task.on('completed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_on_Func_3100', 0, async (done: Function) => {
      let flag: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://repo.huaweicloud.com/ubuntu-releases/20.04/ubuntu-20.04.6-live-server-amd64.iso.zsync',
        saveas: './SUB_Request_RequestDown_on_Func_3100',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        network: request.agent.Network.WIFI,
        headers: {
          "Range": "bytes=0-1000"
        },
        index: 0,
        begins: 0,
        ends: -1
      };
      let callbackCompleted = (progress: request.agent.Progress): void => {
        flag = true;
        console.info(`====>requestTest031 completed:${progress.state}`);
        expect(flag).assertTrue();
        done();
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest031 create Task success:${task.tid}`);
      task.on('completed', callbackCompleted);
      await task.start();
      console.info('====>requestTest031 start success');
    });

    /*
     * @tc.number: SUB_Request_RequestDown_on_Func_3200
     * @tc.name: SUB_Request_RequestDown_on_Func_3200
     * @tc.desc: task.on('failed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_on_Func_3200', 0, async (done: Function) => {
      let flag: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test',
        saveas: './SUB_Request_RequestDown_on_Func_3200',
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
        network: request.agent.Network.WIFI,
        redirect: false
      };
      let callbackFailed = (progress: request.agent.Progress): void => {
        try{
          flag = true;
          console.info(`====>requestTest032 failed:${progress.state}`);
          expect(flag).assertTrue();
          task.off('failed')
          done();
        }catch(err){
          console.info('====>requestTest032 callbackFailed catch err:' + JSON.stringify(err));
          done();
        }        
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest032 create Task success:${task.tid}`);
      try{   
        task.on('failed', callbackFailed);
        await task.start();
        console.info('====>requestTest032 start success');
      }catch(err){
        console.info('====>requestTest032 catch err:' + JSON.stringify(err));
        done();
      }      
    });

    /*
     * @tc.number: SUB_Request_RequestDown_off_Func_3300
     * @tc.name: SUB_Request_RequestDown_off_Func_3300
     * @tc.desc: task.off('progress') /remove one
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_off_Func_3300', 0, async (done: Function) => {
      let flag: boolean = false
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        mode: request.agent.Mode.FOREGROUND,
        network: request.agent.Network.WIFI,
        saveas: './SUB_Request_RequestDown_off_Func_3300',
        overwrite: true
      };
      let callbackProgress1 = (progress: request.agent.Progress): void => {
        flag = true;
        console.info(`====>requestTest033 Progress1:${progress.state}`);
      };
      let callbackProgress2 = (progress: request.agent.Progress): void => {
        console.info(`====>requestTest033 Progress2:${progress.state}`);
        expect(flag).assertFalse();
        done();
      };
      try{
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>requestTest033 create Task success:${task.tid}`);
        task.on('progress', callbackProgress1);
        task.on('progress', callbackProgress2);
        task.off('progress', callbackProgress1);
        await task.start();
        console.info('====>requestTest033 start success');
      }catch(err){
        console.info('====>requestTest033 catch err:' + JSON.stringify(err));
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_RequestDown_off_Func_3400
     * @tc.name: SUB_Request_RequestDown_off_Func_3400
     * @tc.desc: task.off('failed') /remove one
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_off_Func_3400', 0, async (done: Function) => {
      let flag: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/xxxxxx/v1.0/test',
        mode: request.agent.Mode.FOREGROUND,
        network: request.agent.Network.WIFI,
        saveas: './SUB_Request_RequestDown_off_Func_3400',
        overwrite: true,
        redirect: false
      };
      let callbackFailed1 = (progress: request.agent.Progress): void => {
        flag = true;
        console.info(`====>requestTest034 Progress1:${progress.state}`);
      };
      let callbackFailed2 = (progress: request.agent.Progress): void => {
        try{
          console.info(`====>requestTest032 failed:${progress.state}`);
          expect(flag).assertFalse();
          task.off('failed')
          done();
        }catch(err){
          console.info('====>requestTest032 callbackFailed catch err:' + JSON.stringify(err));
          done();
        }
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest034 create Task success:${task.tid}`);
      task.on('failed', callbackFailed1);
      task.on('failed', callbackFailed2);
      task.off('failed', callbackFailed1);
      await task.start();
      console.info('====>requestTest034 start success');
    });

    /*
     * @tc.number: SUB_Request_RequestDown_off_Func_3500
     * @tc.name: SUB_Request_RequestDown_off_Func_3500
     * @tc.desc: task.off('progress') /remove all
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_off_Func_3500', 0, async (done: Function) => {
      let flag1: boolean = false;
      let flag2: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        mode: request.agent.Mode.FOREGROUND,
        saveas: './SUB_Request_RequestDown_off_Func_3500',
        overwrite: true
      };
      let callbackProgress1 = (progress: request.agent.Progress): void => {
        flag1 = true;
        console.info(`====>requestTest035 Progress1:${progress.state}`);
      };
      let callbackProgress2 = (progress: request.agent.Progress): void => {
        flag2 = true;
        console.info(`====>requestTest035 Progress2:${progress.state}`);
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest035 create Task success:${task.tid}`);
      task.on('progress', callbackProgress1);
      task.on('progress', callbackProgress2);
      task.off('progress');
      await task.start();
      console.info('====>requestTest035 start success');
      expect(flag1).assertFalse();
      expect(flag2).assertFalse();
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_off_Func_3600
     * @tc.name: SUB_Request_RequestDown_off_Func_3600
     * @tc.desc: task.off('failed') /remove all
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_off_Func_3600', 0, async (done: Function) => {
      let flag1: boolean = false;
      let flag2: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/te',
        mode: request.agent.Mode.FOREGROUND,
        saveas: './SUB_Request_RequestDown_off_Func_3600',
        overwrite: true
      };
      let callbackFailed1 = (progress: request.agent.Progress): void => {
        flag1 = true;
        console.info(`====>requestTest036 Progress1:${progress.state}`);
      };
      let callbackFailed2 = (progress: request.agent.Progress): void => {
        flag2 = true;
        console.info(`====>requestTest036 Progress2:${progress.state}`);
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest036 create Task success:${task.tid}`);
      task.on('failed', callbackFailed1);
      task.on('failed', callbackFailed2);
      task.off('failed');
      await task.start();
      console.info('====>requestTest036 start success');
      expect(flag1).assertFalse();
      expect(flag2).assertFalse();
      done();
    });

    /*
     * @tc.number: SUB_Request_RequestDown_off_Func_3700
     * @tc.name: SUB_Request_RequestDown_off_Func_3700
     * @tc.desc: task.off('completed') /remove all
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestDown_off_Func_3700', 0, async (done: Function) => {
      let flag2: boolean = false;
      let flag1: boolean = false;
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        mode: request.agent.Mode.FOREGROUND,
        saveas: './SUB_Request_RequestDown_off_Func_3700',
        overwrite: true
      };
      let callbackCompleted1 = (progress: request.agent.Progress): void => {
        flag1 = true;
        console.info(`====>requestTest037 Progress1:${progress.state}`);
      };
      let callbackCompleted2 = (progress: request.agent.Progress): void => {
        flag2 = true;
        console.info(`====>requestTest037 Progress2:${progress.state}`);
      };
      // create Task
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>requestTest037 create Task success:${task.tid}`);
      task.on('completed', callbackCompleted1);
      task.on('completed', callbackCompleted2);
      task.off('completed');
      await task.start();
      console.info('====>requestTest037 start success');
      expect(flag1).assertFalse();
      expect(flag2).assertFalse();
      done();
    });
  });
};