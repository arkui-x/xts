import { describe, it, expect, Level, TestType, Size, } from '@ohos/hypium';
import { http, connection } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';

const AWAIT_SLEEP_MS_1000: number = 1000;
const AWAIT_SLEEP_MS_4000: number = 4000;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
const certPath_legitimate: string = "xtsTest";
const keyPath_legitimate: string = "xtsTest";
const pwd: string = "123";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function requestInStream2() {
  describe('requestInStream2', () => {

    /**
     * @tc.number ACTS_ARKUIX_Http_requestInStream_CallBackWithOutOptions_0100
     * @tc.name ACTS_ARKUIX_Http_requestInStream_CallBackWithOutOptions_0100
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ACTS_ARKUIX_Http_requestInStream_CallBackWithOutOptions_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream("https://www.baidu.com", (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOutOptions_0100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOutOptions_0100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
        httpRequest.destroy();
        console.info('the deviceInfo osFullName is :' + osFullNameInfo);
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0100
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000);
        console.info('the deviceInfo osFullName is :' + osFullNameInfo);

      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0200
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {

        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream(null, options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0200 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0200 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(401)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
        console.info('the deviceInfo osFullName is :' + osFullNameInfo);

      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0300
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream("http://www.aol.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(403)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0300 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0400
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          connectTimeout: 60000,
          readTimeout: 60000,
        };
        httpRequest.requestInStream('https://gitee.com/arkui-x2/xts', options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0400 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(404)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0400 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0500
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream("https:www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0500 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0500 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300003)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0600
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream('https://www.baidu', options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0600 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0600 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300006)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0800 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0800 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0900 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0900 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.HEAD,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1000 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1000 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.HEAD,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.HEAD,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1200 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1200 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.OPTIONS,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1300 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.OPTIONS,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1400 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1400 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.OPTIONS,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1500 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1500 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1600 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1600 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1800 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1800 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_1900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_1900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_1900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.PUT,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1900 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_1900 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.PUT,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2000 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2000 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.PUT,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2100 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2100 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300999)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.DELETE,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2200 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2200 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.DELETE,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2300 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2300 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.DELETE,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2400 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2400 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300999)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.TRACE,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2500 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2500 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.TRACE,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2600 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2600 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.TRACE,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2700 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2700 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300999)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.CONNECT,
          usingProtocol: http.HttpProtocol.HTTP1_1,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2800 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2800 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_2900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_2900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_2900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.CONNECT,
          usingProtocol: http.HttpProtocol.HTTP2,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2900 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_2900 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.CONNECT,
          usingProtocol: http.HttpProtocol.HTTP3,
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3000 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3000 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300999)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          extraData: 'data to send',
        };
        httpRequest.requestInStream('https://gitee.com/arkui-x2/xts', options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3100 requestInStream OK! ResponseCode is " +
                data);
              expect(data != null).assertTrue()
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3100 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          connectTimeout: 60000,
          readTimeout: 60000,
        };
        httpRequest.requestInStream('http://example.com', options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3200 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(411)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3200 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          extraData: {
            letter: "test",
            characters: "测试文字",
          },
          header: "content-type': 'application/json",
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3300 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3300 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          extraData: 'testInformation测试',
          header: "content-type': 'application/x-www-form-urlencoded",
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3400 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3400 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          extraData: 'testInformation测试',
          header: "content-type': 'text/xml",
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3500 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3500 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          extraData: ''
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3600 requestInStream OK! ResponseCode is " +
                data);
              expect(data).assertEqual(200)
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3600 requestInStream ERROR : err = " +
              JSON.stringify(err));
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          priority: 0.5
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          priority: 1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3800 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3800 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_3900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_3900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_3900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          priority: AWAIT_SLEEP_MS_1000
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3900 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_3900 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          priority: 1001
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4000 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4000 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          maxLimit: 999999999999
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          usingProxy: false
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4200 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4200 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          usingProxy: true
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4300 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          usingProxy: ({
            host: "192.168.xx.xxx",
            port: 8080,
          } as connection.HttpProxy)
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4400 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4400 requestInStream ERROR : err = " +
            JSON.stringify(err));
            if (platform == 'iOS') {
              expect(err.code).assertEqual(2300999)
            } else {
              expect(err.code).assertEqual(2300005)
            }
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          dnsOverHttps: 'https://dns.xtstest.com/dns-query'
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4500 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4500 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          dnsOverHttps: undefined
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4600 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          dnsServers: ['http://dns.xtstest1.com/dns-query', 'http://dns.xtstest2.com/dns-query',
            'http://dns.xtstest3.com/dns-query']
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          dnsServers: undefined
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4800 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4800 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_4900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_4900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_4900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          readTimeout: 1,
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4900 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_4900 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300028)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          readTimeout: 60000,
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5000 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5000 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          connectTimeout: 1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5100 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5100 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300028)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          connectTimeout: 60000
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5200 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5200 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          caPath: ' '
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5300 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          caPath: '../../../main/resources/rawfile/certificate.pem'
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5400 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5400 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          resumeFrom: 4294967299
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5500 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5500 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          resumeFrom: 0
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5600 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5600 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          resumeTo: 4294967299
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          resumeTo: 0
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5800 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5800 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_5900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_5900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_5900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          resumeFrom: 9999,
          resumeTo: 333
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5900 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_5900 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6000
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          expectDataType: http.HttpDataType.STRING
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6000 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6000 requestInStream ERROR : err = " +
            JSON.stringify(err));

          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          expectDataType: http.HttpDataType.OBJECT
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          expectDataType: http.HttpDataType.ARRAY_BUFFER
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6200 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6200 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          usingCache: false
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6300 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          usingCache: true
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6400 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6400 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          extraData: "MineMine",
          header: {
            "Content-Type": "application/json",
          },
          readTimeout: 60000,
          connectTimeout: 60000,
          clientCert: {
            certPath: certPath_legitimate,
            keyPath: keyPath_legitimate,
            keyPassword: pwd,
            certType: http.CertType.P12,
          },
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6500 requestInStream OK! ResponseCode is " +
                data);
              httpRequest.destroy();
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6500 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300058)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
          extraData: "MineMine",
          header: {
            "Content-Type": "application/json",
          },
          readTimeout: 60000,
          connectTimeout: 60000,
          clientCert: {
            certPath: certPath_legitimate,
            keyPath: keyPath_legitimate,
            keyPassword: pwd,
            certType: http.CertType.P12,
          },
        };
        httpRequest.requestInStream("https://httpbin.org/anything", options,
          (err: BusinessError<void>, data: number) => {
            if (!err) {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6600 requestInStream OK! ResponseCode is " +
                data);
              httpRequest.destroy();
            } else {
              console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6600 requestInStream ERROR : err = " +
              JSON.stringify(err));
              expect(err.code).assertEqual(2300058)
            }
          })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          header: "content-type': 'multipart/form-data",
          multiFormDataList: [
            {
              name: "Part1",
              contentType: 'text/plain',
              data: 'Example data',
              remoteFileName: 'example.txt'
            }]
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          certificatePinning: [
            {
              publicKeyHash: 'Pin1',
              hashAlgorithm: 'SHA-256'
            }, {
            publicKeyHash: 'Pin2',
            hashAlgorithm: 'SHA-256'
          }
          ],
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_6900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_6900
     * @tc.desc Test requestInStream ErrorCode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_6900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
        };
        httpRequest.requestInStream('https://www.baidu.com/', options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6900 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_6900 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7000
     * @tc.desc Test requestInStream ErrorCode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.POST,
          extraData: 'data to send',
          expectDataType: http.HttpDataType.STRING,
          usingCache: true,
          priority: 1,
          header: new Header('application/json'),
          readTimeout: 60000,
          connectTimeout: 60000,
          usingProtocol: http.HttpProtocol.HTTP1_1,
          usingProxy: false,
        };
        await sleep(AWAIT_SLEEP_MS_4000)
        httpRequest.requestInStream('https://www.baidu.com/', options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7000 requestInStream OK! ResponseCode is " +
              data);
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7000 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7100
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          maxLimit: 999
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7100 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7100 requestInStream ERROR : err = " +
            JSON.stringify(err));

          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7200
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream("https://0.0.0.0/", options, (err: BusinessError<void>, data: number) => {
          if (err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7200 requestInStream ERROR : err = " +
            JSON.stringify(err));
            if (platform == 'iOS') {
              expect(err.code).assertEqual(2300008)
            } else {
              expect(err.code).assertEqual(2300007)
            }
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7200 requestInStream OK! ResponseCode is " +
              data);
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7300
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7300
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          connectTimeout: -1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7300 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7300 requestInStream ERROR : err = " +
            JSON.stringify(err));

          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7400
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7400
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          readTimeout: -1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7400 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7400 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7500
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7500
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          resumeFrom: 1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7500 requestInStream OK! ResponseCode is " +
              data);
            expect(data != null).assertTrue()
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7500 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7600
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7600
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          resumeFrom: 4294967296
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7600 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7600 requestInStream ERROR : err = " +
            JSON.stringify(err));

          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7700
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7700
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          resumeTo: 4294967296
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7700 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7800
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7800
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          resumeTo: 1
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7700 requestInStream OK! ResponseCode is " +
              data);
            expect(data != null).assertTrue()
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7700 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_7900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_7900
     * @tc.desc Test requestInStream options
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_7900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          maxLimit: 104857600
        };
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7900 requestInStream OK! ResponseCode is " +
              data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_7900 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_8000
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_8000
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_8000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest: http.HttpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream("https://httpbin.org/anything", {
          method: http.RequestMethod.POST,
          header: {
            "Content-type": "multipart/form-data",
          },
          multiFormDataList: [
            {
              name: "multiTest",
              remoteFileName: "xtsRemoteTest",
              contentType: "image/png",
              filePath: "../../resources/base/media/icon.png",
            },
          ],
        }, (err: BusinessError, data: number) => {
          if (err) {
            console.info(`ARKUIX_Http_requestInStream_CallBackWithOptions_8000 httpRequest fail:${JSON.stringify(err)}`);
            expect(err.code).assertEqual(2300026)
            httpRequest.destroy();
            done();
          } else {
            console.info(`ARKUIX_Http_requestInStream_CallBackWithOptions_8000 httpRequest success:${JSON.stringify(data)}`);
            httpRequest.destroy();
            done();
          }
        });
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })


    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_8100
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_8100
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_8100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.destroy();

        let options: http.HttpRequestOptions = {};
        httpRequest.requestInStream("https://www.baidu.com", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_8100 requestInStream OK! ResponseCode is " +
              data);
            httpRequest.destroy();
            done();
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_8100 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000);
        console.info('the deviceInfo osFullName is :' + osFullNameInfo);

      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_8200
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_8200
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_8200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        let options: http.HttpRequestOptions = {
          method: http.RequestMethod.GET,
        };
        httpRequest.requestInStream('ws://huawei.com', options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_8200 requestInStream OK! ResponseCode is " +
              data);

          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_8200 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300001)
          }
        })
        await sleep(AWAIT_SLEEP_MS_4000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

  })
}