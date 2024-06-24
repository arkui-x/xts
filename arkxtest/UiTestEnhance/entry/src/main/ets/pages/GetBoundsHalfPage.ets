@Entry
@Component
struct GetBoundsHalfPage {

  build() {
    Column() {
      Image($r('sys.media.ohos_ic_public_clock'))
        .width('100%')
        .id('clockImage')
        .position({x: -120, y: 0})

    }
    .width('100%')
    .height('100%')
  }
}