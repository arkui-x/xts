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

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  delegate: webview.WebDownloadDelegate = new webview.WebDownloadDelegate();
  download: webview.WebDownloadItem = new webview.WebDownloadItem();

  @State Guid: string | null = null;
  @State CurrentSpeed: string | null = null;
  @State PercentComplete: string | null = null;
  @State TotalBytes: string | null = null;
  @State ReceivedBytes: string | null = null;
  @State LastErrorCode: string | null = null;
  @State Method: string | null = null;
  @State State: string | null = null;
  @State MimeType: string | null = null;
  @State SuggestedFileName: string | null = null;
  @State Url: string | null = null;
  @State FullPath: string | null = null;
  @State State_pause: string | null = null;

  @State pause_error: string | null = null;
  @State resume_error: string | null = null;

  build() {
    Row() {
      Scroll() {
        Column() {

          Text(this.Guid)
            .id("Guid")
            .fontSize(10)

          Text(this.CurrentSpeed)
            .id("CurrentSpeed")
            .fontSize(10)

          Text(this.PercentComplete)
            .id("PercentComplete")
            .fontSize(10)

          Text(this.TotalBytes)
            .id("TotalBytes")
            .fontSize(10)

          Text(this.ReceivedBytes)
            .id("ReceivedBytes")
            .fontSize(10)

          Text(this.LastErrorCode)
            .id("LastErrorCode")
            .fontSize(10)

          Text(this.Method)
            .id("Method")
            .fontSize(10)

          Text(this.State)
            .id("State")
            .fontSize(10)

          Text(this.MimeType)
            .id("MimeType")
            .fontSize(10)

          Text(this.SuggestedFileName)
            .id("SuggestedFileName")
            .fontSize(10)

          Text(this.Url)
            .id("Url")
            .fontSize(10)

          Text(this.FullPath)
            .id("FullPath")
            .fontSize(10)

          Text(this.State_pause)
            .id("State_pause")
            .fontSize(10)

          Text(this.pause_error)
            .id("pause_error")
            .fontSize(10)

          Text(this.resume_error)
            .id("resume_error")
            .fontSize(10)

          Button("setDownloadDelegate_onBeforeDownload")
            .id("setDownloadDelegate_onBeforeDownload")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  webDownloadItem.start("/data/storage/el2/base/cache/web/" + webDownloadItem.getSuggestedFileName());
                  this.Guid = webDownloadItem.getGuid();
                  this.CurrentSpeed = `${webDownloadItem.getCurrentSpeed()}`;
                  this.PercentComplete = `${webDownloadItem.getPercentComplete()}`;
                  this.TotalBytes = `${webDownloadItem.getTotalBytes()}`;
                  this.State = `${webDownloadItem.getState()}`;
                  this.LastErrorCode = `${webDownloadItem.getLastErrorCode().toString()}`;
                  this.Method = webDownloadItem.getMethod();
                  this.MimeType = webDownloadItem.getMimeType();
                  this.Url = webDownloadItem.getUrl();
                  this.SuggestedFileName = webDownloadItem.getSuggestedFileName();
                  this.ReceivedBytes = `${webDownloadItem.getReceivedBytes()}`;
                  webDownloadItem.cancel()
                })
                this.controller.setDownloadDelegate(this.delegate);
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button("setDownloadDelegate_onBeforeDownload_error")
            .id("setDownloadDelegate_onBeforeDownload_error")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  this.download = webDownloadItem;
                })
                this.controller.setDownloadDelegate(this.delegate);
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button("setDownloadDelegate_onDownloadUpdated")
            .id("setDownloadDelegate_onDownloadUpdated")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  webDownloadItem.start("/data/storage/el2/base/cache/web/" + webDownloadItem.getSuggestedFileName());
                })
                this.delegate.onDownloadUpdated((webDownloadItem: webview.WebDownloadItem) => {
                  this.Guid = webDownloadItem.getGuid();
                  this.CurrentSpeed = `${webDownloadItem.getCurrentSpeed()}`;
                  this.PercentComplete = `${webDownloadItem.getPercentComplete()}`;
                  this.TotalBytes = `${webDownloadItem.getTotalBytes()}`;
                  this.State = `${webDownloadItem.getState()}`;
                  this.LastErrorCode = `${webDownloadItem.getLastErrorCode().toString()}`;
                  this.Method = webDownloadItem.getMethod();
                  this.MimeType = webDownloadItem.getMimeType();
                  this.Url = webDownloadItem.getUrl();
                  this.SuggestedFileName = webDownloadItem.getSuggestedFileName();
                  this.ReceivedBytes = `${webDownloadItem.getReceivedBytes()}`;
                  this.FullPath = webDownloadItem.getFullPath();
                  webDownloadItem.cancel()
                })
                this.controller.setDownloadDelegate(this.delegate);
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button("setDownloadDelegate_onDownloadUpdated_pause")
            .id("setDownloadDelegate_onDownloadUpdated_pause")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  webDownloadItem.start("/data/storage/el2/base/cache/web/" + webDownloadItem.getSuggestedFileName());
                  this.download = webDownloadItem
                })
                this.delegate.onDownloadUpdated((webDownloadItem: webview.WebDownloadItem) => {
                  this.State_pause = `${webDownloadItem.getState()}`;
                })
                this.controller.setDownloadDelegate(this.delegate);
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button("setDownloadDelegate_onDownloadFailed")
            .id("setDownloadDelegate_onDownloadFailed")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  webDownloadItem.start("/data/storage/el2/base/cache/web/" + webDownloadItem.getSuggestedFileName());
                  webDownloadItem.cancel()
                })
                this.delegate.onDownloadFailed((webDownloadItem: webview.WebDownloadItem) => {
                  this.Guid = webDownloadItem.getGuid();
                  this.CurrentSpeed = `${webDownloadItem.getCurrentSpeed()}`;
                  this.PercentComplete = `${webDownloadItem.getPercentComplete()}`;
                  this.TotalBytes = `${webDownloadItem.getTotalBytes()}`;
                  this.State = `${webDownloadItem.getState()}`;
                  this.LastErrorCode = `${webDownloadItem.getLastErrorCode().toString()}`;
                  this.Method = webDownloadItem.getMethod();
                  this.MimeType = webDownloadItem.getMimeType();
                  this.Url = webDownloadItem.getUrl();
                  this.SuggestedFileName = webDownloadItem.getSuggestedFileName();
                  this.ReceivedBytes = `${webDownloadItem.getReceivedBytes()}`;
                  this.FullPath = webDownloadItem.getFullPath();
                })
                this.controller.setDownloadDelegate(this.delegate);

              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button("setDownloadDelegate_onDownloadFinish")
            .id("setDownloadDelegate_onDownloadFinish")
            .height(24)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.delegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
                  webDownloadItem.start("/data/storage/el2/base/cache/web/" + webDownloadItem.getSuggestedFileName());
                })
                this.delegate.onDownloadFailed((webDownloadItem: webview.WebDownloadItem) => {
                  console.error(`UiTestCase, onDownloadFailed enter`)
                })
                this.delegate.onDownloadUpdated((webDownloadItem: webview.WebDownloadItem) => {
                  console.error(`UiTestCase, onDownloadUpdated enter`)
                })
                this.delegate.onDownloadFinish((webDownloadItem: webview.WebDownloadItem) => {
                  console.error(`UiTestCase, onDownloadFinish enter`)
                  this.Guid = webDownloadItem.getGuid();
                  this.CurrentSpeed = `${webDownloadItem.getCurrentSpeed()}`;
                  this.PercentComplete = `${webDownloadItem.getPercentComplete()}`;
                  this.TotalBytes = `${webDownloadItem.getTotalBytes()}`;
                  this.State = `${webDownloadItem.getState()}`;
                  this.LastErrorCode = `${webDownloadItem.getLastErrorCode().toString()}`;
                  this.Method = webDownloadItem.getMethod();
                  this.MimeType = webDownloadItem.getMimeType();
                  this.Url = webDownloadItem.getUrl();
                  this.SuggestedFileName = webDownloadItem.getSuggestedFileName();
                  this.ReceivedBytes = `${webDownloadItem.getReceivedBytes()}`;
                  this.FullPath = webDownloadItem.getFullPath();
                })
                this.controller.setDownloadDelegate(this.delegate);
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })

          Button('clear_info')
            .id("clear_info")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              console.log("[Debug][JS]:clear enter");
              this.Guid = null;
              this.CurrentSpeed = null;
              this.PercentComplete = null;
              this.TotalBytes = null;
              this.State = null;
              this.LastErrorCode = null;
              this.Method = null;
              this.MimeType = null;
              this.Url = null;
              this.SuggestedFileName = null;
              this.ReceivedBytes = null;
              this.FullPath = null;
            })

          Button('startDownload picture')
            .id("startDownload_picture")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.controller.startDownload('https://vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg');
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
          Button('startDownload')
            .id("startDownload")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.controller.startDownload('https://cd001.v78q.com/cs/104sem/Beyond Compare 文件对比工具_sm60000068e.exe');
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
          Button('start')
            .id("start")
            .onClick(() => {
              try {
                this.download.start("/data/storage/el2/base/cache/web/1");
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
          Button('pause')
            .id("pause")
            .onClick(() => {
              try {
                this.download.pause();
              } catch (error) {
                this.pause_error = `${(error as BusinessError).code}`;
              }
            })
          Button('resume')
            .id("resume")
            .onClick(() => {
              try {
                this.download.resume();
              } catch (error) {
                this.resume_error = `${(error as BusinessError).code}`;
              }
            })
          Button('cancel')
            .id("cancel")
            .onClick(() => {
              try {
                this.download.cancel()
              } catch (error) {
                console.error(`[Debug][JS]:ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
          Web({ src: 'vcg01.cfp.cn/creative/vcg/800/new/VCG211331055004.jpg', controller: this.controller })
        }
      }
    }
  }
}