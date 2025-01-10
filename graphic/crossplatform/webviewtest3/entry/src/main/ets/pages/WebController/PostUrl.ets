// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';


class TestObj {
  constructor() {
  }

  test(str: string): ArrayBuffer {
    let buf = new ArrayBuffer(str.length);
    let buff = new Uint8Array(buf);

    for (let i = 0; i < str.length; i++) {
      buff[i] = str.charCodeAt(i);
    }
    return buf;
  }
}

@Entry
@Component
struct PostUrl {
  controller: webview.WebviewController = new webview.WebviewController();
  controller2: webview.WebviewController = new webview.WebviewController();
  @State errorMessage: BusinessError= {
    code: 0,
    name: '',
    message: ''
  };
  @State testObjtest: TestObj = new TestObj();
  @State requestState: string = '';
  @State url: string = '';
  @State textError: string = "";
  @State postUrlStr: string = "";
  @State postDataStr:string = "";

  build() {
    Column() {
      Back()
      Text('输入postUrl')
      TextInput({text: this.postUrlStr}).onChange((value,previewText)=>{
        this.postUrlStr = value
      }).id('TextId')
      Text('输入postData')
      TextInput({text: this.postDataStr}).onChange((value,previewText)=>{
        this.postDataStr = value
      })
      Text(`${JSON.stringify(this.errorMessage.code)}`)
        .fontColor('red')
        .id("errorCode")
      Text(`错误信息：${this.errorMessage.message}`)
      Text(this.textError)
      Button('捕获错误17100001').id("get1")
        .onClick(() => {
          try {
            let postData = this.testObjtest.test("Name=test&Password=test");
            this.controller2.postUrl('https://developer.huawei.com/', postData);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            this.errorMessage = error as BusinessError;
          }
        })
      Button('捕获错误17100002').id("get2")
        .onClick(() => {
          try {
            this.postUrlStr = '';
            this.postDataStr = "Name=test&Password=test";
            let postData = this.testObjtest.test(this.postDataStr);
            this.controller.postUrl(this.postUrlStr, postData);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            this.errorMessage = error as BusinessError;
          }
        })
      Button('捕获错误401').id("get401")
        .onClick(() => {
          try {
            this.postUrlStr = 'https://developer.huawei.com/';
            this.controller.postUrl(this.postUrlStr, undefined);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            this.errorMessage = error as BusinessError;
          }
        })
      Button('将url设置为：resource://rawfile/index.html')
        .onClick(() => {
          this.postUrlStr = 'resource://rawfile/index.html';
        }).id('setResource')
      Button('加载网页')
        .onClick(() => {
          try {
            let postData = this.testObjtest.test(this.postDataStr);
            this.controller.postUrl(this.postUrlStr, postData);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            this.errorMessage = error as BusinessError;
          }
        })
        .id('postUrlId')
      Web({ src: '', controller: this.controller })
        .onErrorReceive((event) => {
          if (event) {
            this.textError = `url:${event.request.getRequestUrl()}, ErrorCode: ${event.error.getErrorCode() },  Message: ${event.error.getErrorInfo()}`
            console.log('getErrorInfo:' + event.error.getErrorInfo());
            console.log('getErrorCode:' + event.error.getErrorCode());
            console.log('url:' + event.request.getRequestUrl());
          }
        })
    }
  }
}