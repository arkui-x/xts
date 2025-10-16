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

          Button('ERR_INVALID_URL')
            .id('ERR_INVALID_URL')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_URL)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_DISALLOWED_URL_SCHEME')
            .id('ERR_DISALLOWED_URL_SCHEME')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DISALLOWED_URL_SCHEME)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_UNKNOWN_URL_SCHEME')
            .id('ERR_UNKNOWN_URL_SCHEME')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNKNOWN_URL_SCHEME)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_INVALID_REDIRECT')
            .id('ERR_INVALID_REDIRECT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_REDIRECT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_TOO_MANY_REDIRECTS')
            .id('ERR_TOO_MANY_REDIRECTS')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TOO_MANY_REDIRECTS)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_UNSAFE_REDIRECT')
            .id('ERR_UNSAFE_REDIRECT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNSAFE_REDIRECT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_UNSAFE_PORT')
            .id('ERR_UNSAFE_PORT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNSAFE_PORT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })
          Button('ERR_INVALID_RESPONSE')
            .id('ERR_INVALID_RESPONSE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_RESPONSE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_INVALID_CHUNKED_ENCODING')
            .id('ERR_INVALID_CHUNKED_ENCODING')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_CHUNKED_ENCODING)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_METHOD_UNSUPPORTED')
            .id('ERR_METHOD_UNSUPPORTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_METHOD_UNSUPPORTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })
          Button('ERR_UNEXPECTED_PROXY_AUTH')
            .id('ERR_UNEXPECTED_PROXY_AUTH')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNEXPECTED_PROXY_AUTH)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_EMPTY_RESPONSE')
            .id('ERR_EMPTY_RESPONSE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_EMPTY_RESPONSE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_RESPONSE_HEADERS_TOO_BIG')
            .id('ERR_RESPONSE_HEADERS_TOO_BIG')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_RESPONSE_HEADERS_TOO_BIG)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_PAC_SCRIPT_FAILED')
            .id('ERR_PAC_SCRIPT_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PAC_SCRIPT_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_REQUEST_RANGE_NOT_SATISFIABLE')
            .id('ERR_REQUEST_RANGE_NOT_SATISFIABLE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_REQUEST_RANGE_NOT_SATISFIABLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_MALFORMED_IDENTITY')
            .id('ERR_MALFORMED_IDENTITY')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_MALFORMED_IDENTITY)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CONTENT_DECODING_FAILED')
            .id('ERR_CONTENT_DECODING_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CONTENT_DECODING_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_NETWORK_IO_SUSPENDED')
            .id('ERR_NETWORK_IO_SUSPENDED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NETWORK_IO_SUSPENDED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SYN_REPLY_NOT_RECEIVED')
            .id('ERR_SYN_REPLY_NOT_RECEIVED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SYN_REPLY_NOT_RECEIVED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_ENCODING_CONVERSION_FAILED')
            .id('ERR_ENCODING_CONVERSION_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ENCODING_CONVERSION_FAILED)
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