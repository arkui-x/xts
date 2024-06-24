/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { BusinessError } from '@ohos.base';
import { describe, beforeAll, it, expect } from '@ohos/hypium';
import { Driver, ON, } from '@ohos.UiTest';
import notificationManager from '@ohos.notificationManager'
import image from '@ohos.multimedia.image';

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function notificationTest() {
  describe('ActsNotificationTest', () => {
    const WAIT_TIME = 1000;
    let TAG = 'SUB_NOTIFICATION_TEST ===>'

    beforeAll(async () => {
      notificationManager.requestEnableNotification((err) => {
        if (err) {
          console.error(`beforeEach requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
        } else {
          console.info("beforeEach  requestEnableNotification success");
        }
      });
      let driver = Driver.create();
      await driver.delayMs(1500)
      let button = await driver.findComponent(ON.text('允许'));
      console.info(`beforeEach button is ${JSON.stringify(button)}`);
      if (button !== null) {
        await button.click();
        await sleep(1500);
      } else {
        console.info(`beforeEach button is null`)
      }
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0100
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_0100', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0100 success`);

      await notificationManager.requestEnableNotification().then(() => {
        console.info(`${TAG} requestEnableNotification Promise success`);
      }).catch((err: BusinessError) => {
        console.info(`${TAG} requestEnableNotification Promise err: ${err.code}, errMes: ${err.message}`);
      })

      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: 'test_text',
            longText: 'text_longText',
            briefText: 'text_briefText',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      await sleep(WAIT_TIME)
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0100 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0100 errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0100 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0200
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_0200', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0200 success`);
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: '',
            text: 'test_text',
            longText: 'text_longText',
            briefText: 'text_briefText',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      await sleep(WAIT_TIME)
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0200 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0200 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0200 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0300
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_0300', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0300 success`);
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: '',
            longText: 'text_longText',
            briefText: 'text_briefText',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0300 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0300 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0300 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0400
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_0400', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0400 success`)
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: 'test_text',
            longText: '',
            briefText: 'text_briefText',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0400 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0400 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0400 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0500
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_0500', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0500 success`)
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: 'test_text',
            longText: 'text_longText',
            briefText: '',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0500 publish success`);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0500 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0500 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0600
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_0600', 0, async (done: Function) => {
      console.info(`testPublish_longText0006 success`)
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: 'test_text',
            longText: 'text_longText',
            briefText: 'text_briefText',
            expandedTitle: ''
          }
        },
      }
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0600 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_0600 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0600 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0700
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_0700', 0, async (done: Function) => {
      const color = new ArrayBuffer(50000);
      let bufferArr = new Uint8Array(color);
      for (let i = 0; i < bufferArr.byteLength; i++) {
        bufferArr[i++] = 60;
        bufferArr[i++] = 20;
        bufferArr[i++] = 220;
        bufferArr[i] = 100;
      }
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 2, size: {
          height: 100, width: 150
        }
      };
      await image
        .createPixelMap(color, opts)
        .then(async (pixelmap) => {
          await pixelmap.getImageInfo().then(imageInfo => {
            console.log("=== SUB_NotificationManager_TestPublish_Func_0700 size: ===" + JSON.stringify(imageInfo.size));
          }).catch((err: BusinessError) => {
            console.error(" Failed to obtain the image pixel map information." + JSON.stringify(err));
            return;
          })
          await sleep(WAIT_TIME);
          let notificationRequest: notificationManager.NotificationRequest = {
            id: 1,
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
              longText: {
                title: 'text_title',
                text: 'test_text',
                longText: 'text_longText',
                briefText: 'text_briefText',
                expandedTitle: 'text_exoandTitle',
                lockscreenPicture: pixelmap,
              }
            },
          }
          try {
            notificationManager.publish(notificationRequest, (data) => {
              console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0700 publish success`);
              expect(data).assertEqual(null);
              done();
            });
          } catch (err) {
            console.info(` SUB_NotificationManager_TestPublish_Func_0700 errCode: ${err.code}, errMes: ${err.message}`);
            expect(err.code).assertEqual(401);
            done();
          }
          console.info(`SUB_NotificationManager_TestPublish_Func_0700 END`);
        })
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0800
     * @tc.name   : test NotificationContent
     * @tc.desc   : use Promise When notification type：NOTIFICATION_CONTENT_LONG_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_0800', 0, async (done: Function) => {
      console.info(`SUB_NotificationManager_TestPublish_Func_0800 success`)
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: 'text_title',
            text: 'test_text',
            longText: 'text_longText',
            briefText: 'text_briefText',
            expandedTitle: 'text_exoandTitle'
          }
        },
      }
      await sleep(WAIT_TIME)
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_0800 publish success: ${data}`);
        expect(data).assertEqual(null);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0800 publish err: ${err.code}`);
        expect(err.code).assertEqual(1600004);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0800 END`)
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_0900
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_BASIC_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_0900', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      await sleep(WAIT_TIME)
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_0900 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_0900 errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_0900 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01000
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_BASIC_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01000', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "",
            text: "test_text",
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01000 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01000 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01000 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01100
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_BASIC_TEXT
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01100', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "",
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01100 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01100 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01100 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01200
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_BASIC_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_01200', 0, async (done: Function) => {
      const color = new ArrayBuffer(60000);
      let bufferArr = new Uint8Array(color);
      for (let i = 0; i < bufferArr.byteLength; i++) {
        bufferArr[i++] = 60;
        bufferArr[i++] = 20;
        bufferArr[i++] = 220;
        bufferArr[i] = 100;
      }
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 2, size: {
          height: 100, width: 150
        }
      };
      await image
        .createPixelMap(color, opts)
        .then(async (pixelmap) => {
          await pixelmap.getImageInfo().then(imageInfo => {
            console.log("SUB_NotificationManager_TestPublish_Func_01200 size: " + JSON.stringify(imageInfo.size));
          }).catch((err: BusinessError) => {
            console.error("Failed to obtain the image pixel map information." + JSON.stringify(err));
            return;
          })
          await sleep(WAIT_TIME);
          let notificationRequest: notificationManager.NotificationRequest = {
            id: 1,
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
              normal: {
                title: 'text_title',
                text: 'text_text',
                lockscreenPicture: pixelmap
              }
            },
          }
          try {
            notificationManager.publish(notificationRequest, (data) => {
              console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01200 publish success`);
              expect(data).assertEqual(null);
              done();
            });
          } catch (err) {
            console.info(`SUB_NotificationManager_TestPublish_Func_01200 errCode: ${err.code}, errMes: ${err.message}`);
            expect(err.code).assertEqual(401);
            done();
          }
          console.info(`SUB_NotificationManager_TestPublish_Func_01200 END`);
        })
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01300
     * @tc.name   : test NotificationContent
     * @tc.desc   : use Promise When notification type：NOTIFICATION_CONTENT_BASIC_TEXT
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_01300', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_01300 publish success: ${data}`);
        expect(data).assertEqual(null);
        done()
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01300 publish err: ${err.code}`);
        expect(err.code).assertEqual(401);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01300 END`)
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01400
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 1
     */
    it('testPublish_multiLine0001', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: 'test_text',
            briefText: 'text_briefText',
            longTitle: 'text_longtitle',
            lines: ['text_lines'],
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01400 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01400 errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01400 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01500
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01500', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: '',
            briefText: 'text_briefText',
            longTitle: 'text_longtitle',
            lines: ['text_lines'],
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01500 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_01500 errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01500 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01600
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01600', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: '',
            text: 'test_text',
            briefText: 'text_briefText',
            longTitle: 'text_longtitle',
            lines: ['text_lines'],
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01600 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01600 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01600 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01700
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01700', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: 'test_text',
            briefText: '',
            longTitle: 'text_longtitle',
            lines: ['text_lines'],
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01700 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_01700 errCode: ${err.code}, errMes: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01700 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01800
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01800', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: 'test_text',
            briefText: 'text_briefText',
            longTitle: '',
            lines: ['text_lines'],
          }
        }
      };
      await sleep(WAIT_TIME);
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01800 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01800 errCode: ${err.code}, errMes: ${err.message}`)
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01800 END`);
    })
    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_01900
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 2
     */
    it('SUB_NotificationManager_TestPublish_Func_01900', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: 'test_text',
            briefText: 'text_briefText',
            longTitle: 'text_longTitle',
            lines: [],
          }
        }
      };
      await sleep(WAIT_TIME);
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_01900 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(` SUB_NotificationManager_TestPublish_Func_01900 errCode: ${err.code}, errMes: ${err.message}`)
        expect(err.code).assertEqual(401);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_01900 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02000
     * @tc.name   : test NotificationContent
     * @tc.desc   : When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02000', 0, async (done: Function) => {
      const color = new ArrayBuffer(60000);
      let bufferArr = new Uint8Array(color);
      for (let i = 0; i < bufferArr.byteLength; i++) {
        bufferArr[i++] = 60;
        bufferArr[i++] = 20;
        bufferArr[i++] = 220;
        bufferArr[i] = 100;
      }
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 2, size: {
          height: 100, width: 150
        }
      };
      await sleep(WAIT_TIME);
      await image
        .createPixelMap(color, opts)
        .then(async (pixelmap) => {
          await pixelmap.getImageInfo().then(imageInfo => {
            console.log("SUB_NotificationManager_TestPublish_Func_02000 size:" + JSON.stringify(imageInfo.size));
          }).catch((err: BusinessError) => {
            console.error("Failed to obtain the image pixel map information." + JSON.stringify(err));
            return;
          })
          await sleep(WAIT_TIME);
          let notificationRequest: notificationManager.NotificationRequest = {
            id: 1,
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
              multiLine: {
                title: 'text_title',
                text: 'test_text',
                briefText: 'text_briefText',
                longTitle: 'text_longtitle',
                lines: ['text_lines'],
                lockscreenPicture: pixelmap
              }
            }
          }
          try {
            notificationManager.publish(notificationRequest, (data) => {
              console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02000 publish success`)
              expect(data).assertEqual(null);
              done()
            });
          } catch (err) {
            console.info(`SUB_NotificationManager_TestPublish_Func_02000 errCode: ${err.code}, errMes: ${err.message}`)
            expect(err.code).assertEqual(401);
            done()
          }
          console.info(`SUB_NotificationManager_TestPublish_Func_02000 END`);
        })
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02100
     * @tc.name   : test NotificationContent
     * @tc.desc   : use Promise When notification type：NOTIFICATION_CONTENT_MULTILINE
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02100', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: 'text_title',
            text: 'test_text',
            briefText: 'text_briefText',
            longTitle: 'text_longtitle',
            lines: ['text_lines'],
          }
        }
      };
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_02100 publish success: ${data}`)
        expect(data).assertEqual(null);
        done()
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02100 publish err: ${err.code}`)
        expect(err.code).assertEqual(401);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02100 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02200
     * @tc.name   : test Publish interface
     * @tc.desc   : test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02200', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        appMessageId: "appMessageId",
        isOngoing: true,
        deliveryTime: 0,
        tapDismissed: true,
        autoDeletedTime: 500,
        isAlertOnce: true,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      try {
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02200 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_02200 errCode: ${err.code}, errMes: ${err.message}`)
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_02200 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02300
     * @tc.name   : test Publish interface
     * @tc.desc   : test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02300', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        isStopwatch: true,
        isCountDown: true,
        showDeliveryTime: true,
        groupName: "groupName",
        badgeNumber: 4,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      try {
        await sleep(WAIT_TIME);
        notificationManager.publish(notificationRequest, (data) => {
          console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02300 publish success`);
          expect(data).assertEqual(null);
          done();
        });
      } catch (err) {
        console.info(`SUB_NotificationManager_TestPublish_Func_02300 errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`SUB_NotificationManager_TestPublish_Func_02300 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02400
     * @tc.name   : test Publish interface
     * @tc.desc   : use Promise test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02400', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        appMessageId: "appMessageId",
        isOngoing: true,
        deliveryTime: 10,
        tapDismissed: true,
        autoDeletedTime: 500,
        isAlertOnce: false,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      await sleep(WAIT_TIME);
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_02400 publish success: ${data}`);
        expect(data).assertEqual(null);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02400 publish err: ${err.code}`);
        expect(err.code).assertEqual(401);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02400 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02500
     * @tc.name   : test Publish interface
     * @tc.desc   : use Promise test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02500', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        isStopwatch: true,
        isCountDown: false,
        showDeliveryTime: true,
        groupName: "groupName",
        badgeNumber: 4,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "test_title",
            text: "test_text",
          }
        }
      };
      await sleep(WAIT_TIME);
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_02500 publish success: ${data}`);
        expect(data).assertEqual(null);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02500 publish err: ${err.code}`);
        expect(err.code).assertEqual(401);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02500 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02600
     * @tc.name   : test Publish interface
     * @tc.desc   : use Promise test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02600', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        isStopwatch: false,
        isCountDown: false,
        showDeliveryTime: true,
        groupName: "groupName",
        badgeNumber: 4,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          normal: {
            title: 'testTitle',
            text: 'testText',
          },
          multiLine: {
            title: 'testMultiLineTitle',
            text: 'testMultiLineText',
            longTitle: 'testMultiLineLongText',
            briefText: 'testMultiLineBriefText',
            lines: ['firstLine', 'secondLine', 'thirdLine']
          },
        },
      };
      await sleep(WAIT_TIME);
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_02600 publish success: ${data}`);
        expect(data).assertEqual(null);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02600 publish err: ${err.code}`);
        expect(err.code).assertEqual(160004);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02600 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestPublish_Func_02700
     * @tc.name   : test Publish interface
     * @tc.desc   : use Promise test notificationRequest property
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestPublish_Func_02700', 0, async (done: Function) => {
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        appMessageId: "appMessageId",
        isOngoing: false,
        deliveryTime: 10,
        tapDismissed: true,
        autoDeletedTime: 500,
        isAlertOnce: false,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          normal: {
            title: 'testTitle',
            text: 'testText',
          },
          multiLine: {
            title: 'testMultiLineTitle',
            text: 'testMultiLineText',
            longTitle: 'testMultiLineLongText',
            briefText: 'testMultiLineBriefText',
            lines: ['firstLine', 'secondLine', 'thirdLine']
          },
        },
      };
      await sleep(WAIT_TIME);
      await notificationManager.publish(notificationRequest).then(data => {
        console.log(`${TAG} SUB_NotificationManager_TestPublish_Func_02700 publish success: ${data}`);
        expect(data).assertEqual(null);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02700 publish err: ${err.code}`);
        expect(err.code).assertEqual(1600004);
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestPublish_Func_02700 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestCancel_Func_02800
     * @tc.name   : cancel
     * @tc.desc   : test notificationManager cancel interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestCancel_Func_02800', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_02500 START`);
      let id = 10;
      let result = true;
      notificationManager.cancel(id, (err) => {
        if (err) {
          console.info(`${TAG} TestCancel_Func_02800 cancel err: ${err.code}, errMes: ${err.message}`);
          result = false;
        } else {
          console.info(`${TAG} TestCancel_Func_02800 cancel id success`);
        }
      })
      expect(result).assertEqual(true);
      console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_02800 END`);
      done();
    })

    /**
     * @tc.number : SUB_NotificationManager_TestCancel_Func_02900
     * @tc.name   : cancel
     * @tc.desc   : test notificationManager cancel interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestCancel_Func_02900', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_02900 START`);
      let id = 1;
      let result = true;
      notificationManager.cancel(id, (err) => {
        if (err) {
          console.info(`${TAG} TestCancel_Func_02900 id err: ${err.code}`);
          result = false;
        } else {
          console.info(`${TAG} TestCancel_Func_02900 id success`);
        }
      })
      expect(result).assertEqual(true);
      console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_02900 END`);
      done();
    })

    /**
     * @tc.number : SUB_NotificationManager_TestCancel_Func_03000
     * @tc.name   : cancelAll
     * @tc.desc   : test notificationManager cancelAll interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestCancel_Func_03000', 0, async (done: Function) => {
      let result = true;
      console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_03000 START`);
      notificationManager.cancelAll((err) => {
        if (err) {
          console.info(`${TAG} testcancelAll AsyncCallback err: ${err.code}, errMes: ${err.message}`);
          result = false;
        } else {
          console.info(`${TAG} testcancelAll AsyncCallback success`);
        }
        expect(result).assertEqual(true);
        console.info(`${TAG} SUB_NotificationManager_TestCancel_Func_03000 END`);
        done();
      })
    })

    /**
     * @tc.number : SUB_NotificationManager_TestcancelAll_Func_03100
     * @tc.name   : cancelAll
     * @tc.desc   : use Promise test notificationManager cancelAll interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestcancelAll_Func_03100', 0, async (done: Function) => {
      let result = true;
      console.info(`${TAG} SUB_NotificationManager_TestcancelAll_Func_03100 START`);
      await notificationManager.cancelAll().then(() => {
        console.info(`${TAG} TestCancelAll Promise success`);
      }).catch((err: BusinessError) => {
        console.info(`${TAG} TestCancelAll Promise err: ${err.code}`);
        result = false;
      })
      expect(result).assertEqual(true);
      console.info(`${TAG} SUB_NotificationManager_TestcancelAll_Func_03100 END`);
      done();
    })

    /**
     * @tc.number : SUB_NotificationManager_TestIsNotificationEnabled_Func_03200
     * @tc.name   : isNotificationEnabled
     * @tc.desc   : test notificationManager isNotificationEnabled interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestIsNotificationEnabled_Func_03200', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestIsNotificationEnabled_Func_03200 START`);
      let result = true;
      notificationManager.isNotificationEnabled((err, data) => {
        if (err) {
          console.info(`${TAG} isNotificationEnabled AsyncCallback errCode: ${err.code}, errMes: ${err.message}`);
          result = false;
          expect(err.code).assertEqual(202);
        } else {
          console.info("isNotificationEnabled success, data: " + JSON.stringify(data));
          console.info(`${TAG} isNotificationEnabled AsyncCallback success`);
        }
      });
      expect(result).assertEqual(true);
      console.info(`${TAG} SUB_NotificationManager_TestIsNotificationEnabled_Func_03200 END`);
      done();
    });

    /**
     * @tc.number : SUB_NotificationManager_TestIsNotificationEnabled_Func_03300
     * @tc.name   : isNotificationEnabled
     * @tc.desc   : use Promise test notificationManager isNotificationEnabled interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestIsNotificationEnabled_Func_03300', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestIsNotificationEnabled_Func_03300 START`);
      let result = true;
      notificationManager.isNotificationEnabled().then((data: boolean) => {
        console.info("isNotificationEnabled success, data: " + JSON.stringify(data));
        console.info(`${TAG} isNotificationEnabled Promise success`);
      }).catch((err: BusinessError) => {
        console.info(`${TAG} isNotificationEnabled Promise err: ${err.code}`);
        result = false;
      })
      expect(result).assertEqual(true);
      console.info(`${TAG} SUB_NotificationManager_TestIsNotificationEnabled_Func_03300 END`);
      done();
    })

    /**
     * @tc.number : SUB_NotificationManager_TestRequestEnableNotification_Func_03400
     * @tc.name   : requestEnableNotification
     * @tc.desc   : test notificationManager requestEnableNotification interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestRequestEnableNotification_Func_03400', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestRequestEnableNotification_Func_03400 START`);
      let result = true;
      try {
        notificationManager.requestEnableNotification((err) => {
          if (err) {
            console.info(`${TAG} requestEnableNotification AsyncCallback err: ${err.code}, errMes: ${err.message}`);
            result = false;
            done();
          } else {
            console.info(`${TAG} requestEnableNotification AsyncCallback success`);
            expect(result).assertEqual(true);
            done();
          }
        })
      } catch (err) {
        console.info(`${TAG} requestEnableNotification AsyncCallback errCode: ${err.code}, errMes: ${err.message}`);
        done();
      }
      console.info(`${TAG} SUB_NotificationManager_TestRequestEnableNotification_Func_03400 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestRequestEnableNotification_Func_03500
     * @tc.name   : requestEnableNotification
     * @tc.desc   : use Promise test notificationManager requestEnableNotification interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestRequestEnableNotification_Func_03500', 0, async (done: Function) => {
      console.info(`${TAG} SUB_NotificationManager_TestRequestEnableNotification_Func_03200 START`);
      let result = true;
      await notificationManager.requestEnableNotification().then(() => {
        console.info(`${TAG} requestEnableNotification Promise success`);
        expect(result).assertEqual(true);
        done();
      }).catch((err: BusinessError) => {
        console.info(`${TAG} requestEnableNotification Promise err: ${err.code}, errMes: ${err.message}`);
        result = false;
        done();
      })
      console.info(`${TAG} SUB_NotificationManager_TestRequestEnableNotification_Func_03500 END`);
    })

    /**
     * @tc.number : SUB_NotificationManager_TestSetBadgeNumber_Func_03600
     * @tc.name   : setBadgeNumber
     * @tc.desc   : test notificationManager setBadgeNumber interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestSetBadgeNumber_Func_03600', 0, async (done: Function) => {
      let result = true;
      try {
        notificationManager.setBadgeNumber(10, (err) => {
          if (err) {
            console.log(`setBadgeNumber failed, error code: ${err.code}, message: ${err.message}`);
            result = false;
          } else {
            console.log("setBadgeNumber success");
            expect(result).assertEqual(true);
            done();
          }
        })
      } catch (err) {
        console.log(`setBadgeNumber failed, catch error code: ${err.code}, message: ${err.message}`);
        done();
      }
    })

    /**
     * @tc.number : SUB_NotificationManager_TestSetBadgeNumber_Func_03700
     * @tc.name   : setBadgeNumber
     * @tc.desc   : test notificationManager setBadgeNumber interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestSetBadgeNumber_Func_03700', 0, async (done: Function) => {
      let result = true;
      try {
        notificationManager.setBadgeNumber(0, (err) => {
          if (err) {
            console.log(`setBadgeNumber failed, error code: ${err.code}, message: ${err.message}`);
            result = false;
          } else {
            console.log("setBadgeNumber success");
            expect(result).assertEqual(true);
            done();
          }
        })
      } catch (err) {
        console.log(`setBadgeNumber failed, catch error code: ${err.code}, message: ${err.message}`);
        done();
      }
    })

    /**
     * @tc.number : SUB_NotificationManager_TestSetBadgeNumber_Func_03800
     * @tc.name   : setBadgeNumber
     * @tc.desc   : use Promise test notificationManager setBadgeNumber interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestSetBadgeNumber_Func_03800', 0, async (done: Function) => {
      let result = true;
      try {
        await notificationManager.setBadgeNumber(10).then(() => {
          console.log("setBadgeNumber success");
          expect(result).assertEqual(true);
          done();
        }).catch((err: BusinessError) => {
          console.log(`setBadgeNumber failed, error code: ${err.code}, message: ${err.message}`);
          result = false;
        })
      } catch (err) {
        console.log(`setBadgeNumber failed, catch error code: ${err.code}, message: ${err.message}`);
        done();
      }
    })
    /**
     * @tc.number : SUB_NotificationManager_TestSetBadgeNumber_Func_03900
     * @tc.name   : setBadgeNumber
     * @tc.desc   : use Promise test notificationManager setBadgeNumber interface
     * @tc.level  : Level 1
     */
    it('SUB_NotificationManager_TestSetBadgeNumber_Func_03900', 0, async (done: Function) => {
      let result = true;
      try {
        await notificationManager.setBadgeNumber(0).then(() => {
          console.log("setBadgeNumber success");
          expect(result).assertEqual(true);
          done();
        }).catch((err: BusinessError) => {
          console.log(`setBadgeNumber failed, error code: ${err.code}, message: ${err.message}`);
          result = false;
        })
      } catch (err) {
        console.log(`setBadgeNumber failed, catch error code: ${err.code}, message: ${err.message}`);
        done();
      }
    })
  })
}