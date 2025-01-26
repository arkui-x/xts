import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''
  @State userAgent: string = ''
  @State contentDisposition: string = ''
  @State contentLength: number = 0
  @State mimetype: string = ''

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text('url: ' + this.url)
        .id("url")
      Text('userAgent: ' + this.userAgent)
        .id("userAgent")
      Text('contentDisposition: ' + this.contentDisposition)
        .id("contentDisposition")
      Text('contentLength: ' + this.contentLength)
        .id("contentLength")
      Text('mimetype: ' + this.mimetype)
        .id("mimetype")
      Web({ src: 'https://mirrors.tuna.tsinghua.edu.cn/gnu/aspell/aspell-0.50-vc%2B%2B.diff.gz', controller: this.controller })
        .onDownloadStart((event: OnDownloadStartEvent) => {
          if (event) {
            this.url = event.url
            console.log('url:' + event.url)
            this.userAgent = event.userAgent
            console.log('userAgent:' + event.userAgent)
            this.contentDisposition = event.contentDisposition
            console.log('contentDisposition:' + event.contentDisposition)
            this.contentLength = event.contentLength
            console.log('contentLength:' + event.contentLength)
            this.mimetype = event.mimetype
            console.log('mimetype:' + event.mimetype)
          }
        })
    }
  }
}