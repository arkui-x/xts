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

          Button('ERR_PKCS12_IMPORT_INVALID_MAC')
            .id('ERR_PKCS12_IMPORT_INVALID_MAC')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PKCS12_IMPORT_INVALID_MAC)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_PKCS12_IMPORT_INVALID_FILE')
            .id('ERR_PKCS12_IMPORT_INVALID_FILE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PKCS12_IMPORT_INVALID_FILE)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_PKCS12_IMPORT_UNSUPPORTED')
            .id('ERR_PKCS12_IMPORT_UNSUPPORTED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PKCS12_IMPORT_UNSUPPORTED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_KEY_GENERATION_FAILED')
            .id('ERR_KEY_GENERATION_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_KEY_GENERATION_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_PRIVATE_KEY_EXPORT_FAILED')
            .id('ERR_PRIVATE_KEY_EXPORT_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_PRIVATE_KEY_EXPORT_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_SELF_SIGNED_CERT_GENERATION_FAILED')
            .id('ERR_SELF_SIGNED_CERT_GENERATION_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_SELF_SIGNED_CERT_GENERATION_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_CERT_DATABASE_CHANGED')
            .id('ERR_CERT_DATABASE_CHANGED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CERT_DATABASE_CHANGED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_CERT_VERIFIER_CHANGED')
            .id('ERR_CERT_VERIFIER_CHANGED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_CERT_VERIFIER_CHANGED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_MALFORMED_RESPONSE')
            .id('ERR_DNS_MALFORMED_RESPONSE')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_MALFORMED_RESPONSE)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_SERVER_REQUIRES_TCP')
            .id('ERR_DNS_SERVER_REQUIRES_TCP')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_SERVER_REQUIRES_TCP)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_SERVER_FAILED')
            .id('ERR_DNS_SERVER_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_SERVER_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_TIMED_OUT')
            .id('ERR_DNS_TIMED_OUT')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_TIMED_OUT)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_CACHE_MISS')
            .id('ERR_DNS_CACHE_MISS')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_CACHE_MISS)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_SEARCH_EMPTY')
            .id('ERR_DNS_SEARCH_EMPTY')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_SEARCH_EMPTY)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_SORT_ERROR')
            .id('ERR_DNS_SORT_ERROR')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_SORT_ERROR)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED')
            .id('ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_NAME_HTTPS_ONLY')
            .id('ERR_DNS_NAME_HTTPS_ONLY')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_NAME_HTTPS_ONLY)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_REQUEST_CANCELED')
            .id('ERR_DNS_REQUEST_CANCELED')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_REQUEST_CANCELED)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('ERR_DNS_NO_MATCHING_SUPPORTED_ALPN')
            .id('ERR_DNS_NO_MATCHING_SUPPORTED_ALPN')
            .height(15)
            .fontSize(10)
            .margin({ top: 5 })
            .onClick(() => {
              try {
                this.SchemeHandlerResponse.setUrl("http://www.example.com ")
                this.SchemeHandlerResponse.setNetErrorCode(WebNetErrorList.ERR_DNS_NO_MATCHING_SUPPORTED_ALPN)
                this.NetErrorCode = JSON.stringify(this.SchemeHandlerResponse.getNetErrorCode())
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Web({ src: 'https://www.example.com ', controller: this.controller })
        }
      }
    }
  }
}