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
import cert from "@ohos.security.cert";
import {
  testCrlPem, testCrlDer
} from "../common/commonParam";
import { convertToUint8Array, stringTouInt8Array, uInt8ArrayToString, } from "../common/commonFunc";
import { expect } from "@ohos/hypium";

function createX509CRLInstancePromise(certType: string): Promise<cert.X509CRL> {
  let certformat: cert.EncodingFormat;
  let encodingData: Uint8Array;

  if (certType == "der") {
    certformat = cert.EncodingFormat.FORMAT_DER;
    encodingData = convertToUint8Array(testCrlDer);
  } else {
    certformat = cert.EncodingFormat.FORMAT_PEM;
    encodingData = stringTouInt8Array(testCrlPem);
  }

  let encodingBlob: cert.EncodingBlob = {
    data: encodingData,
    encodingFormat: certformat,
  };

  return new Promise((resolve, reject) => {
    cert
      .createX509CRL(encodingBlob)
      .then((data) => {
        console.warn(
          "[promise] createX509CRL success! format is: " + certformat
        );
        resolve(data);
      })
      .catch((err: Error) => {
        reject(err);
      });
  });
}

async function getX509CRLInfoPromise(certType: string, processType: string) {
  let gInstance: cert.X509CRL;
  return new Promise<void>((resolve, reject) => {
    createX509CRLInstancePromise(certType)
      .then((instance) => {
        gInstance = instance;
        switch (processType) {
          case "getType":
            let type = gInstance.getType();
            console.log(processType + " is : " + type);
            expect(type != null).assertTrue();
            break;
          case "getVersion":
            let version = gInstance.getVersion();
            console.log(processType + " is : " + version);
            expect(version != null).assertTrue();
            break;
          case "getIssuerName":
            let issuerName = gInstance.getIssuerName();
            console.log(
              processType + " is : " + uInt8ArrayToString(issuerName.data)
            );
            expect(issuerName != null).assertTrue();
            break;
          case "getLastUpdate":
            let lastUpdate = gInstance.getLastUpdate();
            console.log(processType + " is : " + lastUpdate);
            expect(lastUpdate != null).assertTrue();
            break;
          case "getNextUpdate":
            let nextUpdate = gInstance.getNextUpdate();
            console.log(processType + " is : " + nextUpdate);
            expect(nextUpdate != null).assertTrue();
            break;
          case "getSignature":
            let signature = gInstance.getSignature();
            console.log(
              processType + " is : " + uInt8ArrayToString(signature.data)
            );
            expect(signature != null).assertTrue();
            break;
          case "getSignatureAlgName":
            let signatureAlgName = gInstance.getSignatureAlgName();
            console.log(processType + " is : " + signatureAlgName);
            expect(signatureAlgName != null).assertTrue();
            break;
          case "getSignatureAlgOid":
            let signatureAlgOid = gInstance.getSignatureAlgOid();
            console.log(processType + " is : " + signatureAlgOid);
            expect(signatureAlgOid != null).assertTrue();
            break;
          case "getSignatureAlgParams":
            let signatureAlgParams = gInstance.getSignatureAlgParams();
            console.log(
              processType +
                " is : " +
              uInt8ArrayToString(signatureAlgParams.data)
            );
            expect(signatureAlgParams != null).assertTrue();
            break;
          case "getTbsInfo":
            let tbsInfo = gInstance.getTBSInfo();
            console.log(
              processType + " is : " + uInt8ArrayToString(tbsInfo.data)
            );
            expect(tbsInfo != null).assertTrue();
            break;
          default:
            console.log("Invalid parameter !");
            reject(processType);
        }
        resolve();
      })
      .catch((err: Error) => {
        console.error("[promise] getX509CrtInfo failed! error is: " + err);
        reject(err);
      });
  });
}

export {
  getX509CRLInfoPromise
}