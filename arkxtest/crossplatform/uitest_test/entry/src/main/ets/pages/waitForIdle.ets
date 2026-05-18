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

const SCROLL_OFFSET: number = 50;
const SCROLL_ANIMATION_MS: number = 100;
const SCROLL_INTERVAL_MS: number = 200;
const CONT_SCROLL_MAX: number = 30;
const SHORT_SCROLL_MAX: number = 4;

const WINDOW_UPDATE_INTERVAL_MS: number = 250;
const CONT_WINDOW_MAX: number = 15;
const SHORT_WINDOW_MAX: number = 3;

const ANIMATION_DURATION_MS: number = 100;
const ANIMATION_INTERVAL_MS: number = 150;
const CONT_ANIMATION_MAX: number = 30;

@CustomDialog
struct UpdateDialog {
  controller?: CustomDialogController
  @Link message: string

  build() {
    Column() {
      Text(this.message)
        .id('waitForIdleDialogText')
        .fontSize(20)
        .margin(20)
    }
    .id('waitForIdleDialogColumn')
  }
}

@Entry
@Component
struct WaitForIdle {
  scroller: Scroller = new Scroller()
  @State textMsg: string = 'start'
  @State pageContentCount: number = 0
  @State widthSize: number = 100;
  @State isComponentVisible: boolean = true;
  @State dialogMsg: string = 'Window Event'

  dialogController: CustomDialogController = new CustomDialogController({
    builder: UpdateDialog({ message: $dialogMsg }),
    autoCancel: true
  })

  intervalId: number = -1

  aboutToDisappear() {
    this.stopInterval()
  }

  stopInterval() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId)
      this.intervalId = -1
    }
    // Clear the focus of TextInput to hide the soft keyboard and avoid covering/squeezing other test buttons
    focusControl.requestFocus('waitForIdleContinuousScrollButton')
  }

  build() {
    Scroll() {
      Column({ space: 8 }) {
        Button('Continual Scroll (TYPE_VIEW_SCROLLED_EVENT)')
          .id('waitForIdleContinuousScrollButton')
          .onClick(() => {
            this.stopInterval()
            let count = 0
            let offset = 0
            this.intervalId = setInterval(() => {
              offset += SCROLL_OFFSET
              // Continuous tiny scrolls without long animation so it emits events frequently
              this.scroller.scrollTo({ xOffset: 0, yOffset: offset, animation: { duration: SCROLL_ANIMATION_MS } })
              count++
              if (count > CONT_SCROLL_MAX) this.stopInterval()
            }, SCROLL_INTERVAL_MS)
          })

        Button('Short Scroll (Restore Idle)')
          .id('waitForIdleShortScrollButton')
          .onClick(() => {
            this.stopInterval()
            let count = 0
            let offset = 0
            this.intervalId = setInterval(() => {
              offset += SCROLL_OFFSET
              this.scroller.scrollTo({ xOffset: 0, yOffset: offset, animation: { duration: SCROLL_ANIMATION_MS } })
              count++
              if (count > SHORT_SCROLL_MAX) this.stopInterval()
            }, SCROLL_INTERVAL_MS)
          })

        Button('Continual Window Update (TYPE_WINDOW_UPDATE)')
          .id('waitForIdleContinuousWindowButton')
          .onClick(() => {
            this.stopInterval()
            let count = 0
            this.intervalId = setInterval(() => {
              this.dialogMsg = 'Window Event ' + count
              this.dialogController.open()
              setTimeout(() => {
                this.dialogController.close()
              }, 50)
              count++
              if (count > CONT_WINDOW_MAX) this.stopInterval()
            }, WINDOW_UPDATE_INTERVAL_MS)
          })

        Button('Short Window Update (Restore Idle)')
          .id('waitForIdleShortWindowButton')
          .onClick(() => {
            this.stopInterval()
            let count = 0
            this.intervalId = setInterval(() => {
              this.dialogMsg = 'Short Window ' + count
              this.dialogController.open()
              setTimeout(() => {
                this.dialogController.close()
              }, 50)
              count++
              if (count > SHORT_WINDOW_MAX) this.stopInterval()
            }, WINDOW_UPDATE_INTERVAL_MS)
          })

        Button('Continual Animation Execute')
          .id('waitForIdleContinuousAnimationButton')
          .onClick(() => {
            this.stopInterval()
            let count = 0
            this.intervalId = setInterval(() => {
              animateTo({ duration: ANIMATION_DURATION_MS }, () => {
                this.widthSize = this.widthSize === 100 ? 150 : 100
              })
              count++
              if (count > CONT_ANIMATION_MAX) this.stopInterval()
            }, ANIMATION_INTERVAL_MS)
          })

        if (this.isComponentVisible) {
          Text('Component Visible')
            .id('waitForIdleVisibleStateText')
            .width('100%')
            .height(30)
            .backgroundColor(Color.Pink)
        }

        Text('Animated Text')
          .id('waitForIdleAnimatedText')
          .width(this.widthSize)
          .height(30)
          .backgroundColor(Color.Orange)

        Button('back')
          .id('waitForIdleBackButton')
          .onClick(() => {
            this.stopInterval()
            this.scroller.scrollTo({ xOffset: 0, yOffset: 0 })
            router.back()
          })

        Scroll(this.scroller) {
          Column() {
            ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], (item: number) => {
              Text("Row " + item)
                .id(`waitForIdleContentRowText_${item}`)
                .width("100%")
                .height(60)
                .backgroundColor(item % 2 === 0 ? "#E0E0E0" : "#FFFFFF")
            })
          }
          .id('waitForIdleContentColumn')
        }
        .id('waitForIdleContentScroll')
        .width("100%")
        .height("30%")
      }
      .id('waitForIdleMainColumn')
      .width("100%")
    }
    .id('waitForIdleRootScroll')
    .width("100%")
    .height("100%")
  }
}
