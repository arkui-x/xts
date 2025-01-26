import { webview } from '@kit.ArkWeb';
import { picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController()
  @State getTitle: string = ''
  @State getMode:  FileSelectorMode = 0
  @State getAcceptType_length: number = 0
  @State isCapture: Boolean = false
  @State getAcceptType: string = ''

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text('getTitle: ' + this.getTitle)
      Text('getMode: ' + this.getMode)
      Text('isCapture: ' + this.isCapture)
      Text('getAcceptType_length: ' + this.getAcceptType_length)
      Text('getAcceptType: ' + this.getAcceptType)
      Web({ src: $rawfile('OnShowFileSelectorEvent.html'), controller: this.controller })
        .id('Web')
        .onShowFileSelector((event:OnShowFileSelectorEvent) => {
          console.log('MyFileUploader onShowFileSelector invoked')
          const documentSelectOptions = new picker.DocumentSelectOptions();
          let uri: string | null = null;
          const documentViewPicker = new picker.DocumentViewPicker();
          documentViewPicker.select(documentSelectOptions).then((documentSelectResult) => {
            uri = documentSelectResult[0];
            console.info('documentViewPicker.select to file succeed and uri is:' + uri);
            if (event) {
              event.result.handleFileList([uri]);
            }
          }).catch((err: BusinessError) => {
            console.error(`Invoke documentViewPicker.select failed, code is ${err.code},  message is ${err.message}`);
          })
          this.getTitle = event.fileSelector.getTitle()
          console.log('getTitle: ' + event.fileSelector.getTitle())
          this.getMode = event.fileSelector.getMode()
          console.log('getMode: ' + event.fileSelector.getMode())
          this.getAcceptType_length = event.fileSelector.getAcceptType().length
          console.log('getAcceptType length: ' + event.fileSelector.getAcceptType().length)
          this.isCapture = event.fileSelector.isCapture()
          console.log('isCapture: ' + event.fileSelector.isCapture())
          for (let i of event.fileSelector.getAcceptType()) {
            this.getAcceptType += i;
              console.log('ljs: ' + i.toString())
          }
          return true;
        })
    }
  }
}