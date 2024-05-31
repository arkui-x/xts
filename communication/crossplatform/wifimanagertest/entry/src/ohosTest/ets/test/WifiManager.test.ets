import wifiManager from '@ohos.wifiManager';
import { describe, beforeAll, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';

const COMMON_DELAY = 3000;

function sleep(time: number = COMMON_DELAY): Promise<void> {
  return new Promise((res) => setTimeout(res, time));
};

export default function abilityTest() {
  describe('WifiManegerTest', () => {
    beforeAll(() => {
      console.log('************* start wifiManegerTest *************');
    })
    afterAll(() => {
      console.log('************* end wifiManegerTest *************');
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_startScan_Func_0100
    * @tc.name:    test startScan method
    * @tc.desc:    start scan
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_startScan_Func_0100', 0, async () => {
      try {
        wifiManager.startScan();
      } catch (err) {
        console.log(`SUB_Communication_Wifi_Manager_startScan_Func_0100 errCode ${err.code}`);
        console.log(`SUB_Communication_Wifi_Manager_startScan_Func_0100 errMessage ${err.message}`);
      }
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getScanInfoList_Func_0200
    * @tc.name:    test getScanInfoList method
    * @tc.desc:    start scan
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getScanInfoList_Func_0200', 0, () => {
      let scanInfoList: Array<wifiManager.WifiScanInfo> = wifiManager.getScanInfoList();
      console.log(`SUB_Communication_Wifi_Manager_getScanInfoList_Func_0200 ${JSON.stringify(scanInfoList)}`);
      expect(scanInfoList !== null).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0300
    * @tc.name:    test setScanAlwaysAllowed method
    * @tc.desc:    set scanAlwaysAllowed
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0300', 0, () => {
      try {
        let isScanAlwaysAllowed: boolean = true;
        wifiManager.setScanAlwaysAllowed(isScanAlwaysAllowed);
        let value: boolean = wifiManager.getScanAlwaysAllowed();
        console.log('SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0300 ', value);
        expect(value).assertTrue();
      } catch (error) {
        console.log(`SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0300 errCode ${error.code}`);
        console.log(`SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0300 errMessage ${error.message}`);
      }
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0400
    * @tc.name:    test setScanAlwaysAllowed method
    * @tc.desc:    set scanAlwaysAllowed
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0400', 0, () => {
      try {
        let isScanAlwaysAllowed: boolean = false;
        wifiManager.setScanAlwaysAllowed(isScanAlwaysAllowed);
        let value: boolean = wifiManager.getScanAlwaysAllowed();
        console.log('SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0400 ', value);
        expect(value).assertFalse()
      } catch (error) {
        console.log(`SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0400 errCode ${error.code}`);
        console.log(`SUB_Communication_Wifi_Manager_setScanAlwaysAllowed_Func_0400 errMessage ${error.message}`);
      }
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0500
    * @tc.name:    test getScanAlwaysAllowed method
    * @tc.desc:    get scanAlwaysAllowed
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0500', 0, () => {
      wifiManager.setScanAlwaysAllowed(true);
      let value: boolean = wifiManager.getScanAlwaysAllowed();
      expect(value).assertTrue();
      console.log(`SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0500 ${value}`);
    })


    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0600
    * @tc.name:    test getScanAlwaysAllowed method
    * @tc.desc:    get scanAlwaysAllowed
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0600', 0, () => {
      wifiManager.setScanAlwaysAllowed(false);
      let value: boolean = wifiManager.getScanAlwaysAllowed();
      expect(value).assertFalse();
      console.log(`SUB_Communication_Wifi_Manager_getScanAlwaysAllowed_Func_0600 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getIpv6Info_Func_0700
    * @tc.name:    test getIpv6Info method
    * @tc.desc:    get Ipv6Info
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getIpv6Info_Func_0700', 0, () => {
      let value: wifiManager.Ipv6Info = wifiManager.getIpv6Info();
      expect(value !== null).assertTrue();
      console.log(`SUB_Communication_Wifi_Manager_getIpv6Info_Func_0700 ${JSON.stringify(value)}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0800
    * @tc.name:    test isBandTypeSupported method throw 401 error code
    * @tc.desc:    get the value of isBandTypeSupported
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0800', 0, () => {
      try {
        // param not correct,throw 401 error code
        let value: boolean = wifiManager.isBandTypeSupported(0);
        console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0800 ${value}`);
      } catch (err) {
        console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0800 errCode ${err.code}}`);
        console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0800 errMessage ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0900
    * @tc.name:    test isBandTypeSupported method
    * @tc.desc:    get the value of isBandTypeSupported
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0900', 0, () => {
      let value: boolean = wifiManager.isBandTypeSupported(1);
      expect(value).assertInstanceOf("Boolean");
      console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_0900 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1000
    * @tc.name:    test isBandTypeSupported method
    * @tc.desc:    get the value of isBandTypeSupported
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1000', 0, () => {
      let value: boolean = wifiManager.isBandTypeSupported(2);
      expect(value).assertInstanceOf("Boolean");
      console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1000 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1100
    * @tc.name:    test isBandTypeSupported method
    * @tc.desc:    get the value of isBandTypeSupported
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1100', 0, () => {
      let value: boolean = wifiManager.isBandTypeSupported(3);
      expect(value).assertInstanceOf("Boolean");
      console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1100 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1200
    * @tc.name:    test isBandTypeSupported method
    * @tc.desc:    get the value of isBandTypeSupported
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1200', 0, () => {
      let value: boolean = wifiManager.isBandTypeSupported(4);
      expect(value).assertInstanceOf("Boolean");
      console.log(`SUB_Communication_Wifi_Manager_isBandTypeSupported_Func_1200 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_get5GChannelList_Func_1300
    * @tc.name:    test get5GChannelList method
    * @tc.desc:    get the 5GChannelList
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_get5GChannelList_Func_1300', 0, () => {
      let value: Array<number> = wifiManager.get5GChannelList();
      expect(value !== null).assertTrue();
      console.log(`SUB_Communication_Wifi_Manager_get5GChannelList_Func_1300 ${value}`);
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400
    * @tc.name:    test getDisconnectedReason method
    * @tc.desc:    get the DisconnectedReason
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400', 0, async () => {
      // if wifi is not turned on, turn it on, then disconnect it, and then turn it on again
      if (!wifiManager.isWifiActive()) {
        try {
          wifiManager.enableWifi();
        } catch (err) {
          console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
        }
        await sleep();
        try {
          wifiManager.disableWifi();
        } catch (err) {
          console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
        }
        await sleep();
        try {
          wifiManager.enableWifi();
        } catch (err) {
          console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
        }
      } else {
        // if wifi is already turned on, simply disconnect and turn it on again
        try {
          wifiManager.disableWifi();
        } catch (err) {
          console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
        }
        await sleep();
        try {
          wifiManager.enableWifi();
        } catch (err) {
          console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
        }
      }
      await sleep();
      console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 ${JSON.stringify(wifiManager.isWifiActive())}`);
      try {
        let value: wifiManager.DisconnectedReason = wifiManager.getDisconnectedReason();
        expect(value).assertEqual(0);
        console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 ${value}`);
      } catch (err) {
        console.log(`SUB_Communication_Wifi_Manager_getDisconnectedReason_Func_1400 failed ${JSON.stringify(err)}`);
      }
    })
  })
}