@Entry
@Component
struct RotatePage {
  @State angle: number = 0
  @State rotateValue: number = 0

  build() {
    Column() {
      Text('' + this.angle)
        .fontSize(30)
        .margin({top: 30})
        .id('rotateText')

      Column() {

      }
      .width(300)
      .height(200)
      .backgroundColor(0x66FFCC)
      .margin({top: 180})
      .rotate({angle: this.angle})

    }
    .width('100%')
    .height('100%')
    .gesture(
      RotationGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.angle = this.rotateValue + event.angle
        })
        .onActionEnd(() => {
          this.rotateValue = this.angle
        })
    )

  }
}