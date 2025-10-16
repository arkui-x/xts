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

          Button('ERR_QUIC_PROTOCOL_ERROR')
            .id('ERR_QUIC_PROTOCOL_ERROR')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_QUIC_PROTOCOL_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_RESPONSE_HEADERS_TRUNCATED')
            .id('ERR_RESPONSE_HEADERS_TRUNCATED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_RESPONSE_HEADERS_TRUNCATED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_QUIC_HANDSHAKE_FAILED')
            .id('ERR_QUIC_HANDSHAKE_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_QUIC_HANDSHAKE_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY')
            .id('ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_FLOW_CONTROL_ERROR')
            .id('ERR_HTTP2_FLOW_CONTROL_ERROR')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_FLOW_CONTROL_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_FRAME_SIZE_ERROR')
            .id('ERR_HTTP2_FRAME_SIZE_ERROR')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_FRAME_SIZE_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_COMPRESSION_ERROR')
            .id('ERR_HTTP2_COMPRESSION_ERROR')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_COMPRESSION_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION')
            .id('ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP_1_1_REQUIRED')
            .id('ERR_HTTP_1_1_REQUIRED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP_1_1_REQUIRED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_HTTP_1_1_REQUIRED')
            .id('ERR_PROXY_HTTP_1_1_REQUIRED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_HTTP_1_1_REQUIRED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PAC_SCRIPT_TERMINATED')
            .id('ERR_PAC_SCRIPT_TERMINATED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PAC_SCRIPT_TERMINATED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_INVALID_HTTP_RESPONSE')
            .id('ERR_INVALID_HTTP_RESPONSE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_HTTP_RESPONSE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CONTENT_DECODING_INIT_FAILED')
            .id('ERR_CONTENT_DECODING_INIT_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CONTENT_DECODING_INIT_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED')
            .id('ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE')
            .id('ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER')
            .id('ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_TOO_MANY_RETRIES')
            .id('ERR_TOO_MANY_RETRIES')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TOO_MANY_RETRIES)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_STREAM_CLOSED')
            .id('ERR_HTTP2_STREAM_CLOSED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_STREAM_CLOSED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_CLIENT_REFUSED_STREAM')
            .id('ERR_HTTP2_CLIENT_REFUSED_STREAM')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_CLIENT_REFUSED_STREAM)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH')
            .id('ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH)
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