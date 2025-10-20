/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import cryptoFramework from '@ohos.security.cryptoFramework';
import * as rsa from '../pkcs/pkcs1topkcs8';
import * as dsa from '../pkcs/pkcs8Utils';

async function generateSignKey(algName: string): Promise<cryptoFramework.KeyPair> {
  try {
    let key = cryptoFramework.createAsyKeyGenerator(algName);
    let keyPair: cryptoFramework.KeyPair = {} as cryptoFramework.KeyPair;
    switch (algName) {
      case "RSA1024":
        keyPair = await key.convertPemKey(rsa.pubKeyPkcs1Str1024, rsa.priKeyPkcs1Str1024);
        break;
      case "RSA2048":
        keyPair = await key.convertPemKey(rsa.pubKeyPkcs1Str2048, rsa.priKeyPkcs1Str2048);
        break;
      case "RSA3072":
        keyPair = await key.convertPemKey(rsa.pubKeyPkcs1Str3072, rsa.priKeyPkcs1Str3072);
        break;
      case "RSA4096":
        keyPair = await key.convertPemKey(rsa.pubKeyPkcs1Str4096, rsa.priKeyPkcs1Str4096);
        break;
      case "RSA8192":
        keyPair = await key.convertPemKey(rsa.pubKeyPkcs1Str8192, rsa.priKeyPkcs1Str8192);
        break;
      case "DSA1024":
        if (dsa.keys.key_1024) {
          let pubKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_1024.pub)};
          let priKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_1024.pri)};
          keyPair = await key.convertKey(pubKey, priKey)
        } else {
          keyPair = await key.generateKeyPair();
        }
        break;
      case "DSA2048":
        if (dsa.keys.key_2048) {
          let pubKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_2048.pub)};
          let priKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_2048.pri)};
          keyPair = await key.convertKey(pubKey, priKey)
        } else {
          keyPair = await key.generateKeyPair();
        }
        break;
      case "DSA3072":
        if (dsa.keys.key_3072) {
          let pubKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_3072.pub)};
          let priKey: cryptoFramework.DataBlob = {data: new Uint8Array(dsa.keys.key_3072.pri)};
          keyPair = await key.convertKey(pubKey, priKey)
        } else {
          keyPair = await key.generateKeyPair();
        }
        break;
      default:
        keyPair = await key.generateKeyPair();
        break;
    }
    return keyPair;
  } catch (error) {
    console.error(`doVerifyWithUpdateSync “${error}“, error code: ${error.code}`);
    throw error as Error;
  }
}
export {
  generateSignKey
}