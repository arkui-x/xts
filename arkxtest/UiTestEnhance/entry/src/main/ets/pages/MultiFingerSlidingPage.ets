@Entry
@Component
struct MultiFingerSlidingPage {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Column() {
      Scroll() {
        Column() {
          ForEach(this.arr, (item: number) => {
            Text(item.toString())
              .width('90%')
              .height(150)
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
          })

        }
        .width('100%')
        .id('multiFingerSlidingColumn')
      }
      .id('multiFingerSlidingScroll')
    }
    .width('100%')
    .height('100%')
  }
}