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
          Button('ERR_SSL_CLIENT_AUTH_CERT_NEEDED')
            .id("ERR_SSL_CLIENT_AUTH_CERT_NEEDED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_CERT_NEEDED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_TUNNEL_CONNECTION_FAILED')
            .id("ERR_TUNNEL_CONNECTION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TUNNEL_CONNECTION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_NO_SSL_VERSIONS_ENABLED')
            .id("ERR_NO_SSL_VERSIONS_ENABLED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NO_SSL_VERSIONS_ENABLED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_VERSION_OR_CIPHER_MISMATCH')
            .id("ERR_SSL_VERSION_OR_CIPHER_MISMATCH")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_VERSION_OR_CIPHER_MISMATCH)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_RENEGOTIATION_REQUESTED')
            .id("ERR_SSL_RENEGOTIATION_REQUESTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_RENEGOTIATION_REQUESTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_AUTH_UNSUPPORTED')
            .id("ERR_PROXY_AUTH_UNSUPPORTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_AUTH_UNSUPPORTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_BAD_SSL_CLIENT_AUTH_CERT')
            .id("ERR_BAD_SSL_CLIENT_AUTH_CERT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_BAD_SSL_CLIENT_AUTH_CERT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CONNECTION_TIMED_OUT')
            .id("ERR_CONNECTION_TIMED_OUT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CONNECTION_TIMED_OUT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HOST_RESOLVER_QUEUE_TOO_LARGE')
            .id("ERR_HOST_RESOLVER_QUEUE_TOO_LARGE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HOST_RESOLVER_QUEUE_TOO_LARGE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SOCKS_CONNECTION_FAILED')
            .id("ERR_SOCKS_CONNECTION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKS_CONNECTION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SOCKS_CONNECTION_HOST_UNREACHABLE')
            .id("ERR_SOCKS_CONNECTION_HOST_UNREACHABLE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKS_CONNECTION_HOST_UNREACHABLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_ALPN_NEGOTIATION_FAILED')
            .id("ERR_ALPN_NEGOTIATION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ALPN_NEGOTIATION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_NO_RENEGOTIATION')
            .id("ERR_SSL_NO_RENEGOTIATION")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_NO_RENEGOTIATION)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES')
            .id("ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_DECOMPRESSION_FAILURE_ALERT')
            .id("ERR_SSL_DECOMPRESSION_FAILURE_ALERT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_DECOMPRESSION_FAILURE_ALERT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_BAD_RECORD_MAC_ALERT')
            .id("ERR_SSL_BAD_RECORD_MAC_ALERT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_BAD_RECORD_MAC_ALERT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_AUTH_REQUESTED')
            .id("ERR_PROXY_AUTH_REQUESTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_AUTH_REQUESTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_CONNECTION_FAILED')
            .id("ERR_PROXY_CONNECTION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_CONNECTION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_MANDATORY_PROXY_CONFIGURATION_FAILED')
            .id("ERR_MANDATORY_PROXY_CONFIGURATION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_MANDATORY_PROXY_CONFIGURATION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PRECONNECT_MAX_SOCKET_LIMIT')
            .id("ERR_PRECONNECT_MAX_SOCKET_LIMIT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PRECONNECT_MAX_SOCKET_LIMIT)
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