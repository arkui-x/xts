import router from '@ohos.router';

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller()
  private PageList: string[] = ["main_index"]

  build() {
    Scroll(this.scroller) {
      Column() {
        Scroll(this.scroller) {
          Flex({ direction: FlexDirection.Column }) {
          ForEach(this.PageList, (item: string) => {
              Button() {
              Text('' + item)
                .width('100%')
                .height(50)
                .fontSize(20)
                .fontWeight(600)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .key(''+item)
                .backgroundColor(0xFFFFFF)
                .margin({top:5})
                .onClick(() => {
                  router.pushUrl({ url: `pages/${item}` })
                })
            }
          })
          }.width('90%')
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(0xDCDCDC)
      .padding({ top: 10 })
    }
  }
}