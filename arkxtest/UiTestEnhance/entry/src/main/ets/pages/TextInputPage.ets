@Entry
@Component
struct TextInputPage {
  @State textA: string = ''
  @State textB: string = ''
  @State textC: string = ''

  build() {
    Column() {
      TextInput({text: this.textA})
        .margin({top: 30})
        .id('inputA')
        .onChange((value: string) => {
          this.textA = value
        })

      TextInput({text: this.textB})
        .margin({top: 30})
        .id('inputB')
        .onChange((value: string) => {
          this.textB = value
        })

      Text('1')
        .width(1)
        .height(1)
        .margin({top: 30})
        .backgroundColor(Color.Black)
        .id('smallText')

      TextInput({text: this.textC})
        .width('100%')
        .margin({top: 30, left: 300})
        .id('inputC')
        .onChange((value: string) => {
          this.textC = value
        })

    }
    .width('100%')
    .height('100%')
  }
}