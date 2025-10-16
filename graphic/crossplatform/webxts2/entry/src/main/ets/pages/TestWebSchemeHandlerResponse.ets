import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { WebNetErrorList } from '@ohos.web.netErrorList';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  schemeHandler: webview.WebSchemeHandler = new webview.WebSchemeHandler();
  @State Url: string = ''
  @State Status: string = ''
  @State StatusText: string = ''
  @State MimeType: string = ''
  @State Encoding: string = ''
  @State HeaderByName: string = ''
  @State NetErrorCode: string = ''
  @State ErrorCode: string = ''

  build() {
    Column() {
      Text(this.Url)
        .id("Url")
        .fontSize(10)

      Text(this.Status)
        .id("Status")
        .fontSize(10)

      Text(this.StatusText)
        .id("StatusText")
        .fontSize(10)

      Text(this.MimeType)
        .id("MimeType")
        .fontSize(10)

      Text(this.Encoding)
        .id("Encoding")
        .fontSize(10)

      Text(this.HeaderByName)
        .id("HeaderByName")
        .fontSize(10)

      Text(this.ErrorCode)
        .id("ErrorCode")
        .fontSize(10)

      Text(this.NetErrorCode)
        .id("NetErrorCode")
        .fontSize(10)

      Button('TestSchemeHandlerResponse')
        .height(24)
        .fontSize(12)
        .margin({ top: 5 }).onClick(() => {
        let response = new webview.WebSchemeHandlerResponse();
        try {
          response.setUrl("http://www.example.com")
          response.setStatus(200)
          response.setStatusText("OK")
          response.setMimeType("text/html")
          response.setEncoding("utf-8")
          response.setHeaderByName("header1", "value1", false)
          response.setNetErrorCode(WebNetErrorList.NET_OK)


          this.Url = response.getUrl()
          this.Status = JSON.stringify(response.getStatus())
          this.StatusText = response.getStatusText()
          this.MimeType = response.getMimeType()
          this.Encoding = response.getEncoding()
          this.HeaderByName = response.getHeaderByName("header1")
          this.NetErrorCode = JSON.stringify(response.getNetErrorCode())
        } catch (error) {
          this.ErrorCode = '';
          console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
        }
      })

      Button('response设置为空字符串')
        .height(24)
        .fontSize(12)
        .margin({ top: 5 }).onClick(() => {
        let response = new webview.WebSchemeHandlerResponse();
        try {
          response.setUrl("")
          response.setStatus(200)
          response.setStatusText("")
          response.setMimeType("")
          response.setEncoding("")
          response.setHeaderByName("", "", null)
          response.setNetErrorCode(null)
        } catch (error) {
          this.ErrorCode = JSON.stringify(error.code);
          console.error(` ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
        }
      })

      Button('response设置为null')
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .onClick(() => {
          let response = new webview.WebSchemeHandlerResponse();
          try {
            response.setUrl(null)
            response.setStatus(200)
            response.setStatusText(null)
            response.setMimeType(null)
            response.setEncoding(null)
            response.setHeaderByName(null, null, false)
            response.setNetErrorCode(null)
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(` ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Button('response设置为undefined')
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .onClick(() => {
          let response = new webview.WebSchemeHandlerResponse();
          try {
            response.setUrl(undefined)
            response.setStatus(undefined)
            response.setStatusText(undefined)
            response.setMimeType(undefined)
            response.setEncoding(undefined)
            response.setHeaderByName(undefined, undefined, undefined)
            response.setNetErrorCode(undefined)
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Web({ src: 'https://www.example.com', controller: this.controller })
    }
  }
}