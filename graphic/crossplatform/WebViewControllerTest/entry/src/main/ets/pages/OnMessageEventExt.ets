/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import router from '@ohos.router';

class TestObj {
  test(str: string): ArrayBuffer {
    let buf = new ArrayBuffer(str.length);
    let buff = new Uint8Array(buf);

    for (let i = 0; i < str.length; i++) {
      buff[i] = str.charCodeAt(i);
    }
    return buf;
  }
}

// 应用与网页互发消息的示例：使用"init_web_messageport"的通道，通过端口0在应用侧接受网页发送的消息，通过端口1在网页侧接受应用发送的消息。
@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  ports: webview.WebMessagePort[] = [];
  nativePort: webview.WebMessagePort | null = null;
  message: webview.WebMessageExt = new webview.WebMessageExt();

  @State onMessageResult: string = ""
  @State testObjtest: TestObj = new TestObj();

  build() {
    Row() {
      Scroll() {
        Column() {
          Text(this.onMessageResult)
            .id("onMessageResult")
            .fontSize(16)

          Button("notifyH5 sendString")
            .id("notifyH5 sendString")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.STRING);
                  this.message.setString("string");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("notifyH5 sendNumber")
            .id("notifyH5 sendNumber")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.STRING);
                  this.message.setString("number");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("notifyH5 sendBoolean")
            .id("notifyH5 sendBoolean")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.STRING);
                  this.message.setString("boolean");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("notifyH5 sendArray")
            .id("notifyH5 sendArray")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.STRING);
                  this.message.setString("array");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("nullCallback")
            .id("nullCallback")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                if (this.nativePort) {
                  this.nativePort.onMessageEventExt(null);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("undefinedCallback")
            .id("undefinedCallback")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                if (this.nativePort) {
                  this.nativePort.onMessageEventExt(undefined);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("notifyH5 sendString_getNumber")
            .id("notifyH5 sendString_getNumber")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                if (this.nativePort) {
                  this.nativePort.onMessageEventExt((result) => {
                    try {
                      let type = result.getType();
                      switch (type) {
                        case webview.WebMessageType.STRING: {
                          result.getNumber();
                          break;
                        }
                        default: {
                          this.onMessageResult = "default break" + type;
                          break;
                        }
                      }
                    } catch (error) {
                      this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
                    }
                  });
                  this.message.setType(webview.WebMessageType.STRING);
                  this.message.setString("string");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("notifyH5 closePost")
            .id("notifyH5 closePost")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                if (this.nativePort) {
                  this.ports[0].close();
                  this.nativePort.onMessageEventExt((result) => {});
                }
              } catch (error) {
                this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("Back")
            .id("Back")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#fffbb80d')
            .onClick(() => {
              router.back();
            })

          Web({ src: $rawfile('index_on.html'), controller: this.controller })
            .onPageEnd(() => {
              console.log("In ArkTS side message onPageEnd init message channel");
              // 1. 创建消息端口
              this.ports = this.controller.createWebMessagePorts(true);
              // 2. 发送端口1到HTML5
              this.controller.postMessage("init_web_messageport", [this.ports[1]], "*");
              // 3. 保存端口0到本地
              this.nativePort = this.ports[0];
              // 4. 设置回调函数
              this.nativePort.onMessageEventExt((result) => {
                console.log("In ArkTS side got message");
                try {
                  let type = result.getType();
                  switch (type) {
                    case webview.WebMessageType.STRING: {
                      this.onMessageResult = `String:${result.getString()}`;
                      break;
                    }
                    case webview.WebMessageType.NUMBER: {
                      this.onMessageResult = `Number:${result.getNumber()}`;
                      break;
                    }
                    case webview.WebMessageType.BOOLEAN: {
                      this.onMessageResult = `Boolean:${result.getBoolean()}`;
                      break;
                    }
                    case webview.WebMessageType.ARRAY: {
                      this.onMessageResult = `Array:${result.getArray()}`;
                      break;
                    }
                    case webview.WebMessageType.ERROR: {
                      this.onMessageResult = `Error:${result.getError()}`;
                      break;
                    }
                    default: {
                      this.onMessageResult = "default break" + type;
                      break;
                    }
                  }
                } catch (error) {
                  this.onMessageResult = `ErrorCode:${(error as BusinessError).code}`;
                }
              });
            })


        }
      }
    }
  }
}