/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from "@ohos/hypium";
import request from '@ohos.request';
import common from '@ohos.app.ability.common';

export default function requestCrossplatformDownloadJSUnit() {
  describe("requestCrossplatformDownloadTest", () => {
    console.info("====>################################request download Test start");
    let baseContext: common.Context;

    let sleep = (timeout: number): Promise<null> => {
      return new Promise(resolve => {
        const st = setTimeout(() => {
          resolve(null);
          clearTimeout(st);
        }, timeout);
      });
    };

    /**
     * beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async( done: Function) => {
      try {
        await sleep(5000);
        let context: common.Context | undefined = AppStorage.get('context');
        if (context !== undefined){
          baseContext = context;
          console.info('====>beforeAll baseContext:'+JSON.stringify(baseContext))
          done();
        } else {
          console.info('====>beforeAll baseContext is undefined')
          done();
        }
      } catch (err) {
        console.info('====>beforeAll catch err:'+JSON.stringify(err))
        done();
      }
    });

    /**
     * beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.
     */
    beforeEach(() => {
      console.info("====>beforeEach: Prerequisites is executed.");
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
      await sleep(500);
      console.info("====>afterEach: Test case-level clearance conditions is executed.");
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(() => {
      console.info("====>afterAll: Test suite-level cleanup condition is executed");
    });
    let removeTask = async (task: request.agent.Task): Promise<void> => {
      try {
        await request.agent.remove(task.tid)
        console.info("====>task remove success");
      } catch (err) {
        console.info("====>task remove failed, possibly the task have remove" + JSON.stringify(err));
      }
    }

    /**
     * @tc.number: SUB_Request_Agent_proxy_0400
     * @tc.name: SUB_Request_Agent_proxy_0400
     * @tc.desc: incorrect parameters of the download proxy
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('SUB_Request_Agent_proxy_0400', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_Request_Agent_proxy_0400 is starting-----------------------');
      let config:request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_proxy_0400',
        network: request.agent.Network.ANY,
        overwrite: true,
        proxy: 'https://192.168.249.58:808'
      };
      try {
        console.info('====>SUB_Request_Agent_proxy_0400 create task');
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info('====>SUB_Request_Agent_proxy_0400 create success');
        expect().assertFail();
        done();
      } catch (err) {
        console.info('====>SUB_Request_Agent_proxy_0400 create catch err: ' + JSON.stringify(err));
        console.info('====>: ' + err.code);
        console.info('====>: ' + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.number SUB_Misc_REQUEST_Pause_Download_Callback_0010
     * @tc.name SUB_Misc_REQUEST_Pause_Download_Callback_0010
     * @tc.desc Restore the download task
     * @tc.size      MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Misc_REQUEST_Pause_Download_Callback_0010', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Misc_REQUEST_Pause_Download_Callback_0010 is starting-----------------------");
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_Misc_REQUEST_Pause_Download_Callback_0010.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
        mode: request.agent.Mode.FOREGROUND,
      };
      request.agent.create(baseContext, config, async (err, task)=>{
        console.info("====>SUB_Misc_REQUEST_Pause_Download_Callback_0010 downloadTask: " + task);
        task.start(err => {
          console.info("====>SUB_Misc_REQUEST_Pause_Download_Callback_0010 download start: " + JSON.stringify(err));
          task.pause(async err => {
            try {
              if(err){
                console.info("====>SUB_Misc_REQUEST_Pause_Download_Callback_0010 download pause err: " + JSON.stringify(err));
                expect().assertFail();
              }
              expect(true).assertEqual(true);
              console.info("====>SUB_Misc_REQUEST_Pause_Download_Callback_0010 download pause success: " + task);
            } catch(err) {
              console.info("====>SUB_Misc_REQUEST_Pause_Download_Callback_0010 catch err: " + JSON.stringify(err));
            }
            await request.agent.remove(task.tid);
            console.info("-----------------------SUB_Misc_REQUEST_Pause_Download_Callback_0010 end-----------------------");
            done();
          })
        })
      });
    });

    /**
     * @tc.number SUB_Misc_REQUEST_Pause_Download_Promise_0010
     * @tc.name SUB_Misc_REQUEST_Pause_Download_Promise_0010
     * @tc.desc Restore the download task
     * @tc.size      MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Misc_REQUEST_Pause_Download_Promise_0010', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Misc_REQUEST_Pause_Download_Promise_0010 is starting-----------------------");
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_Misc_REQUEST_Pause_Download_Promise_0010.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };

      let task = await request.agent.create(baseContext, config);
      task.start(async err => {
        try {
          console.info("====>SUB_Misc_REQUEST_Pause_Download_Promise_0010 download start: " + JSON.stringify(err));
          await task.pause();
          expect(true).assertEqual(true);
          await request.agent.remove(task.tid);
          console.info("====>SUB_Misc_REQUEST_Pause_Download_Promise_0010 download pause success: " + task);
          done();
        } catch (err) {
          console.info("====>SUB_Misc_REQUEST_Pause_Download_Promise_0010 download pause err: " + JSON.stringify(err));
          await request.agent.remove(task.tid);
          expect().assertFail();
          done();
        }
      })
    });

    /**
     * @tc.number SUB_Misc_REQUEST_Resume_Download_Callback_0010
     * @tc.name SUB_Misc_REQUEST_Resume_Download_Callback_0010
     * @tc.desc Get the download task info
     * @tc.size      MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Misc_REQUEST_Resume_Download_Callback_0010', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Misc_REQUEST_Resume_Download_Callback_0010 is starting-----------------------");
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_Misc_REQUEST_Resume_Download_Callback_0010.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };
      request.agent.create(baseContext, config, async (err, task)=>{
        console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 downloadTask: " + task);
        task.start(async err => {
          console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 start: " + JSON.stringify(err));
          task.pause(err => {
            console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 pause: " + JSON.stringify(err));
            task.resume(async err => {
              try {
                if (err) {
                  console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 download resume err: " + JSON.stringify(err));
                  expect().assertFail();
                }
                expect(true).assertEqual(true);
                console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 download resume success: " + task);
              } catch(err) {
                console.info("====>SUB_Misc_REQUEST_Resume_Download_Callback_0010 catch err: " + JSON.stringify(err));
              }
              await request.agent.remove(task.tid);
              console.info("-----------------------SUB_Misc_REQUEST_Resume_Download_Callback_0010 end-----------------------");
              done();
            })
          })
        })
      });
    });

    /**
     * @tc.number SUB_Misc_REQUEST_Resume_Download_Promise_0010
     * @tc.name SUB_Misc_REQUEST_Resume_Download_Promise_0010
     * @tc.desc Get the download task info
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Misc_REQUEST_Resume_Download_Promise_0010', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Misc_REQUEST_Resume_Download_Promise_0010 is starting-----------------------");
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_Misc_REQUEST_Resume_Download_Promise_0010.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };
      let task = await request.agent.create(baseContext, config);
      task.start(err => {
        console.info("====>SUB_Misc_REQUEST_Resume_Download_Promise_0010 start: " + JSON.stringify(err));
        task.pause(async err => {
          console.info("====>SUB_Misc_REQUEST_Resume_Download_Promise_0010 pause: " + JSON.stringify(err));
          try {
            await task.resume();
            expect(true).assertEqual(true);
            await request.agent.remove(task.tid);
            console.info("====>SUB_Misc_REQUEST_Resume_Download_Promise_0010 download resume success: " + task);
            done();
          } catch (err) {
            console.info("====>SUB_Misc_REQUEST_Resume_Download_Promise_0010 download resume err: " + JSON.stringify(err));
            await request.agent.remove(task.tid);
            expect().assertFail();
            done();
          }
        });
      });
    });

    /**
     * @tc.number SUB_REQUEST_On_Download_Pause_0100
     * @tc.name SUB_REQUEST_On_Download_Pause_0100
     * @tc.desc download task
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_On_Download_Pause_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_On_Download_Pause_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_On_Download_Pause_0100.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };
      request.agent.create(baseContext, config, async (err, task) => {
        let on_pauseCallback = async (pro: request.agent.Progress) => {
          task.off('pause', on_pauseCallback);
          try {
            await request.agent.remove(task.tid);
          } catch (err) {
            console.info('====>SUB_REQUEST_On_Download_Pause_0100 task not remove: ' + JSON.stringify(task.tid));
          }
          expect(true).assertTrue();
          console.info('====>SUB_REQUEST_On_Download_Pause_0100 background onPause success');
          done();
        }
        try {
          if (err) {
            console.info('====>SUB_REQUEST_On_Download_Pause_0100 create err: ' + JSON.stringify(err.message));
            expect().assertFail();
            done();
          }
          task.on('pause', on_pauseCallback);
          task.start(async (err) => {
            try {
              if (err) {
                console.info('====>SUB_REQUEST_On_Download_Pause_0100 task.start err' + JSON.stringify(err.message));
                expect().assertFail();
                done();
              }
              await task.pause();
              console.info('====>SUB_REQUEST_On_Download_Pause_0100 task.start success');
            } catch (err) {
              console.info('====>SUB_REQUEST_On_Download_Pause_0100 task start failed: ' + JSON.stringify(err));
              done();
            }
          });
        } catch (err) {
          console.info('====>SUB_REQUEST_On_Download_Pause_0100 catch err: ' + JSON.stringify(err));
          done();
        }
      });

    });

    /**
     * @tc.number SUB_REQUEST_Off_Download_Pause_0100
     * @tc.name SUB_REQUEST_Off_Download_Pause_0100
     * @tc.desc Starts a upload session.
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Pause_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Off_Download_Pause_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_Off_Download_Pause_0100.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };
      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Pause_0100 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            task.off('pause', pro1)
            console.info("====>SUB_REQUEST_Off_Download_Pause_0100 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }

          let pro2 = (task2: request.agent.Progress) => {
            task.off('pause', pro2)
            console.info("====>SUB_REQUEST_Off_Download_Pause_0100 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }

          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('pause', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Pause_0100 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Pause_0100 task3 pause on arr: " + JSON.stringify(arr));
              expect(arr).toContain(0);
              expect(arr).toContain(1);
              expect(arr).toContain(2);
              expect(arr.length).toEqual(3);
              try {
                await request.agent.remove(task.tid);
              } catch (err) {
                console.info('====>SUB_REQUEST_Off_Download_Pause_0100 task not remove: ' + JSON.stringify(task.tid));
              }
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Pause_0100 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('pause', pro1);
          task.on('pause', pro2);
          task.on('pause', pro3);
          task.start(async (err) => {
            try {
              if (err) {
                console.info('====>SUB_REQUEST_Off_Download_Pause_0100 task.start err' + JSON.stringify(err));
                expect().assertFail();
              }
              await task.pause();
              console.info('====>SUB_REQUEST_Off_Download_Pause_0100 task.start success');
            } catch (err) {
              console.info('====>SUB_REQUEST_Off_Download_Pause_0100 task start failed: ' + JSON.stringify(err));
            }
          });
          console.info("====>SUB_REQUEST_Off_Download_Pause_0100 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Pause_0100 create catch err: " + JSON.stringify(err));
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_Off_Download_Pause_0200
     * @tc.name SUB_REQUEST_Off_Download_Pause_0200
     * @tc.desc Starts a upload session.
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Pause_0200', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Upload_backgroundOnPause_0500 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'reeateTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_On_Download_Pause_0100.txt',
        overwrite: true,
        network: request.agent.Network.ANY,
      };
      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Pause_0200 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Pause_0200 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }
          let pro2 = (task2: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Pause_0200 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }
          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('pause', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Pause_0200 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Pause_0200 task3 pause on arr: " + JSON.stringify(arr));
              expect(arr[0]).assertEqual(2);
              try {
                await request.agent.remove(task.tid);
              } catch (err) {
                console.info('====>SUB_REQUEST_Off_Download_Pause_0200 task not remove: ' + JSON.stringify(task.tid));
              }
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Pause_0200 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('pause', pro1);
          task.on('pause', pro2);
          task.off('pause');
          task.on('pause', pro3);
          task.start(async (err) => {
            try {
              if (err) {
                console.info('====>SUB_REQUEST_Off_Download_Pause_0200 task.start err' + JSON.stringify(err));
                expect().assertFail();
              }
              await task.pause();
              console.info('====>SUB_REQUEST_Off_Download_Pause_0200 task.start success');
            } catch (err) {
              console.info('====>SUB_REQUEST_Off_Download_Pause_0200 task start failed: ' + JSON.stringify(err));
            }
          });
          console.info("====>SUB_REQUEST_Off_Download_Pause_0200 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Pause_0200 create catch err: " + JSON.stringify(err));
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_On_Download_Resume_0100
     * @tc.name SUB_REQUEST_On_Download_Resume_0100
     * @tc.desc download task
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_On_Download_Resume_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_On_Download_Resume_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_On_Download_Resume_0100.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          let on_resumeCallback = async (pro: request.agent.Progress) => {
            task.off('resume', on_resumeCallback);
            try {
              await request.agent.remove(task.tid);
            } catch (err) {
              console.info('====>SUB_REQUEST_On_Download_Resume_0100 task not remove: ' + JSON.stringify(task.tid));
            }
            console.info('====>SUB_REQUEST_On_Download_Resume_0100 on_resumeCallback');
            expect(true).assertTrue();
            done();
          }

          try {
            if (err) {
              console.info('====>SUB_REQUEST_On_Download_Resume_0100 create err: ' + JSON.stringify(err));
              expect().assertFail();
            }
            task.on('resume', on_resumeCallback);
            task.start(async (err) => {
              try {
                if (err) {
                  console.info('====>SUB_REQUEST_On_Download_Resume_0100 task.start err' + JSON.stringify(err));
                  expect().assertFail();
                }
                await task.pause();
                await task.resume();
                console.info('====>SUB_REQUEST_On_Download_Resume_0100 task.start success');
              } catch (err) {
                console.info('====>SUB_REQUEST_On_Download_Resume_0100 task start failed: ' + JSON.stringify(err));
              }
            });
          } catch (err) {
            console.info('====>SUB_REQUEST_On_Download_Resume_0100 catch err: ' + JSON.stringify(err));
            done();
          }
        });
      } catch (err) {
        console.info('====>SUB_REQUEST_On_Download_Resume_0100 create catch err: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_Off_Download_Resume_0100
     * @tc.name SUB_REQUEST_Off_Download_Resume_0100
     * @tc.desc Starts a upload session.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Resume_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Off_Download_Resume_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_Off_Download_Resume_0100.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };

      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Resume_0100 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            task.off('resume', pro1)
            console.info("====>SUB_REQUEST_Off_Download_Resume_0100 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }

          let pro2 = (task2: request.agent.Progress) => {
            task.off('resume', pro2)
            console.info("====>SUB_REQUEST_Off_Download_Resume_0100 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }

          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('resume', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Resume_0100 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Resume_0100 resume pause on arr: " + JSON.stringify(arr));
              expect(arr).toContain(0);
              expect(arr).toContain(1);
              expect(arr).toContain(2);
              expect(arr.length).toEqual(3);
              try {
                await request.agent.remove(task.tid);
              } catch (err) {
                console.info('====>SUB_REQUEST_On_Download_Resume_0200 task not remove: ' + JSON.stringify(task.tid));
              }
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Resume_0100 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('resume', pro1);
          task.on('resume', pro2);
          task.on('resume', pro3);
          task.start(async (err) => {
            try {
              if (err) {
                console.info('====>SUB_REQUEST_Off_Download_Resume_0100 task.start err' + JSON.stringify(err));
                expect().assertFail();
              }
              await task.pause();
              await task.resume();
              console.info('====>SUB_REQUEST_Off_Download_Resume_0100 task.start success');
            } catch (err) {
              console.info('====>SUB_REQUEST_Off_Download_Resume_0100 task start failed: ' + JSON.stringify(err));
            }
          });
          console.info("====>SUB_REQUEST_Off_Download_Resume_0100 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Resume_0100 create catch err: " + JSON.stringify(err));
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_Off_Download_Resume_0200
     * @tc.name SUB_REQUEST_Off_Download_Resume_0200
     * @tc.desc Starts a upload session.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Resume_0200', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Download_backgroundOnPause_0500 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_Off_Download_Resume_0200.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };

      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Resume_0200 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Resume_0200 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }

          let pro2 = (task2: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Resume_0200 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }

          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('resume', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Resume_0200 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Resume_0200 task3 resume on arr: " + JSON.stringify(arr));
              expect(arr[0]).assertEqual(2);
              try {
                await request.agent.remove(task.tid);
              } catch (err) {
                console.info('====>SUB_REQUEST_Off_Download_Resume_0200 task not remove: ' + JSON.stringify(task.tid));
              }
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Resume_0200 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('resume', pro1);
          task.on('resume', pro2);
          task.off('resume');
          task.on('resume', pro3);
          task.start(async (err) => {
            try {
              if (err) {
                console.info('====>SUB_REQUEST_Off_Download_Resume_0200 task.start err' + JSON.stringify(err));
                expect().assertFail();
              }
              await task.pause();
              await task.resume();
              console.info('====>SUB_REQUEST_Off_Download_Resume_0200 task.start success');
            } catch (err) {
              console.info('====>SUB_REQUEST_Off_Download_Resume_0200 task start failed: ' + JSON.stringify(err));
            }
          });
          console.info("====>SUB_REQUEST_Off_Download_Resume_0200 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Resume_0200 create catch err: " + JSON.stringify(err));
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_On_Download_Remove_0100
     * @tc.name SUB_REQUEST_On_Download_Remove_0100
     * @tc.desc download task
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_On_Download_Remove_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_On_Download_Remove_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_On_Download_Remove_0100.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          let on_removeCallback = async (pro: request.agent.Progress) => {
            try {
              task.off('remove', on_removeCallback);
              expect(true).assertTrue();
              console.info('====>SUB_REQUEST_On_Download_Remove_0100 on_removeCallback success');
              done();
            } catch (err) {
              console.info('====>SUB_REQUEST_On_Download_Remove_0100 task not remove: ' + JSON.stringify(task.tid));
              done();
            }

          }
          try {
            if (err) {
              console.info('====>SUB_REQUEST_On_Download_Remove_0100 create err: ' + JSON.stringify(err));
              expect().assertFail();
            }
            task.on('remove', on_removeCallback);
            request.agent.remove(task.tid)
          } catch (err) {
            console.info('====>SUB_REQUEST_On_Download_Remove_0100 catch err: ' + JSON.stringify(err));
            done();
          }
        });
      } catch (err) {
        console.info('====>SUB_REQUEST_On_Download_Remove_0100 create catch err: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_REQUEST_Off_Download_Remove_0100
     * @tc.name SUB_REQUEST_Off_Download_Remove_0100
     * @tc.desc Starts a upload session.
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Remove_0100', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Off_Download_Remove_0100 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_Off_Download_Remove_0100.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Remove_0100 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            task.off('remove', pro1)
            console.info("====>SUB_REQUEST_Off_Download_Remove_0100 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }
          let pro2 = (task2: request.agent.Progress) => {
            task.off('remove', pro2)
            console.info("====>SUB_REQUEST_Off_Download_Remove_0100 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }
          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('remove', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Remove_0100 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Remove_0100 task3 remove on arr: " + JSON.stringify(arr));
              expect(arr).toContain(0);
              expect(arr).toContain(1);
              expect(arr).toContain(2);
              expect(arr.length).toEqual(3);
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Remove_0100 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('remove', pro1);
          task.on('remove', pro2);
          task.on('remove', pro3);
          await request.agent.remove(task.tid);
          console.info("====>SUB_REQUEST_Off_Download_Remove_0100 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Remove_0100 create catch err: " + JSON.stringify(err));
        done();
      }
    });
    /**
     * @tc.number SUB_REQUEST_Off_Download_Remove_0200
     * @tc.name SUB_REQUEST_Off_Download_Remove_0200
     * @tc.desc Starts a upload session.
     * @tc.size      MEDIUMTEST
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_Off_Download_Remove_0200', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_REQUEST_Off_Download_Remove_0200 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_REQUEST_Off_Download_Remove_0200.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND
      };
      let arr: Array<number> = new Array();
      try {
        request.agent.create(baseContext, config, async (err, task) => {
          if (err) {
            console.info("====>SUB_REQUEST_Off_Download_Remove_0200 create err: " + JSON.stringify(err));
            expect().assertFail();
          }
          let pro1 = (task1: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Remove_0200 pro1: " + JSON.stringify(task1));
            arr.push(0);
          }
          let pro2 = (task2: request.agent.Progress) => {
            console.info("====>SUB_REQUEST_Off_Download_Remove_0200 pro2: " + JSON.stringify(task2));
            arr.push(1);
          }
          let pro3 = async (task3: request.agent.Progress) => {
            try {
              task.off('remove', pro3)
              console.info("====>SUB_REQUEST_Off_Download_Remove_0200 pro3: " + JSON.stringify(task3));
              arr.push(2);
              console.info("====>SUB_REQUEST_Off_Download_Remove_0200 task3 remove on arr: " + JSON.stringify(arr));
              expect(arr[0]).assertEqual(2);
              done();
            } catch (err) {
              console.info("====>SUB_REQUEST_Off_Download_Remove_0200 catch err: " + JSON.stringify(err));
              done();
            }
          }
          task.on('remove', pro1);
          task.on('remove', pro2);
          task.off('remove');
          task.on('remove', pro3);
          await request.agent.remove(task.tid);
          console.info("====>SUB_REQUEST_Off_Download_Remove_0200 task.start");
        });
      } catch (err) {
        console.info("====>SUB_REQUEST_Off_Download_Remove_0200 create catch err: " + JSON.stringify(err));
        done();
      }
    });

    /*
    * @tc.number: SUB_Request_Agent_onResponse_0100
    * @tc.name: supports the response header of the listening task.
    * @tc.desc: request config saveas validate
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level: Level 1
    */
    it('SUB_Request_Agent_onResponse_0100', Level.LEVEL1, async (done: Function) => {
      console.info("====>-----------------------SUB_Request_Agent_onResponse_0100 is starting-----------------------");
      let config:request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_onResponse_0100',
        network: request.agent.Network.ANY,
        overwrite: true
      };
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info("====>SUB_Request_Agent_onResponse_0100 create success");
        let responseCallback_1 = async (info: request.agent.HttpResponse) => {
          try {
            task.off('response');
            await removeTask(task);
            console.info("====>SUB_Request_Agent_onResponse_0100 response info: " + JSON.stringify(info));
            expect(info.version).assertEqual('HTTP/1.1');
            expect(info.statusCode).assertEqual(200);
            expect(info.reason).assertEqual('OK');
            expect(typeof(info.headers) === 'object').assertTrue();
            done();
          } catch (err) {
            console.info("====>SUB_Request_Agent_onResponse_0100 err: " + JSON.stringify(err));
            done();
          }
        }
        task.on('response', responseCallback_1);
        await task.start();
        console.info("====>SUB_Request_Agent_onResponse_0100 task.start");
      } catch (err) {
        console.info("====>SUB_Request_Agent_onResponse_0100 create catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_Agent_onResponse_0200
     * @tc.name: supports the response header of the listening task.
     * @tc.desc: request config saveas validate
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('SUB_Request_Agent_onResponse_0200', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Request_Agent_onResponse_0200 is starting-----------------------");
      let config:request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984572/test-files/releases/downloads/1.1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_onResponse_0200',
        network: request.agent.Network.ANY,
        overwrite: true
      };
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info("====>SUB_Request_Agent_onResponse_0200 create success");
        let responseCallback_1 = async (info: request.agent.HttpResponse) => {
          try {
            task.off('response');
            removeTask(task);
            console.info("====>SUB_Request_Agent_onResponse_0200 response info: " + JSON.stringify(info));
            expect(info.statusCode).assertEqual(404);
            done();
          } catch (err) {
            console.info("====>SUB_Request_Agent_onResponse_0200 err: " + JSON.stringify(err));
            done();
          }
        }
        task.on('response', responseCallback_1);
        await task.start();
        console.info("====>SUB_Request_Agent_onResponse_0200 task.start");
      } catch (err) {
        console.info("====>SUB_Request_Agent_onResponse_0200 create catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_Agent_onResponse_0300
     * @tc.name: supports the response header of the listening task.
     * @tc.desc: request config saveas validate
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('SUB_Request_Agent_onResponse_0300', Level.LEVEL1, async (done: Function) => {
      console.info("====>-----------------------SUB_Request_Agent_onResponse_0300 is starting-----------------------");
      let config:request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/chenzhixue/downloadTest/releases/download/v1.0/test.apk',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_onResponse_0300',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        let flage: boolean = true;
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info("====>SUB_Request_Agent_onResponse_0300 create success");
        let responseCallback_1 = (info: request.agent.HttpResponse) => {
          flage = false;
          console.info("====>SUB_Request_Agent_onResponse_0300 response info: " + JSON.stringify(info));
        }
        let completed = (pro: request.agent.Progress) => {
          try {
            task.off('completed');
            console.info("====>SUB_Request_Agent_onResponse_0300 completed pro: " + JSON.stringify(pro));
            expect(flage).assertTrue();
            done();
          } catch (err) {
            console.info("====>SUB_Request_Agent_onResponse_0300 err: " + JSON.stringify(err));
            done();
          }
        }
        task.on('response', responseCallback_1);
        task.off('response', responseCallback_1);
        task.on('completed', completed)
        await task.start();
        console.info("====>SUB_Request_Agent_onResponse_0300 task.start");
      } catch (err) {
        console.info("====>SUB_Request_Agent_onResponse_0300 create catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_Agent_onResponse_0400
     * @tc.name: supports the response header of the listening task.
     * @tc.desc: request config saveas validate
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('SUB_Request_Agent_onResponse_0400', Level.LEVEL2, async (done: Function) => {
      console.info('====>-----------------------SUB_Request_Agent_onResponse_0400 is starting-----------------------');
      let config: request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_onResponse_0400.txt',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      let arr: Array<number> = new Array();
      let arr1 = [0, 1, 2];
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        let responseCallback_1 = (info1: request.agent.HttpResponse) => {
          task.off('response', responseCallback_1)
          console.info("====>SUB_Request_Agent_onResponse_0400 info1: " + JSON.stringify(info1));
          arr.push(0);
        }
        let responseCallback_2 = (info2: request.agent.HttpResponse) => {
          task.off('response', responseCallback_2)
          console.info("====>SUB_Request_Agent_onResponse_0400 info2: " + JSON.stringify(info2));
          arr.push(1);
        }
        let responseCallback_3 = async (info3: request.agent.HttpResponse) => {
          try {
            task.off('response', responseCallback_3)
            await removeTask(task);
            console.info("====>SUB_Request_Agent_onResponse_0400 info3: " + JSON.stringify(info3));
            arr.push(2);
            console.info("====>SUB_Request_Agent_onResponse_0400 task3 response on arr: " + JSON.stringify(arr));
            expect(arr.join()).assertEqual(arr1.join());
            done();
          } catch (err) {
            console.info("====>SUB_Request_Agent_onResponse_0400 catch err: " + JSON.stringify(err));
            done();
          }
        }
        task.on('response', responseCallback_1);
        task.on('response', responseCallback_2);
        task.on('response', responseCallback_3);
        await task.start();
        console.info("====>SUB_Request_Agent_onResponse_0400 task.start");
      } catch (err) {
        console.info("====>SUB_Request_Agent_onResponse_0400 create catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /*
     * @tc.number: SUB_Request_Agent_onResponse_0500
     * @tc.name: supports the response header of the listening task.
     * @tc.desc: request config saveas validate
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('SUB_Request_Agent_onResponse_0500', Level.LEVEL2, async (done: Function) => {
      console.info("====>-----------------------SUB_Request_Agent_onResponse_0500 is starting-----------------------");
      let config:request.agent.Config = {
        action: request.agent.Action.DOWNLOAD,
        url: 'https://gitee.com/murphy1984/download/releases/download/V1/test.hap',
        title: 'createTest',
        description: 'XTS download test!',
        saveas: './SUB_Request_Agent_onResponse_0500',
        network: request.agent.Network.ANY,
        overwrite: true,
        mode: request.agent.Mode.FOREGROUND,
      };
      try {
        let flage: boolean = true;
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info("====>SUB_Request_Agent_onResponse_0500 create success");
        let responseCallback_1 = (info1: request.agent.HttpResponse) => {
          flage = false;
          console.info("====>SUB_Request_Agent_onResponse_0500 response info1: " + JSON.stringify(info1));
        }
        let responseCallback_2 = (info2: request.agent.HttpResponse) => {
          flage = false;
          console.info("====>SUB_Request_Agent_onResponse_0500 response info2: " + JSON.stringify(info2));
        }
        let completed = (pro: request.agent.Progress) => {
          try {
            task.off('completed');
            console.info("====>SUB_Request_Agent_onResponse_0500 completed pro: " + JSON.stringify(pro));
            expect(flage).assertTrue();
            done();
          } catch (err) {
            console.info("====>SUB_Request_Agent_onResponse_0500 err: " + JSON.stringify(err));
            done();
          }
        }
        task.on('response', responseCallback_1);
        task.on('response', responseCallback_2);
        task.off('response');
        task.on('completed', completed)
        await task.start();
        console.info("====>SUB_Request_Agent_onResponse_0500 task.start");
      } catch (err) {
        console.info("====>SUB_Request_Agent_onResponse_0500 create catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

  });
}
