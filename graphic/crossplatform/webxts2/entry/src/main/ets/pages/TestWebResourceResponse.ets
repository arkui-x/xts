import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  responseResource: WebResourceResponse = new WebResourceResponse();
  @State ResponseData: string = '';
  @State ResponseEncoding: string = '';
  @State ResponseMimeType: string = '';
  @State ResponseCode: string = '';
  @State ReasonMessage: string = '';
  @State ResponseDataEx: string = '';
  @State ResponseIsReady: string = '';
  @State ResponseHeader: string = '';
  @State ErrorCode: string = '';
  @State webData: string = '<!DOCTYPE html>\n' +
    '<html>\n' +
    '<head>\n' +
    '<title>intercept test</title>\n' +
    '</head>\n' +
    '<body>\n' +
    '<h1>intercept ok</h1>\n' +
    '</body>\n' +
    '</html>'

  build() {
    Column() {

      Text(this.ResponseData)
        .id("ResponseData")
        .fontSize(10)

      Text(this.ResponseEncoding)
        .id("ResponseEncoding")
        .fontSize(10)

      Text(this.ResponseMimeType)
        .id("ResponseMimeType")
        .fontSize(10)

      Text(this.ReasonMessage)
        .id("ReasonMessage")
        .fontSize(10)

      Text(this.ResponseDataEx)
        .id("ResponseDataEx")
        .fontSize(10)

      Text(this.ResponseCode)
        .id("ResponseCode")
        .fontSize(10)

      Text(this.ResponseIsReady)
        .id("ResponseIsReady")
        .fontSize(10)

      Text(this.ResponseHeader)
        .id("ResponseHeader")
        .fontSize(10)

      Text(this.ErrorCode)
        .id("ErrorCode")
        .fontSize(10)

      Button('TestResponseResource')
        .id("TestResponseResource")
        .height(24)
        .fontSize(12)
        .margin({ top: 5 })
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          try {
            this.responseResource.setResponseData(this.webData);
            this.responseResource.setResponseEncoding('utf-8');
            this.responseResource.setResponseMimeType('text/html');
            this.responseResource.setResponseCode(200);
            this.responseResource.setReasonMessage('OK');

            this.ResponseData = this.responseResource.getResponseData()
            this.ResponseEncoding = this.responseResource.getResponseEncoding()
            this.ResponseMimeType = this.responseResource.getResponseMimeType()
            this.ResponseCode = JSON.stringify(this.responseResource.getResponseCode())
            this.ReasonMessage = this.responseResource.getReasonMessage()
            this.ResponseDataEx = JSON.stringify(this.responseResource.getResponseDataEx())
            this.ResponseIsReady = JSON.stringify(this.responseResource.getResponseIsReady())
            let resph = this.responseResource.getResponseHeader();
            this.ResponseHeader = JSON.stringify(resph.length)
            console.info('TecstResponseResource The response header result size is ' + resph.length);
            for (let i of resph) {
              console.info('The response header key is : ' + i.headerKey + ' , value is : ' + i.headerValue);
              this.ResponseHeader = i.headerKey;
            }
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })

      Web({ src: 'https://www.example.com', controller: this.controller })
    }
  }
}