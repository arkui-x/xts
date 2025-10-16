// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { WebNetErrorList } from '@ohos.web.netErrorList';
import router from '@ohos.router';
import { Router } from '@ohos.arkui.UIContext'

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  schemeHandler: webview.WebSchemeHandler = new webview.WebSchemeHandler();
  SchemeHandlerResponse: webview.WebSchemeHandlerResponse = new webview.WebSchemeHandlerResponse();
  router: Router = this.getUIContext().getRouter()
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
      Scroll() {
        Column() {
          Text(this.NetErrorCode)
            .id("NetErrorCode")
            .fontSize(10)

          Button('return')
            .id('return')
            .width('50%')
            .height(30)
            .fontSize(15)
            .margin(5)
            .onClick(() => {
              this.router.back()
            })

          Button('ERR_IO_PENDING')
            .id('ERR_IO_PENDING')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_IO_PENDING)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_FAILED')
            .id('ERR_FAILED')

            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_ABORTED')
            .id('ERR_ABORTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ABORTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })


          Button('ERR_INVALID_ARGUMENT')
            .id('ERR_INVALID_ARGUMENT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_ARGUMENT)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_INVALID_HANDLE')
            .id('ERR_INVALID_HANDLE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_HANDLE)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_FILE_NOT_FOUND')
            .id('ERR_FILE_NOT_FOUND')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_NOT_FOUND)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_TIMED_OUT')
            .id('ERR_TIMED_OUT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TIMED_OUT)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_FILE_TOO_LARGE')
            .id('ERR_FILE_TOO_LARGE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_TOO_LARGE)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })
          Button('ERR_UNEXPECTED')
            .id('ERR_UNEXPECTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNEXPECTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_ACCESS_DENIED')
            .id('ERR_ACCESS_DENIED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ACCESS_DENIED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_NOT_IMPLEMENTED')
            .id('ERR_NOT_IMPLEMENTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NOT_IMPLEMENTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_INSUFFICIENT_RESOURCES')
            .id('ERR_INSUFFICIENT_RESOURCES')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INSUFFICIENT_RESOURCES)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_OUT_OF_MEMORY')
            .id('ERR_OUT_OF_MEMORY')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_OUT_OF_MEMORY)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_UPLOAD_FILE_CHANGED')
            .id('ERR_UPLOAD_FILE_CHANGED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UPLOAD_FILE_CHANGED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_SOCKET_NOT_CONNECTED')
            .id('ERR_SOCKET_NOT_CONNECTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKET_NOT_CONNECTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_FILE_EXISTS')
            .id('ERR_FILE_EXISTS')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_EXISTS)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_FILE_PATH_TOO_LONG')
            .id('ERR_FILE_PATH_TOO_LONG')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_PATH_TOO_LONG)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_FILE_NO_SPACE')
            .id('ERR_FILE_NO_SPACE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_NO_SPACE)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_FILE_VIRUS_INFECTED')
            .id('ERR_FILE_VIRUS_INFECTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_FILE_VIRUS_INFECTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })

          Button('ERR_BLOCKED_BY_CLIENT')
            .id('ERR_BLOCKED_BY_CLIENT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_BLOCKED_BY_CLIENT)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
              }
            })


          Web({ src: 'https://www.example.com', controller: this.controller })
        }
      }
    }
  }
}