/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import common from '@ohos.app.ability.common';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

const permissions: Array<Permissions> = ['ohos.permission.READ_IMAGEVIDEO'];
function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): void {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
  atManager.requestPermissionsFromUser(context, permissions).then((data) => {
    let grantStatus: Array<number> = data.authResults;
    let length: number = grantStatus.length;
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // 用户授权，可以继续访问目标操作
      } else {
        // 用户拒绝授权
        return;
      }
    }
    // 授权成功
    console.info('MICROPHONE permission success');
  }).catch((err: BusinessError) => {
    console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
  })
}

@Entry
@Component
struct Index {
  aboutToAppear() {
    console.log('aboutToAppear');
    const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    reqPermissionsFromUser(permissions, context);
    if (platform != 'Android' && platform != 'iOS') {
      this.message = 'Hello World';
    }
  }
  @State message: string = '请赋予相册权限'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}