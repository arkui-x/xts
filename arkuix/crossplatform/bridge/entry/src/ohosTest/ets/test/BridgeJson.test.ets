/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import bridge from '@arkui-x.bridge';
import { BusinessError } from '@kit.BasicServicesKit';

const WAIT_READY_MS_1000: number = 1000;
const WAIT_READY_MS_300: number = 300;
const ERROR_CODE_OK: number = 0;
const ERROR_MESSAGE_OK: string = "Correct!";
const ERROR_CODE_METHOD: number = 6;
const ERROR_MESSAGE_METHOD: string = "Method not implemented!";
const ERROR_CODE_PARAMS: number = 7;
const gBridges = new Map<string, bridge.BridgeObject>();

function getOrCreateBridgeJSON(name: string, type: bridge.BridgeType): bridge.BridgeObject {
  let obj = gBridges.get(name);
  if (!obj) {
    obj = bridge.createBridge(name, type);
    gBridges.set(name, obj);
  }
  return obj;
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const bridgeObject: bridge.BridgeObject = getOrCreateBridgeJSON("testXts", bridge.BridgeType.JSON_TYPE);
const bridgeObjectCallBack: bridge.BridgeObject = getOrCreateBridgeJSON("testXtsCallBack", bridge.BridgeType.JSON_TYPE);
const bridgeObjectCallMethod: bridge.BridgeObject =
  getOrCreateBridgeJSON("testXtsCallMethod", bridge.BridgeType.JSON_TYPE);
const bridgeObjectError: bridge.BridgeObject = getOrCreateBridgeJSON("testXtsError", bridge.BridgeType.JSON_TYPE);

export default function BridgeJsonTest() {
  let bridgeObjectTest: bridge.BridgeObject;
  describe('ActsBridgeJsonTest', () => {
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300);
    });

    /**
     * @tc.number ArkUIX_Bridge_JsonCreateBridge_0100
     * @tc.name ArkUIX_Bridge_JsonCreateBridge_0100
     * @tc.desc Test Bridge Json createBridge function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCreateBridge_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let bridgeName: string = "testCreateBridgeJson";
        bridgeObjectTest =
          bridge.createBridge("testCreateBridgeJson", bridge.BridgeType.JSON_TYPE);
        expect((bridgeObjectTest != null) && (bridgeObjectTest != undefined)).assertEqual(true);
        expect(bridgeObjectTest.bridgeName).assertEqual(bridgeName);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCreateBridge_0200
     * @tc.name ArkUIX_Bridge_JsonCreateBridge_0200
     * @tc.desc Test Bridge Json createBridge function (empty bridge name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCreateBridge_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge("", bridge.BridgeType.JSON_TYPE);
        expect(bridgeObjectTest == undefined).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCreateBridge_0300
     * @tc.name ArkUIX_Bridge_JsonCreateBridge_0300
     * @tc.desc Test Bridge Json createBridge function (null bridge name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCreateBridge_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge(null, bridge.BridgeType.JSON_TYPE);
        expect(bridgeObjectTest == undefined).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCreateBridge_0400
     * @tc.name ArkUIX_Bridge_JsonCreateBridge_0400
     * @tc.desc Test Bridge Json createBridge function (invalid bridge type)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCreateBridge_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let errorType: number = 99;
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge("testCreateBridgeJson400", errorType);
        expect(bridgeObjectTest == undefined).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0100
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0100
     * @tc.desc Test Bridge Json sendMessage function (promise, string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: string | undefined = "";
        bridgeObject.sendMessage("test sendMessage 0010").then((data: bridge.ResultValue) => {
          result = data?.toString();
          expect(result).assertEqual("test sendMessage 0010");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0200
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0200
     * @tc.desc Test Bridge Json sendMessage function (promise, boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: bridge.ResultValue = false;
        bridgeObject.sendMessage(true).then((data: bridge.ResultValue) => {
          result = data;
          expect(result).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0300
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0300
     * @tc.desc Test Bridge Json sendMessage function (promise, number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage(100).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0400
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0400
     * @tc.desc Test Bridge Json sendMessage function (promise, string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeObject.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<string>;
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0500
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0500
     * @tc.desc Test Bridge Json sendMessage function (promise, boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeObject.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<boolean>;
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0600
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0600
     * @tc.desc Test Bridge Json sendMessage function (promise, number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeObject.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<number>;
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0700
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0700
     * @tc.desc Test Bridge Json sendMessage function (promise, null)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage(null).then((data: bridge.ResultValue) => {
          expect(data?.toString()).assertEqual("arkTS sendMessage null");
          done();
        }).catch((error: BusinessError) => {
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0800
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0800
     * @tc.desc Test Bridge Json sendMessage function (callback, string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage("test sendMessage 0080", (error, data: bridge.Response) => {
          let result = data?.toString();
          expect(result).assertEqual("test sendMessage 0080");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_0900
     * @tc.name ArkUIX_Bridge_JsonSendMessage_0900
     * @tc.desc Test Bridge Json sendMessage function (callback, boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage(true, (error, data: bridge.ResultValue) => {
          expect(data).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1000
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1000
     * @tc.desc Test Bridge Json sendMessage function (callback, number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage(100, (error, data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1100
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1100
     * @tc.desc Test Bridge Json sendMessage function (callback, string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeObject.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<string>;
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1200
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1200
     * @tc.desc Test Bridge Json sendMessage function (callback, boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeObject.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<boolean>;
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1300
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1300
     * @tc.desc Test Bridge Json sendMessage function (callback, number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeObject.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<number>;
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1400
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1400
     * @tc.desc Test Bridge Json sendMessage function (callback, null)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObject.sendMessage(null, (error, data: bridge.ResultValue) => {
          let result = data?.toString()
          expect(result).assertEqual("arkTS sendMessage null");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1500
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1500
     * @tc.desc Test Bridge Json sendMessage function (callback, MAX_SAFE_INTEGER)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let max_number: number = Number.MAX_SAFE_INTEGER;
        bridgeObject.sendMessage(max_number, (error, data: bridge.ResultValue) => {
          let result = data as number;
          expect(result).assertEqual(max_number);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSendMessage_1600
     * @tc.name ArkUIX_Bridge_JsonSendMessage_1600
     * @tc.desc Test Bridge Json sendMessage function (callback, MIN_SAFE_INTEGER)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSendMessage_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let mix_number: number = Number.MIN_SAFE_INTEGER;
        bridgeObject.sendMessage(mix_number, (error, data: bridge.ResultValue) => {
          let result = data as number;
          expect(result).assertEqual(mix_number);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonSetMessageListener_0100
     * @tc.name ArkUIX_Bridge_JsonSetMessageListener_0100
     * @tc.desc Test Bridge Json setMessageListener function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonSetMessageListener_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let callback: (message: bridge.Message) => bridge.Response = (message: bridge.Message) => {
          expect(message).assertEqual("setMessageListener success");
          return '';
        }
        bridgeObjectCallBack.setMessageListener(callback);
        bridgeObjectCallBack.sendMessage("test setMessageListener");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0100
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0100
     * @tc.desc Test Bridge Json callMethod function (promise, no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeObjectCallMethod.callMethod("callMethodT0010").then((data: bridge.ResultValue) => {
          let result = data?.toString();
          expect(result).assertEqual("callMethodT0010 call success");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0200
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0200
     * @tc.desc Test Bridge Json callMethod function (promise, string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: string = "callMethodT0020 call success";
        bridgeObjectCallMethod.callMethod("callMethodT0020", param).then((data: bridge.ResultValue) => {
          let result = data?.toString();
          expect(result).assertEqual("callMethodT0020 call success");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0300
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0300
     * @tc.desc Test Bridge Json callMethod function (promise, boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeObjectCallMethod.callMethod("callMethodT0030", true).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0400
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0400
     * @tc.desc Test Bridge Json callMethod function (promise, number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeObjectCallMethod.callMethod("callMethodT0040", 100).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0500
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0500
     * @tc.desc Test Bridge Json callMethod function (promise, string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeObjectCallMethod.callMethod("callMethodT0050", param).then((data: bridge.ResultValue) => {
          let result = data as Array<string>;
          if (result == null || result.length == 0) {
            expect().assertFail();
          } else {
            expect(result[0]).assertEqual("hello");
            expect(result[1]).assertEqual("world");
          }
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0600
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0600
     * @tc.desc Test Bridge Json callMethod function (promise, boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeObjectCallMethod.callMethod("callMethodT0060", param).then((data: bridge.ResultValue) => {
          let result = data as Array<boolean>;
          if (result == null || result.length == 0) {
            expect().assertFail();
          } else {
            expect(result[0]).assertEqual(false);
            expect(result[1]).assertEqual(true);
          }
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethod_0700
     * @tc.name ArkUIX_Bridge_JsonCallMethod_0700
     * @tc.desc Test Bridge Json callMethod function (promise, number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethod_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeObjectCallMethod.callMethod("callMethodT0070", param).then((data: bridge.ResultValue) => {
          let result = data as Array<number>;
          if (result == null || result.length == 0) {
            expect().assertFail();
          } else {
            expect(result[0]).assertEqual(100);
            expect(result[1]).assertEqual(200);
          }
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodError_0100
     * @tc.name ArkUIX_Bridge_JsonCallMethodError_0100
     * @tc.desc Test Bridge Json callMethod function (promise, error method name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodError_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeObjectError.callMethod("errorMethodName").then((data: bridge.ResultValue) => {
          expect().assertFail();
          done();
        }).catch((error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_METHOD);
          expect(error.message).assertEqual("Method not implemented!");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodError_0200
     * @tc.name ArkUIX_Bridge_JsonCallMethodError_0200
     * @tc.desc Test Bridge Json callMethod function (promise, invalid params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodError_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeObjectError.callMethod("callMethodT0010", "error param").then((data: bridge.ResultValue) => {
          expect().assertFail();
          done();
        }).catch((error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_PARAMS);
          expect(error.message).assertEqual("Method parameter error!");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0100
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0100
     * @tc.desc Test Bridge Json callMethodSync function (sync, no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: bridge.ResultValue = "";
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0010");
        expect(result?.toString()).assertEqual("callMethodSyncT0010 call success");
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0200
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0200
     * @tc.desc Test Bridge Json callMethodSync function (sync, string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: bridge.ResultValue = "";
        let param = "callMethodSyncT0020 call success"
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0020", param);
        expect(result?.toString()).assertEqual("callMethodSyncT0020 call success");
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0300
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0300
     * @tc.desc Test Bridge Json callMethodSync function (sync, boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: bridge.ResultValue = false;
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0030", true);
        expect(result).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0400
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0400
     * @tc.desc Test Bridge Json callMethodSync function (sync, number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: bridge.ResultValue = 0;
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0040", 100);
        expect(result).assertEqual(100);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0500
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0500
     * @tc.desc Test Bridge Json callMethodSync function (sync, string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: Array<string> = [];
        let param: Array<string> = ["hello", "world"];
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0050", param) as Array<string>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0600
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0600
     * @tc.desc Test Bridge Json callMethodSync function (sync, boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: Array<boolean> = [];
        let param: Array<boolean> = [false, true];
        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0060", param) as Array<boolean>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSync_0700
     * @tc.name ArkUIX_Bridge_JsonCallMethodSync_0700
     * @tc.desc Test Bridge Json callMethodSync function (sync, number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSync_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let result: Array<number> = [];
        let param: Array<number> = [100, 200];

        result = bridgeObjectCallMethod.callMethodSync("callMethodSyncT0070", param) as Array<number>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSyncError_0100
     * @tc.name ArkUIX_Bridge_JsonCallMethodSyncError_0100
     * @tc.desc Test Bridge Json callMethodSync function (sync, error method name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSyncError_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          bridgeObjectError.callMethodSync("errorMethodName");
          expect().assertFail();
          done();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_METHOD);
          expect(error.message).assertEqual("Method not implemented!");
          done();
        }
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodSyncError_0200
     * @tc.name ArkUIX_Bridge_JsonCallMethodSyncError_0200
     * @tc.desc Test Bridge Json callMethodSync function (sync, invalid params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodSyncError_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          bridgeObjectError.callMethodSync("callMethodSyncT0010", "error param");
          expect().assertFail();
          done();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_PARAMS);
          expect(error.message).assertEqual("Method parameter error!");
          done();
        }
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0100
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0100
     * @tc.desc Test Bridge Json registerMethod function (string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let method: bridge.MethodData = {
          name: "arkTsMethod",
          method: (param: bridge.Parameter): bridge.ResultValue => {
            let result = param?.toString();
            expect(result).assertEqual("arkTsMethod call success");
            return "";
          }
        }
        bridgeObjectCallBack.registerMethod(method);
        bridgeObjectCallBack.sendMessage("test registerMethod");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0200
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0200
     * @tc.desc Test Bridge Json registerMethod function (string, shorthand)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testRegisterMethod0020 = (param: string): bridge.ResultValue => {
          expect(param?.toString()).assertEqual("testRegisterMethod0020 call success");
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0020", method: testRegisterMethod0020 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0020");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0300
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0300
     * @tc.desc Test Bridge Json registerMethod function (boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testRegisterMethod0030 = (param: boolean): bridge.ResultValue => {
          expect(param).assertEqual(true);
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0030", method: testRegisterMethod0030 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0030");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0400
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0400
     * @tc.desc Test Bridge Json registerMethod function (number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testRegisterMethod0040 = (param: number): bridge.ResultValue => {
          expect(param).assertEqual(123);
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0040", method: testRegisterMethod0040 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0040");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0500
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0500
     * @tc.desc Test Bridge Json registerMethod function (string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0050 = (param: Array<string>): bridge.ResultValue => {
          expect(param[0]).assertEqual("hello");
          expect(param[1]).assertEqual("world");
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0050", method: testRegisterMethod0050 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0050");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0600
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0600
     * @tc.desc Test Bridge Json registerMethod function (boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0060 = (param: Array<boolean>): bridge.ResultValue => {
          expect(param[0]).assertEqual(false);
          expect(param[1]).assertEqual(true);
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0060", method: testRegisterMethod0060 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0060");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonRegisterMethod_0700
     * @tc.name ArkUIX_Bridge_JsonRegisterMethod_0700
     * @tc.desc Test Bridge Json registerMethod function (number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonRegisterMethod_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0070 = (param: Array<number>): bridge.ResultValue => {
          expect(param[0]).assertEqual(100);
          expect(param[1]).assertEqual(200);
          return "call success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testRegisterMethod0070", method: testRegisterMethod0070 });
        bridgeObjectCallBack.sendMessage("testRegisterMethod0070");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0100
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0100
     * @tc.desc Test Bridge Json callMethodWithCallback function (no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let methodName: string = "callMethodWithCallbackT0010";
        let method: (...parameters: Array<bridge.Parameter>) => bridge.ResultValue =
          (param: bridge.Parameter): bridge.ResultValue => {
            let result = param?.toString();
            expect(result).assertEqual("arkTsMethodWithCallback call success");
            return "";
          }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method).then((result: bridge.ResultValue) => {
          expect(result?.toString()).assertEqual("callMethodWithCallbackT0010 call success");
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0200
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0200
     * @tc.desc Test Bridge Json callMethodWithCallback function (string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let data: string = "callMethodWithCallbackT0020 call success";
        let methodName: string = "callMethodWithCallbackT0020";
        let method = (param: string): bridge.ResultValue => {
          expect(param?.toString()).assertEqual(data);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result?.toString()).assertEqual(data);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0300
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0300
     * @tc.desc Test Bridge Json callMethodWithCallback function (boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let data: boolean = true;
        let methodName: string = "callMethodWithCallbackT0030";
        let method = (param: boolean): bridge.ResultValue => {
          expect(param).assertEqual(data);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result).assertEqual(data);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0400
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0400
     * @tc.desc Test Bridge Json callMethodWithCallback function (number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let data: number = 100;
        let methodName: string = "callMethodWithCallbackT0040";
        let method = (param: number): bridge.ResultValue => {
          expect(param).assertEqual(data);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result).assertEqual(data);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0500
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0500
     * @tc.desc Test Bridge Json callMethodWithCallback function (string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let data: Array<string> = ["hello", "world"];
        let methodName: string = "callMethodWithCallbackT0050";
        let method = (param: Array<string>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          let resData = result as Array<string>;
          expect(resData[0]).assertEqual(data[0]);
          expect(resData[1]).assertEqual(data[1]);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0600
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0600
     * @tc.desc Test Bridge Json callMethodWithCallback function (boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let data: Array<boolean> = [false, true];
        let methodName: string = "callMethodWithCallbackT0060";
        let method = (param: Array<boolean>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          let res = result as Array<boolean>;
          expect(res[0]).assertEqual(data[0]);
          expect(res[1]).assertEqual(data[1]);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonCallMethodWithCallback_0700
     * @tc.name ArkUIX_Bridge_JsonCallMethodWithCallback_0700
     * @tc.desc Test Bridge Json callMethodWithCallback function (number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonCallMethodWithCallback_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let data: Array<number> = [100, 200];
        let methodName: string = "callMethodWithCallbackT0070";
        let method = (param: Array<number>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeObjectCallBack.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          let res = result as Array<number>;
          expect(res[0]).assertEqual(data[0]);
          expect(res[1]).assertEqual(data[1]);
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonUnRegisterMethod_0100
     * @tc.name ArkUIX_Bridge_JsonUnRegisterMethod_0100
     * @tc.desc Test Bridge Json unRegisterMethod function (Promise)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonUnRegisterMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testUnRegister", method: method });
        await bridgeObjectCallBack.unRegisterMethod("testUnRegister").then(() => {
          expect(true).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          expect().assertFail();
          done();
        });
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonUnRegisterMethod_0200
     * @tc.name ArkUIX_Bridge_JsonUnRegisterMethod_0200
     * @tc.desc Test Bridge Json unRegisterMethod with unregistered method (Promise)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonUnRegisterMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        await bridgeObjectCallBack.unRegisterMethod("testUnRegister").then(() => {
          expect().assertFail();
          done();
        }).catch((error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_METHOD)
          expect(error.message).assertEqual(ERROR_MESSAGE_METHOD)
          done();
        });
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonUnRegisterMethod_0300
     * @tc.name ArkUIX_Bridge_JsonUnRegisterMethod_0300
     * @tc.desc Test Bridge Json unRegisterMethod function (callback)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonUnRegisterMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        bridgeObjectCallBack.registerMethod({ name: "testUnRegister", method: method });
        bridgeObjectCallBack.unRegisterMethod("testUnRegister", (error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_OK)
          expect(error.message).assertEqual(ERROR_MESSAGE_OK)
          done();
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_JsonUnRegisterMethod_0400
     * @tc.name ArkUIX_Bridge_JsonUnRegisterMethod_0400
     * @tc.desc Test Bridge Json unRegisterMethod with unregistered method (callback)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_JsonUnRegisterMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        bridgeObjectCallBack.unRegisterMethod("UnregisteredMethod", (error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_METHOD)
          expect(error.message).assertEqual(ERROR_MESSAGE_METHOD)
          done();
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })
  })
}
