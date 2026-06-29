/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('WebWindowXts').fontSize(24).fontWeight(FontWeight.Bold).margin(10)

      // ===== onWindowNew 接口测试 =====
      Text('── onWindowNew 接口（13个场景） ──').fontSize(14).fontColor('#1890ff').margin({ top: 8 })
      Button('OnWindowNewTest').id('onWindowNewTest').width('100%').margin(2)
        .onClick(()=>{ router.pushUrl({ url: 'pages/OnWindowNewTest' }) })

      // ===== onWindowExit 接口测试 =====
      Text('── onWindowExit 接口（1个场景） ──').fontSize(14).fontColor('#52c41a').margin({ top: 8 })
      Button('OnWindowExitTest').id('onWindowExitTest').width('100%').margin(2)
        .onClick(()=>{ router.pushUrl({ url: 'pages/OnWindowExitTest' }) })

      // ===== allowWindowOpenMethod 接口测试 =====
      Text('── allowWindowOpenMethod 接口（4个场景） ──').fontSize(14).fontColor('#faad14').margin({ top: 8 })
      Button('AllowOpenMethodTest').id('allowOpenMethodTest').width('100%').margin(2)
        .onClick(()=>{ router.pushUrl({ url: 'pages/AllowOpenMethodTest' }) })

      // ===== multiWindowAccess 接口测试 =====
      Text('── multiWindowAccess 接口（2个场景） ──').fontSize(14).fontColor('#722ed1').margin({ top: 8 })
      Button('MultiAccessTest').id('multiAccessTest').width('100%').margin(2)
        .onClick(()=>{ router.pushUrl({ url: 'pages/MultiAccessTest' }) })

      // ===== onRenderExited 接口测试 =====
      Text('── onRenderExited 接口（3个场景） ──').fontSize(14).fontColor('#eb2f96').margin({ top: 8 })
      Button('OnRenderExitedTest').id('onRenderExitedTest').width('100%').margin(2)
        .onClick(()=>{ router.pushUrl({ url: 'pages/OnRenderExitedTest' }) })

      Button('返回').id('返回').width('100%').margin({ top: 12 })
        .onClick(()=>{ router.back() })
    }
    .width('100%')
    .height('100%')
  }
}
