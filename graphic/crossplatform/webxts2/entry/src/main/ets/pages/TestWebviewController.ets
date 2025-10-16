import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State customUserAgent: string = ' DemoApp';
  @State userAgent: string = '';
  @State userAgent1: string = '';

  @State ua: string = '';
  @State code: string = '';
  @State ErrorCode: string = ''

  build() {
    Column() {

      Text(this.ErrorCode)
        .id("ErrorCode")
        .fontSize(10)

      Text(this.userAgent)
        .id("userAgent")
        .fontSize(10)

      Text(this.userAgent1)
        .id("userAgent1")
        .fontSize(10)

      Button('setCustomUserAgent')
        .id("setCustomUserAgent")
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.ua = this.controller.getUserAgent() + this.customUserAgent;
            this.controller.setCustomUserAgent(this.ua);
            console.log("userAgent : " + this.ua);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Button('setCustomUserAgent(undefined)')
        .id("setCustomUserAgent(undefined)")
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.controller.setCustomUserAgent(undefined);
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Button('setCustomUserAgent(123qwe!@#)')
        .id('setCustomUserAgent(123qwe!@#)')
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.controller.setCustomUserAgent("123qwe!@#");
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Button('getCustomUserAgent')
        .id("getCustomUserAgent")
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.userAgent = this.controller.getCustomUserAgent();
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Button('getUserAgent')
        .id("getUserAgent")
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.userAgent1 = this.controller.getUserAgent();
          } catch (error) {
            this.ErrorCode = JSON.stringify(error.code);
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Web({ src: 'https://www.example.com', controller: this.controller })
    }
  }
}