import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State Message: string = ''
  @State SourceId: string = ''
  @State LineNumber: number = 0
  @State MessageLevel: number = 0

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text('getMessage: ' + this.Message)
        .id("getMessage")
      Text('getSourceId: ' + this.SourceId)
        .id("getSourceId")
      Text('getLineNumber: ' + this.LineNumber)
        .id("getLineNumber")
      Text('getMessageLevel: ' + this.MessageLevel)
        .id("getMessageLevel")
      Button('onconsole message')
        .width(200)
        .height(30)
        .onClick(() => {
          this.controller.runJavaScript('myFunction()');
        })
      Web({ src: $rawfile('OnConsoleEvent.html'), controller: this.controller })
        .onConsole((event: OnConsoleEvent) => {
          if (event) {
            this.Message = event.message.getMessage()
            console.log('getMessage:' + event.message.getMessage());
            this.SourceId = event.message.getSourceId()
            console.log('getSourceId:' + event.message.getSourceId());
            this.LineNumber = event.message.getLineNumber()
            console.log('getLineNumber:' + event.message.getLineNumber());
            this.MessageLevel = event.message.getMessageLevel()
            console.log('getMessageLevel:' + event.message.getMessageLevel());
          }
          return false;
        })
    }
  }
}