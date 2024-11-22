@Entry
@Component
struct RichTextExample {
  @State data: string = '<h1 style="text-align: center;">h1标题</h1>' +
    '<h1 style="text-align: center;"><i>h1斜体</i></h1>' +
    '<h1 style="text-align: center;"><u>h1下划线</u></h1>' +
    '<h2 style="text-align: center;">h2标题</h2>' +
    '<h3 style="text-align: center;">h3标题</h3>' +
    '<p style="text-align: center;">p常规</p><hr/>' +
    '<div style="width: 500px;height: 500px;border: 1px solid;margin: 0auto;">' +
    '<p style="font-size: 35px;text-align: center;font-weight: bold; color: rgb(24,78,228)">字体大小35px,行高45px</p>' +
    '<p style="background-color: rgb(229, 229, 229);line-height: 45px;font-size: 35px;text-indent: 2em;">' +
    '<p>这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字</p>';
  @State dataOnStart: string = '<h1 style="text-align: center;">OnStart</h1>'
  @State dataOnComplete: string = '<h1 style="text-align: center;">OnComplete</h1>'

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center }) {
      RichText(this.data)
        .width(500)
        .height(400)
        .backgroundColor(0XBDDB69)
      RichText(this.dataOnStart)
        .onStart(() => {
          console.info('RichText onStart');
          this.dataOnStart = '<h1 style="text-align: center;">OnStart Be triggered</h1>'
        })
        .width(500)
        .height(100)
        .backgroundColor(0X92C48D)
      RichText(this.dataOnComplete)
        .onComplete(() => {
          console.info('RichText onComplete');
          this.dataOnComplete = '<h1 style="text-align: center;">OnComplete Be triggered</h1>'
        })
        .width(500)
        .height(100)
        .backgroundColor(0X92C48D)
    }
  }
}
