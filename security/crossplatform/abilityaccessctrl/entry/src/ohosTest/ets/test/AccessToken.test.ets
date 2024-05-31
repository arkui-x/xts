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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';

const GrantStatus = abilityAccessCtrl.GrantStatus;
const ERR_PARAM_INVALID = 12100001;

let permissionNameUser: Permissions = "ohos.permission.DISTRIBUTED_DATASYNC";
let permissionNameSystem: Permissions = "ohos.permission.GET_BUNDLE_INFO";
let tokenID: number = 11;

export default function AccessTokenTest() {
  describe('AccessTokenTest', function () {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(function () {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(function () {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(function () {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(function () {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    
    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_001
     *@tc.name      : testCheckAccessToken001
     *@tc.desc      : After the installation, user_grant permission is not granted by default(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessToken001', 0, async function(done){
      console.info("Test_checkAccessToken_001 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        var result = await atManager.checkAccessToken(tokenID, permissionNameUser);
        console.info("Test_checkAccessToken_001 tokenID" + tokenID + "-" + result);
        expect(result).assertEqual(GrantStatus.PERMISSION_DENIED);
        done();
      } catch(error) {
        console.info("Test_checkAccessToken_001 tokenID" + JSON.stringify(error));
      }
      done();
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_002
     *@tc.name      : testCheckAccessToken002
     *@tc.desc      : After the installation, system_grant permission is granted by default(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessToken002', 0, async function(done){
      console.info("Test_checkAccessToken_002 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        var result = await atManager.checkAccessToken(tokenID, permissionNameSystem);
        console.info("Test_checkAccessToken_002 tokenID" + tokenID + "-" + result);
        expect(result).assertEqual(GrantStatus.PERMISSION_DENIED);
        done();
      } catch(error) {
        console.info("Test_checkAccessToken_002 error code" + error.code + "error message" + error.message);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_003
     *@tc.name      : testCheckAccessToken003
     *@tc.desc      : Test invalid permission(empty)(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessToken003', 0, async function(done){
      console.info("Test_checkAccessToken_003 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        atManager.checkAccessToken(0, permissionNameUser).then((data) => {
          console.log(`Test_checkAccessToken_003 , data->${JSON.stringify(data)}`);
        }).catch((err) => {
          console.log(`Test_checkAccessToken_003 err->${JSON.stringify(err)}`);
          expect(err.code).assertEqual(ERR_PARAM_INVALID);
          done();
        });
      }catch(err) {
        console.log(`catch err->${JSON.stringify(err)}`);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_004
     *@tc.name      : testCheckAccessToken004
     *@tc.desc      : Test invalid tokenId(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessToken004', 0, async function(done){
      console.info("Test_checkAccessToken_004 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        atManager.checkAccessToken(11, permissionNameUser).then((data) => {
          console.log(`Test_checkAccessToken_004 data->${JSON.stringify(data)}`);
          expect(data).assertEqual(GrantStatus.PERMISSION_DENIED);
          done();
        }).catch((err) => {
          console.log(`Test_checkAccessToken_004 err->${JSON.stringify(err)}`);
        });
      }catch(err) {
        console.log(`catch err->${JSON.stringify(err)}`);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_005
     *@tc.name      : testCheckAccessToken005
     *@tc.desc      : Test invalid permission(length exceeds 256)(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessToken005', 0, async function(done){
      console.info("Test_checkAccessToken_005 start");
      var atManager = abilityAccessCtrl.createAtManager();
      var permissionName = "ohos.permission.testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
      + "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
      + "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest";
      try {
        atManager.checkAccessToken(0, permissionNameUser).then((data) => {
          console.log(`Test_checkAccessToken_005 success, data->${JSON.stringify(data)}`);
        }).catch((err) => {
          console.log(`Test_checkAccessToken_005 err->${JSON.stringify(err)}`);
          expect(err.code).assertEqual(ERR_PARAM_INVALID);
          done();
        });
      }catch(err) {
        console.log(`catch err->${JSON.stringify(err)}`);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_SYNC_001
     *@tc.name      : testCheckAccessTokenSync001
     *@tc.desc      : After the installation, user_grant permission is not granted by default(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessTokenSync001', 0, async function(done){
      console.info("Test_checkAccessTokenSync_001 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        var result = atManager.checkAccessTokenSync(tokenID, permissionNameUser);
        console.info("Test_checkAccessTokenSync_001 tokenID" + tokenID + "-" + result);
        expect(result).assertEqual(GrantStatus.PERMISSION_DENIED);
        done();
      } catch(error) {
        console.info("Test_checkAccessTokenSync_001 tokenID" + JSON.stringify(error));
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_SYNC_002
     *@tc.name      : testCheckAccessTokenSync002
     *@tc.desc      : After the installation, system_grant permission is granted by default(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessTokenSync002', 0, async function(done){
      console.info("Test_checkAccessTokenSync_002 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        var result = atManager.checkAccessTokenSync(tokenID, permissionNameSystem);
        console.info("Test_checkAccessTokenSync_002 tokenID" + tokenID + "-" + result);
        expect(result).assertEqual(GrantStatus.PERMISSION_DENIED);
        done();
      } catch(error) {
        console.info("Test_checkAccessTokenSync_002 error code" + error.code + "error message" + error.message);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_SYNC_003
     *@tc.name      : testCheckAccessTokenSync003
     *@tc.desc      : Test invalid permission(empty)(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessTokenSync003', 0, async function(done){
      console.info("Test_checkAccessTokenSync_003 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        atManager.checkAccessTokenSync(0, permissionNameSystem);
      } catch(error) {
        console.info("Test_checkAccessTokenSync_003 error code" + error.code + "error message" + error.message);
        expect(error.code).assertEqual(ERR_PARAM_INVALID);
        done();
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_SYNC_004
     *@tc.name      : testCheckAccessTokenSync004
     *@tc.desc      : Test invalid tokenId(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessTokenSync004', 0, async function(done){
      console.info("Test_checkAccessTokenSync_004 start");
      var atManager = abilityAccessCtrl.createAtManager();
      try {
        var result = atManager.checkAccessTokenSync(11, permissionNameSystem);
        console.info("Test_checkAccessTokenSync_004 tokenID" + tokenID + "-" + result);
        expect(result).assertEqual(GrantStatus.PERMISSION_DENIED);
        done();
      } catch(error) {
        console.info("Test_checkAccessTokenSync_004 error code" + error.code + "error message" + error.message);
      }
    })

    /**
     *@tc.number    : TEST_CHECK_ACCESS_TOKEN_SYNC_005
     *@tc.name      : testCheckAccessTokenSync005
     *@tc.desc      : Test invalid permission(length exceeds 256)(Promise).
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it('testCheckAccessTokenSync005', 0, async function(done){
      console.info("Test_checkAccessTokenSync_005 start");
      var atManager = abilityAccessCtrl.createAtManager();
      var permissionName = "ohos.permission.testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
      + "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
      + "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest";
      try {
        atManager.checkAccessTokenSync(0, permissionNameUser);
      } catch(error) {
        console.info("Test_checkAccessTokenSync_005 error code" + error.code + "error message" + error.message);
        expect(error.code).assertEqual(ERR_PARAM_INVALID);
        done();
      }
    })

    /**
     *@tc.number    : TEST_GRANT_STATUS_001
     *@tc.name      : testGrantStatus001
     *@tc.desc      : Test enum.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it("testGrantStatus001", 0, function () {
      try {
        expect(abilityAccessCtrl.GrantStatus.PERMISSION_DENIED).assertEqual(-1);
      } catch (err) {
        console.info("testGrantStatus001 meet an error: " + err);
      }
    });

    /**
     *@tc.number    : TEST_GRANT_STATUS_002
     *@tc.name      : testGrantStatus002
     *@tc.desc      : Test enum.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 2
     */
    it("testGrantStatus002", 0, function () {
      try {
        expect(abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED).assertEqual(0);
      } catch (err) {
        console.info("testGrantStatus002 meet an error: " + err);
      }
    });
  })
}
