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

import bridge from '@arkui-x.bridge'
import deviceInfo from '@ohos.deviceInfo'

export enum PlatformTypeEnum {
  HARMONYOS = 'HarmonyOS Platform',
  ANDROID = 'Android Platform',
  IOS = 'iOS Platform',
}

export class PlatformInfo {
  static getPlatform(): PlatformTypeEnum {
    let osFullNameInfo: string = deviceInfo.osFullName;
    let platformName: string = osFullNameInfo.split(' ')[0];
    if (platformName.includes("Android")) {
      return PlatformTypeEnum.ANDROID;
    } else if (platformName.includes('iOS')) {
      return PlatformTypeEnum.IOS;
    } else {
      return PlatformTypeEnum.HARMONYOS;
    }
  }
}

@Entry
@Component
struct Index {
  private birdgeImpl: bridge.BridgeObject | undefined = undefined

  aboutToAppear(): void {
    if (PlatformInfo.getPlatform() == PlatformTypeEnum.ANDROID) {
      this.birdgeImpl = bridge.createBridge('BasicBridge')
    }
  }

  build() {
    Row() {
      Scroll() {
        Column() {
          Row().size({ width: '100%', height: 50 })

          Button('设置屏幕方向为竖向')
            .fontSize(20)
            .size({ width: '100%', height: 45 })
            .margin({ top: 20 })
            .id('BT1')
            .onClick(() => {
              if (PlatformInfo.getPlatform() == PlatformTypeEnum.ANDROID) {
                if (this.birdgeImpl != undefined) {
                  this.birdgeImpl.callMethod('setSystemOrientation', false)
                }
              }
            })

          Button('设置屏幕方向为横向')
            .fontSize(20)
            .size({ width: '100%', height: 45 })
            .margin({ top: 20 })
            .id('BT2')
            .onClick(() => {
              if (PlatformInfo.getPlatform() == PlatformTypeEnum.ANDROID) {
                if (this.birdgeImpl != undefined) {
                  this.birdgeImpl.callMethod('setSystemOrientation', true)
                }
              }
            })

          Row().size({ width: '100%', height: 50 })
        }.width('100%')
      }.scrollBar(BarState.Off)
    }.height('100%')
  }
}