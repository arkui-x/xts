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
import { beforeAll, describe, expect, it, TestType, Level, Size } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import { Driver } from '@ohos.UiTest';
import cryptoFramework from '@ohos.security.cryptoFramework';
import buffer from '@ohos.buffer';
import SecurityUtils from '../config/securityUtils'
import AbilityUtils from '../config/abilityUtils';

export default function securityTest() {
  describe('SecurityTest', () => {
    let abilityContext: common.UIAbilityContext
    let applicationContext: common.ApplicationContext
    beforeAll(async (done: Function) => {
      abilityContext = AppStorage.get<common.UIAbilityContext>('TestAbilityContext') as common.UIAbilityContext
      applicationContext = abilityContext.getApplicationContext()
      expect(await AbilityUtils.startAbility('com.acts.pcs.arktstest', 'TestAbility', abilityContext)).assertTrue()
      let driver = Driver.create()
      await driver.delayMs(2000)
      done()
    })

    /*
     * @tc.number : SUB_SECURITY_SECURITY_TEST_Func_0100
     * @tc.name   : testSupportAESCCM128Alg0100
     * @tc.desc   : 【S|STD-SECURITY-0312】必须支持 AES 对称加密算法，分组模式支持 ECB、OFB、CFB、CTR、CCM、
     *            密钥长度支持 128、192、256 位。
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSupportAESCCM128Alg0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let keyData1 = new Uint8Array(buffer.from('12345678abcdefgh', 'utf8').buffer)
        let symKey1 = await SecurityUtils.genSymKeyByData(keyData1, 'AES128')
        let message1 = "This is a AES-CCM-128 test"
        let plainText1: cryptoFramework.DataBlob = {
          data: new Uint8Array(buffer.from(message1, 'utf-8').buffer)
        }
        let ccmParams = SecurityUtils.genCcmParamsSpec()
        let encryptText1 =
          await SecurityUtils.encryptMessageByAESCCMPromise('AES128|CCM|PKCS7', symKey1, plainText1, ccmParams)
        let decryptText1 =
          await SecurityUtils.decryptMessageByAESCCMPromise('AES128|CCM|PKCS7', symKey1, encryptText1, ccmParams)
        expect(decryptText1.data.toString()).assertEqual(plainText1.data.toString())
      } catch (error) {
        let err = error as BusinessError
        console.error(`Failed to use AES-CCM-128 for encryption and decryption. error: ${JSON.stringify(err)}`)
        expect(false).assertEqual(true)
      }
      done()
    })

    /*
     * @tc.number : SUB_SECURITY_SECURITY_TEST_Func_0200
     * @tc.name   : testSupportAESCCM192Alg0200
     * @tc.desc   : 【S|STD-SECURITY-0312】必须支持 AES 对称加密算法，分组模式支持 ECB、OFB、CFB、CTR、CCM、
     *            密钥长度支持 128、192、256 位。
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSupportAESCCM192Alg0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let keyData2 = new Uint8Array(buffer.from('12345678abcdefgh12345678', 'utf8').buffer)
        let symKey2 = await SecurityUtils.genSymKeyByData(keyData2, 'AES192')
        let message2 = "This is a AES-CCM-192 test"
        let plainText2: cryptoFramework.DataBlob = {
          data: new Uint8Array(buffer.from(message2, 'utf-8').buffer)
        }
        let ccmParams = SecurityUtils.genCcmParamsSpec()
        let encryptText2 =
          await SecurityUtils.encryptMessageByAESCCMPromise('AES192|CCM|PKCS7', symKey2, plainText2, ccmParams)
        let decryptText2 =
          await SecurityUtils.decryptMessageByAESCCMPromise('AES192|CCM|PKCS7', symKey2, encryptText2, ccmParams)
        expect(decryptText2.data.toString()).assertEqual(plainText2.data.toString())
      } catch (error) {
        let err = error as BusinessError
        console.error(`Failed to use AES-CCM-192 for encryption and decryption. error: ${JSON.stringify(err)}`)
        expect(false).assertEqual(true)
      }
      done()
    })

    /*
     * @tc.number : SUB_SECURITY_SECURITY_TEST_Func_0300
     * @tc.name   : testSupportAESCCM256Alg0300
     * @tc.desc   : 【S|STD-SECURITY-0312】必须支持 AES 对称加密算法，分组模式支持 ECB、OFB、CFB、CTR、CCM、
     *            密钥长度支持 128、192、256 位。
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSupportAESCCM256Alg0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let keyData3 = new Uint8Array(buffer.from('12345678abcdefgh12345678abcdefgh', 'utf8').buffer)
        let symKey3 = await SecurityUtils.genSymKeyByData(keyData3, 'AES256')
        let message3 = "This is a AES-CCM-256 test"
        let plainText3: cryptoFramework.DataBlob = {
          data: new Uint8Array(buffer.from(message3, 'utf-8').buffer)
        }
        let ccmParams = SecurityUtils.genCcmParamsSpec()
        let encryptText3 =
          await SecurityUtils.encryptMessageByAESCCMPromise('AES256|CCM|PKCS7', symKey3, plainText3, ccmParams)
        let decryptText3 =
          await SecurityUtils.decryptMessageByAESCCMPromise('AES256|CCM|PKCS7', symKey3, encryptText3, ccmParams)
        expect(decryptText3.data.toString()).assertEqual(plainText3.data.toString())
      } catch (error) {
        let err = error as BusinessError
        console.error(`Failed to use AES-CCM-256 for encryption and decryption. error: ${JSON.stringify(err)}`)
        expect(false).assertEqual(true)
      }
      done()
    })
  });
}