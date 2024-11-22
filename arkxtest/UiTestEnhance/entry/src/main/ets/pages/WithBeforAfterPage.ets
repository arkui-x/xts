@Entry
@Component
struct WithBeforAfterPage {
  @State message: string = 'test_001'

  build() {
    Column() {

      Column() {
        Text("up_001")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Green)
          .backgroundColor(Color.Red)

        Text("up_002")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)

        Text("up_003")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .offset({x:200})
          .backgroundColor(Color.Red)

        Blank()

        Text("up_004")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Red)

      }
      .width('100%')
      .height('30%')
      .backgroundColor(Color.White)
      .id("up")

      Column() {
        Text("center_001")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Green)

        Blank()

        Column(){
          Blank()
          Text("center_center")
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(Color.Green)
          Blank()
        }.height('25%')
        .width('100%')
        .backgroundColor(Color.Red)

        Column(){

        }.height('25%')
        .width('100%')
        .backgroundColor(Color.Blue)
        .id("center_empty")

        Blank()

        Text("center_003")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Green)
      }
      .width('100%')
      .height('40%')
      .backgroundColor(Color.Yellow)
      .id("center")

      Column() {
        Text("down_001")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Red)

        Text("down_002")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .offset({x:-200})
          .backgroundColor(Color.Red)

        Blank()

        Text("down_003")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)

        Text("down_004")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Red)
      }
      .width('100%')
      .height('30%')
      .backgroundColor(Color.White)
      .id("down")


    }
    .height('100%')
    .id("father")
  }
}