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

          Button('ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR')
            .id("ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE')
            .id("ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE')
            .id("ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT')
            .id("ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_ICANN_NAME_COLLISION')
            .id("ERR_ICANN_NAME_COLLISION")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_ICANN_NAME_COLLISION)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_SSL_SERVER_CERT_BAD_FORMAT')
            .id("ERR_SSL_SERVER_CERT_BAD_FORMAT")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_SERVER_CERT_BAD_FORMAT)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_CT_STH_PARSING_FAILED')
            .id("ERR_CT_STH_PARSING_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CT_STH_PARSING_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CT_STH_INCOMPLETE')
            .id("ERR_CT_STH_INCOMPLETE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CT_STH_INCOMPLETE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH')
            .id("ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED')
            .id("ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_OBSOLETE_CIPHER')
            .id("ERR_SSL_OBSOLETE_CIPHER")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_OBSOLETE_CIPHER)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_WS_UPGRADE')
            .id("ERR_WS_UPGRADE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_WS_UPGRADE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_READ_IF_READY_NOT_IMPLEMENTED')
            .id("ERR_READ_IF_READY_NOT_IMPLEMENTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_READ_IF_READY_NOT_IMPLEMENTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_NO_BUFFER_SPACE')
            .id("ERR_NO_BUFFER_SPACE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_NO_BUFFER_SPACE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS')
            .id("ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })


          Button('ERR_EARLY_DATA_REJECTED')
            .id("ERR_EARLY_DATA_REJECTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_EARLY_DATA_REJECTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_WRONG_VERSION_ON_EARLY_DATA')
            .id("ERR_WRONG_VERSION_ON_EARLY_DATA")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_WRONG_VERSION_ON_EARLY_DATA)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_TLS13_DOWNGRADE_DETECTED')
            .id("ERR_TLS13_DOWNGRADE_DETECTED")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_TLS13_DOWNGRADE_DETECTED)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_SSL_KEY_USAGE_INCOMPATIBLE')
            .id("ERR_SSL_KEY_USAGE_INCOMPATIBLE")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SSL_KEY_USAGE_INCOMPATIBLE)
              this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`,);
            }
          })

          Button('ERR_INVALID_ECH_CONFIG_LIST')
            .id("ERR_INVALID_ECH_CONFIG_LIST")
            .height(15)
            .fontSize(10)
            .margin({ top: 5 }).onClick(() => {
            try {
              this.SchemeHandlerResponse.setUrl("http://www.example.com")
              this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_INVALID_ECH_CONFIG_LIST)
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