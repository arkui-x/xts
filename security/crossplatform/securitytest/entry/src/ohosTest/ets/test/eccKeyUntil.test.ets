/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, TestType, Size, Level, expect } from '@ohos/hypium';
import cryptoFramework from '@ohos.security.cryptoFramework';
import * as specUtil from '../config/keyGenSpecUtil';
import { AsyAlgName } from '../config/keyGenSpecUtil';

export default function SecurityCryptoFwKeyGenerateECCTestUnit() {
  describe('SecurityCryptoFwKeyGenerateECCTestUnit', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    });
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    });
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    });
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0100
     * @tc.name   : testEccKeyUntil0100
     * @tc.desc   : test convertPoint with compressed format and different curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0100";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = specUtil.curveName(AsyAlgName.P256t1);
      try {
        let pointData: Uint8Array = specUtil.compressedPointData(algName);
        cryptoFramework.ECCKeyUtil.convertPoint(errAlgName, pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0200
     * @tc.name   : testEccKeyUntil0200
     * @tc.desc   : test convertPoint with compressed format and empty curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0200";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = "";
      try {
        let pointData: Uint8Array = specUtil.compressedPointData(algName);
        cryptoFramework.ECCKeyUtil.convertPoint(errAlgName, pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0300
     * @tc.name   : testEccKeyUntil0300
     * @tc.desc   : test convertPoint with compressed format and error curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0300";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = "errTest";
      try {
        let pointData: Uint8Array = specUtil.compressedPointData(algName);
        cryptoFramework.ECCKeyUtil.convertPoint(errAlgName, pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0400
     * @tc.name   : testEccKeyUntil0400
     * @tc.desc   : test convertPoint with error compressed point, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0400";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      try {
        let pointData: Uint8Array = specUtil.compressedPointData(algName);
        pointData[0] = 4;
        cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0500
     * @tc.name   : testEccKeyUntil0500
     * @tc.desc   : test convertPoint with error compressed point, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0500";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      try {
        let pointData: Uint8Array = specUtil.compressedPointData(algName);
        pointData = pointData.slice(0, pointData.length - 1);
        cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0600
     * @tc.name   : testEccKeyUntil0600
     * @tc.desc   : test convertPoint with unCompressed format and different curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0600";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = specUtil.curveName(AsyAlgName.P256t1);
      try {
        let pointData: Uint8Array = specUtil.unCompressedPointData(algName);
        cryptoFramework.ECCKeyUtil.convertPoint(errAlgName, pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0700
     * @tc.name   : testEccKeyUntil0700
     * @tc.desc   : test convertPoint with error unCompressed point, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0700";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      try {
        let pointData: Uint8Array = specUtil.unCompressedPointData(algName);
        pointData[1] = 0;
        cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0800
     * @tc.name   : testEccKeyUntil0800
     * @tc.desc   : test convertPoint with error unCompressed point, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0800";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      try {
        let pointData: Uint8Array = specUtil.unCompressedPointData(algName);
        pointData[0] = 2;
        cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0900
     * @tc.name   : testEccKeyUntil0900
     * @tc.desc   : test convertPoint with error unCompressed point, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil0900";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      try {
        let pointData: Uint8Array = specUtil.unCompressedPointData(algName);
        let tmpArr = new Uint8Array(pointData.length + 1);
        tmpArr.set(pointData);
        tmpArr[pointData.length] = 0;
        pointData = tmpArr;
        cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1000
     * @tc.name   : testEccKeyUntil1000
     * @tc.desc   : test getEncodedPoint with ecc point and compressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level1
     */
    it("testEccKeyUntil1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let testNumber: string = "testEccKeyUntil1000";
      console.log(testNumber + ": started");
      let algNames: AsyAlgName[] = [AsyAlgName.ECC224, AsyAlgName.ECC256, AsyAlgName.ECC384, AsyAlgName.ECC521];
      let format: string = "COMPRESSED";
      try {
        for (let i = 0; i < algNames.length; i++) {
          let point: cryptoFramework.Point = specUtil.pkPoint(algNames[i]);
          let pointData: Uint8Array =
            cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algNames[i]), point, format);
          expect(pointData.toString()).assertEqual(specUtil.compressedPointData(algNames[i]).toString());
          console.log(testNumber + `: ${algNames[i]} getEncodedPoint success`);
          let postPoint: cryptoFramework.Point =
            cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algNames[i]), pointData);
          console.log(testNumber + `: ${algNames[i]} convertPoint success`);
          expect(postPoint.x).assertEqual(point.x);
          expect(postPoint.y).assertEqual(point.y);
        }
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1100
     * @tc.name   : testEccKeyUntil1100
     * @tc.desc   : test getEncodedPoint with brainPool point and compressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1100";
      console.log(testNumber + ": started");
      let algNames: AsyAlgName[] = [AsyAlgName.P160r1, AsyAlgName.P160t1, AsyAlgName.P192r1, AsyAlgName.P192t1,
        AsyAlgName.P224r1, AsyAlgName.P224t1, AsyAlgName.P256r1, AsyAlgName.P256t1, AsyAlgName.P320r1,
        AsyAlgName.P320t1, AsyAlgName.P384r1, AsyAlgName.P384t1, AsyAlgName.P512r1, AsyAlgName.P512t1];
      let format: string = "COMPRESSED";
      try {
        for (let i = 0; i < algNames.length; i++) {
          let point: cryptoFramework.Point = specUtil.pkPoint(algNames[i]);
          let pointData: Uint8Array =
            cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algNames[i]), point, format);
          expect(pointData.toString()).assertEqual(specUtil.compressedPointData(algNames[i]).toString());
          console.log(testNumber + `: ${algNames[i]} getEncodedPoint success`);
          let postPoint: cryptoFramework.Point =
            cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algNames[i]), pointData);
          console.log(testNumber + `: ${algNames[i]} convertPoint success`);
          expect(postPoint.x).assertEqual(point.x);
          expect(postPoint.y).assertEqual(point.y);
        }
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1200
     * @tc.name   : testEccKeyUntil1200
     * @tc.desc   : test getEncodedPoint with sm2 point and compressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1200";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.SM2;
      let format: string = "COMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        let pointData: Uint8Array =
          cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algName), point, format);
        expect(pointData.toString()).assertEqual(specUtil.compressedPointData(algName).toString());
        console.log(testNumber + `: ${algName} getEncodedPoint success`);
        let postPoint: cryptoFramework.Point =
          cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        console.log(testNumber + `: ${algName} convertPoint success`);
        expect(postPoint.x).assertEqual(point.x);
        expect(postPoint.y).assertEqual(point.y);
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1300
     * @tc.name   : testEccKeyUntil1300
     * @tc.desc   : test getEncodedPoint with ecc point and unCompressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level1
     */
    it("testEccKeyUntil1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let testNumber: string = "testEccKeyUntil1300";
      console.log(testNumber + ": started");
      let algNames: AsyAlgName[] = [AsyAlgName.ECC224, AsyAlgName.ECC256, AsyAlgName.ECC384, AsyAlgName.ECC521];
      let format: string = "UNCOMPRESSED";
      try {
        for (let i = 0; i < algNames.length; i++) {
          let point: cryptoFramework.Point = specUtil.pkPoint(algNames[i]);
          let pointData: Uint8Array =
            cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algNames[i]), point, format);
          expect(pointData.toString()).assertEqual(specUtil.unCompressedPointData(algNames[i]).toString());
          console.log(testNumber + `: ${algNames[i]} getEncodedPoint success`);
          let postPoint: cryptoFramework.Point =
            cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algNames[i]), pointData);
          console.log(testNumber + `: ${algNames[i]} convertPoint success`);
          expect(postPoint.x).assertEqual(point.x);
          expect(postPoint.y).assertEqual(point.y);
        }
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1400
     * @tc.name   : testEccKeyUntil1400
     * @tc.desc   : test getEncodedPoint with brainPool point and unCompressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1400";
      console.log(testNumber + ": started");
      let algNames: AsyAlgName[] = [AsyAlgName.P160r1, AsyAlgName.P160t1, AsyAlgName.P192r1, AsyAlgName.P192t1,
        AsyAlgName.P224r1, AsyAlgName.P224t1, AsyAlgName.P256r1, AsyAlgName.P256t1, AsyAlgName.P320r1,
        AsyAlgName.P320t1, AsyAlgName.P384r1, AsyAlgName.P384t1, AsyAlgName.P512r1, AsyAlgName.P512t1];
      let format: string = "UNCOMPRESSED";
      try {
        for (let i = 0; i < algNames.length; i++) {
          let point: cryptoFramework.Point = specUtil.pkPoint(algNames[i]);
          let pointData: Uint8Array =
            cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algNames[i]), point, format);
          expect(pointData.toString()).assertEqual(specUtil.unCompressedPointData(algNames[i]).toString());
          console.log(testNumber + `: ${algNames[i]} getEncodedPoint success`);
          let postPoint: cryptoFramework.Point =
            cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algNames[i]), pointData);
          console.log(testNumber + `: ${algNames[i]} convertPoint success`);
          expect(postPoint.x).assertEqual(point.x);
          expect(postPoint.y).assertEqual(point.y);
        }
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1500
     * @tc.name   : testEccKeyUntil1500
     * @tc.desc   : test getEncodedPoint with sm2 point and unCompressed format, process success
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1500";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.SM2;
      let format: string = "UNCOMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        let pointData: Uint8Array =
          cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algName), point, format);
        expect(pointData.toString()).assertEqual(specUtil.unCompressedPointData(algName).toString());
        console.log(testNumber + `: ${algName} getEncodedPoint success`);
        let postPoint: cryptoFramework.Point =
          cryptoFramework.ECCKeyUtil.convertPoint(specUtil.curveName(algName), pointData);
        console.log(testNumber + `: ${algName} convertPoint success`);
        expect(postPoint.x).assertEqual(point.x);
        expect(postPoint.y).assertEqual(point.y);
      } catch (err) {
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        expect(null).assertFail();
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1600
     * @tc.name   : testEccKeyUntil1600
     * @tc.desc   : test getEncodedPoint with unCompressed format and error curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1600";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = "RSA512";
      let format: string = "UNCOMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        cryptoFramework.ECCKeyUtil.getEncodedPoint(errAlgName, point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1700
     * @tc.name   : testEccKeyUntil1700
     * @tc.desc   : test getEncodedPoint with unCompressed format and different curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1700";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = "NID_brainpoolP256t1";
      let format: string = "UNCOMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        cryptoFramework.ECCKeyUtil.getEncodedPoint(errAlgName, point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1800
     * @tc.name   : testEccKeyUntil1800
     * @tc.desc   : test getEncodedPoint with unCompressed format and empty curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil1800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil1800";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let errAlgName: string = "";
      let format: string = "UNCOMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        cryptoFramework.ECCKeyUtil.getEncodedPoint(errAlgName, point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_1900
     * @tc.name   : testEccKeyUntil1900
     * @tc.desc   : test getEncodedPoint with unCompressed format and error curveName, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("SUB_Security_CryptoFramework_AsyKeyGenerator_ECC_Func_4700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let testNumber: string = "SUB_Security_CryptoFramework_AsyKeyGenerator_ECC_Func_4700";
        console.log(testNumber + ": started");
        let algName: AsyAlgName = AsyAlgName.P256r1;
        let errAlgName: string = "errTest";
        let format: string = "UNCOMPRESSED";
        try {
          let point: cryptoFramework.Point = specUtil.pkPoint(algName);
          cryptoFramework.ECCKeyUtil.getEncodedPoint(errAlgName, point, format);
          expect(null).assertFail();
        } catch (err) {
          expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
          console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
        }
        console.log(testNumber + ": success");
      });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_2000
     * @tc.name   : testEccKeyUntil2000
     * @tc.desc   : test getEncodedPoint with empty format, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil2000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil2000";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let format: string = "";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        let pointData: Uint8Array =
          cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algName), point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_2100
     * @tc.name   : testEccKeyUntil2100
     * @tc.desc   : test getEncodedPoint with error format, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil2100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil2100";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let format: string = "errTest";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        let pointData: Uint8Array =
          cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algName), point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_2200
     * @tc.name   : testEccKeyUntil2200
     * @tc.desc   : test getEncodedPoint with unCompressed format and error x value, process fail
     * @tc.size   : Medium
     * @tc.type   : Func
     * @tc.level  : Level3
     */
    it("testEccKeyUntil2200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testEccKeyUntil2200";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let format: string = "UNCOMPRESSED";
      try {
        let point: cryptoFramework.Point = specUtil.pkPoint(algName);
        point.x++;
        cryptoFramework.ECCKeyUtil.getEncodedPoint(specUtil.curveName(algName), point, format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });
  });
}