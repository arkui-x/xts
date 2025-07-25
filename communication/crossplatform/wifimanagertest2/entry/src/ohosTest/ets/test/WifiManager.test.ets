import wifiManager from '@ohos.wifiManager';
import { describe, beforeAll, afterAll, beforeEach, it, expect, TestType, Level, Size } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function abilityTest() {
  describe('WifiManegerTest', () => {
    beforeAll(async () => {
      await sleep(300);
      console.log('************* start wifiManegerTest *************');
    })

    beforeEach(async () => {
      await sleep(300);
      console.log('************* start wifiManegerTest *************');
    })

    afterAll(async () => {
      await sleep(500);
      console.log('************* end wifiManegerTest *************');
    })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100
    * @tc.name:    SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100
    * @tc.desc:    test getLinkedInfo method in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        wifiManager.getLinkedInfo().then(data => {
          console.log(`SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0100  ${JSON.stringify(data)}`);
          expect(data != null).assertTrue();
          done();
        })
      })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200
    * @tc.name:    SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200
    * @tc.desc:    test getLinkedInfo method in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        wifiManager.getLinkedInfo((err, data) => {
          console.log(`SUB_Communication_Wifi_Manager_getLinkedInfo_Func_0200 ${JSON.stringify(data)}`);
          expect(data != null).assertTrue();
          done();
        })
      })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isConnected_Func_0100
    * @tc.name:    SUB_Communication_Wifi_Manager_isConnected_Func_0100
    * @tc.desc:    test isConnected method
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isConnected_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        let value: boolean = wifiManager.isConnected();
        console.log(`SUB_Communication_Wifi_Manager_isConnected_Func_0100 ${value}`);
        expect(value).assertTrue();
      })

    /* *
    * @tc.number:  SUB_Communication_Wifi_Manager_isWifiActive_Func_0100
    * @tc.name:    SUB_Communication_Wifi_Manager_isWifiActive_Func_0100
    * @tc.desc:    test isWifiActive method
    * @tc.size:    MediumTest
    * @tc.type:    Function
    * @tc.level:   level 2
    */
    it('SUB_Communication_Wifi_Manager_isWifiActive_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        // IOS 平台不支持
        if (platform == 'iOS') {
          expect(true).assertTrue();
          done();
        } else {
          let value: boolean = wifiManager.isWifiActive();
          console.log(`SUB_Communication_Wifi_Manager_isWifiActive_Func_0100 ${value}`);
          expect(value).assertTrue();
          done();
        }
      })
  })
}