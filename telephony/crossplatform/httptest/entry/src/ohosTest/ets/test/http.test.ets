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

import { describe, expect, it } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import http from '@ohos.net.http';
import connection from '@ohos.net.connection';
import {Driver} from '@ohos.UiTest'

const ExpectFail = () => {
  try {
    expect().assertFail();
  } catch (err) {
    console.info("expectInfo", `test failed`);
  }
}

const ExpectTrue = (n: boolean) => {
  try {
    expect(n).assertTrue();
  } catch (err) {
    console.info("expectInfo", `test failed`);
  }
}

async function  sleep(time:number){
  let driver = Driver.create()
  await driver.delayMs(time)
}

type emptyFunc = () => void;

const TEST_MORE_LEN: number = 2;
const TEST_MORE_REQUEST_LEN: number = 2;

export const ADDR_TEST_STREAM_HTTPS = "https://cn.bing.com/rp/Q5BJPjebyYN5QiqznkcMQmLrF9U.svg";

export default function HttpTest() {
  describe('HttpTest', () => {

    let Address_Baidu: string = "https://www.baidu.com/";
    let XTS_TEST_STREAM_HTTPS_URL: string = "https://cn.bing.com/rp/Q5BJPjebyYN5QiqznkcMQmLrF9U.svg";

    let httpRequestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      header: "content-type': 'application/json",
      readTimeout: 60000,
      connectTimeout: 60000
    };

    /**
     * @tc.number Telephony_http_HttpRequest_requestInStream_0100
     * @tc.name httprequestInStream::requestInStream
     * @tc.desc Test requestInStream(url: string, callback: AsyncCallback<void>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_Async_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_Async_0100";
      let Address_Img = "https://img1.baidu.com/it/u=3010094603,1247181326&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500";
      let httpRequest = http.createHttp();
      try {
        const dataReceive_on_callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          console.info(`${CaseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        const dataReceiveProgress_on_callback: (data: object) => void = (data: object) => {
          console.log("dataReceiveProgress_on_callback receive datProgress:" + JSON.stringify(data));
        }
        const dataEnd_on_callback: () => void = () => {
          console.log("dataEnd_on_callback callback function");
        }
        httpRequest.on("dataReceive", dataReceive_on_callback);
        httpRequest.on("dataReceiveProgress", dataReceiveProgress_on_callback);
        httpRequest.on("dataEnd", dataEnd_on_callback);
        httpRequest.requestInStream(Address_Img, httpRequestOptions, (err, data) => {
          console.info(CaseName + " responseCode data : " + data);
          console.log(CaseName + "NETSTACK requestInStream OK!");
          httpRequest.off("dataReceive");
          console.log("NETSTACK off dataReceive success!");
          httpRequest.off("dataReceiveProgress");
          console.log("NETSTACK off dataReceiveProgress success!");
          httpRequest.off("dataEnd");
          console.log("NETSTACK off dataEnd success!");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        })
      } catch (error) {
        console.log(CaseName + " requestInStream catch : error = " + JSON.stringify(error));
        expect(error).assertFalse();
        done();
      }
    });

    /**
     * @tc.number Telephony_http_HttpRequest_requestInStream_0200
     * @tc.name httprequestInStream::requestInStream
     * @tc.desc Test requestInStream(url: string, options: HttpRequestOptions, callback: AsyncCallback<void>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_Async_0200", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_Async_0200"
      let httpRequest = http.createHttp();
      httpRequest.requestInStream(Address_Baidu, (err, data) => {
        if (err) {
          console.log(CaseName + " requestInStream ERROR" + JSON.stringify(err));
          expect().assertFail();
          done();
        }
        httpRequest.destroy();
        console.log(CaseName + " requestInStream Finish responseCode " + data);
        done();
      });
    });

    /**
     * @tc.number Telephony_http_HttpRequest_requestInStream_0100
     * @tc.name httprequestInStream::requestInStream
     * @tc.desc Test requestInStream(url: string, options: HttpRequestOptions): Promise<void>.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_Promise_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_Promise_0100";
      let httpRequest = http.createHttp();
      httpRequest.requestInStream(Address_Baidu, httpRequestOptions).then((data) => {
        console.log(CaseName + " requestInStream Finish responseCode " + data);
        httpRequest.destroy();
        done();
      }).catch((err:BusinessError) => {
        console.log(CaseName + " error = " + JSON.stringify(err));
        expect().assertFail();
        done();
      });
    });

    /**
     * @tc.number Telephony_http_HttpRequest_requestInStream_0100
     * @tc.name httprequestInStream::requestInStream
     * @tc.desc Test requestInStream(url: string): Promise<void>.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_Promise_0200", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_Promise_0200";
      let httpRequest = http.createHttp();
      httpRequest.requestInStream(Address_Baidu).then((data) => {
        console.log(CaseName + " requestInStream Finish responseCode " + data);
        httpRequest.destroy();
        done();
      }).catch((err:BusinessError) => {
        console.log(CaseName + " : error = " + JSON.stringify(err));
        expect().assertFail();
        done();
      });
    });

    /**
     * @tc.number SUB_Telephony_http_HttpRequest_once_headersReceive_0100
     * @tc.name httprequest::once_headersReceive_0100
     * @tc.desc Test Test httprequest property.
     * @tc.level 0
     * @tc.type: Function
     * @tc.size: SmallTest
     */
    it("SUB_Telephony_http_HttpRequest_once_headersReceive_0100", 0, async (done: Function) => {
      let caseName = "SUB_Telephony_http_HttpRequest_once_headersReceive_0100"
      console.log("-----------------------HttpRequest_once_headersReceive Test is starting-----------------------");
      try {
        let httpRequest = http.createHttp();
        httpRequest.once('headersReceive', (data) => {
          console.log(caseName + " data: " + JSON.stringify(data));
          expect(true).assertTrue();
          httpRequest.destroy();
          console.log("-----------------------HttpRequest_on_headersReceive Test end-----------------------");
          done();
        });
        httpRequest.request(Address_Baidu, (err, data) => {
          console.log(caseName + " data: " + JSON.stringify(data.responseCode) + " err: " + JSON.stringify(err));
        });
      } catch (error) {
        console.log("SUB_Telephony_http_HttpRequest_once_headersReceive_010 : error = " + error);
        expect(false).assertTrue();
        done();
      }
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_0700
     * @tc.name:    testHttpRequestOn0700
     * @tc.desc:    test on with type dataReceive send one request with httpRequest.requestInStream only one listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn0700', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn0700";
      console.info(`${caseName} test Start`);
      connection.getAllNets((error: BusinessError, data: connection.NetHandle[]) => {
        if (error) {
          console.error(`Failed to get all nets. Code:${error.code}, message:${error.message}`);
          return;
        }
        console.info("Succeeded to get data: " + JSON.stringify(data));
      });
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 1
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                if (err) {
                  reject(err);
                } else {
                  resolve();
                }
              });
            })
          );
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_0800
     * @tc.name:    testHttpRequestOn0800
     * @tc.desc:    test on with type dataReceive send one request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn0800', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn0800";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: TEST_MORE_LEN
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                if (err) {
                  reject(err);
                } else {
                  resolve();
                }
              });
            })
          )
          ;
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_0900
     * @tc.name:    testHttpRequestOn0900
     * @tc.desc:    test on with type dataReceive send more request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn0900', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn0900";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: TEST_MORE_LEN
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < TEST_MORE_REQUEST_LEN; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                if (err) {
                  reject(err);
                } else {
                  resolve();
                }
              });
            })
          )
          ;
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= TEST_MORE_REQUEST_LEN);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_0300
     * @tc.name   : testNetworkMgrHttpHttpRequestOff0300
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff0300', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff0300';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.on("dataReceive", (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        });
        httpRequest.off("dataReceive");
        httpRequest.request(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_2500
     * @tc.name:    testHttpRequestOn2500
     * @tc.desc:    test on with type dataReceive with httpRequest.request not support
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn2500', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn2500";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        httpRequest.on('dataReceive', callback);
        const promise: Promise<void> = new Promise<void>((resolve, reject) => {
          httpRequest.request(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
            if (err) {
              reject(err);
            } else {
              resolve();
            }
          });
        });
        promise.then(() => {
          ExpectTrue(called == 0);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promise catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_3500
     * @tc.name:    testHttpRequestOn3500
     * @tc.desc:    test on with type dataReceive send one request with httpRequest.requestInStream only one listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn3500', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn3500";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 1
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<number>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_3600
     * @tc.name:    testHttpRequestOn3600
     * @tc.desc:    test on with type dataReceive send one request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn3600', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn3600";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: TEST_MORE_LEN
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<number>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_3700
     * @tc.name:    testHttpRequestOn3700
     * @tc.desc:    test on with type dataReceive send more request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn3700', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn3700";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: TEST_MORE_LEN
        }).forEach(() => {
          httpRequest.on('dataReceive', callback);
        });
        let list: Promise<number>[] = [];
        for (let i = 0; i < TEST_MORE_REQUEST_LEN; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          ExpectTrue(called >= TEST_MORE_REQUEST_LEN);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_5300
     * @tc.name:    testHttpRequestOn5300
     * @tc.desc:    test on with type dataReceive with httpRequest.request not support
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn5300', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn5300";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        httpRequest.on('dataReceive', () => {
          called++;
        });
        httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS).then((res: number) => {
          console.info(`${caseName} request sunccess, data: ${JSON.stringify(res)}`);
          console.info(`${caseName} called: ${called}`);
          ExpectTrue(called == 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} request fail, error code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_0400
     * @tc.name   : testNetworkMgrHttpHttpRequestOff0400
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff0400', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff0400';
      console.info(`${caseName}---Start`);
      try {
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.on("dataReceive", callback);
        httpRequest.off("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_1500
     * @tc.name   : testNetworkMgrHttpHttpRequestOff1500
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff1500', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff1500';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.off("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_2100
     * @tc.name   : testNetworkMgrHttpHttpRequestOff2100
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff2100', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff2100';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.off("dataReceive");
        httpRequest.on("dataReceive", (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        });
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 2);
            httpRequest.destroy();
            httpRequest.off("dataReceive");
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_2200
     * @tc.name   : testNetworkMgrHttpHttpRequestOff2200
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff2200', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff2200';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.off("dataReceive", callback);
        httpRequest.on("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 2);
            httpRequest.destroy();
            httpRequest.off("dataReceive");
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_4500
     * @tc.name   : testNetworkMgrHttpHttpRequestOff4500
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff4500', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff4500';
      ;
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.off("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_5100
     * @tc.name   : testNetworkMgrHttpHttpRequestOff5100
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff5100', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff5100';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.off("dataReceive");
        httpRequest.on("dataReceive", (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        });
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 2);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_5200
     * @tc.name   : testNetworkMgrHttpHttpRequestOff5200
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff5200', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff5200';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.off("dataReceive", callback);
        httpRequest.on("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 2);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          httpRequest.destroy();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_6300
     * @tc.name   : testNetworkMgrHttpHttpRequestOff6300
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff6300', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff6300';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.on("dataReceive", (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        });
        httpRequest.off("dataReceive");
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err： ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_6400
     * @tc.name   : testNetworkMgrHttpHttpRequestOff6400
     * @tc.desc   : Unsubscribe from HTTP streaming response data receiving events.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff6400', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff6400';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          count = count + 1;
          console.info(`${caseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.on("dataReceive", callback);
        httpRequest.off("dataReceive", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err： ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_on_dataReceive_0100
     * @tc.name httprequestInStream::on_dataReceive
     * @tc.desc Test on(type: "dataReceive", callback: Callback<ArrayBuffer>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_on_dataReceive_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_on_dataReceive_0100";
      try {
        let httpRequest = http.createHttp();
        const dataReceive_on_callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          console.info(`${CaseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.on("dataReceive", dataReceive_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          console.log(CaseName + " on dataReceive Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0100
     * @tc.name httprequestInStream::off_dataReceive
     * @tc.desc Test off(type: "dataReceive", callback: Callback<ArrayBuffer>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0100";
      try {
        let httpRequest = http.createHttp();
        const dataReceive_on_callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          console.info(`${CaseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.on("dataReceive", dataReceive_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          httpRequest.off("dataReceive", dataReceive_on_callback);
          console.log(CaseName + " off dataReceive Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0200
     * @tc.name httprequestInStream::off_dataReceive
     * @tc.desc Test off(type: "dataReceive"): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0200", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_off_dataReceive_0200";
      try {
        let httpRequest = http.createHttp();
        const dataReceive_on_callback: (data: ArrayBuffer) => void = (data: ArrayBuffer) => {
          console.info(`${CaseName} dataReceive length: ${JSON.stringify(data.byteLength)}`);
        }
        httpRequest.on("dataReceive", dataReceive_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          httpRequest.off("dataReceive");
          console.log(CaseName + " off dataReceive Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_1000
     * @tc.name:    testHttpRequestOn1000
     * @tc.desc:    test on with type dataEnd send one request with httpRequest.requestInStream only one listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn1000', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn1000";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 1
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                setTimeout(() => {
                  if (err) {
                    reject(err);
                  } else {
                    resolve();
                  }
                }, 0);
              });
            })
          )
          ;
        }
        Promise.all(list).then(() => {
          ExpectTrue(called == 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_1100
     * @tc.name:    testHttpRequestOn1100
     * @tc.desc:    test on with type dataEnd send one request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn1100', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn1100";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 2
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                setTimeout(() => {
                  if (err) {
                    reject(err);
                  } else {
                    resolve();
                  }
                }, 0);
              });
            })
          )
          ;
        }
        Promise.all(list).then(() => {
          ExpectTrue(called == 1);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
          })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_1200
     * @tc.name:    testHttpRequestOn1200
     * @tc.desc:    test on with type dataEnd send more request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn1200', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn1200";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 2
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });
        let list: Promise<void>[] = [];
        for (let i = 0; i < 2; i++) {
          list.push(
            new Promise<void>((resolve, reject) => {
              httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
                setTimeout(() => {
                  if (err) {
                    reject(err);
                  } else {
                    resolve();
                  }
                }, 0);
              });
            })
          );
        }
        Promise.all(list).then(() => {
          ExpectTrue(called == 2);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_2700
     * @tc.name:    testHttpRequestOn2700
     * @tc.desc:    test on with type dataEnd with httpRequest.request not support
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn2700', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn2700";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        httpRequest.on('dataEnd', callback);
        const promise: Promise<void> = new Promise<void>((resolve, reject) => {
          httpRequest.request(ADDR_TEST_STREAM_HTTPS, (err: BusinessError) => {
            if (err) {
              reject(err);
            } else {
              resolve();
            }
          });
        });
        promise.then(() => {
          ExpectTrue(called == 0);
          httpRequest.destroy();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promise catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_3800
     * @tc.name:    testHttpRequestOn3800
     * @tc.desc:    test on with type dataEnd send one request with httpRequest.requestInStream only one listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn3800', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn3800";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 1
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });
        let list: Promise<number>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          setTimeout(() => {
            console.info(`${caseName} called: ${called}}`);
            ExpectTrue(called == 1);
            httpRequest.destroy();
            done();
          }, 0)
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_3900
     * @tc.name:    testHttpRequestOn3900
     * @tc.desc:    test on with type dataEnd send one request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn3900', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn3900";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 2
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });

        let list: Promise<number>[] = [];
        for (let i = 0; i < 1; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          setTimeout(() => {
            console.info(`${caseName} called: ${called}}`);
            ExpectTrue(called == 1);
            httpRequest.destroy();
            done();
          }, 0)
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
     * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_4000
     * @tc.name:    testHttpRequestOn4000
     * @tc.desc:    test on with type dataEnd send more request with httpRequest.requestInStream one more listener
     * @tc.size:    MediumTest
     * @tc.type:    Function
     * @tc.level:   level 2
     */
    it('testHttpRequestOn4000', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn4000";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
        const callback: emptyFunc = () => {
          called++;
        }
        Array.from<void>({
          length: 2
        }).forEach(() => {
          httpRequest.on('dataEnd', callback);
        });
        let list: Promise<number>[] = [];
        for (let i = 0; i < 2; i++) {
          list.push(
            httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS)
          );
        }
        Promise.all(list).then(() => {
          setTimeout(() => {
            console.info(`${caseName} called: ${called}}`);
            ExpectTrue(called == 2);
            httpRequest.destroy();
            done();
          }, 0)
        }).catch((error: BusinessError) => {
          console.info(`${caseName} promiseAll catch error, code: ${error.code}, msg: ${error.message}`);
          httpRequest.destroy();
          ExpectFail();
          done();
        })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /* *
 * @tc.number:  SUB_NetworkMgr_Http_HttpRequest_On_5500
 * @tc.name:    testHttpRequestOn5500
 * @tc.desc:    test on with type dataEnd with httpRequest.request not support
 * @tc.size:    MediumTest
 * @tc.type:    Function
 * @tc.level:   level 2
 */
    it('testHttpRequestOn5500', 0, async (done: Function) => {
      const caseName: string = "testHttpRequestOn5500";
      console.info(`${caseName} test Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let called: number = 0;
      httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS).then((res: number) => {
      })
    httpRequest.on('dataEnd', () => {
      called++;
    });
    httpRequest.requestInStream(ADDR_TEST_STREAM_HTTPS).then( async (res: number) => {
      await sleep(10)
      console.info(`${caseName} request sunccess, data: ${JSON.stringify(res)}`);
      console.info(`${caseName} called: ${called}`);
      ExpectTrue(called == 1);
      httpRequest.destroy();
      done();
    }).catch((error: BusinessError) => {
      console.info(`${caseName} request fail, error code: ${error.code}, msg: ${error.message}`);
      httpRequest.destroy();
      ExpectFail();
      done();
    })
      } catch (err) {
        console.info(`${caseName} catch ERROR-->:${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName} test End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_0500
     * @tc.name   : testNetworkMgrHttpHttpRequestOff0500
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff0500', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff0500';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.on("dataEnd", () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        });
        httpRequest.off("dataEnd");
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_1600
     * @tc.name   : testNetworkMgrHttpHttpRequestOff1600
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff1600', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff1600';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: () => void = () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        }
        httpRequest.off("dataEnd", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_3500
     * @tc.name   : testNetworkMgrHttpHttpRequestOff3500
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff3500', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff3500';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        httpRequest.on("dataEnd", () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        });
        httpRequest.off("dataEnd");
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_3600
     * @tc.name   : testNetworkMgrHttpHttpRequestOff3600
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff3600', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff3600';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: () => void = () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        }
        httpRequest.on("dataEnd", callback);
        httpRequest.off("dataEnd", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_4600
     * @tc.name   : testNetworkMgrHttpHttpRequestOff4600
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff4600', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff4600';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: () => void = () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        }
        httpRequest.off("dataEnd", callback);
        httpRequest.requestInStream(XTS_TEST_STREAM_HTTPS_URL).then(() => {
          console.info(`${caseName} count---${count}`);
          ExpectTrue(count == 1);
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.info(`${caseName} request fail err : ${JSON.stringify(err)}`);
          ExpectFail();
          done();
        });
      } catch (err) {
        console.info(`${caseName} trycatch err: ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number : SUB_NetworkMgr_Http_HttpRequest_Off_0600
     * @tc.name   : testNetworkMgrHttpHttpRequestOff0600
     * @tc.desc   : Unsubscribe from the HTTP streaming response data reception completion event.
     * @tc.level  : Level 3
     * @tc.type   : Function
     * @tc.size   : MediumTest
     */
    it('testNetworkMgrHttpHttpRequestOff0600', 0, async (done: Function) => {
      const caseName: string = 'testNetworkMgrHttpHttpRequestOff0600';
      console.info(`${caseName}---Start`);
      try {
        console.info(`${caseName} Network connected`);
        let httpRequest: http.HttpRequest = http.createHttp();
        let count: number = 1;
        const callback: () => void = () => {
          count = count + 1;
          console.info(`${caseName} Receive dataEnd`);
        }
        httpRequest.on("dataEnd", callback);
        httpRequest.off("dataEnd", callback);
        httpRequest.requestInStream(Address_Baidu, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} request err: ${JSON.stringify(err)}`);
            ExpectFail();
            httpRequest.destroy();
            done();
          } else {
            console.info(`${caseName} count: ${count}`);
            ExpectTrue(count == 1);
            httpRequest.destroy();
            done();
          }
        });
      } catch (err) {
        console.info(`${caseName} trycatch failed ${JSON.stringify(err)}`);
        ExpectFail();
        done();
      }
      console.info(`${caseName}---End`);
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_on_dataEnd_0100
     * @tc.name httprequestInStream::on_dataEnd
     * @tc.desc Test on(type: "dataEnd", callback: Callback<void>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_on_dataEnd_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_on_dataEnd_0100";
      try {
        let httpRequest = http.createHttp();
        const dataEnd_on_callback: () => void = () => {
          console.log("dataEnd_on_callback callback function");
        }
        httpRequest.on("dataEnd", dataEnd_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          console.log(CaseName + " on dataEnd Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0100
     * @tc.name httprequestInStream::off_dataEnd
     * @tc.desc Test off(type: "dataEnd", callback?: Callback<void>): void.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0100", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0100";
      try {
        let httpRequest = http.createHttp();
        const dataEnd_on_callback: () => void = () => {
          console.log("dataEnd_on_callback callback function");
        }
        httpRequest.on("dataEnd", dataEnd_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          httpRequest.off("dataEnd", dataEnd_on_callback);
          console.log(CaseName + " off dataEnd Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0200
     * @tc.name httprequestInStream::off_dataEnd
     * @tc.desc Test off(type: "dataEnd"): void;.
     */
    it("SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0200", 0, async (done: Function) => {
      let CaseName = "SUB_Telephony_NetStack_HttprequestInStream_off_dataEnd_0200";
      try {
        let httpRequest = http.createHttp();
        const dataEnd_on_callback: () => void = () => {
          console.log("dataEnd_on_callback callback function");
        }
        httpRequest.on("dataEnd", dataEnd_on_callback);
        httpRequest.requestInStream(Address_Baidu).then((data) => {
          httpRequest.off("dataEnd");
          console.log(CaseName + " off dataEnd Finish ");
          expect(data == 200).assertTrue();
          httpRequest.destroy();
          done();
        }).catch((err: Error) => {
          console.log(CaseName + " : error = " + JSON.stringify(err));
          expect().assertFail();
          done();
        });
      } catch (error) {
        console.log(CaseName + " : error = " + JSON.stringify(error));
        expect().assertFail();
        done();
      }
    });
  });
}
