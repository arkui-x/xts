import { describe, it, expect, afterEach, Level, TestType, Size,} from '@ohos/hypium';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';

const AWAIT_SLEEP_MS_1000: number = 1000;
const AWAIT_SLEEP_MS_3000: number = 3000;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function requestInStream1() {
  describe('requestInStream1', () => {
    afterEach(async () => {
      await sleep(AWAIT_SLEEP_MS_3000)
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0100
     * @tc.name ARKUIX_Http_requestInStream_callback_0100
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream("https://www.baidu.com", (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0100 requestInStream OK! ResponseCode is " + data);
            expect(data).assertEqual(200)
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0100 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0200
     * @tc.name ARKUIX_Http_requestInStream_callback_0200
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream("https://www.aol.com", (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0200 requestInStream OK! ResponseCode is " + data);
            expect(data).assertEqual(403)
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0200 requestInStream ERROR : err = " +
            JSON.stringify(err));
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0300
     * @tc.name ARKUIX_Http_requestInStream_callback_0300
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream('https:www.baidu.com/', (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0300 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0300 requestInStream ERROR : err = " +
            JSON.stringify(err));
            console.log('err.code: ' + err.code)
            expect(err.code).assertEqual(2300003)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0400
     * @tc.name ARKUIX_Http_requestInStream_callback_0400
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream('https://www.baidu', (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0400 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0400 requestInStream ERROR : err = " +
            JSON.stringify(err));
            console.log('err.code: ' + err.code)
            expect(err.code).assertEqual(2300006)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0500
     * @tc.name   : ACTS_ARKUIX_Http_requestInStream_callback_0500
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.destroy()
        httpRequest.requestInStream('https://www.baidu', (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0500 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0500 requestInStream ERROR : err = " +
            JSON.stringify(err));
            console.log('err.code: ' + err.code)
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0600
     * @tc.name ARKUIX_Http_requestInStream_callback_0600
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream('https://0.0.0.0/', (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0600 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0600 requestInStream ERROR : err = " +
            JSON.stringify(err));
            console.log('err.code: ' + err.code)
            if (platform == 'iOS') {
              expect(err.code).assertEqual(2300008)
            } else {
              expect(err.code).assertEqual(2300007)
            }
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0700
     * @tc.name ARKUIX_Http_requestInStream_callback_0700
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream(null, (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0700 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0700 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(401)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_callback_0800
     * @tc.name ARKUIX_Http_requestInStream_callback_0800
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_callback_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.requestInStream("https://www.baidu.com", (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_callback_0800 requestInStream OK! ResponseCode is " + data);
          } else {
            console.info("ARKUIX_Http_requestInStream_callback_0800 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300023)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
        httpRequest.destroy()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_requestInStream_CallBackWithOptions_0900
     * @tc.name ARKUIX_Http_requestInStream_CallBackWithOptions_0900
     * @tc.desc Test requestInStream URL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_Http_requestInStream_CallBackWithOptions_0900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        await sleep(AWAIT_SLEEP_MS_1000)
        httpRequest.destroy();
        httpRequest.requestInStream("https://httpbin.org/anything", (err: BusinessError, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0900 requestInStream OK! ResponseCode is " +
              data);
            httpRequest.destroy();
            done();
          } else {
            console.info("ARKUIX_Http_requestInStream_CallBackWithOptions_0900 requestInStream ERROR : err = " +
            JSON.stringify(err));
            expect(err.code).assertEqual(2300999)
          }
        })
        await sleep(AWAIT_SLEEP_MS_3000)
        httpRequest.destroy()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}