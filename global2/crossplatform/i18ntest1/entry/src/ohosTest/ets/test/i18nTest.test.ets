import hilog from '@ohos.hilog';
import I18n from '@ohos.i18n'
import Intl from '@ohos.intl'
import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function i18nTest() {
  describe('i18nTest', () => {
    let measuresArrayLength : number = 6;
    let date = new Date("2024-5-20");
    date.setHours(15);
    date.setMinutes(30);
    date.setSeconds(45);
    date.setMilliseconds(60);

    let formatTabletExpect: Array<string> = [
      "20 May 2024, 15:30:45", "May 2024 Monday", "7 in the morning", "15 China Standard Time",
      "123 hectares", "US$123.00", "1 day ago", "1 quarter ago",
      "2024年5月20日 15:30:45", "2024年5月 星期一", "清晨7时", "中国标准时间15时",
      "123公顷", "¥123.00", "1天前", "1个季度前"]

    let formatPhoneExpect: Array<string> = [
      "20/05/2024, 15:30", "May 2024 Mon", "7 in the morning", "15 GMT+8",
      "123 ha", "US$123.00", "1 day ago", "1 quarter ago",
      "2024/5/20 15:30", "2024年5月 周一", "早上7时", "GMT+815时",
      "123公顷", "¥123.00", "1天前", "1个季度前"]

    let measuresPhoneExpect_1: Array<string> = [
      "size-file-byte: ", "1 byte", "1.00 kB", "1.00 MB", "1.00 GB", "1.00 TB"]
    let measuresPhoneExpect_2: Array<string> = [
      "size-shortfile-byte: ", "1 byte", "1.0 kB", "1.0 MB", "1.0 GB", "1.0 TB"]
    let measuresPhoneExpect_3: Array<string> = [
      "elapsed-time-second: ", "now", "1 minute ago", "yesterday", "last month", "last year"]
    let measuresPhoneExpect_4: Array<string> = [
      "elapsed-time-second: ", "现在", "1分钟前", "昨天", "上个月", "去年"]
    let measuresPhoneExpect_5: Array<string> = [
      "size-file-byte: ", "1 B", "1.00 kB", "1.00 MB", "1.00 GB", "1.00 TB"]
    let measuresPhoneExpect_6: Array<string> = [
      "size-shortfile-byte: ", "1 B", "1.0 kB", "1.0 MB", "1.0 GB", "1.0 TB"]
    let measuresPhoneExpect_7: Array<string> = [
      "size-file-byte: ", "3 byte", "2.95 kB", "2.95 MB", "2.95 GB", "2.95 TB"]
    let measuresPhoneExpect_8: Array<string> = [
      "size-shortfile-byte: ", "3 byte", "2.9 kB", "3.0 MB", "3.0 GB", "3.0 TB"]
    let measuresPhoneExpect_9: Array<string> = [
      "size-file-byte: ", "3 B", "2.95 kB", "2.95 MB", "2.95 GB", "2.95 TB"]
    let measuresPhoneExpect_10: Array<string> = [
      "size-shortfile-byte: ", "3 B", "2.9 kB", "3.0 MB", "3.0 GB", "3.0 TB"]

    let measuresTabletExpect_1: Array<string> = [
      "size-file-byte: ", "1 byte", "1.00 kilobytes", "1.00 megabytes", "1.00 gigabytes", "1.00 terabytes"]
    let measuresTabletExpect_2: Array<string> = [
      "size-shortfile-byte: ", "1 byte", "1.0 kilobytes", "1.0 megabytes", "1.0 gigabytes", "1.0 terabytes"]
    let measuresTabletExpect_3: Array<string> = [
      "elapsed-time-second: ", "now", "1 minute ago", "yesterday", "last month", "last year"]
    let measuresTabletExpect_4: Array<string> = [
      "elapsed-time-second: ", "现在", "1分钟前", "昨天", "上个月", "去年"]
    let measuresTabletExpect_5: Array<string> = [
      "size-file-byte: ", "1字节", "1.00千字节", "1.00兆字节", "1.00吉字节", "1.00太字节"]
    let measuresTabletExpect_6: Array<string> = [
      "size-shortfile-byte: ", "1字节", "1.0千字节", "1.0兆字节", "1.0吉字节", "1.0太字节"]
    let measuresTabletExpect_7: Array<string> = [
      "size-file-byte: ", "3 bytes", "2.95 kilobytes", "2.95 megabytes", "2.95 gigabytes", "2.95 terabytes"]
    let measuresTabletExpect_8: Array<string> = [
      "size-shortfile-byte: ", "3 bytes", "2.9 kilobytes", "3.0 megabytes", "3.0 gigabytes", "3.0 terabytes"]
    let measuresTabletExpect_9: Array<string> = [
      "size-file-byte: ", "3字节", "2.95千字节", "2.95兆字节", "2.95吉字节", "2.95太字节"]
    let measuresTabletExpect_10: Array<string> = [
      "size-shortfile-byte: ", "3字节", "2.9千字节", "3.0兆字节", "3.0吉字节", "3.0太字节"]

    let LocaleArray: string[] = ["zh-Hant-CN", "zh-Hans-MO", "en-Shaw-GB", "en-US", "en-GB"];
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(async () => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
      await sleep(1000);
    })
    afterAll(async () => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
      await sleep(2000);
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0010
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by dateStyle、timeStyle in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0010', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("en-GB", {
        dateStyle: "auto",
        timeStyle: "auto"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default" ){
        expect(value).assertEqual(formatPhoneExpect[0]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[0]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0020
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by year、month、weekday in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0020', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("en-GB", {
        year: "auto",
        month: "auto",
        weekday: "auto"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[1]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[1]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0030
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by hour、hourCycle、dayPeriod、timeZone in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0030', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("en-GB", {
        hour: "numeric",
        hourCycle: "h12",
        dayPeriod: "auto",
        timeZone: "UTC"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[2]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[2]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0040
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by hour、timeZone in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0040', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("en-GB", {
        hour: "2-digit",
        timeZoneName: "auto"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[3]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[3]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0050
     * @tc.name   : test intl NumberFormat
     * @tc.desc   : test NumberFormat with 123 hectare in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0050', 0, async (done: Function) => {
      let IntlFmt = new Intl.NumberFormat("en-GB", {
        style: "unit",
        unit: "hectare"
      });
      let value = IntlFmt.format(123);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[4]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[4]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0060
     * @tc.name   : test intl NumberFormat
     * @tc.desc   : test NumberFormat with 123 USD in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0060', 0, async (done: Function) => {
      let IntlFmt = new Intl.NumberFormat("en-GB", {
        style: "currency",
        currency: "USD"
      });
      let value = IntlFmt.format(123);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[5]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[5]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0070
     * @tc.name   : test intl RelativeTimeFormat
     * @tc.desc   : test RelativeTimeFormat with -1 day in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0070', 0, async (done: Function) => {
      let IntlFmt = new Intl.RelativeTimeFormat("en-GB");
      let value = IntlFmt.format(-1, "day");
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[6]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[6]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_0080
     * @tc.name   : test intl RelativeTimeFormat
     * @tc.desc   : test RelativeTimeFormat with -1 quarter in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_0080', 0, async (done: Function) => {
      let IntlFmt =new Intl.RelativeTimeFormat("en-GB");
      let value = IntlFmt.format(-1, "quarter");
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[7]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[7]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0010
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by dateStyle、timeStyle in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0010', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("zh-CN", {
        dateStyle: "auto",
        timeStyle: "auto"
      });
      let value = IntlFmt.format(date);
      let expectRes = false
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        if((value == formatPhoneExpect[8] || value == "2024/5/20 下午3:30")){
          expectRes = true
        }
      }else{
        // crossplatform only support tablet
        if((value == formatTabletExpect[8] || value == "2024/5/20 下午3:30")){
          expectRes = true
        }
      }
      expect(expectRes).assertEqual(true);
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0020
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by year、month、weekday in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0020', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("zh-CN", {
        year: "auto",
        month: "auto",
        weekday: "auto"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[9]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[9]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0030
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by numeric、hourCycle、dayPeriod、timeZone in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0030', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("zh-CN", {
        hour: "numeric",
        hourCycle: "h12",
        dayPeriod: "auto",
        timeZone: "UTC"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[10]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[10]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0040
     * @tc.name   : test intl DateTimeFormat
     * @tc.desc   : test NumberFormat by 2-digit、timeZoneName in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0040', 0, async (done: Function) => {
      let IntlFmt = new Intl.DateTimeFormat("zh-CN", {
        hour: "2-digit",
        timeZoneName: "auto"
      });
      let value = IntlFmt.format(date);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[11]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[11]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0050
     * @tc.name   : test intl NumberFormat
     * @tc.desc   : test NumberFormat with 123 hectare in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0050', 0, async (done: Function) => {
      let IntlFmt = new Intl.NumberFormat("zh-CN", {
        style: "unit",
        unit: "hectare"
      });
      let value = IntlFmt.format(123);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[12]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[12]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0060
     * @tc.name   : test intl NumberFormat
     * @tc.desc   : test NumberFormat with 123 CNY in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0060', 0, async (done: Function) => {
      let IntlFmt = new Intl.NumberFormat("zh-CN", {
        style: "currency",
        currency: "CNY"
      });
      let value = IntlFmt.format(123);
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[13]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[13]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0070
     * @tc.name   : test intl RelativeTimeFormat
     * @tc.desc   : test RelativeTimeFormat with -1 day in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0070', 0, async (done: Function) => {
      let IntlFmt = new Intl.RelativeTimeFormat("zh-CN");
      let value = IntlFmt.format(-1, "day");
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[14]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[14]);
      }
      done();
    })

    /**
     * @tc.number : SUB_INTL_FORMAT_ZH_0080
     * @tc.name   : test intl RelativeTimeFormat
     * @tc.desc   : test RelativeTimeFormat with -1 quarter in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_INTL_FORMAT_ZH_0080', 0, async (done: Function) => {
      let IntlFmt =new Intl.RelativeTimeFormat("zh-CN");
      let value = IntlFmt.format(-1, "quarter");
      if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
        expect(value).assertEqual(formatPhoneExpect[15]);
      }else{
        // crossplatform only support tablet
        expect(value).assertEqual(formatTabletExpect[15]);
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0010
     * @tc.name   : test intl measure
     * @tc.desc   : use size-file-byte type test NumberFormat format with 1.0 in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0010', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: 'unit',
        unit: "byte",
        unitUsage: 'size-file-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-file-byte: ");
      resArray.push(numfmt.format(1)); // 1B
      resArray.push(numfmt.format(1000)); // 1KB
      resArray.push(numfmt.format(1000 * 1000)); // 1MB
      resArray.push(numfmt.format(1000 * 1000 * 1000)); // 1GB
      resArray.push(numfmt.format(1000 * 1000 * 1000 * 1000)); // 1TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_1[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_1[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0020
     * @tc.name   : test intl measure
     * @tc.desc   : use size-shortfile-byte type test NumberFormat format with 1.0 in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0020', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: 'unit',
        unit: "megabyte",
        unitUsage: 'size-shortfile-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-shortfile-byte: ");
      resArray.push(numfmt.format(0.000001)); // 1B
      resArray.push(numfmt.format(0.001)); // 1KB
      resArray.push(numfmt.format(1)); // 1MB
      resArray.push(numfmt.format(1000)); // 1GB
      resArray.push(numfmt.format(1000 * 1000)); // 1TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_2[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_2[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0030
     * @tc.name   : test intl measure
     * @tc.desc   : use elapsed-time-second type test NumberFormat format with date format in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0030', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: 'unit',
        unit: "day",
        unitUsage: 'elapsed-time-second'
      });
      let resArray: Array<string> = []
      resArray.push("elapsed-time-second: ");
      resArray.push(numfmt.format(0.00001));
      resArray.push(numfmt.format(0.001));
      resArray.push(numfmt.format(1));
      resArray.push(numfmt.format(1 * 30));
      resArray.push(numfmt.format(1 * 30 * 12));
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_3[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_3[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0040
     * @tc.name   : test intl measure
     * @tc.desc   : use elapsed-time-second type test NumberFormat format with date format in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0040', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: 'unit',
        unit: "day",
        unitUsage: 'elapsed-time-second'
      });
      let resArray: Array<string> = []
      resArray.push("elapsed-time-second: ");
      resArray.push(numfmt.format(0.00001));
      resArray.push(numfmt.format(0.001));
      resArray.push(numfmt.format(1));
      resArray.push(numfmt.format(1 * 30));
      resArray.push(numfmt.format(1 * 30 * 12));
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_4[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_4[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0050
     * @tc.name   : test intl measure
     * @tc.desc   : use size-file-byte type test NumberFormat format with 1.0 in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0050', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: 'unit',
        unit: "byte",
        unitUsage: 'size-file-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-file-byte: ");
      resArray.push(numfmt.format(1)); // 1B
      resArray.push(numfmt.format(1000)); // 1KB
      resArray.push(numfmt.format(1000 * 1000)); // 1MB
      resArray.push(numfmt.format(1000 * 1000 * 1000)); // 1GB
      resArray.push(numfmt.format(1000 * 1000 * 1000 * 1000)); // 1TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_5[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_5[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0060
     * @tc.name   : test intl measure
     * @tc.desc   : use size-shortfile-byte type test NumberFormat format with 1.0 in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0060', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: 'unit',
        unit: "megabyte",
        unitUsage: 'size-shortfile-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-shortfile-byte: ");
      resArray.push(numfmt.format(0.000001)); // 1B
      resArray.push(numfmt.format(0.001)); // 1KB
      resArray.push(numfmt.format(1)); // 1MB
      resArray.push(numfmt.format(1000)); // 1GB
      resArray.push(numfmt.format(1000 * 1000)); // 1TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_6[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_6[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0070
     * @tc.name   : test intl measure
     * @tc.desc   : use size-file-byte type test NumberFormat format with 2.95 in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0070', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: 'unit',
        unit: "byte",
        unitUsage: 'size-file-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-file-byte: ");
      resArray.push(numfmt.format(2.95)); // B
      resArray.push(numfmt.format(2950)); // KB
      resArray.push(numfmt.format(2950000)); // MB
      resArray.push(numfmt.format(2950000000)); // GB
      resArray.push(numfmt.format(2950000000000)); // TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_7[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_7[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0080
     * @tc.name   : test intl measure
     * @tc.desc   : use size-shortfile-byte type test NumberFormat format with 2.95 in en-GB
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0080', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("en-GB", {
        style: 'unit',
        unit: "megabyte",
        unitUsage: 'size-shortfile-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-shortfile-byte: ");
      resArray.push(numfmt.format(0.00000295)); // B
      resArray.push(numfmt.format(0.00295)); // KB
      resArray.push(numfmt.format(2.95)); // MB
      resArray.push(numfmt.format(2950)); // GB
      resArray.push(numfmt.format(2950 * 1000)); // TB
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_8[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_8[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0090
     * @tc.name   : test intl measure
     * @tc.desc   : use size-file-byte type test NumberFormat format with 2.95 in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0090', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("zh-cn", {
        style: 'unit',
        unit: "byte",
        unitUsage: 'size-file-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-file-byte: ");
      resArray.push(numfmt.format(2.95)); 
      resArray.push(numfmt.format(2950)); 
      resArray.push(numfmt.format(2950000)); 
      resArray.push(numfmt.format(2950000000)); 
      resArray.push(numfmt.format(2950000000000)); 
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_9[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_9[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_Intl_MEASURES_0100
     * @tc.name   : test intl measure
     * @tc.desc   : use size-shortfile-byte type test NumberFormat format with 2.95 in zh-CN
     * @tc.level  : Level 0
     */
    it('SUB_Intl_MEASURES_0100', 0, async (done: Function) => {
      let numfmt = new Intl.NumberFormat("zh-CN", {
        style: 'unit',
        unit: "megabyte",
        unitUsage: 'size-shortfile-byte'
      });
      let resArray: Array<string> = []
      resArray.push("size-shortfile-byte: ");
      resArray.push(numfmt.format(0.00000295));
      resArray.push(numfmt.format(0.00295));
      resArray.push(numfmt.format(2.95));
      resArray.push(numfmt.format(2950));
      resArray.push(numfmt.format(2950 * 1000));
      for (let i = 0; i < measuresArrayLength; i++) {
        if(deviceInfo.deviceType == "Handset" || deviceInfo.deviceType == "phone" || deviceInfo.deviceType == "default"){
          expect(resArray[i]).assertEqual(measuresPhoneExpect_10[i]);
        }else{
          // crossplatform only support tablet
          expect(resArray[i]).assertEqual(measuresTabletExpect_10[i]);
        }
      }
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0010
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : zh-CN matched zh-Hans-MO
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0010', 0, async (done: Function) => {
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("zh-CN", LocaleArray);
      expect(BestLocale).assertEqual("zh-Hans-MO");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0020
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : zh-Hant-CN matched zh-Hant-CN
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0020', 0, async (done: Function) => {
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("zh-Hant-CN", LocaleArray);
      expect(BestLocale).assertEqual("zh-Hant-CN");
      done();
    })


    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0030
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : en-AU matched en-GB
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0030', 0, async (done: Function) => {
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("en-AU", LocaleArray);
      expect(BestLocale).assertEqual("en-GB");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0040
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : en-Latn-US matched en-US
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0040', 0, async (done: Function) => {
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("en-Latn-US", LocaleArray);
      expect(BestLocale).assertEqual("en-US");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0050
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : invalid locale id
     * @tc.level  : Level 2
     */
    it('SUB_I18n_getBestMatchLocale_0050', 2, async (done: Function) => {
      try {
        let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("error data", LocaleArray);
      } catch(error) {
        let err: BusinessError = error as BusinessError;
        expect(err.code).assertEqual("890001");
      }
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0060
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : system locale is empty
     * @tc.level  : Level 2
     */
    it('SUB_I18n_getBestMatchLocale_0060', 2, async (done: Function) => {
      try {
        let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("", LocaleArray);
      } catch(error) {
        let err: BusinessError = error as BusinessError;
        expect(err.code).assertEqual("890001");
      }
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0070
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : resource list is empty
     * @tc.level  : Level 2
     */
    it('SUB_I18n_getBestMatchLocale_0070', 2, async (done: Function) => {
      try {
        let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("zh-CN", []);
      } catch(error) {
        let err: BusinessError = error as BusinessError;
        expect(err.code).assertEqual("890001");
      }
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0080
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : The system language is the same, but the area is different from the system area. The system area is empty,
     the resource area is not empty, and the system language is en-qaq
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0080', 0, async (done: Function) => {
      done();
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("en-qaq", LocaleArray);
      expect(BestLocale).assertEqual("en-Latn-US");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0090
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : system language is same, system locale is same, match the same language
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0090', 0, async (done: Function) => {
      done();
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("en-Shaw-GB", LocaleArray);
      expect(BestLocale).assertEqual("en-Shaw-GB");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0100
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : system language is same, system locale is empty, match the resource with locale empty
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0100', 0, async (done: Function) => {
      done();
      let BestLocale: string = I18n.I18NUtil.getBestMatchLocale("zh", ["en-Latn-US","zh","zh-Hant-CN","zh-Hans-MO", "en-GB"]);
      expect(BestLocale).assertEqual("zh");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0110
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : getBestMatchLocale performance test
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0110', 0, async (done: Function) => {
      let exeTime = 0;
      let EXETIME = 100;
      for (let i = 0; i < EXETIME; i++) {
        let eachStartTime = new Date().getTime();
        I18n.I18NUtil.getBestMatchLocale("en-Latn-AU", ["en-Latn-US","en-Latn","en-Latn-GB",]);
        let eachExeTime = new Date().getTime() - eachStartTime;
        exeTime = exeTime + eachExeTime;
      }
      let avgTime = exeTime / EXETIME;
      expect(avgTime < 0.5).assertTrue();
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0120
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : system local matched by alphabetically
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0120', 0, async (done: Function) => {
      let matchedLocaleId: string = I18n.I18NUtil.getBestMatchLocale("zh-Hant-MO", ["zh-Hant-HK", "zh-Hant-CN","zh-Hant-AR"]);
      expect(matchedLocaleId).assertEqual("zh-Hant-HK");
      done();
    })

    /**
     * @tc.number : SUB_I18n_getBestMatchLocale_0130
     * @tc.name   : test the getBestMatchLocale interface
     * @tc.desc   : en-Qaag matched en-Latn-US
     * @tc.level  : Level 0
     */
    it('SUB_I18n_getBestMatchLocale_0130', 0, () => {
      let matchedLocaleId: string = I18n.I18NUtil.getBestMatchLocale("en-Qaag", ["en-GB","en-Latn-US","en-IM","en-IM","en-GI"]);
      expect(matchedLocaleId).assertEqual("en-Latn-US");
    })
  })
}