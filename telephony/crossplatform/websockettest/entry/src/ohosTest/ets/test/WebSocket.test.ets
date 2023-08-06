/**
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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect} from '@ohos/hypium'
import webSocket from '@ohos.net.webSocket'

export default function webSocketTest() {
  describe('webSocketTest', function () {
    console.log("************* webSocket Test start*************");

    /*
     * @tc.number: TEST_WEB_SOCKET_REQUEST_OPTIONS_HEADER_001
     * @tc.name  : testWebSocketRequestOptions_header001
     * @tc.desc  : webSocketRequestOptions.header
     * @tc.size  : MediumTest
     * @tc.type  : Field
     * @tc.level : Level 1
     */
    it('testWebSocketRequestOptions_header001', 0, async function (done) {
      let webSocketRequestOptions: webSocket.WebSocketRequestOptions = {
        header: "test header"
      }
      expect(webSocketRequestOptions.header === "test header").assertTrue();
      done();
    });

    /*
     * @tc.number: TEST_ON_OPEN_001
     * @tc.name  : testOn_Open001
     * @tc.desc  : Subscribe to WebSocket open events, using callback as an asynchronous method.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('testOn_Open001', 0, async function (done) {
      let ws = webSocket.createWebSocket();
      done();
      console.log("testOn_Open001: 0");
      ws.on('open', (err, value) => {
        console.log("testOn_Open001: 1");
        console.log("on open, status:" + value['status'] + ", message:" + value['message']);
        console.log("testOn_Open001: 2");
        expect(true).assertTrue();
        done();
      });
      ws.off('open');
      console.log("testOn_Open001: 3");
    });

    /*
     * @tc.number: TEST_OFF_OPEN_001
     * @tc.name  : testOff_Open001
     * @tc.desc  : Unsubscribe from WebSocket open events, using callback as an asynchronous method.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('testOff_Open001', 0, async function (done) {
      let ws = webSocket.createWebSocket();
      done();
      let callback1 = (err, value) => {
        console.log("on open, status:" + value['status'] + ", message:" + value['message']);
      }
      ws.on('open', callback1);
      ws.off('open', callback1);
      expect(true).assertTrue();
    });

    /*
     * @tc.number: TEST_ON_OFF_MESSAGE_001
     * @tc.name  : testOn_Off_Message001
     * @tc.desc  : Subscribe to WebSocket received server message events, using callback as an asynchronous method. The maximum length of each message is 4K, and more than 4K automatic fragmentation.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('testOn_Off_Message001', 0, async function (done) {
      let ws = webSocket.createWebSocket();
      done();
      ws.on('message', (err, value) => {
        console.log("on message, message:" + value);
        expect(true).assertTrue();
      });
      ws.off('message');
    });

    /*
     * @tc.number: TEST_On_Off_CLOSE_001
     * @tc.name  : testOn_Off_Close001
     * @tc.desc  : Subscribe to WebSocket shutdown events, using the callback method as an asynchronous method.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('testOn_Off_Close001', 0, async function (done) {
      let ws = webSocket.createWebSocket();
      done();
      ws.on('close', (err, value) => {
      });
      ws.off('close');
      expect(true).assertTrue();
    });

    /*
     * @tc.number: TEST_ON_OFF_ERROR_001
     * @tc.name  : testOn_Off_Error001
     * @tc.desc  : Unsubscribe to WebSocket shutdown events, using the callback method as an asynchronous method.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('testOn_Off_Error001', 0, async function (done) {
      let ws = webSocket.createWebSocket();
      done();
      ws.on('error', (err) => {
        console.log("on error, error:" + JSON.stringify(err))
      });
      ws.off('error');
      expect(true).assertTrue();
    });


  })
}