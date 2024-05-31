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

import request from '@ohos.request';
import { describe, it, expect } from '@ohos/hypium'
import { BusinessError } from '@ohos.base'
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';

export default function requestUpTest() {
  describe('requestTest', () => {
    let baseContext: common.Context = AppStorage.get('context') as common.Context;
    let wenBen:string = '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。' +
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'+
      '创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。'

    /*
     * @tc.number: SUB_Request_RequestTest_Create_Remove_Func_0100
     * @tc.name: SUB_Request_RequestTest_Create_Remove_Func_0100
     * @tc.desc: request.agent.create and request.agent.remove  (upload/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Create_Remove_Func_0100', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        network: request.agent.Network.WIFI
      };
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>001Succeeded in creating a upload task:${typeof task}`);
        expect(typeof task === 'object').assertTrue();
        // remove task
        request.agent.remove(task.tid, (err: BusinessError) => {
          try {
            if (err) {
              console.info(`====>001Failed to removing a upload task:${err}`);
              expect(err).assertFail();
              done();
            }
            console.info(`====>001Succeeded in removing a upload success`);
            expect(true).assertTrue();
            done();
          } catch (err) {
            console.info(`====>001Succeeded in removing upload failed: ${err}`);
            done();
          };
        });
      }catch (err) {
        console.info(`====>001Succeeded in create upload failed: ${err}`);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Create_Remove_Func_0200
     * @tc.name: SUB_Request_RequestTest_Create_Remove_Func_0200
     * @tc.desc: request.agent.create and request.agent.remove  (upload/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Create_Remove_Func_0200', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        network: request.agent.Network.WIFI
      };
      try {
        let task = await request.agent.create(baseContext, config);
        console.info(`====>002Succeeded in creating a upload task:${typeof task}`);
        expect(typeof task === 'object').assertTrue();
        console.info(`====>002Succeeded in removing a upload task1`);
        await request.agent.remove(task.tid);
        console.info(`====>002Succeeded in removing a upload task2`);
        expect(true).assertTrue();
        done();
      }catch (err) {
        console.info(`====>002Failed to create or remove failed: ${err}`);
        expect().assertFail();
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Remove_Func_0300
     * @tc.name: SUB_Request_RequestTest_Remove_Func_0300
     * @tc.desc: request.agent.remove tid not found (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestTest_Remove_Func_0300', 0, async (done: Function) => {
      request.agent.remove("创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。", (err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>003remove requestTest task fail:${err.code}`);
            expect(err.code).assertEqual(21900006);
            done();
          }else{
            console.info(`====>003remove success`);
            expect().assertFail();
          }
        }catch (err) {
          console.info(`====>003remove to create or remove failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Remove_Func_0400
     * @tc.name: SUB_Request_RequestTest_Remove_Func_0400
     * @tc.desc: request.agent.remove tid not found (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestTest_Remove_Func_0400', 0, async (done: Function) => {
      try {
        await request.agent.remove("创建要上传或下载的任务，并将其排入队列，每个应用最多支持创建10个未完成的任务。使用callback异步回调。")
        console.info(`====>004remove requestTest task success!`);
        expect().assertFail();
        done();
      }catch (err) {
        console.info(`====>004remove requestTest task fail:${err}`);
        expect(err.code).assertEqual(21900006);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Show_Func_0500
     * @tc.name: SUB_Request_RequestTest_Show_Func_0500
     * @tc.desc: request.agent.show (upload/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Show_Func_0500', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        network: request.agent.Network.WIFI
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>005Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>005Succeeded in creating a upload task:${task}`);
            // show task
            request.agent.show(task.tid, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
              try {
                if (err) {
                  console.info(`====>005Failed to show a upload task:${err}`);
                  expect(err).assertFail();
                  done();
                } else {
                  console.info(`====>005Succeeded in showing a upload task:${taskInfo}`);
                  expect(taskInfo.tid).assertEqual(task.tid);
                  // remove task
                  await request.agent.remove(task.tid);
                  done();
                }
              }
              catch (err) {
                console.info(`====>005Failed to showfailed: ${err}`);
                done();
              };
            })
          }
        }
        catch (err) {
          console.info(`====>005Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Show_Func_0600
     * @tc.name: SUB_Request_RequestTest_Show_Func_0600
     * @tc.desc: request.agent.show (upload/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Show_Func_0600', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        network: request.agent.Network.WIFI
      };
      request.agent.create(baseContext, config, async (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>006Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>006Succeeded in creating a upload task:${task}`);
            // show task
            let taskInfo: request.agent.TaskInfo = await request.agent.show(task.tid);
            console.info(`====>006Succeeded in showing a upload task: ${taskInfo.tid}`);
            expect(taskInfo.tid).assertEqual(task.tid);
            await request.agent.remove(task.tid);
            done();
          }
        }
        catch (err) {
          console.info(`====>006Failed to create or remove failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Show_Func_0700
     * @tc.name: SUB_Request_RequestTest_Show_Func_0700
     * @tc.desc: request.agent.show (upload task not found/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestTest_Show_Func_0700', 0, async (done: Function) => {
      request.agent.show('task.tid',(err: BusinessError, taskInfo: request.agent.TaskInfo) => {
        try {
          if (err) {
            console.info(`====>007requestTest showTask fail:${err}`);
            expect(err.code).assertEqual(21900006);
            done();
          } else {
            console.info(`====>007requestTest showTask success:${taskInfo.tid}`);
            expect().assertFail();
          }
        }
        catch (err) {
          console.info(`====>007requestTest show error: ${err}`);
          done();
        };
      });
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Show_Func_0800
     * @tc.name: SUB_Request_RequestTest_Show_Func_0800
     * @tc.desc: request.agent.show (upload task not found/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Request_RequestTest_Show_Func_0800', 0, async (done: Function) => {
      try {
        await request.agent.show('task.tid');
        console.info(`====>008requestTest showTask success`);
        expect().assertFail();
        done();
      }catch (err) {
        console.info(`====>008requestTest showTask fail:${err}`);
        expect(err.code).assertEqual(21900006);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Touch_Func_0900
     * @tc.name: SUB_Request_RequestTest_Touch_Func_0900
     * @tc.desc: request.agent.touch (upload/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Touch_Func_0900', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        token: 'is test009'
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>009Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>009Succeeded in creating a upload task:${task}`);
            // touch task
            request.agent.touch(task.tid, config.token, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
              try {
                if (err) {
                  console.info(`====>009Failed to touch a upload task, Code: ${err.code}, message: ${err.message}`);
                  expect(err).assertFail();
                  done();
                } else {
                  console.info(`====>009Succeeded in touching a upload task：${taskInfo.tid}`);
                  expect(taskInfo.tid).assertEqual(task.tid);
                  await request.agent.remove(task.tid);
                  done();
                }
              }
              catch (err) {
                console.info(`====>009Succeeded in touching a upload failed: ${err}` );
                done();
              };
            })
          }
        }
        catch (err) {
          console.info(`====>009Failed to create a upload failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Touch_Func_1000
     * @tc.name: SUB_Request_RequestTest_Touch_Func_1000
     * @tc.desc: request.agent.touch (upload/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Touch_Func_1000', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        token: "is test010"
      };
      request.agent.create(baseContext, config, async (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>010Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>010Succeeded in creating a upload task:${task}`);
            // touch task
            let token: string = '';
            let tokenConfig: string = token + config.token;
            let taskInfo: request.agent.TaskInfo = await request.agent.touch(task.tid, tokenConfig);
            console.info(`====>010Succeeded in touching a upload task.`);
            expect(taskInfo.tid).assertEqual(task.tid);
            await request.agent.remove(task.tid);
            done();
          }
        }
        catch (err) {
          console.info(`====>010Succeeded in create or remove failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Touch_Func_1100
     * @tc.name: SUB_Request_RequestTest_Touch_Func_1100
     * @tc.desc: request.agent.touch (upload token is wrong/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Touch_Func_1100', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        token: "is test011"
      };
      request.agent.create(baseContext, config, async (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>011Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>011Succeeded in creating a upload task:${task}`);
            // touch task
            try {
              request.agent.touch(task.tid, 'wrong', (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
                if (err) {
                  console.info(`====>011requestTest touchTask fail:${err}`);
                } else {
                  console.info(`====>011requestTest touchTask success:${taskInfo.tid}`);
                }
              })
            } catch (err) {
              console.info(`====>011requestTest11 touchTask catch:${err}`);
              expect(err.code).assertEqual(401);
              // remove task
              await request.agent.remove(task.tid);
              done();
            }
          }
        }
        catch (err) {
          console.info(`====>011Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Touch_Func_1200
     * @tc.name: SUB_Request_RequestTest_Touch_Func_1200
     * @tc.desc: request.agent.touch (upload token is wrong/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Touch_Func_1200', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        token: "is test012"
      };
      request.agent.create(baseContext, config, async (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>012Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>012Succeeded in creating a upload task:${task}`);
            // touch task
            try {
              request.agent.touch(task.tid,'wrong').then((taskInfo: request.agent.TaskInfo) => {
                console.info(`====>012requestTest touchTask success:${taskInfo.tid}`);
                expect(taskInfo.tid).assertEqual(task.tid);
              }).catch((err: BusinessError) => {
                console.info(`====>012requestTest touchTask fail:${err}`);
              })
            } catch (err) {
              console.info(`====>012requestTest touchTask catch:${typeof err.code}`);
              expect(err.code).assertEqual(401);
              // remove task
              await request.agent.remove(task.tid);
              done();
            }
          }
        }
        catch (err) {
          console.info(`====>012Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Touch_Func_1300
     * @tc.name: SUB_Request_RequestTest_Touch_Func_1300
     * @tc.desc: request.agent.touch (upload task not found/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Touch_Func_1300', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        token: "is test013"
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>013Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>013Succeeded in creating a upload task:${task}`);
            // touch task
            request.agent.touch('123', config.token, async (err: BusinessError, taskInfo: request.agent.TaskInfo) => {
              try {
                if (err) {
                  console.info(`====>013requestTest touchTask fail:${err.code}`);
                  expect(err.code).assertEqual(21900006);
                  // remove task
                  await request.agent.remove(task.tid);
                  done();
                } else {
                  console.info(`====>013requestTest touchTask success:${taskInfo.tid}`);
                  done();
                }
              } catch (err) {
                console.info(`====>013requestTest touchTask catch:${err}`);
                done();
              }
            })
          }
        }
        catch (err) {
          console.info(`====>013Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Search_Func_1400
     * @tc.name: SUB_Request_RequestTest_Search_Func_1400
     * @tc.desc: request.agent.search (upload default Filter/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Search_Func_1400', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>014Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>014Succeeded in creating a upload task:${task}`);
            request.agent.search(async (err: BusinessError, data: Array<string>) => {
              try {
                if (err) {
                  console.info(`====>014requestTest searchTask fail:${err}`);
                  expect(err).assertFail();
                  done();
                } else {
                  console.info(`====>014requestTest searchTask success:${data}`);
                  expect(data instanceof Array).assertTrue();
                  await request.agent.remove(task.tid);
                  done();
                }
              } catch (err) {
                console.info(`====>014requestTest searchTask catch:${err}`);
                done();
              }
            })
          }
        }
        catch (err) {
          console.info(`====>014Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Search_Func_1500
     * @tc.name: SUB_Request_RequestTest_Search_Func_1500
     * @tc.desc: request.agent.search (upload set Filter/callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Search_Func_1500', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let filter: request.agent.Filter = {
        state: request.agent.State.INITIALIZED,
        action: request.agent.Action.UPLOAD,
        mode: request.agent.Mode.FOREGROUND,
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>015Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>015Succeeded in creating a upload task:${task}`);
            request.agent.search(filter,async (err: BusinessError, data: Array<string>) => {
              try {
                if (err) {
                  console.info(`====>015requestTest searchTask fail:${err}`);
                  expect(err).assertFail();
                  done();
                } else {
                  console.info(`====>015requestTest searchTask success:${data}`);
                  expect(data instanceof Array).assertTrue();
                  await request.agent.remove(task.tid);
                  done();
                }
              } catch (err) {
                console.info(`====>015requestTest searchTask catch:${err}`);
                done();
              }
            })
          }
        }
        catch (err) {
          console.info(`====>015Failed to create failed: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Search_Func_1600
     * @tc.name: SUB_Request_RequestTest_Search_Func_1600
     * @tc.desc: request.agent.search (upload set Filter/promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Search_Func_1600', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let filter: request.agent.Filter = {
        state: request.agent.State.INITIALIZED,
        action: request.agent.Action.UPLOAD,
        mode: request.agent.Mode.FOREGROUND,
      };
      request.agent.create(baseContext, config, async (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>016Failed to create a upload task:${err}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>016Succeeded in creating a upload task:${task}`);
            let data: Array<string> = await request.agent.search(filter);
            console.info(`====>016requestTest searchTask success: ${data}`);
            expect(data instanceof Array).assertTrue();
            await request.agent.remove(task.tid);
            done();
           }
        } catch (err) {
          console.info(`====>016requestTest create or serarch catch:${err}`);
          done();
        }
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Start_Func_1700
     * @tc.name: SUB_Request_RequestTest_Start_Func_1700
     * @tc.desc: uploadTask.start (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Start_Func_1700', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      request.agent.create(baseContext, config, (err: BusinessError, task: request.agent.Task) => {
        try {
          if (err) {
            console.info(`====>017Failed to create a upload task:${JSON.stringify(err)}`);
            expect(err).assertFail();
            done();
          } else {
            console.info(`====>017Succeeded in creating a upload task:${JSON.stringify(task)}`);
            task.start(async (err: BusinessError) => {
              try {
                if (err) {
                  console.info(`====>017Failed to start the download task, Code: ${err.code}, message: ${err.message}`);
                  expect(err).assertFail();
                  done();
                } else {
                  console.info(`====>017Succeeded in starting a download task.`);
                  expect(true).assertTrue();
                  try{
                    await request.agent.remove(task.tid);
                    console.info(`====>017Succeeded remove success`);
                  }catch(err){
                    console.info(`====>017Succeeded task has remove: ` + JSON.stringify(err));
                  }
                  done();
                }
              }
              catch (err) {
                console.info(`====>017Failed to start failed: ${err.code}, message: ${err.message}`);
                done();
              };
            })
          }
        }
        catch (err) {
          console.info(`====>017Failed to create failed: ${JSON.stringify(err)}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Start_Func_1800
     * @tc.name: SUB_Request_RequestTest_Start_Func_1800
     * @tc.desc: uploadTask.start (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Start_Func_1800', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      try {
        let task: request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>018Succeeded in creating a upload task:${task}`);
        await request.agent.remove(task.tid);
        console.info(`====>018Succeeded remove`);
        await task.start();
        console.info(`====>018Succeeded in starting a download task`);
        expect().assertFail();
        done();
      }catch (err) {
        console.info(`====>018Failed to start the download task, Code: ${err.code}, message: ${err.message}`);
        expect(err.code).assertEqual(21900007);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Stop_Func_2300
     * @tc.name: SUB_Request_RequestTest_Stop_Func_2300
     * @tc.desc: task.stop (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Stop_Func_2300', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>023requestTest create Task success:${task.tid}`);
      let start:void = await task.start();
      console.info(`====>023requestTest start success${start}`);
      task.stop(async (err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>023requestTest stop fail${err}`);
            expect(err.code).assertEqual(21900007);
            done();
          } else {
            console.info(`====>023requestTest stop success${err}`);
            expect(err).assertNull();
            done();
          }
        }
        catch (err) {
          console.info(`====>023requestTest stop error: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Stop_Func_2400
     * @tc.name: SUB_Request_RequestTest_Stop_Func_2400
     * @tc.desc: task.stop (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Stop_Func_2400', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      try {
        let task:request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>024requestTest create Task success:${task.tid}`);
        let start:void = await task.start();
        console.info(`====>024requestTest start success${start}`);
        await task.stop();
        console.info(`====>024requestTest stop success`);
        done();
      }
      catch (err) {
        console.info(`====>024requestTest stop fail:${err}`);
        expect(err.code).assertEqual(21900007);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Start_Func_2500
     * @tc.name: SUB_Request_RequestTest_Start_Func_2500
     * @tc.desc: task.start()  /task state error. (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Start_Func_2500', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>025requestTest create Task success:${task.tid}`);
      let remove:void = await request.agent.remove(task.tid);
      console.info(`====>025requestTest remove success:${remove}`);
      task.start((err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>025requestTest start fail:${err.code}`);
            expect(err.code).assertEqual(21900007);
            done();
          }else{
            console.info(`====>025requestTest start success`);
            expect().assertFail();
            done();
          }
        }
        catch (err) {
          console.info(`====>025requestTest start success:${err}`);
          done();
        };
      });
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Start_Func_2600
     * @tc.name: SUB_Request_RequestTest_Start_Func_2600
     * @tc.desc: task.start()  /task state error. (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Start_Func_2600', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      try {
        let task:request.agent.Task = await request.agent.create(baseContext, config);
        console.info(`====>026requestTest create Task success:${task.tid}`);
        let remove:void = await request.agent.remove(task.tid);
        console.info(`====>026requestTest remove success:${remove}`);
        console.info(`====>026requestTest start`);
        await task.start();
        expect().assertFail();
      }
      catch (err) {
        console.info(`====>026requestTest start fail:${err.code}`);
        expect(err.code).assertEqual(21900007);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Stop_Func_3100
     * @tc.name: SUB_Request_RequestTest_Stop_Func_3100
     * @tc.desc: task.stop() /task state error. (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Stop_Func_3100', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>031requestTest create Task success:${task.tid}`);
      task.stop(async (err: BusinessError) => {
        try {
          if (err) {
            console.info(`====>031requestTest stop fail:${err.code}`);
            expect(err.code).assertEqual(21900007);
            // remove task
            await request.agent.remove(task.tid);
            done();
          } else {
            console.info(`====>031requestTest stop success:${err}`);
            expect().assertFail();
          }
        }
        catch (err) {
          console.info(`====>031requestTest stop error: ${err}`);
          done();
        };
      })
    })

    /*
     * @tc.number: SUB_Request_RequestTest_Stop_Func_3200
     * @tc.name: SUB_Request_RequestTest_Stop_Func_3200
     * @tc.desc: task.stop()  /task state error. (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_Stop_Func_3200', 0, async (done: Function) => {
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments
      };
      let task: request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>032requestTest create Task success:${task.tid}`)

      try {
        await task.stop()
        console.info(`====>032requestTest stop success`);
        expect().assertFail();
      }
      catch (err) {
        console.info(`====>032requestTest stop fail:${err.code}`);
        expect(err.code).assertEqual(21900007);
        // remove task
        await request.agent.remove(task.tid);
        done();
      };
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OnProgress_Func_3300
     * @tc.name: SUB_Request_RequestTest_OnProgress_Func_3300
     * @tc.desc:  task.on('progress')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OnProgress_Func_3300', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnProgress = (progress: request.agent.Progress):void => {
        task.off('progress')
        console.info(`====>033upload task progress: ${progress}`);
        flag = true;
        expect(flag).assertTrue();
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>033requestTest create Task success: ${task.tid}`);
      task.on('progress', createOnProgress);
      // start task
      let start:void = await task.start();
      console.info(`====>033Succeeded in starting a upload task: ${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OnCompleted_Func_3400
     * @tc.name: SUB_Request_RequestTest_OnCompleted_Func_3400
     * @tc.desc:  task.on('completed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OnCompleted_Func_3400', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND,
        index: 0,
        begins: 10,
        ends: 100
      };
      let createOnCompleted = (progress: request.agent.Progress):void => {
        task.off('completed')
        console.info(`====>034upload task completed.${progress}`);
        flag = true
        expect(flag).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>034requestTest create Task success:${task.tid}`);
      task.on('completed', createOnCompleted);
      // start task
      let start:void = await task.start();
      console.info(`====>034Succeeded in starting a upload task${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OnFailed_Func_3500
     * @tc.name: SUB_Request_RequestTest_OnFailed_Func_3500
     * @tc.desc: task.on('failed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OnFailed_Func_3500', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnFailed = (progress: request.agent.Progress):void => {
        task.off('failed')
        console.info(`====>035upload task failed.${progress}`);
        flag = true
        expect(flag).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>035requestTest create Task success:${task.tid}`);
      task.on('failed', createOnFailed);
      // start task
      let start:void = await task.start();
      console.info(`====>035Succeeded in starting a upload task${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OffProgress_Func_3600
     * @tc.name: SUB_Request_RequestTest_OffProgress_Func_3600
     * @tc.desc: task.off('progress')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OffProgress_Func_3600', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnProgress = (progress: request.agent.Progress):void => {
        console.info(`====>036upload task progress.${progress}`);
        flag = true
        expect(flag).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>036requestTest create Task success:${task.tid}`);
      task.on('progress', createOnProgress);
      task.off('progress', createOnProgress);
      // start task
      let start:void = await task.start();
      console.info(`====>036Succeeded in starting a upload task${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OffCompleted_Func_3700
     * @tc.name: SUB_Request_RequestTest_OffCompleted_Func_3700
     * @tc.desc:  task.off('completed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OffCompleted_Func_3700', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnCompleted = (progress: request.agent.Progress):void => {
        console.info(`====>037upload task completed.${progress}`);
        flag = true
        expect(flag).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>037requestTest create Task success:${task.tid}`);
      task.on('completed', createOnCompleted);
      task.off('completed', createOnCompleted);
      // start task
      let start:void = await task.start();
      console.info(`====>037Succeeded in starting a upload task${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OffFailed_Func_3800
     * @tc.name: SUB_Request_RequestTest_OffFailed_Func_3800
     * @tc.desc:  task.off('failed')
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OffFailed_Func_3800', 0, async (done: Function) => {
      let flag:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnFailed = (progress: request.agent.Progress):void => {
        console.info(`====>038upload task failed.${progress}`);
        flag = true
        expect(flag).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>038requestTest create Task success:${task.tid}`);
      task.on('failed', createOnFailed);
      task.off('failed', createOnFailed);
      // start task
      let start:void = await task.start();
      console.info(`====>038Succeeded in starting a upload task${start}`);
      done();
    })

    /*
     * @tc.number: SUB_Request_RequestTest_OffFailed_Func_3900
     * @tc.name: SUB_Request_RequestTest_OffFailed_Func_3900
     * @tc.desc:  task.off('failed')/unsubscribe all
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Request_RequestTest_OffFailed_Func_3900', 0, async (done: Function) => {
      let flag1:Boolean = false;
      let flag2:Boolean = false;
      let file:fs.File = fs.openSync(baseContext.cacheDir + '/createUploadTest.txt', 0o100 | 0o2);
      fs.writeSync(file.fd, wenBen);
      let attachments: Array<request.agent.FormItem> = [{
        name: "createUploadTest",
        value: {
          filename: "createUploadTest.txt",
          mimeType: "application/octet-stream",
          path: "./createUploadTest.txt",
        }
      }];
      let config: request.agent.Config = {
        action: request.agent.Action.UPLOAD,
        url: 'http://127.0.0.1',
        data: attachments,
        mode: request.agent.Mode.FOREGROUND
      };
      let createOnFailed1 = (progress: request.agent.Progress):void => {
        console.info(`====>039upload task failed.${progress}`);
        flag1 = true
        expect(flag1).assertTrue()
      };
      let createOnFailed2 = (progress: request.agent.Progress):void => {
        console.info(`====>039upload task failed.${progress}`);
        flag2 = true
        expect(flag2).assertTrue()
      };
      let task:request.agent.Task = await request.agent.create(baseContext, config);
      console.info(`====>039requestTest create Task success:${task.tid}`);
      task.on('failed', createOnFailed1);
      task.on('failed', createOnFailed2);
      task.off('failed');
      // start task
      let start:void = await task.start();
      console.info(`====>039Succeeded in starting a upload task${start}`);
      done();
    })
  })
}