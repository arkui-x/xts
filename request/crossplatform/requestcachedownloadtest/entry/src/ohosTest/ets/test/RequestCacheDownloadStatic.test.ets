/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import cacheDownload from "@ohos.request.cacheDownload";
import common from '@ohos.app.ability.common';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size  } from "@ohos/hypium";

import Utils from './Util.test';

let baseContext: common.UIAbilityContext | undefined;

export default function requestCacheDownloadStaticTest() {
  describe('requestCacheDownloadStaticTest', (): void => {
    console.info('====>################################request download Test start');

    /**
     * beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async (done: () => void): Promise<void> => {
      try {
        console.info('====>beforeAll start');
        await Utils.msSleep(1000)
        console.info('====>beforeAll end');
        baseContext = AppStorage.get<common.UIAbilityContext>("context") as common.UIAbilityContext;
        console.info('====>baseContext set success');
        try {
          let timeoutOptions: cacheDownload.TimeoutOptions = {
            networkCheckTimeout: 10,
            httpTotalTimeout: 30000,
          }
          cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
          console.info('====>beforeAll setGlobalTimeoutOptions success');
        } catch (err) {
          console.info('====>beforeAll setGlobalTimeoutOptions err:' + JSON.stringify(err));
        }
        done();
      } catch (err) {
        console.info('====>beforeAll catch err:'+JSON.stringify(err))
        done();
      }
    });

    /**
     * beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.
     */
    beforeEach((): void => {
      console.info('====>beforeEach: Prerequisites is executed.');
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach((): void => {
      console.info('====>afterEach: Test case-level clearance conditions is executed.');
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll((): void => {
      console.info('====>afterAll: Test suite-level cleanup condition is executed');
    });


    /**
     * @tc.name   SUB_Request_cacheDownload_ListeningSuccess_0100
     * @tc.number SUB_Request_cacheDownload_ListeningSuccess_0100
     * @tc.desc   onDownloadSuccess url equal 8192.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_ListeningSuccess_0100',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_ListeningSuccess_0100 is starting-----------------------");
      let dns = cacheDownload.ErrorCode.DNS
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 DNS: ${JSON.stringify(dns)}`);
      expect(dns === 0).assertTrue();
      let tcp = cacheDownload.ErrorCode.TCP
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 TCP: ${JSON.stringify(tcp)}`);
      expect(tcp === 16).assertTrue();
      let ssl = cacheDownload.ErrorCode.SSL
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 SSL: ${JSON.stringify(ssl)}`);
      expect(ssl === 32).assertTrue();
      let http = cacheDownload.ErrorCode.HTTP
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 HTTP: ${JSON.stringify(http)}`);
      expect(http === 48).assertTrue();
      let others = cacheDownload.ErrorCode.OTHERS
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 OTHERS: ${JSON.stringify(others)}`);
      expect(others === 255).assertTrue();
      let force = cacheDownload.CacheStrategy.FORCE
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 OTHERS: ${JSON.stringify(force)}`);
      expect(force === 0).assertTrue();
      let lazy = cacheDownload.CacheStrategy.LAZY
      console.info(`====>SUB_Request_cacheDownload_ListeningSuccess_0100 OTHERS: ${JSON.stringify(lazy)}`);
      expect(lazy === 1).assertTrue();
      done();
    });


    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0200
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0200
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0200',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0200 is starting-----------------------");
      try {
        let num: number = 1 * 1024 * 1024
        let url: string = 'http://127.0.0.1:8080/testpicture6.jpg';
        let headers: Record<string, string> = {'Accept': '*/*'};
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          headers: headers,
          sslType: cacheDownload.SslType.TLCP,
          cacheStrategy: cacheDownload.CacheStrategy.LAZY,
          caPath: '/data/storage/el2/bundle/entry_test/resources/resfile/sm2.ca.pem',
        }
        cacheDownload.setMemoryCacheSize(num);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0200 setMemoryCacheSize success");
        cacheDownload.setFileCacheSize(num);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0200 setFileCacheSize success");
        cacheDownload.download(url, downloadOptions);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0200 doonDownloadErrorwnload success");
        let downloadInfo = cacheDownload.getDownloadInfo(url);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0200 getDownloadInfo: " + JSON.stringify(downloadInfo));
        expect(downloadInfo === undefined).assertTrue();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0200 catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });


    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0300
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0300
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0300',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0300 is starting-----------------------");
      try {
        let url: string = 'http://127.0.0.1:8080/test_picture_1.jpg';
        let headers: Record<string, string> = {'Accept': '*/*'};
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          headers: headers,
          sslType: cacheDownload.SslType.TLS,
          cacheStrategy: cacheDownload.CacheStrategy.FORCE,
          caPath:''
        }

        let onSuccessCallback = () => {
          try {
            cacheDownload.offDownloadSuccess(url);
            let downloadInfo = cacheDownload.getDownloadInfo(url);
            console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0300 getDownloadInfo: " + JSON.stringify(downloadInfo));
            expect(downloadInfo!.resource.size !== undefined).assertTrue();
            expect(downloadInfo!.network.dnsServers !== undefined).assertTrue();
            expect(downloadInfo!.network.ip !== undefined).assertTrue();
            expect(downloadInfo!.performance.dnsTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.connectTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.tlsTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.firstSendTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.firstReceiveTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.totalTime !== undefined).assertTrue();
            expect(downloadInfo!.performance.redirectTime !== undefined).assertTrue();
            cacheDownload.clearFileCache();
            cacheDownload.clearMemoryCache();
            cacheDownload.cancel(url);
            done();
          }catch (err) {
            console.info(`====>SUB_Request_cacheDownload_Supplemental_Static_0300 onSuccessCallback error: ${JSON.stringify(err)}`);
            done();
          }
        }
        cacheDownload.setDownloadInfoListSize(1);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0300 setDownloadInfoListSize success");
        cacheDownload.download(url, downloadOptions);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0300 download success url: " + url);
        cacheDownload.onDownloadSuccess(url, onSuccessCallback);
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0300 catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });


    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0400
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0400
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0400',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0400 is starting-----------------------");
      try {
        let url: string = 'http://127.0.0.1:8080/testpicture7.jpg';
        let onErrorCallback = (err: cacheDownload.DownloadError) => {
          try {
            cacheDownload.offDownloadError(url);
            console.info(`====>SUB_Request_cacheDownload_Supplemental_Static_0400 onErrorCallback3 message: ${JSON.stringify(err.message)}`);
            console.info(`====>SUB_Request_cacheDownload_Supplemental_Static_0400 onErrorCallback3 errorCode: ${JSON.stringify(err.errorCode)}`);
            expect(err.message === "404").assertTrue();
            expect(err.errorCode === 48).assertTrue();
            done();
          }catch (err) {
            console.info(`====>SUB_Request_cacheDownload_Supplemental_Static_0400 onSuccessCallback error: ${JSON.stringify(err)}`);
            done();
          }
        }
        cacheDownload.setDownloadInfoListSize(1);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0400 setDownloadInfoListSize success");
        cacheDownload.download(url, {});
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0400 download success url: " + url);
        cacheDownload.onDownloadError(url, onErrorCallback);
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0400 catch err: " + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0500
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0500
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0500',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0500 is starting-----------------------");
      let headers: Record<string, string> = {'Accept': '*/*'};
      let downloadOptions: cacheDownload.CacheDownloadOptions = {
        headers: headers,
      }
      let text: string = ''.padEnd(8176, 'cacheDownload')
      let url: string = 'https://gitee' + text + '.com';
      try {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0500 download success url length: " + url.length);
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0500 catch err: " + JSON.stringify(err));
        expect(err.code).assertEqual(401);
        done();
      }
    });


    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0600
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0600
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0600',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0600 is starting-----------------------");
      let text: string = ''.padEnd(8176, 'cacheDownload')
      let url: string = 'https://gitee' + text + '.com';
      try {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0600 cancel success url length: " + url.length);
        cacheDownload.cancel(url);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0600 catch err: " + JSON.stringify(err));
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0700
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0700
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0700',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0700 is starting-----------------------");
      let num: number = 1 * 1024 * 1024 * 1024 + 1
      try {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0700 setMemoryCacheSize success num: " + num);
        cacheDownload.setMemoryCacheSize(num);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0700 catch err: " + JSON.stringify(err));
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0800
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0800
     * @tc.desc   Starts a upload session.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0800',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0800 is starting-----------------------");
      let num: number = 4294967296 + 1
      try {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0800 setMemoryCacheSize success num: " + num);
        cacheDownload.setFileCacheSize(num);
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0800 setMemoryCacheSize setFileCacheSize success" + num);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0800 catch err: " + JSON.stringify(err.code));
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_0900
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_0900
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_0900',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_0900 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: -1,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_0900 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1000
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1000
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1000',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1000 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 21,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1000 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1100
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1100
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1100',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1100 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 0,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1100 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1200
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1200
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1200',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1200 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 20,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1200 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1300
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1300
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1300',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1300 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 0,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1300 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1400
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1400
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1400',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1400 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 4294968,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1400 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1500
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1500
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1500',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1500 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 1,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1500 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1600
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1600
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1600',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1600 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 4294967,
        }
        cacheDownload.setGlobalTimeoutOptions(timeoutOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1600 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1700
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1700
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1700',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1700 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: -1,
        }
        cacheDownload.setGlobalRetryOptions(retryOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1700 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1800
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1800
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1800',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1800 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 11,
        }
        cacheDownload.setGlobalRetryOptions(retryOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1800 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_1900
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_1900
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_1900',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_1900 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 0,
        }
        cacheDownload.setGlobalRetryOptions(retryOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_1900 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2000
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2000
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2000',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2000 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 10,
        }
        cacheDownload.setGlobalRetryOptions(retryOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2000 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2100
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2100
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2100',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2100 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: -1,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          retry: retryOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2100 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2200
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2200
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2200',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2200 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 11,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          retry: retryOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2200 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2300
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2300
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2300',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2300 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 0,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          retry: retryOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2300 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2400
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2400
     * @tc.desc   the boundary value of RetryOptions.maxRetryCount
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2400',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2400 is starting-----------------------");
      try {
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 10,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          retry: retryOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2400 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2500
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2500
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout 
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2500',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2500 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: -1,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2500 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2600
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2600
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout 
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2600',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2600 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 21,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2600 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2700
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2700
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2700',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2700 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 0,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2700 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2800
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2800
     * @tc.desc   the boundary value of TimeoutOptions.networkCheckTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2800',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2800 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          networkCheckTimeout: 20,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2800 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

        /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_2900
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_2900
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout 
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_2900',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_2900 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 0,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_2900 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_3000
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_3000
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout 
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_3000',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_3000 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 4294968,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        expect().assertFail();
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_3000 catch err code:" + err.code + "err message:" + err.message);
        expect(err.code).assertEqual(401);
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_3100
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_3100
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_3100',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_3100 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 1,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_3100 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_3200
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_3200
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_3200',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_3200 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 4294967,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_3200 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.name   SUB_Request_cacheDownload_Supplemental_Static_3300
     * @tc.number SUB_Request_cacheDownload_Supplemental_Static_3300
     * @tc.desc   the boundary value of TimeoutOptions.httpTotalTimeout  
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('SUB_Request_cacheDownload_Supplemental_Static_3300',  TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (done: () => void) => {
      console.info("====>-----------------------SUB_Request_cacheDownload_Supplemental_Static_3300 is starting-----------------------");
      try {
        let timeoutOptions: cacheDownload.TimeoutOptions = {
          httpTotalTimeout: 1,
          networkCheckTimeout: 0,
        }
        let retryOptions: cacheDownload.RetryOptions = {
          maxRetryCount: 0,
        }
        let url: string = 'https://gitcode.com/gzccc/request_test/blob/main/README.md';
        let downloadOptions: cacheDownload.CacheDownloadOptions = {
          timeout: timeoutOptions,
          retry: retryOptions,
        }
        cacheDownload.download(url, downloadOptions);
        done();
      } catch (err) {
        console.info("====>SUB_Request_cacheDownload_Supplemental_Static_3300 catch err code:" + err.code + "err message:" + err.message);
        expect().assertFail();
        done();
      }
    });

  });
}