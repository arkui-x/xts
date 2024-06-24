@Entry
@Component
struct MultiFingerOperationPage {
  @State scaleValue: number = 1
  @State pinchValue: number = 1

  build() {
    Column() {
      Image($r('sys.media.ohos_ic_public_cast_stream'))
        .width(128)
        .height(256)
        .backgroundColor(0x66FFCC)
        .id('scaleImage')
        .scale({ x: this.scaleValue, y: this.scaleValue })

    }
    .width('100%')
    .height('100%')
    .id('multiFingerOperationColumn')
    .justifyContent(FlexAlign.Center)
    .gesture(
      PinchGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.scaleValue = this.pinchValue * event.scale
        })
        .onActionEnd(() => {
          this.pinchValue = this.scaleValue
        })
    )

  }
}