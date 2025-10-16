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
import cryptoFramework from '@ohos.security.cryptoFramework';
// import huks from '@ohos.security.huks';
// import { BusinessError } from '@ohos.base';

export default class SecurityUtils {
  static async genSymKeyByData(symKeyData: Uint8Array, algName: string) {
    let symKeyBlob: cryptoFramework.DataBlob = {
      data: symKeyData
    };
    let aesGenerator = cryptoFramework.createSymKeyGenerator(algName);
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    console.info('convertKey success');
    return symKey;
  }

  static genGcmParamsSpec() {
    let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let dataIv = new Uint8Array(arr)
    let ivBlob: cryptoFramework.DataBlob = {
      data: dataIv
    }
    arr = [0, 0, 0, 0, 0, 0, 0, 0]
    let dataAad = new Uint8Array(arr)
    let aadBlob: cryptoFramework.DataBlob = {
      data: dataAad
    }
    arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let dataTag = new Uint8Array(arr)
    let tagBlob: cryptoFramework.DataBlob = {
      data: dataTag
    };
    let gcmParamsSpec: cryptoFramework.GcmParamsSpec = {
      iv: ivBlob,
      aad: aadBlob,
      authTag: tagBlob,
      algName: "GcmParamsSpec"
    };
    return gcmParamsSpec;
  }

  static genIvParamsSpec() {
    let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let dataIv = new Uint8Array(arr)
    let ivBlob: cryptoFramework.DataBlob = {
      data: dataIv
    }
    let ivParamsSpec: cryptoFramework.IvParamsSpec = {
      algName: "IvParamsSpec",
      iv: ivBlob
    };
    return ivParamsSpec;
  }

  static genCcmParamsSpec() {
    let arr = [0, 0, 0, 0, 0, 0, 0]
    let dataIv = new Uint8Array(arr)
    let ivBlob: cryptoFramework.DataBlob = {
      data: dataIv
    }
    arr = [0, 0, 0, 0, 0, 0, 0, 0]
    let dataAad = new Uint8Array(arr)
    let aadBlob: cryptoFramework.DataBlob = {
      data: dataAad
    }
    arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let dataTag = new Uint8Array(arr)
    let tagBlob: cryptoFramework.DataBlob = {
      data: dataTag
    };
    let ccmParamsSpec: cryptoFramework.CcmParamsSpec = {
      iv: ivBlob,
      aad: aadBlob,
      authTag: tagBlob,
      algName: "CcmParamsSpec"
    };
    return ccmParamsSpec;
  }

  static async encryptMessagePromise(algName: string, symKey: cryptoFramework.SymKey,
    plainText: cryptoFramework.DataBlob,
    ivParams?: cryptoFramework.IvParamsSpec) {
    let cipher = cryptoFramework.createCipher(algName)
    if (ivParams) {
      await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, ivParams)
    }
    else {
      await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, null)
    }
    let cipherData = await cipher.doFinal(plainText)
    return cipherData;
  }

  static async decryptMessagePromise(algName: string, symKey: cryptoFramework.SymKey,
    encryptUpdate: cryptoFramework.DataBlob,
    ivParams?: cryptoFramework.IvParamsSpec) {
    let decoder = cryptoFramework.createCipher(algName)
    if (ivParams) {
      await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, ivParams);
    }
    else {
      await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, null);
    }
    let decryptData = await decoder.doFinal(encryptUpdate);
    return decryptData;
  }

  static async encryptMessageByAESGCMPromise(algName: string, symKey: cryptoFramework.SymKey,
    plainText: cryptoFramework.DataBlob,
    gcmParams: cryptoFramework.GcmParamsSpec) {
    let cipher = cryptoFramework.createCipher(algName)
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, gcmParams)
    let encryptUpdate = await cipher.update(plainText)
    gcmParams.authTag = await cipher.doFinal(null)
    return encryptUpdate
  }

  static async decryptMessageByAESGCMPromise(algName: string, symKey: cryptoFramework.SymKey,
    encryptUpdate: cryptoFramework.DataBlob,
    gcmParams: cryptoFramework.GcmParamsSpec) {
    let decoder = cryptoFramework.createCipher(algName)
    await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, gcmParams)
    let decryptUpdate = await decoder.update(encryptUpdate)
    let decryptData = await decoder.doFinal(null)
    return decryptUpdate;
  }

  static async encryptMessageByAESCCMPromise(algName: string, symKey: cryptoFramework.SymKey,
    plainText: cryptoFramework.DataBlob,
    ccmParams: cryptoFramework.CcmParamsSpec) {
    let cipher = cryptoFramework.createCipher(algName)
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, ccmParams)
    let encryptUpdate = await cipher.update(plainText)
    ccmParams.authTag = await cipher.doFinal(null)
    return encryptUpdate
  }

  static async decryptMessageByAESCCMPromise(algName: string, symKey: cryptoFramework.SymKey,
    encryptUpdate: cryptoFramework.DataBlob,
    ccmParams: cryptoFramework.CcmParamsSpec) {
    let decoder = cryptoFramework.createCipher(algName)
    await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, ccmParams)
    let decryptUpdate = await decoder.update(encryptUpdate)
    let decryptData = await decoder.doFinal(null)
    return decryptUpdate;
  }

  static async signMessagePromise(signAlg: string, input: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey) {
    let signer = cryptoFramework.createSign(signAlg);
    await signer.init(priKey);
    let signData = await signer.sign(input);
    return signData;
  }

  static async verifyMessagePromise(verifyAlg: string, input: cryptoFramework.DataBlob,
    signMessageBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey) {
    let verifier = cryptoFramework.createVerify(verifyAlg);
    await verifier.init(pubKey);
    let res = await verifier.verify(input, signMessageBlob);
    return res;
  }

  static StringToUint8Array(str: String) {
    let arr: number[] = new Array();
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    return new Uint8Array(arr);
  }
}