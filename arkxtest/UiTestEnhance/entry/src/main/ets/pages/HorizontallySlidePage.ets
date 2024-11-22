@Entry
@Component
struct HorizontallySlidePage {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Row() {
      Scroll() {
        Row() {
          ForEach(this.arr, (item: number) => {
            Text(item.toString())
              .width(150)
              .height('90%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ left: 10 })
          })

        }
        .height('100%')
        .id('horizontallySlideRow')
      }
      .id('horizontallySlideScroll')
      .scrollable(ScrollDirection.Horizontal)
    }
    .width('100%')
    .height('100%')
  }
}