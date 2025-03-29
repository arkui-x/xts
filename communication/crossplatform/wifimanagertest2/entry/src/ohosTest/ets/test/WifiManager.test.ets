import wifiManager from '@ohos.wifiManager';
import { describe, beforeAll, afterAll, beforeEach, it, expect } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function abilityTest() {
  describe('WifiManegerTest', () => {
    beforeAll(async () => {
      await sleep(500);
      console.log('************* start wifiManegerTest *************');
    })

    beforeEach(async () => {
      await sleep(500);
      console.log('************* start wifiManegerTest *************');
    })

    afterAll(async () => {
      await sleep(500);
      console.log('************* end wifiManegerTest *************');
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100
    * @tc.name:    test getLinkedInfo method in promise mode
    * @tc.desc:    get the LinkedInfo
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100', 0, async (done: Function) => {
      wifiManager.getLinkedInfo().then(data => {
        console.log(`SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100  ${JSON.stringify(data)}`);
        expect(data != null).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200
    * @tc.name:    test getLinkedInfo method in callback mode
    * @tc.desc:    get the LinkedInfo
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200', 0, async (done: Function) => {
      wifiManager.getLinkedInfo((err, data) => {
        console.log(`SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200 ${JSON.stringify(data)}`);
        expect(data != null).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isConnected_Func_0100
    * @tc.name:    test isConnected method
    * @tc.desc:    get the isConnected
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isConnected_Func_0100', 0, async () => {
      let value: boolean = wifiManager.isConnected();
      console.log(`SUB_Communication_Wifi_Manager_isConnected_Func_0100 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isWifiActive_Func_0100
    * @tc.name:    test isWifiActive method
    * @tc.desc:    get the isWifiActive
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isWifiActive_Func_0100', 0, async (done:Function) => {
      // IOS 平台不支持
      if (platform == 'iOS') {
        expect(true).assertTrue();
        done();
      }else {
        let value: boolean = wifiManager.isWifiActive();
        console.log(`SUB_Communication_Wifi_Manager_isWifiActive_Func_0100 ${value}`);
        expect(value).assertTrue();
        done();
      }
    })
  })
}