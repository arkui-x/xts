/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
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

import { describe, it, expect, beforeEach } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import webSocket from '@ohos.net.webSocket';
import deviceInfo from '@ohos.deviceInfo';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

function expectTrue(exp: boolean, info: string = ''): void {
  try {
    expect(exp).assertTrue();
  } catch (err) {
    console.info(`${info} test failed`);
  }
}

function expectFail(info: string = ''): void {
  try {
    expect().assertFail();
  } catch (err) {
    console.info(`${info} test failed`);
  }
}

function expectEqual(exp: string | number | boolean, assert: string | number | boolean, info: string = ''): void {
  try {
    expect(exp).assertEqual(assert);
  } catch (err) {
    console.info(`${info} test failed`);
  }
}


const osFullNameInfo: string = deviceInfo.osFullName
const platform = osFullNameInfo.split(' ')[0]
let platformpath : string = ''
let context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test')
let resourcePath = context.resourceDir
let filesPath = context.filesDir

if (platform == "Android") {
  platformpath = filesPath.substring(0, filesPath.length - 5) + 'arkui-x/entry_test/resources/rawfile/cer/';
} else if (platform == "iOS"){
  platformpath = context.bundleCodeDir + '/entry_test/resources/rawfile/cer/';
} else {
  platformpath = resourcePath + '/cer/';
}

let WebSocketRequestOptions: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}live.crt`,
}

let webSocketRequestOptions_default: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' }
}

let webSocketRequestOptions_caPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca.cer`
}

let webSocketRequestOptions_errorcaPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca_error.cer`
}

let webSocketRequestOptions_empty_caPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: ''
}

let WebSocketRequestOptions_clientCert_defaultKey: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  clientCert: {
    certPath: `${platformpath}client.cer`,
    keyPath: `${platformpath}client.key`
  }
}

let WebSocketRequestOptions_clientCert: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  clientCert: {
    certPath: `${platformpath}client.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorcaPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca_error.cer`,
  clientCert: {
    certPath: `${platformpath}client.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorcertPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  clientCert: {
    certPath: `${platformpath}client_error.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorcertPath_errorcaPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca_error.cer`,
  clientCert: {
    certPath: `${platformpath}client_error.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorcertPath_caPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca.cer`,
  clientCert: {
    certPath: `${platformpath}client_error.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorkeyPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  clientCert: {
    certPath: `${platformpath}client_error.cer`,
    keyPath: `${platformpath}client_error.key`,
    keyPassword: '123456'
  }
}

let WebSocketRequestOptions_clientCert_errorkeyPassword: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  clientCert: {
    certPath: `${platformpath}client.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456error'
  }
}

let WebSocketRequestOptions_clientCert_caPath: webSocket.WebSocketRequestOptions = {
  header: { 'Content-Type': 'application/json' },
  caPath: `${platformpath}ca.cer`,
  clientCert: {
    certPath: `${platformpath}client.cer`,
    keyPath: `${platformpath}client.key`,
    keyPassword: '123456'
  }
}

let ws: webSocket.WebSocket;
let availableWebSocketAddress: string = 'wss://ws.welive.huawei.com/';
let errorWebSocketAddress: string = '192.168.1.1';

export default function WebSocketApiTest() {
  describe('webSocketApiTest', () => {
    beforeEach((done: Function) => {
      ws = webSocket.createWebSocket();
      done();
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0100
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0100
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and default clientCert)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0100', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0100';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, webSocketRequestOptions_default, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectFail();
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectEqual(data, true);
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0200
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0200
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with caPath and default clientCert)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0200', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0200';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, webSocketRequestOptions_caPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectFail();
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectEqual(data, true);
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0300
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0300
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with empty caPath and default clientCert)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0300', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0300';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, webSocketRequestOptions_empty_caPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectFail();
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectEqual(data, true);
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0400
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0400
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert with default
     *             keyPassword)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0400', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0400';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_defaultKey, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code, 2302999);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0500
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0500
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0500', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0500';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectFail();
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectEqual(data, true);
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0600
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0600
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with caPath and clientCert)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0600', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0600';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_caPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectFail();
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectEqual(data, true);
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0700
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0700
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with caPath and default clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0700', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0700';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, webSocketRequestOptions_caPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302001);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0800
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0800
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with error caPath and default clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0800', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0800';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, webSocketRequestOptions_errorcaPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0900
     * @tc.name  : testNetworkMgrWebSocketConnectCallback0900
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert with default
     *             keyPassword)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0900', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_0900';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, webSocketRequestOptions_errorcaPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1000
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1000
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with default caPath and clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1000', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1000';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, WebSocketRequestOptions_clientCert, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302001);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1100
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1100
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with default caPath and clientCert with error certPath)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1100', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1100';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, WebSocketRequestOptions_clientCert_errorcertPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1200
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1200
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with default caPath and clientCert with error keyPath)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1200', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1200';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, WebSocketRequestOptions_clientCert_errorkeyPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1300
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1300
     * @tc.desc  : Establish a WebSocket connection based on the URL address(error) and
     *             options(options with default caPath and clientCert with error keyPassword)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1300', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1300';
      console.info(`${caseName} test start`);
      ws.connect(errorWebSocketAddress, WebSocketRequestOptions_clientCert_errorkeyPassword, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302001);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1400
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1400
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert with error certPath)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1400', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1400';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorcertPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1500
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1500
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert with error keyPath)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1500', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1500';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorkeyPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1600
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1600
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with default caPath and clientCert with error keyPassword)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1600', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1600';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorkeyPassword, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302999);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1700
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1700
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with caPath and error clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1700', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1700';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorcertPath_caPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1800
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1800
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with error caPath and clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1800', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1800';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorcaPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1900
     * @tc.name  : testNetworkMgrWebSocketConnectCallback1900
     * @tc.desc  : Establish a WebSocket connection based on the URL address and
     *             options(options with error caPath and error clientCert)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1900', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_ConnectCallback_WebSocketRequestOptions_1900';
      console.info(`${caseName} test start`);
      ws.connect(availableWebSocketAddress, WebSocketRequestOptions_clientCert_errorcertPath_errorcaPath, (err, data) => {
        if (err) {
          console.log(`${caseName} connect failed, err: ${JSON.stringify(err)}`);
          expectEqual(err.code,2302002);
          done();
        } else {
          console.log(`${caseName} connect success, data: ${JSON.stringify(data)}`);
          expectFail();
          done();
        }
      })
    })


    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_OnDataEnd_0100
     * @tc.name  : testNetworkMgrWebSocketOnDataEnd0100
     * @tc.desc  : Subscription to WebSocket data receiving end event(on_null)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_OnDataEnd_0100', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OnDataEnd_0100';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.on(null, () => {
          console.info(`${caseName} ondataEnd success`);
          done();
        })
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)}`);
        });
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectTrue(err.code == 401);
        done();
        console.info(`${caseName} test end`);
      }
    })

    /* *
    * @tc.number: SUB_NetworkMgr_WebSocket_OnDataEnd_0200
    * @tc.name  : testNetworkMgrWebSocketOnDataEnd0200
    * @tc.desc  : Subscription to WebSocket data receiving end event(onDataEnd)
    * @tc.level : level 0
    */
    it('SUB_NetworkMgr_WebSocket_OnDataEnd_0200', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OnDataEnd_0200';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.on('dataEnd', () => {
          console.info(`${caseName} ondataEnd success`);
          done();
        })
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)} + `);
        });
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, WebSocketRequestOptions, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectFail(`${caseName} fail,errInfo->${JSON.stringify(err)}`);
        done();
        console.info(`${caseName} test end`);
      }
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_OffDataEnd_0100
     * @tc.name  : testNetworkMgrWebSocketOffDataEnd0100
     * @tc.desc  : Unsubscribe from WebSocket data receiving end event(off_null)
     * @tc.level : level 2
     */
    it('SUB_NetworkMgr_WebSocket_OffDataEnd_0100', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OffDataEnd_0100';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)}`);
        });
        ws.on('dataEnd', () => {
          console.info(`${caseName} ondataEnd success`);
          done();
        });
        ws.off(null);
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectTrue(err.code == 401);
        done();
        console.info(`${caseName} test end`);
      }
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_OffDataEnd_0200
     * @tc.name  : testNetworkMgrWebSocketOffDataEnd0200
     * @tc.desc  : Unsubscribe from WebSocket data receiving end event(off twice)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_OffDataEnd_0200', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OffDataEnd_0200';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.on('dataEnd', () => {
          console.info(`${caseName} ondataEnd success`);
          expectFail();
          done();
        });
        ws.off('dataEnd');
        ws.off('dataEnd');
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)}`);
        });
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, WebSocketRequestOptions, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectFail(`${caseName} fail,errInfo->${JSON.stringify(err)}`);
        done();
        console.info(`${caseName} test end`);
      }
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_OffDataEnd_0300
     * @tc.name  : testNetworkMgrWebSocketOffDataEnd0300
     * @tc.desc  : Unsubscribe from WebSocket data receiving end event(off--on)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_OffDataEnd_0300', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OffDataEnd_0300';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.off('dataEnd');
        ws.on('dataEnd', () => {
          console.info(`${caseName} ondataEnd success`);
          done();
        });
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)}`);
        });
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, WebSocketRequestOptions, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectFail(`${caseName} fail,errInfo->${JSON.stringify(err)}`);
        done();
        console.info(`${caseName} test end`);
      }
    })

    /* *
     * @tc.number: SUB_NetworkMgr_WebSocket_OffDataEnd_0400
     * @tc.name  : testNetworkMgrWebSocketOffDataEnd0400
     * @tc.desc  : Unsubscribe from WebSocket data receiving end event(on--off)
     * @tc.level : level 0
     */
    it('SUB_NetworkMgr_WebSocket_OffDataEnd_0400', 0, async (done: Function) => {
      let caseName: string = 'SUB_NetworkMgr_WebSocket_OffDataEnd_0400';
      console.info(`${caseName} test start`);
      try {
        class OutValue {
          status: number = 0
          message: string = ""
        }
        ws.on('dataEnd', () => {
          console.info(`${caseName} ondataEnd success`);
          expectFail();
          done();
        });
        ws.off('dataEnd');
        ws.on('error', (err: BusinessError) => {
          console.info(`${caseName} findError + ${JSON.stringify(err)}`);
        });
        ws.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
          console.info(`${caseName} onmessage err is ${JSON.stringify(err)} and value is ${value}`);
          expectTrue(value != null);
          done();
        });
        ws.on('open', (err: BusinessError, value: Object) => {
          console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
          const status: number = (value as OutValue).status;
          expectEqual(status,101);
          ws.send('Hello', (err: BusinessError, value: boolean) => {
            if (err) {
              console.info(`${caseName} send fail ${JSON.stringify(err)}`);
              expectFail(`${caseName} send fail`);
              done();
              console.info(`${caseName} test end`);
            } else {
              console.info(`${caseName} send success and value is ${value}`);
              expectTrue(value);
              done();
              console.info(`${caseName} test end`);
            }
          })
        });
        ws.connect(availableWebSocketAddress, WebSocketRequestOptions, (err: BusinessError, value: boolean) => {
          if (err) {
            console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
            expectFail(`${caseName} test connect fail`);
            done();
            console.info(`${caseName} test end`);
          } else {
            console.info(`${caseName} test connect success and value is ${value}`);
          }
        })
      } catch (err) {
        console.info(`${caseName} catchError ${JSON.stringify(err)}`);
        expectFail(`${caseName} fail,errInfo->${JSON.stringify(err)}`);
        done();
        console.info(`${caseName} test end`);
      }
    })
  });
}