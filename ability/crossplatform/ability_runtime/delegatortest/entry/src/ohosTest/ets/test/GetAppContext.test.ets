/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
import {
  afterAll,
  afterEach,
  beforeAll,
  beforeEach,
  describe,
  expect,
  it,
} from "@ohos/hypium";
import AbilityDelegatorRegistry from "@ohos.app.ability.abilityDelegatorRegistry";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function GetAppContextTest() {
  describe("GetAppContextTest", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number: ACTS_GET_APP_CONTENT_0001
     * @tc.name  : actsGetAppContextCallback0001
     * @tc.desc  : Test the api "abilityDelegator.startAbility", return the result with callback function.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("ACTS_GET_APP_CONTENT_0001", 0, async (done: Function) => {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      if (context != null) {
        abilityDelegator.printSync(
          "ACTS_GET_APP_CONTENT_0001 : " + JSON.stringify(context)
        );
        expect(context.applicationInfo.name).assertEqual(
          "com.example.delegatortest"
        );
        expect(context.applicationInfo.description).assertEqual("");
        expect(context.applicationInfo.label).assertEqual("$string:app_name");
        expect(context.applicationInfo.labelId!=null).assertTrue();
        expect(context.applicationInfo.icon).assertEqual("$media:app_icon");
        expect(context.applicationInfo.iconId!=null).assertTrue();
        expect(context.applicationInfo.codePath != null).assertTrue();
        abilityDelegator.printSync("ACTS_GET_APP_CONTENT_0001 pass ");
        done();
      } else {
        abilityDelegator.printSync(
          "ACTS_GET_APP_CONTENT_0001 not found context"
        );
        expect().assertFail();
        done();
      }
    });
  });
}
