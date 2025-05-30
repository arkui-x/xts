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

import request from "@ohos.request";
import fileIO from "@ohos.file.fs";
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from "@ohos/hypium";
import { BusinessError } from '@ohos.base';

function prepareFile(fpath:string, content:string) {
  try {
    let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
    fileIO.truncateSync(file.fd);
    fileIO.writeSync(file.fd, content);
    fileIO.fsyncSync(file.fd);
    fileIO.closeSync(file);
    return true;
  } catch (e) {
    console.log("Failed to prepareFile for " + e);
    return false;
  }
}

export default function requestUploadCrossplatformJSUnit() {
  let testFilePath = '';
  describe('requestUploadCrossplatformTest', () => {
    console.info('====>################################request upload Test start');

    /**
     * beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(() => {
      console.info('====>beforeAll: Prerequisites are executed.');
      testFilePath = globalThis.abilityContext.cacheDir + '/test.txt';
      console.log('testFilePath: ' + testFilePath)
      prepareFile(testFilePath, '123');
    });

    /**
     * beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.
     */
    beforeEach(() => {
      console.info('====>beforeEach: Prerequisites is executed.');
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(() => {
      console.info('====>afterEach: Test case-level clearance conditions is executed.');
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(() => {
      console.info('====>afterAll: Test suite-level cleanup condition is executed');
    });

    let uploadTask: request.UploadTask;
    let RequestData:ESObject = {
      name: 'name',
      value: '123'
    }

    let File: ESObject = {
      filename: 'test',
      name: 'test',
      uri: 'internal://cache/test.txt',
      type: 'txt'
    }

    let uploadConfig:request.UploadConfig = {
      url: 'http://127.0.0.1',
      header: {
        headers: 'http'
      },
      method: 'POST',
      files: [File],
      data: [RequestData]
    };

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 request.NETWORK_MOBILE:" + request.NETWORK_MOBILE);
        expect(request.NETWORK_MOBILE).assertEqual(1);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 request.NETWORK_WIFI:" + request.NETWORK_WIFI);
        expect(request.NETWORK_WIFI).assertEqual(65536);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 request.ERROR_CANNOT_RESUME:" + request.ERROR_CANNOT_RESUME);
        expect(request.ERROR_CANNOT_RESUME).assertEqual(0);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 request.ERROR_DEVICE_NOT_FOUND:" + request.ERROR_DEVICE_NOT_FOUND);
        expect(request.ERROR_DEVICE_NOT_FOUND).assertEqual(1);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0001 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 request.ERROR_FILE_ALREADY_EXISTS:" + request.ERROR_FILE_ALREADY_EXISTS);
        expect(request.ERROR_FILE_ALREADY_EXISTS).assertEqual(2);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 request.ERROR_FILE_ERROR:" + request.ERROR_FILE_ERROR);
        expect(request.ERROR_FILE_ERROR).assertEqual(3);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 request.ERROR_HTTP_DATA_ERROR:" + request.ERROR_HTTP_DATA_ERROR);
        expect(request.ERROR_HTTP_DATA_ERROR).assertEqual(4);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 request.ERROR_INSUFFICIENT_SPACE:" + request.ERROR_INSUFFICIENT_SPACE);
        expect(request.ERROR_INSUFFICIENT_SPACE).assertEqual(5);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0002 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 request.ERROR_TOO_MANY_REDIRECTS:" + request.ERROR_TOO_MANY_REDIRECTS);
        expect(request.ERROR_TOO_MANY_REDIRECTS).assertEqual(6);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 request.ERROR_UNHANDLED_HTTP_CODE:" + request.ERROR_UNHANDLED_HTTP_CODE);
        expect(request.ERROR_UNHANDLED_HTTP_CODE).assertEqual(7);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 request.ERROR_UNKNOWN:" + request.ERROR_UNKNOWN);
        expect(request.ERROR_UNKNOWN).assertEqual(8);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 request.PAUSED_QUEUED_FOR_WIFI:" + request.PAUSED_QUEUED_FOR_WIFI);
        expect(request.PAUSED_QUEUED_FOR_WIFI).assertEqual(0);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0003 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 request.PAUSED_UNKNOWN:" + request.PAUSED_UNKNOWN);
        expect(request.PAUSED_UNKNOWN).assertEqual(4);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 request.PAUSED_WAITING_FOR_NETWORK:" + request.PAUSED_WAITING_FOR_NETWORK);
        expect(request.PAUSED_WAITING_FOR_NETWORK).assertEqual(1);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 request.PAUSED_WAITING_TO_RETRY:" + request.PAUSED_WAITING_TO_RETRY);
        expect(request.PAUSED_WAITING_TO_RETRY).assertEqual(2);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 request.PAUSED_BY_USER:" + request.PAUSED_BY_USER);
        expect(request.PAUSED_BY_USER).assertEqual(3);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0004 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 request.SESSION_FAILED:" + request.SESSION_FAILED);
        expect(request.SESSION_FAILED).assertEqual(4);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 request.SESSION_PAUSED:" + request.SESSION_PAUSED);
        expect(request.SESSION_PAUSED).assertEqual(3);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 request.SESSION_PENDING:" + request.SESSION_PENDING);
        expect(request.SESSION_PENDING).assertEqual(2);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 request.SESSION_RUNNING:" + request.SESSION_RUNNING);
        expect(request.SESSION_RUNNING).assertEqual(1);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 request.SESSION_SUCCESSFUL:" + request.SESSION_SUCCESSFUL);
        expect(request.SESSION_SUCCESSFUL).assertEqual(0);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0005 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_PERMISSION:" + request.EXCEPTION_PERMISSION);
        expect(request.EXCEPTION_PERMISSION).assertEqual(201);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_PARAMCHECK:" + request.EXCEPTION_PARAMCHECK);
        expect(request.EXCEPTION_PARAMCHECK).assertEqual(401);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_UNSUPPORTED:" + request.EXCEPTION_UNSUPPORTED);
        expect(request.EXCEPTION_UNSUPPORTED).assertEqual(801);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_FILEIO:" + request.EXCEPTION_FILEIO);
        expect(request.EXCEPTION_FILEIO).assertEqual(13400001);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_FILEPATH:" + request.EXCEPTION_FILEPATH);
        expect(request.EXCEPTION_FILEPATH).assertEqual(13400002);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_SERVICE:" + request.EXCEPTION_SERVICE);
        expect(request.EXCEPTION_SERVICE).assertEqual(13400003);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.EXCEPTION_OTHERS:" + request.EXCEPTION_OTHERS);
        expect(request.EXCEPTION_OTHERS).assertEqual(13499999);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.ERROR_OFFLINE:" + request.ERROR_OFFLINE);
        expect(request.ERROR_OFFLINE).assertEqual(9);
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 request.ERROR_UNSUPPORTED_NETWORK_TYPE:" + request.ERROR_UNSUPPORTED_NETWORK_TYPE);
        expect(request.ERROR_UNSUPPORTED_NETWORK_TYPE).assertEqual(10);
      } catch (err) {
        expect().assertFail();
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 error: " + err);
      }
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0006 end-----------------------");
      done();
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001
     * @tc.name      Test requestUploadTest type = TIMER_TYPE_REALTIME
     * @tc.desc      Test requestUploadTest API functionality.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 uploadConfig = " + JSON.stringify(uploadConfig));
        request.uploadFile(globalThis.abilityContext, uploadConfig, async (err, uploadTask) => {
          console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 progress uploadTask =" + JSON.stringify(uploadTask));
          expect(uploadTask != undefined).assertEqual(true);
          uploadTask.on('progress', (data1, data2) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 on data1 =" + data1);
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 on data2 =" + data2);
          });

          uploadTask.off('progress', (data1, data2) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 off data1 =" + data1);
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 off data2 =" + data2);
          });

          uploadTask.delete((err, data) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 remove =" + data);
            expect(data).assertEqual(true);
            console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 end-----------------------");
            done();
          });
        });
      } catch (err) {
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_CALLBACK_0001 error: " + err);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001
     * @tc.name      : Use getEntries get the value by mixing the string key
     * @tc.desc      : Mixed strings value can be obtained correctly
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 UploadConfig = " + JSON.stringify(uploadConfig));
        request.uploadFile(globalThis.abilityContext, uploadConfig).then((uploadTask) => {
          console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 uploadTask = " + uploadTask);
          expect(true).assertEqual((uploadTask != undefined));
          uploadTask.on('headerReceive', (header) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 header = " + header);
            expect(true).assertEqual((JSON.stringify(header) !== '{}' || header !== undefined));
          });

          uploadTask.off('headerReceive', (header) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 header = " + header);
            expect(true).assertEqual((JSON.stringify(header) !== '{}' || header !== undefined));
          });

          uploadTask.delete().then((result)=>{
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 remove result = " + result);
            expect(result).assertEqual(true);
            console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 end-----------------------");
            done();
          });
        });
      } catch (e) {
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_PROMISE_0001 error: " + JSON.stringify(e));
        expect(true).assertFail();
      }
    });

    /**
     * @tc.number    : SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007
     * @tc.name      : Use getEntries get the value by mixing the string key
     * @tc.desc      : Mixed strings value can be obtained correctly
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 UploadConfig = " + JSON.stringify(uploadConfig));
        request.uploadFile(globalThis.abilityContext, uploadConfig).then((uploadTask) => {
          console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 uploadTask = " + uploadTask);
          expect(true).assertEqual((uploadTask != undefined));
          uploadTask.on('complete', (taskStates) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 on_complete" );
          });

          uploadTask.off('complete', (taskStates) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 off_complete");
          });

          uploadTask.delete().then((result)=>{
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 remove result = " + result);
            expect(result).assertEqual(true);
            console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 end-----------------------");
            done();
          });
        });
      } catch (e) {
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0007 error: " + JSON.stringify(e));
        expect().assertFail();
      }
    });


    /**
     * @tc.number    : SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008
     * @tc.name      : Use getEntries get the value by mixing the string key
     * @tc.desc      : Mixed strings value can be obtained correctly
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 is starting-----------------------");
      try {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 UploadConfig = " + JSON.stringify(uploadConfig));
        request.uploadFile(globalThis.abilityContext, uploadConfig).then((uploadTask) => {
          console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 uploadTask = " + uploadTask);
          expect(true).assertEqual((uploadTask != undefined));
          uploadTask.on('fail', (taskStates) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 on_fail");
          });

          uploadTask.off('fail', (taskStates) => {
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 off_fail");
          });

          uploadTask.delete().then((result)=>{
            console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 remove result = " + result);
            expect(result).assertEqual(true);
            console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 end-----------------------");
            done();
          });
        });
      } catch (e) {
        console.error("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_0008 error: " + JSON.stringify(e));
        expect().assertFail();
      }
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001
     * @tc.desc      Starts a upload task.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001', 0, async (done: Function) => {
      console.info("-----------------------SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001 is starting-----------------------");
      try {
        request.uploadFile(globalThis.abilityContext, uploadConfig, (err, uploadTask)=>{
          console.info("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001 uploadFile: " + uploadTask);
          try{
            expect(true).assertEqual(uploadTask != undefined);
          }catch(e){
            console.info("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001 except error: " + e);
          }
        });
      } catch (err) {
        console.error("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001 error: " + err);
      };
      let t = setTimeout(()=>{
        console.info("-----------------------SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_CALLBACK_0001 end-----------------------");
        clearTimeout(t);
        done();
      }, 8000);
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001
     * @tc.desc      Starts a upload task.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001', 0, async (done: Function) => {
      console.info("-----------------------SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 is starting-----------------------");
      try{
        request.uploadFile(globalThis.abilityContext, uploadConfig).then(uploadTask => {
          console.info("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 uploadFile: " + uploadTask);
          try{
            expect(true).assertEqual(uploadTask != undefined);
          }catch(e){
            console.info("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 except error: " + e);
          }
        }).catch((err: BusinessError) => {
          console.error("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 error: " + err);
          expect().assertFail();
        })
      }catch(err){
        console.error("====>SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 catch error: " + err);
      }
      let t = setTimeout(()=>{
        console.info("-----------------------SUB_REQUEST_CROSSPLATFORM_uploadFile_STAGE_API_PROMISE_0001 end-----------------------");
        clearTimeout(t);
        done();
      }, 8000);
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001
     * @tc.desc      Delete the upload task.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 is starting-----------------------");
      request.uploadFile(globalThis.abilityContext, uploadConfig, (err, uploadTask) => {
        try{
          console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 uploadTask: " + uploadTask);
          expect(uploadTask != undefined).assertEqual(true);
          uploadTask.delete((err, data) => {
            try{
              if (err) {
                console.error('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 Failed to delete the uploadTask task.');
                expect().assertFail();
                done();
              }
              console.info('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 uploadTask task delete success.');
              expect(typeof data == "boolean").assertTrue();
              console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 end-----------------------");
              done();
            }catch(err){
              console.error('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 delete error' + err);
              done();
            }
          });
        } catch (error) {
          console.error('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0001 delete catch error' + error);
          done();
        }
      })
    });

    /**
     * @tc.number    SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002
     * @tc.desc      Delete the upload task.
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002', 0, async (done: Function) => {
      console.info("====>-----------------------SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002 is starting-----------------------");
      request.uploadFile(globalThis.abilityContext, uploadConfig, (err, uploadTask) => {
        console.info("====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002 uploadTask: " + uploadTask);
        try{
          expect(uploadTask != undefined).assertEqual(true);
          uploadTask.delete().then(data => {
            console.info('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002 delete data:' + JSON.stringify(data));
            expect(data).assertEqual(true);
            done();
          }).catch((err: BusinessError) => {
            console.info('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002 Failed to delete the uploadTask task.');
            expect().assertFail();
            done();
          })
        }catch(err){
          console.error('====>SUB_REQUEST_CROSSPLATFORM_UPLOAD_API_DELETE_0002 delete catch err');
          done();
        }
      })
    });

  })
}
