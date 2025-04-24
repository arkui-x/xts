import { describe, it, expect, afterEach, Level, TestType, Size, } from '@ohos/hypium';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function onAndoff() {
  describe('onAndoff', () => {
    afterEach(async () => {
      await sleep(3000)
    })
    /**
     * @tc.number ARKUIX_Http_OnAndOff_0100
     * @tc.name ARKUIX_Http_OnAndOff_0100
     * @tc.desc Test on("dataReceiveProgress") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (data: http.DataReceiveProgressInfo) => {
          console.info("dataReceiveProgress:" + JSON.stringify(data));
          count += 1
        }
        httpRequest.on("dataReceiveProgress", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0100 requestInStream OK! ResponseCode is " + JSON.stringify(data));
            expect(data != null).assertTrue()
          } else {
            console.info("ARKUIX_Http_OnAndOff_0100 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        await sleep(1000)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0200
     * @tc.name ARKUIX_Http_OnAndOff_0200
     * @tc.desc Test off("dataReceiveProgress") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (data: http.DataReceiveProgressInfo) => {
          console.info("dataReceiveProgress:" + JSON.stringify(data));
          count += 1
        }
        httpRequest.on("dataReceiveProgress", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0200 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0200 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        httpRequest.off("dataReceiveProgress", func)
        await sleep(1000)
        expect(count == 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0300
     * @tc.name ARKUIX_Http_OnAndOff_0300
     * @tc.desc Test on("headersReceive") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (header: Object) => {
          console.log("header: " + JSON.stringify(header));
          count += 1
        }
        httpRequest.on("headersReceive", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0300 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0300 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        await sleep(1000)
        expect(count != 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0400
     * @tc.name ARKUIX_Http_OnAndOff_0400
     * @tc.desc Test off("headersReceive") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (header: Object) => {
          console.log("header: " + JSON.stringify(header));
          count += 1
        }
        httpRequest.on("headersReceive", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0400 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0400 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        httpRequest.off("headersReceive", func);
        console.log("ARKUIX_Http_OnAndOff_0400 header: " + JSON.stringify(count));
        await sleep(1000)
        expect(count == 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0500
     * @tc.name ARKUIX_Http_OnAndOff_0500
     * @tc.desc Test on("dataReceive") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (data: ArrayBuffer) => {
          console.info("dataReceive length: " + JSON.stringify(data.byteLength));
          count += 1
        }
        httpRequest.on("dataReceive", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0500 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0500 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        await sleep(1000)
        expect(count != 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0600
     * @tc.name ARKUIX_Http_OnAndOff_0600
     * @tc.desc Test off("dataReceive") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = (data: ArrayBuffer) => {
          console.info("dataReceive length: " + JSON.stringify(data.byteLength));
          count += 1
        }
        httpRequest.on("dataReceive", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0600 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0600 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        httpRequest.off("dataReceive", func)
        await sleep(1000)
        expect(count == 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number ARKUIX_Http_OnAndOff_0700
     * @tc.name ARKUIX_Http_OnAndOff_0700
     * @tc.desc Test on("dataEnd") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = () => {
          console.info("Receive dataEnd !");
          count += 1
        }
        httpRequest.on("dataEnd", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0700 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0700 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })
        await sleep(1000)
        expect(count != 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })


    /**
     * @tc.number ARKUIX_Http_OnAndOff_0800
     * @tc.name ARKUIX_Http_OnAndOff_0800
     * @tc.desc Test off("dataEnd") success
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     * @tc.require
     */

    it('ARKUIX_Http_OnAndOff_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let httpRequest = http.createHttp();
        let count = 0
        let func = () => {
          console.info("Receive dataEnd !");
          count += 1
        }
        httpRequest.on("dataEnd", func);

        class Header {
          public contentType: string;

          constructor(contentType: string) {
            this.contentType = contentType;
          }
        }

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
        await sleep(2000)
        httpRequest.requestInStream("https://www.baidu.com/", options, (err: BusinessError<void>, data: number) => {
          if (!err) {
            console.info("ARKUIX_Http_OnAndOff_0800 requestInStream OK! ResponseCode is " + JSON.stringify(data));
          } else {
            console.info("ARKUIX_Http_OnAndOff_0800 requestInStream ERROR : err = " + JSON.stringify(err));
          }
        })

        httpRequest.off("dataEnd", func);
        await sleep(1000)
        expect(count == 0).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}