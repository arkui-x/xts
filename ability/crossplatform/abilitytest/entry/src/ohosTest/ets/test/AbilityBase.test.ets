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
import { beforeAll, describe, expect, it, Level,  TestType, Size } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import { common, StartOptions, Want } from '@kit.AbilityKit';

let context: common.UIAbilityContext

export default function openLinkTest() {
  describe('AbilityBaseUIAbilityContextTest', () => {
    beforeAll(() => {
      context = AppStorage.get<common.UIAbilityContext>("UIAbilityContext") as common.UIAbilityContext
    });

    /**
    * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0100
    * @tc.name   : testAbilityAbilityBaseUIAbilityContext0100
    * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
    * @tc.type   : Function
    * @tc.size   : MediumTest
    * @tc.level  : Level 0
    */
    it('testAbilityAbilityBaseUIAbilityContext0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0100`;
      console.log(`${tag}, it begin`);
      let want: Want | null = null;
      try {
        context.startAbility(want, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0200
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0200
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0200', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0200`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = undefined;
      let options: StartOptions = {
        displayId: 0
      }
      try {
        context.startAbility(want, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0300
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0300
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0300', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0300`;
      console.log(`${tag}, it begin`);
      let want: Want | null = null
      let options: StartOptions | null = {
        displayId: 0
      };
      try {
        context.startAbility(want, options, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0400
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0400
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0400', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0400`;
      console.log(`${tag}, it begin`);
      let want: Want | undefined = undefined;
      let options: StartOptions = {
        displayId: 0
      }
      try {
        context.startAbility(want, options, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0500
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0500
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0500', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0500`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = null;
      let options: StartOptions = {};
      try {
        context.startAbility(want, options, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0600
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0600
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0600', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0600`;
      console.log(`${tag}, it begin`);
      let want: Want | undefined = undefined
      let options: StartOptions | undefined = {}
      try {
        context.startAbility(want, options, (err: BusinessError) => {
          if (err?.code) {
            console.error(`${tag}, startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          }
        });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0700
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0700
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0700', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0700`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = null;
      let options: StartOptions | null | undefined = {
        displayId: 0
      }
      try {
        context.startAbility(want, options)
          .then(() => {
            console.info('startAbility succeed');
            expect().assertFail();
          })
          .catch((err: BusinessError) => {
            console.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0800
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0800
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0800', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0800`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = undefined;
      let options: StartOptions | null | undefined = {
        displayId: 0
      }
      try {
        context.startAbility(want, options)
          .then(() => {
            console.info('startAbility succeed');
            expect().assertFail();
          })
          .catch((err: BusinessError) => {
            console.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_0900
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext0900
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext0900', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_0900`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = null;
      let options: StartOptions | null | undefined = {}
      try {
        context.startAbility(want, options)
          .then(() => {
            console.info('startAbility succeed');
            expect().assertFail();
          })
          .catch((err: BusinessError) => {
            console.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_ABILITY_AbilityBase_UIAbilityContext_1000
     * @tc.name   : testAbilityAbilityBaseUIAbilityContext1000
     * @tc.desc   : Call the interface startAbility through context, return errorcode 16000019
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityBaseUIAbilityContext1000', Level.LEVEL0, () => {
      let tag = `SUB_Ability_AbilityBase_UIAbilityContext_1000`;
      console.log(`${tag}, it begin`);
      let want: Want | null | undefined = undefined;
      let options: StartOptions | null | undefined = {}
      try {
        context.startAbility(want, options)
          .then(() => {
            console.info('startAbility succeed');
            expect().assertFail();
          })
          .catch((err: BusinessError) => {
            console.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
            expect(err.code).assertEqual(16000019);
          });
      } catch (err) {
        let code = (err as BusinessError).code;
        let message = (err as BusinessError).message;
        console.error(`${tag} startAbility failed, code is ${code}, message is ${message}`);
        expect().assertFail();
      }
    });
  })
}