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

const WAIT_READY_MS_1000: number = 1000
const WAIT_READY_MS_300: number = 300
const ERROR_CODE_OK: number = 0;
const ERROR_MESSAGE_OK: string = "Correct!";
const ERROR_CODE_METHOD: number = 6;
const ERROR_MESSAGE_METHOD: string = "Method not implemented!";
const ERROR_CODE_PARAMS: number = 7;
const gBridges = new Map<string, bridge.BridgeObject>();

function getOrCreateBridge(name: string, type: bridge.BridgeType): bridge.BridgeObject {
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

const bridgeObjectBinary: bridge.BridgeObject = getOrCreateBridge("testXtsBinary", bridge.BridgeType.BINARY_TYPE);
const bridgeBinaryError: bridge.BridgeObject = getOrCreateBridge("testXtsBinaryError", bridge.BridgeType.BINARY_TYPE);
const bridgeBinaryCallMethod: bridge.BridgeObject =
  getOrCreateBridge("testXtsBinaryCallMethod", bridge.BridgeType.BINARY_TYPE);
const bridgeBinaryCallBack: bridge.BridgeObject =
  getOrCreateBridge("testXtsBinaryCallBack", bridge.BridgeType.BINARY_TYPE);

export default function BridgeBinaryTest() {
  describe('ActsBridgeBinaryTest', () => {
    let bridgeObjectTest: bridge.BridgeObject;

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
     * @tc.number ArkUIX_Bridge_BinaryCreateBridge_0100
     * @tc.name ArkUIX_Bridge_BinaryCreateBridge_0100
     * @tc.desc Test Bridge Binary createBridge function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCreateBridge_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let bridgeName: string = "testCreateBridgeBinary";
        bridgeObjectTest = bridge.createBridge("testCreateBridgeBinary", bridge.BridgeType.BINARY_TYPE);
        expect((bridgeObjectTest != null) && (bridgeObjectTest != undefined)).assertEqual(true);
        expect(bridgeObjectTest.bridgeName).assertEqual(bridgeName);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCreateBridge_0200
     * @tc.name ArkUIX_Bridge_BinaryCreateBridge_0200
     * @tc.desc Test Bridge Binary createBridge function (empty bridge name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCreateBridge_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge("", bridge.BridgeType.BINARY_TYPE);
        expect(bridgeObjectTest == undefined).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCreateBridge_0300
     * @tc.name ArkUIX_Bridge_BinaryCreateBridge_0300
     * @tc.desc Test Bridge Binary createBridge function (null bridge name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCreateBridge_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge(null, bridge.BridgeType.BINARY_TYPE);
        expect(bridgeObjectTest == undefined).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCreateBridge_0400
     * @tc.name ArkUIX_Bridge_BinaryCreateBridge_0400
     * @tc.desc Test Bridge Binary createBridge function (invalid bridge type)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCreateBridge_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let errorType: number = 99;
        let bridgeObjectTest: bridge.BridgeObject = bridge.createBridge("testCreateBridgeBinary400", errorType);
        expect((bridgeObjectTest == undefined) || bridgeObjectTest == null).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0100
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0100
     * @tc.desc Test Bridge Binary callMethod function (promise, no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeBinaryCallMethod.callMethod("callMethodT0010").then((data: bridge.ResultValue) => {
          let result = data?.toString();
          expect(result).assertEqual("callMethodT0010 call success");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0200
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0200
     * @tc.desc Test Bridge Binary callMethod function (promise, string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {

        bridgeBinaryCallMethod.callMethod("callMethodT0020", "callMethodT0010 call success")
          .then((data: bridge.ResultValue) => {
            let result = data?.toString();
            expect(result).assertEqual("callMethodT0010 call success");
            done();
          });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0300
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0300
     * @tc.desc Test Bridge Binary callMethod function (promise, boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeBinaryCallMethod.callMethod("callMethodT0030", true).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0400
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0400
     * @tc.desc Test Bridge Binary callMethod function (promise, number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        bridgeBinaryCallMethod.callMethod("callMethodT0040", 100).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        })
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0500
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0500
     * @tc.desc Test Bridge Binary callMethod function (promise, string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeBinaryCallMethod.callMethod("callMethodT0050", param).then((data: bridge.ResultValue) => {
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
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0600
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0600
     * @tc.desc Test Bridge Binary callMethod function (promise, boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeBinaryCallMethod.callMethod("callMethodT0060", param).then((data: bridge.ResultValue) => {
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
     * @tc.number ArkUIX_Bridge_BinaryCallMethod_0700
     * @tc.name ArkUIX_Bridge_BinaryCallMethod_0700
     * @tc.desc Test Bridge Binary callMethod function (promise, number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethod_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeBinaryCallMethod.callMethod("callMethodT0070", param).then((data: bridge.ResultValue) => {
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
     * @tc.number ArkUIX_Bridge_BinaryCallMethodError_0100
     * @tc.name ArkUIX_Bridge_BinaryCallMethodError_0100
     * @tc.desc Test Bridge Binary callMethod function (promise, error method name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodError_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        bridgeBinaryError.callMethod("errorMethodName").then((data: bridge.ResultValue) => {
          expect().assertFail();
          done();
        }).catch((error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_METHOD);
          expect(error.message).assertEqual("Method not implemented!");
          done();
        })
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodError_0200
     * @tc.name ArkUIX_Bridge_BinaryCallMethodError_0200
     * @tc.desc Test Bridge Binary callMethod function (promise, invalid params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodError_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        bridgeBinaryError.callMethod("callMethodT0010", "error param").then((data: bridge.ResultValue) => {
          expect().assertFail();
          done();
        }).catch((error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_PARAMS);
          expect(error.message).assertEqual("Method parameter error!");
          done();
        })
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0100
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0100
     * @tc.desc Test Bridge Binary sendMessage function (promise, string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage("test sendMessage 0010").then((data: bridge.ResultValue) => {
          let result = data?.toString();
          expect(result).assertEqual("test sendMessage 0010");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0200
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0200
     * @tc.desc Test Bridge Binary sendMessage function (promise, boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(true).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0300
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0300
     * @tc.desc Test Bridge Binary sendMessage function (promise, number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(100).then((data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0400
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0400
     * @tc.desc Test Bridge Binary sendMessage function (promise, string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeObjectBinary.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<string>;
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0500
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0500
     * @tc.desc Test Bridge Binary sendMessage function (promise, boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeObjectBinary.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<boolean>;
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0600
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0600
     * @tc.desc Test Bridge Binary sendMessage function (promise, number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeObjectBinary.sendMessage(param).then((data: bridge.ResultValue) => {
          let result = data as Array<number>;
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0700
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0700
     * @tc.desc Test Bridge Binary sendMessage function (promise, null)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(null).then((data: bridge.ResultValue) => {
          let result = data?.toString();
          expect(result?.toString()).assertEqual("arkTS sendMessage null");
          done();
        })
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0800
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0800
     * @tc.desc Test Bridge Binary sendMessage function (callback, string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage("test sendMessage 0080", (error, data: bridge.Response) => {
          let result = data?.toString();
          expect(result).assertEqual("test sendMessage 0080");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_0900
     * @tc.name ArkUIX_Bridge_BinarySendMessage_0900
     * @tc.desc Test Bridge Binary sendMessage function (callback, boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(true, (error, data: bridge.ResultValue) => {
          expect(data).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1000
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1000
     * @tc.desc Test Bridge Binary sendMessage function (callback, number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(100, (error, data: bridge.ResultValue) => {
          expect(data).assertEqual(100);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1100
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1100
     * @tc.desc Test Bridge Binary sendMessage function (callback, string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<string> = ["hello", "world"];
        bridgeObjectBinary.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<string>;
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1200
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1200
     * @tc.desc Test Bridge Binary sendMessage function (callback, boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<boolean> = [false, true];
        bridgeObjectBinary.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<boolean>;
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1300
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1300
     * @tc.desc Test Bridge Binary sendMessage function (callback, number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let param: Array<number> = [100, 200];
        bridgeObjectBinary.sendMessage(param, (error, data: bridge.ResultValue) => {
          let result = data as Array<number>;
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1400
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1400
     * @tc.desc Test Bridge Binary sendMessage function (callback, null)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        bridgeObjectBinary.sendMessage(null, (error, data: bridge.ResultValue) => {
          let result = data?.toString()
          expect(result).assertEqual("arkTS sendMessage null");
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1500
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1500
     * @tc.desc Test Bridge Binary sendMessage function (callback, MAX_SAFE_INTEGER)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let max_number: number = Number.MAX_SAFE_INTEGER;
        bridgeObjectBinary.sendMessage(max_number, (error, data: bridge.ResultValue) => {
          let result = data as number;
          expect(result).assertEqual(max_number);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySendMessage_1600
     * @tc.name ArkUIX_Bridge_BinarySendMessage_1600
     * @tc.desc Test Bridge Binary sendMessage function (callback, MIN_SAFE_INTEGER)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySendMessage_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let mix_number: number = Number.MIN_SAFE_INTEGER;
        bridgeObjectBinary.sendMessage(mix_number, (error, data: bridge.ResultValue) => {
          let result = data as number;
          expect(result).assertEqual(mix_number);
          done();
        });
      })

    /**
     * @tc.number ArkUIX_Bridge_BinarySetMessageListener_0100
     * @tc.name ArkUIX_Bridge_BinarySetMessageListener_0100
     * @tc.desc Test Bridge Binary setMessageListener function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinarySetMessageListener_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let callback: (message: bridge.Message) => bridge.Response = (message: bridge.Message) => {
          expect(message).assertEqual("setMessageListener success");
          return '';
        }
        bridgeObjectBinary.setMessageListener(callback);
        bridgeObjectBinary.sendMessage("test setMessageListener");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0100
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0100
     * @tc.desc Test Bridge Binary callMethodSync function (sync, no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: bridge.ResultValue = "";
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0010");
        expect(result?.toString()).assertEqual("callMethodSyncT0010 call success");
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0200
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0200
     * @tc.desc Test Bridge Binary callMethodSync function (sync, string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: bridge.ResultValue = "";
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0020", "callMethodSyncT0020 call success");
        expect(result?.toString()).assertEqual("callMethodSyncT0020 call success");
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0300
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0300
     * @tc.desc Test Bridge Binary callMethodSync function (sync, boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: bridge.ResultValue = false;
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0030", true);
        expect(result).assertEqual(true);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0400
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0400
     * @tc.desc Test Bridge Binary callMethodSync function (sync, number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: bridge.ResultValue = 0;
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0040", 100);
        expect(result).assertEqual(100);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0500
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0500
     * @tc.desc Test Bridge Binary callMethodSync function (sync, string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: Array<string> = [];
        let param: Array<string> = ["hello", "world"];
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0050", param) as Array<string>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual("hello");
          expect(result[1]).assertEqual("world");
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0600
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0600
     * @tc.desc Test Bridge Binary callMethodSync function (sync, boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: Array<boolean> = [];
        let param: Array<boolean> = [false, true];
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0060", param) as Array<boolean>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual(false);
          expect(result[1]).assertEqual(true);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSync_0700
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSync_0700
     * @tc.desc Test Bridge Binary callMethodSync function (sync, number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSync_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let result: Array<number> = [];
        let param: Array<number> = [100, 200];
        result = bridgeBinaryCallMethod.callMethodSync("callMethodSyncT0070", param) as Array<number>;
        if (result == null || result.length == 0) {
          expect().assertFail();
        } else {
          expect(result[0]).assertEqual(100);
          expect(result[1]).assertEqual(200);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSyncError_0100
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSyncError_0100
     * @tc.desc Test Bridge Binary callMethodSync function (sync, error method name)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSyncError_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          bridgeBinaryError.callMethodSync("errorMethodName");
          expect().assertFail();
          done();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_METHOD);
          expect(error.message).assertEqual("Method not implemented!");
          done();
        }
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodSyncError_0200
     * @tc.name ArkUIX_Bridge_BinaryCallMethodSyncError_0200
     * @tc.desc Test Bridge Binary callMethodSync function (sync, invalid params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodSyncError_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          bridgeBinaryError.callMethodSync("callMethodSyncT0010", "error param");
          expect().assertFail();
          done();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_PARAMS);
          expect(error.message).assertEqual("Method parameter error!");
          done();
        }
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0100
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0100
     * @tc.desc Test Bridge Binary registerMethod function (string)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let method: bridge.MethodData = {
          name: "arkTsMethod",
          method: (param: bridge.Parameter): bridge.ResultValue => {
            let result = param?.toString();
            expect(result).assertEqual("arkTsMethod call success");
            return "";
          }
        }
        bridgeBinaryCallBack.registerMethod(method);
        bridgeBinaryCallBack.sendMessage("test registerMethod");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0200
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0200
     * @tc.desc Test Bridge Binary registerMethod function (string, shorthand)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testRegisterMethod0020 = (param: string): bridge.ResultValue => {
          expect(param?.toString()).assertEqual("testRegisterMethod0020 call success");
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0020", method: testRegisterMethod0020 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0020");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0300
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0300
     * @tc.desc Test Bridge Binary registerMethod function (boolean)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0030 = (param: boolean): bridge.ResultValue => {
          expect(param).assertEqual(true);
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0030", method: testRegisterMethod0030 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0030");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0400
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0400
     * @tc.desc Test Bridge Binary registerMethod function (number)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0040 = (param: number): bridge.ResultValue => {
          expect(param).assertEqual(123);
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0040", method: testRegisterMethod0040 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0040");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0500
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0500
     * @tc.desc Test Bridge Binary registerMethod function (string array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0050 = (param: Array<string>): bridge.ResultValue => {
          expect(param[0]).assertEqual("hello");
          expect(param[1]).assertEqual("world");
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0050", method: testRegisterMethod0050 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0050");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0600
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0600
     * @tc.desc Test Bridge Binary registerMethod function (boolean array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0060 = (param: Array<boolean>): bridge.ResultValue => {
          expect(param[0]).assertEqual(false);
          expect(param[1]).assertEqual(true);
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0060", method: testRegisterMethod0060 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0060");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryRegisterMethod_0700
     * @tc.name ArkUIX_Bridge_BinaryRegisterMethod_0700
     * @tc.desc Test Bridge Binary registerMethod function (number array)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryRegisterMethod_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let testRegisterMethod0070 = (param: Array<number>): bridge.ResultValue => {
          expect(param[0]).assertEqual(100);
          expect(param[1]).assertEqual(200);
          return "call success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testRegisterMethod0070", method: testRegisterMethod0070 });
        bridgeBinaryCallBack.sendMessage("testRegisterMethod0070");
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0100
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0100
     * @tc.desc Test Bridge Binary callMethodWithCallback function (no params)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let methodName: string = "callMethodWithCallbackT0010";
        let method: (...parameters: Array<bridge.Parameter>) => bridge.ResultValue =
          (param: bridge.Parameter): bridge.ResultValue => {
            let result = param?.toString();
            expect(result).assertEqual("arkTsMethodWithCallback call success");
            return "";
          }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method).then((data: bridge.ResultValue) => {
          expect(data?.toString()).assertEqual("callMethodWithCallbackT0010 call success");
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0200
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0200
     * @tc.desc Test Bridge Binary callMethodWithCallback function (string param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: string = "callMethodWithCallbackT0020 call success";
        let methodName: string = "callMethodWithCallbackT0020";
        let method = (param: string): bridge.ResultValue => {
          expect(param?.toString()).assertEqual(data);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result?.toString()).assertEqual(data);
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0300
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0300
     * @tc.desc Test Bridge Binary callMethodWithCallback function (boolean param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: boolean = true;
        let methodName: string = "callMethodWithCallbackT0030";
        let method = (param: boolean): bridge.ResultValue => {
          expect(param).assertEqual(data);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result).assertEqual(data);
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0400
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0400
     * @tc.desc Test Bridge Binary callMethodWithCallback function (number param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: number = 100;
        let methodName: string = "callMethodWithCallbackT0040";
        let method = (param: number): bridge.ResultValue => {
          expect(param).assertEqual(data);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          expect(result).assertEqual(data);
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0500
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0500
     * @tc.desc Test Bridge Binary callMethodWithCallback function (string array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: Array<string> = ["hello", "world"];
        let methodName: string = "callMethodWithCallbackT0050";
        let method = (param: Array<string>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          result = result as Array<string>;
          expect(result[0]).assertEqual(data[0]);
          expect(result[1]).assertEqual(data[1]);
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0600
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0600
     * @tc.desc Test Bridge Binary callMethodWithCallback function (boolean array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: Array<boolean> = [false, true];
        let methodName: string = "binary_callMethodWithCallbackT0060";
        let method = (param: Array<boolean>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          result = result as Array<boolean>;
          expect(result[0]).assertEqual(data[0]);
          expect(result[1]).assertEqual(data[1]);
        })
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryCallMethodWithCallback_0700
     * @tc.name ArkUIX_Bridge_BinaryCallMethodWithCallback_0700
     * @tc.desc Test Bridge Binary callMethodWithCallback function (number array param)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryCallMethodWithCallback_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let data: Array<number> = [100, 200];
        let methodName: string = "callMethodWithCallbackT0070";
        let method = (param: Array<number>): bridge.ResultValue => {
          expect(param[0]).assertEqual(data[0]);
          expect(param[1]).assertEqual(data[1]);
          return "call success";
        }
        bridgeBinaryCallMethod.callMethodWithCallback(methodName, method, data).then((result: bridge.ResultValue) => {
          result = result as Array<number>;
          expect(result[0]).assertEqual(data[0]);
          expect(result[1]).assertEqual(data[1]);
        })
        await sleep(WAIT_READY_MS_1000)
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryUnRegisterMethod_0100
     * @tc.name ArkUIX_Bridge_BinaryUnRegisterMethod_0100
     * @tc.desc Test Bridge Binary unRegisterMethod function (Promise)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryUnRegisterMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testUnRegister", method: method });
        await bridgeBinaryCallBack.unRegisterMethod("testUnRegister").then(() => {

          expect(true).assertTrue();
          done();
        }).catch((error: BusinessError) => {

          expect().assertFail();
          done();
        });
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryUnRegisterMethod_0200
     * @tc.name ArkUIX_Bridge_BinaryUnRegisterMethod_0200
     * @tc.desc Test Bridge Binary unRegisterMethod with unregistered method (Promise)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryUnRegisterMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        await bridgeBinaryCallBack.unRegisterMethod("testUnRegister").then(() => {
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
     * @tc.number ArkUIX_Bridge_BinaryUnRegisterMethod_0300
     * @tc.name ArkUIX_Bridge_BinaryUnRegisterMethod_0300
     * @tc.desc Test Bridge Binary unRegisterMethod function (callback)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryUnRegisterMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let method = (param: string): bridge.ResultValue => {
          return "success";
        }
        bridgeBinaryCallBack.registerMethod({ name: "testUnRegister", method: method });
        bridgeBinaryCallBack.unRegisterMethod("testUnRegister", (error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_OK)
          expect(error.message).assertEqual(ERROR_MESSAGE_OK)
          done();
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })

    /**
     * @tc.number ArkUIX_Bridge_BinaryUnRegisterMethod_0400
     * @tc.name ArkUIX_Bridge_BinaryUnRegisterMethod_0400
     * @tc.desc Test Bridge Binary unRegisterMethod with unregistered method (callback)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Bridge_BinaryUnRegisterMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        bridgeBinaryCallBack.unRegisterMethod("UnregisteredMethod", (error: BusinessError) => {
          expect(error.code).assertEqual(ERROR_CODE_METHOD)
          expect(error.message).assertEqual(ERROR_MESSAGE_METHOD)
          done();
        });
        await sleep(WAIT_READY_MS_1000);
        done();
      })
  })
}
