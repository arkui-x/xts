/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium';
import { BusinessError } from '@kit.BasicServicesKit';

export default function requestCacheDownloadNormalUnitTest() {
  describe('requestCacheDownloadNormalJSTest', () => {
    console.info('====>requestCacheDownloadNormalJSTest Test start');

    afterAll(async (): Promise<void> => {
      try {
        cacheDownload.clearMemoryCache();
        console.info('====>afterAll clearMemoryCache success');
        cacheDownload.clearFileCache();
        console.info('====>afterAll clearFileCache success');
      } catch (err) {
        console.info('====>afterAll cleanup err:' + JSON.stringify(err));
      }
    });

    // =====================================================================
    // The two cases below are commented out: platform semantics gap, arkui-x
    // on iOS cannot express the "no network permission -> 201" scenario.
    //
    // Background: in the upstream OH suite (xts_acts/request/
    // requestCacheDownloadNormalTest) these two cases live in a SEPARATE test
    // app whose module.json5 deliberately does NOT declare
    // ohos.permission.INTERNET, to verify that cacheDownload.download() /
    // getDownloadInfo() synchronously throw err.code === 201 when network
    // permission is absent.
    //
    // arkui-x cannot reproduce this denial scenario, for three reasons:
    //   1) Migration merged this suite into the main requestCacheDownloadTest
    //      app, whose module.json5 DOES declare ohos.permission.INTERNET, so
    //      the "no permission" precondition is already broken at config level.
    //   2) arkui-x has no OH permission gate: download()/getDownloadInfo()
    //      do not check permission and lazily initialize on first call
    //      (see Download() in cache_download_module.cpp), so they never throw
    //      201.
    //   3) iOS does have a checkable "wireless data" authorization
    //      (CoreTelephony.CTCellularData.restrictedState), but XTS runs on the
    //      simulator which has no cellular modem: the state stays unknown/
    //      notRestricted and the prompt never fires. Its semantics are also
    //      cellular-only and it is a one-time prompt, so it cannot be replayed
    //      per case and cannot map to ohos.permission.INTERNET's 201.
    //
    // To restore: split this suite back into a standalone app that does NOT
    // declare INTERNET, and implement a manifest-based permission gate in
    // arkui-x (throw 201 when INTERNET is absent from module.json5
    // requestPermissions). This approach is independent of any iOS API.
    // =====================================================================

    // /**
    //  * @tc.name   SUB_Request_cacheDownloadNormal_0100
    //  * @tc.number SUB_Request_cacheDownloadNormal_0100
    //  * @tc.desc   Starts a upload session.
    //  * @tc.type   FUNCTION
    //  * @tc.size   MEDIUMTEST
    //  * @tc.level  LEVEL0
    //  */
    // it('SUB_Request_cacheDownloadNormal_0100', Level.LEVEL0, async (done: Function) => {
    //   console.info("====>-----------------------SUB_Request_cacheDownloadNormal_0100 is starting-----------------------");
    //   class cacheDownloadOptions implements cacheDownload.CacheDownloadOptions {
    //     headers?: Record<string, string> | undefined = {'Accept': '*/*'}
    //   }
    //   let url: string = 'https://gitee.com/murphy1984/download/releases/download/V1/test_picture_1.jpg';
    //   try {
    //     let downloadOptions = new cacheDownloadOptions();
    //     cacheDownload.download(url, downloadOptions);
    //     console.info("====>SUB_Request_cacheDownloadNormal_0100 download success url: " + url);
    //     expect().assertFail();
    //     done();
    //   } catch (err) {
    //     console.info("====>SUB_Request_cacheDownloadNormal_0100 catch err: " + JSON.stringify(err));
    //     expect(err.code).assertEqual(201);
    //     done();
    //   }
    // });

    // /**
    //  * @tc.name   SUB_Request_cacheDownload_maintenance_0100
    //  * @tc.number SUB_Request_cacheDownload_maintenance_0100
    //  * @tc.desc   Starts a upload session.
    //  * @tc.type   FUNCTION
    //  * @tc.size   MEDIUMTEST
    //  * @tc.level  LEVEL0
    //  */
    // it('SUB_Request_cacheDownload_maintenance_0100', Level.LEVEL0, async (done: Function) => {
    //   console.info("====>-----------------------SUB_Request_cacheDownload_maintenance_0100 is starting-----------------------");
    //   try {
    //     let url: string = 'https://gitee.com/murphy1984/download/releases/download/V1/test_picture_1.jpg';
    //     let downloadInfo: cacheDownload.DownloadInfo | undefined = cacheDownload.getDownloadInfo(url);
    //     console.info("====>SUB_Request_cacheDownload_maintenance_0100 downloadInfo success: " + downloadInfo);
    //     expect().assertFail();
    //     done();
    //   } catch (err) {
    //     console.info("====>SUB_Request_cacheDownload_maintenance_0100 catch err: " + JSON.stringify(err));
    //     expect(err.code).assertEqual(201);
    //     done();
    //   }
    // });

  });
}
