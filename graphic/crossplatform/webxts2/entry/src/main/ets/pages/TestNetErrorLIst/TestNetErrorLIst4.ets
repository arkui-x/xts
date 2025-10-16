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

          Button('ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED')
            .id("ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED")

            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY')
            .id("ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_PROXY_CERTIFICATE_INVALID')
            .id("ERR_PROXY_CERTIFICATE_INVALID")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PROXY_CERTIFICATE_INVALID)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_NAME_RESOLUTION_FAILED')
            .id("ERR_NAME_RESOLUTION_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NAME_RESOLUTION_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_NETWORK_ACCESS_DENIED')
            .id("ERR_NETWORK_ACCESS_DENIED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NETWORK_ACCESS_DENIED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_TEMPORARILY_THROTTLED')
            .id("ERR_TEMPORARILY_THROTTLED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TEMPORARILY_THROTTLED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT')
            .id("ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED')
            .id("ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_MSG_TOO_BIG')
            .id("ERR_MSG_TOO_BIG")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_MSG_TOO_BIG)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_WS_PROTOCOL_ERROR')
            .id("ERR_WS_PROTOCOL_ERROR")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_WS_PROTOCOL_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_ADDRESS_IN_USE')
            .id("ERR_ADDRESS_IN_USE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ADDRESS_IN_USE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_HANDSHAKE_NOT_COMPLETED')
            .id("ERR_SSL_HANDSHAKE_NOT_COMPLETED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_HANDSHAKE_NOT_COMPLETED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_BAD_PEER_PUBLIC_KEY')
            .id("ERR_SSL_BAD_PEER_PUBLIC_KEY")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_BAD_PEER_PUBLIC_KEY)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN')
            .id("ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED')
            .id("ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })
          Button('ERR_SSL_DECRYPT_ERROR_ALERT')
            .id("ERR_SSL_DECRYPT_ERROR_ALERT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_DECRYPT_ERROR_ALERT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_WS_THROTTLE_QUEUE_TOO_LARGE')
            .id("ERR_WS_THROTTLE_QUEUE_TOO_LARGE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_WS_THROTTLE_QUEUE_TOO_LARGE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_SERVER_CERT_CHANGED')
            .id("ERR_SSL_SERVER_CERT_CHANGED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_SERVER_CERT_CHANGED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_UNRECOGNIZED_NAME_ALERT')
            .id("ERR_SSL_UNRECOGNIZED_NAME_ALERT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_UNRECOGNIZED_NAME_ALERT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR')
            .id("ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR)
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