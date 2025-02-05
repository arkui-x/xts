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

  @State h5MessageResult: string = "";
  @State testObjtest: TestObj = new TestObj();

  build() {
    Row() {
      Scroll() {
        Column() {
          Text(this.h5MessageResult)
            .id("h5MessageResult")
            .fontSize(16)

          Button("SendToH5 setString")
            .id("SendToH5 setString")
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
                  this.message.setString("helloFromEts");
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 setNumber")
            .id("SendToH5 setNumber")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.NUMBER);
                  this.message.setNumber(12345);
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 setBoolean")
            .id("SendToH5 setBoolean")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.BOOLEAN);
                  this.message.setBoolean(true);
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 setArray")
            .id("SendToH5 setArray")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.message.setType(webview.WebMessageType.ARRAY);
                  this.message.setArray([1, 2, 3]);
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 setNull")
            .id("SendToH5 setNull")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.nativePort.postMessageEventExt(null);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 setUndefined")
            .id("SendToH5 setUndefined")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              // 使用本侧端口发送消息给HTML5
              try {
                if (this.nativePort) {
                  this.nativePort.postMessageEventExt(undefined);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
              }
            })

          Button("SendToH5 closePost")
            .id("SendToH5 closePost")
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
                  this.message.setString("helloFromEts");
                  this.ports[0].close();
                  this.nativePort.postMessageEventExt(this.message);
                }
              } catch (error) {
                this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
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

          Web({ src: $rawfile('index.html'), controller: this.controller })
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
                      this.h5MessageResult = `${result.getString()}`;
                      break;
                    }
                    default: {
                      this.h5MessageResult = "default break" + type;
                      break;
                    }
                  }
                } catch (error) {
                  this.h5MessageResult = `ErrorCode:${(error as BusinessError).code}`;
                }
              });
            })
        }
      }
    }
  }
}