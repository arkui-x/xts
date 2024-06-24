import I18n from '@ohos.i18n';
import { describe, beforeAll, afterAll, it, expect } from '@ohos/hypium';

export default function I18nTest() {
  describe('I18nTest', () => {
    beforeAll(() => {
      console.log('************* start I18NTest *************');
    })
    afterAll(() => {
      console.log('************* end I18NTest *************');
    })

    /* *
    * @tc.number:  SUB_Global_I18n_PhoneNumberFormat_Func_0100
    * @tc.name:    test PhoneNumberFormat method
    * @tc.desc:    create a PhoneNumberFormat object
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_PhoneNumberFormat_Func_0100', 0, () => {
      let value: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        "type": "E164"
      });
      console.log(`SUB_Global_I18n_PhoneNumberFormat_Func_0100 ${value}`);
      expect(value != null).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_PhoneNumberFormat_Func_0200
    * @tc.name:    test PhoneNumberFormat method
    * @tc.desc:    create a PhoneNumberFormat object
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_PhoneNumberFormat_Func_0200', 0, () => {
      let value: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        "type": "INTERNATIONAL"
      });
      console.log(`SUB_Global_I18n_PhoneNumberFormat_Func_0200 ${value}`);
      expect(value != null).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_PhoneNumberFormat_Func_0300
    * @tc.name:    test PhoneNumberFormat method
    * @tc.desc:    create a PhoneNumberFormat object
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_PhoneNumberFormat_Func_0300', 0, () => {
      let value: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        "type": "NATIONAL"
      });
      console.log(`SUB_Global_I18n_PhoneNumberFormat_Func_0300 ${value}`);
      expect(value != null).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_PhoneNumberFormat_Func_0400
    * @tc.name:    test PhoneNumberFormat method
    * @tc.desc:    create a PhoneNumberFormat object
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_PhoneNumberFormat_Func_0400', 0, () => {
      let value: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        "type": "RFC3966"
      });
      console.log(`SUB_Global_I18n_PhoneNumberFormat_Func_0400 ${value}`);
      expect(value != null).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_0500
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_0500', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("15825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_0500 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_0600
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_0600', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("110");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_0600 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_0700
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_0700', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("8615825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_0700 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_0800
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_0800', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("+8615825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_0800 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_0900
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_0900', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("158-2548-2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_0900 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1000
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1000', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("158 2548 2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1000 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1100
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1100', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("+86-158-2548-2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1100 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1200
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1200', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("86-158-2548-2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1200 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1300
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1300', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("86 158 2548 2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1300 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1400
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1400', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("+86 158 2548 2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1400 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1500
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1500', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:+86 158 2548 2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1500 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1600
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1600', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:+86-158-2548-2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1600 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1700
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1700', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:+8615825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1700 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1800
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1800', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:8615825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1800 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_1900
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_1900', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:15825482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_1900 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2000
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2000', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:158 2548 2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2000 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2100
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2100', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("tel:158-2548-2312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2100 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2200
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2200', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("0755-61000887");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2200 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2300
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2300', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("075561000887");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2300 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2400
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2400', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("0755 61000887");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2400 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2500
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2500', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("61000887");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2500 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2600
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2600', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("158312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2600 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2700
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2700', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("1583125482312");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2700 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2800
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2800', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("1583125482a");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2800 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_2900
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_2900', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: boolean = phonenumberfmt.isValidNumber("not a number");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_2900 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_3000
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_3000', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US");
      let value: boolean = phonenumberfmt.isValidNumber("6262023375");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_3000 ${value}`);
      expect(value).assertTrue();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_3100
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_3100', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US");
      let value: boolean = phonenumberfmt.isValidNumber("626202337");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_3100 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_3200
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_3200', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US");
      let value: boolean = phonenumberfmt.isValidNumber("62620233756");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_3200 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_IsValidNumber_Func_3300
    * @tc.name:    test isValidNumber method
    * @tc.desc:    test a phoneNumber is valid or not
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_IsValidNumber_Func_3300', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US");
      let value: boolean = phonenumberfmt.isValidNumber("626202337a");
      console.log(`SUB_Global_I18n_IsValidNumber_Func_3300 ${value}`);
      expect(value).assertFalse();
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3400
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3400', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: string = phonenumberfmt.format("15825482312");
      console.log(`SUB_Global_I18n_Format_Func_3400 ${value}`);
      expect(value).assertEqual("158 2548 2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3500
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3500', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US");
      let value: string = phonenumberfmt.format("6262023375");
      console.log(`SUB_Global_I18n_Format_Func_3500 ${value}`);
      expect(value).assertEqual("(626) 202-3375");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3600
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3600', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'NATIONAL'
      });
      let value: string = phonenumberfmt.format("15825482312");
      console.log(`SUB_Global_I18n_Format_Func_3600 ${value}`);
      expect(value).assertEqual("158 2548 2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3700
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3700', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'NATIONAL'
      });
      let value: string = phonenumberfmt.format("1582548231");
      console.log(`SUB_Global_I18n_Format_Func_3700 ${value}`);
      expect(value).assertEqual("1582548231");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3800
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3800', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'NATIONAL'
      });
      let value: string = phonenumberfmt.format("158254823123");
      console.log(`SUB_Global_I18n_Format_Func_3800 ${value}`);
      expect(value).assertEqual("015 825 482 3123");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_3900
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_3900', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'NATIONAL'
      });
      let value: string = phonenumberfmt.format("158 2548 2312");
      console.log(`SUB_Global_I18n_Format_Func_3900 ${value}`);
      expect(value).assertEqual("158 2548 2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4000
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4000', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'INTERNATIONAL'
      });
      let value: string = phonenumberfmt.format("15825482312");
      console.log(`SUB_Global_I18n_Format_Func_4000 ${value}`);
      expect(value).assertEqual("+86 158 2548 2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4100
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4100', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'RFC3966'
      });
      let value: string = phonenumberfmt.format("15825482312");
      console.log(`SUB_Global_I18n_Format_Func_4100 ${value}`);
      expect(value).assertEqual("tel:+86-158-2548-2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4200
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4200', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN", {
        'type': 'E164'
      });
      let value: string = phonenumberfmt.format("15825482312");
      console.log(`SUB_Global_I18n_Format_Func_4200 ${value}`);
      expect(value).assertEqual("+8615825482312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4300
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4300', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US", {
        'type': 'NATIONAL'
      });
      let value: string = phonenumberfmt.format("6262023376");
      console.log(`SUB_Global_I18n_Format_Func_4300 ${value}`);
      expect(value).assertEqual("(626) 202-3376");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4400
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4400', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US", {
        'type': 'INTERNATIONAL'
      });
      let value: string = phonenumberfmt.format("6262023376");
      console.log(`SUB_Global_I18n_Format_Func_4400 ${value}`);
      expect(value).assertEqual("+1 626-202-3376");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4500
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4500', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US", {
        'type': 'RFC3966'
      });
      let value: string = phonenumberfmt.format("6262023376");
      console.log(`SUB_Global_I18n_Format_Func_4500 ${value}`);
      expect(value).assertEqual("tel:+1-626-202-3376");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4600
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4600', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("US", {
        'type': 'E164'
      });
      let value: string = phonenumberfmt.format("6262023376");
      console.log(`SUB_Global_I18n_Format_Func_4600 ${value}`);
      expect(value).assertEqual("+16262023376");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4700
    * @tc.name:    test format method
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4700', 0, () => {
      let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
      let value: string = phonenumberfmt.format("158****2312");
      console.log(`SUB_Global_I18n_Format_Func_4700 ${value}`);
      expect(value).assertEqual("158 2312");
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Format_Func_4800
    * @tc.name:    test format method 401 throw error code
    * @tc.desc:    format phoneNumber
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Format_Func_4800', 0, () => {
      try {
        let phonenumberfmt: I18n.PhoneNumberFormat = new I18n.PhoneNumberFormat("CN");
        // param number not correct,throw 448 error code
        let value: string = phonenumberfmt.format("not a number");
        console.log(`SUB_Global_I18n_Format_Func_4800 ${value}`);
      } catch (err) {
        console.log(`SUB_Global_I18n_Format_Func_4800 err.code ${err.code}`)
        console.log(`SUB_Global_I18n_Format_Func_4800 err.message ${err.message}`)
        expect(err.code === 401).assertTrue();
      }
    })

    /* *
    * @tc.number:  SUB_Global_I18n_GetTimeInMillis_Func_4900
    * @tc.name:    test getTimeInMillis method
    * @tc.desc:    get the timeInMillis
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_GetTimeInMillis_Func_4900', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar("en-US", "gregory");
      calendar.setTime(10540800000);
      let value: number = calendar.getTimeInMillis()
      console.log(`SUB_Global_I18n_GetTimeInMillis_Func_4900 ${value}`);
      expect(value).assertEqual(10540800000);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5000
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5000', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('year', 8);
      let value: number = calendar.get('year');
      console.log(`SUB_Global_I18n_Add_Func_5000 ${value}`);
      expect(value).assertEqual(2029);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5100
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5100', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('month', 8);
      let value: number = calendar.get('month');
      console.log(`SUB_Global_I18n_Add_Func_5100 ${value}`);
      expect(value).assertEqual(7);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5200
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5200', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('week_of_year', 8);
      let value: number = calendar.get('week_of_year');
      console.log(`SUB_Global_I18n_Add_Func_5200 ${value}`);
      expect(value).assertEqual(6);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5300
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5300', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('week_of_month', 8);
      let value: number = calendar.get('week_of_month');
      console.log(`SUB_Global_I18n_Add_Func_5300 ${value}`);
      expect(value).assertEqual(1);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5400
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5400', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('date', 8);
      let value: number = calendar.get('date');
      console.log(`SUB_Global_I18n_Add_Func_5400 ${value}`);
      expect(value).assertEqual(19);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5500
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5500', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('day_of_year', 8);
      let value: number = calendar.get('day_of_year');
      console.log(`SUB_Global_I18n_Add_Func_5500 ${value}`);
      expect(value).assertEqual(353);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5600
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5600', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('day_of_week', 8);
      let value: number = calendar.get('day_of_week');
      console.log(`SUB_Global_I18n_Add_Func_5600 ${value}`);
      expect(value).assertEqual(1);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5700
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5700', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('day_of_week_in_month', 8);
      let value: number = calendar.get('day_of_week_in_month');
      console.log(`SUB_Global_I18n_Add_Func_5700 ${value}`);
      expect(value).assertEqual(1);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5800
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5800', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('hour', 8);
      let value: number = calendar.get('hour');
      console.log(`SUB_Global_I18n_Add_Func_5800 ${value}`);
      expect(value).assertEqual(4);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_5900
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_5900', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('hour_of_day', 8);
      let value: number = calendar.get('hour_of_day');
      console.log(`SUB_Global_I18n_Add_Func_5900 ${value}`);
      expect(value).assertEqual(16);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_6000
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_6000', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('minute', 8);
      let value: number = calendar.get('minute');
      console.log(`SUB_Global_I18n_Add_Func_6000 ${value}`);
      expect(value).assertEqual(8);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_6100
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_6100', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      // 设置日期 2021年12月11号8:00:00
      calendar.set(2021, 11, 11, 8, 0, 0);
      calendar.add('second', 8);
      let value: number = calendar.get('second');
      console.log(`SUB_Global_I18n_Add_Func_6100 ${value}`);
      expect(value).assertEqual(8);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_6200
    * @tc.name:    test add method
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_6200', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      calendar.setTime(10540800000);
      calendar.add('millisecond', 8);
      let value: number = calendar.getTimeInMillis();
      console.log(`SUB_Global_I18n_Add_Func_6200 ${value}`);
      expect(value).assertEqual(10540800008);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_Add_Func_6300
    * @tc.name:    test add method throw 401 error code
    * @tc.desc:    add calendar
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_Add_Func_6300', 0, () => {
      try {
        let calendar: I18n.Calendar = I18n.getCalendar("zh-CN");
        // param field not correct,throw 890063 error code
        calendar.add('day', 1)
      } catch (err) {
        console.log(`SUB_Global_I18n_Add_Func_6300 err.code ${err.code}`)
        console.log(`SUB_Global_I18n_Add_Func_6300 err.message ${err.message}`)
        expect(err.code == 890001).assertTrue();
      }
    })

    /* *
    * @tc.number:  SUB_Global_I18n_CompareDays_Func_6400
    * @tc.name:    test compareDays method
    * @tc.desc:    compare days between calendar and date
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_CompareDays_Func_6400', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      calendar.setTime(5000);
      let date: Date = new Date(6000);
      let value: number = calendar.compareDays(date);
      console.log(`SUB_Global_I18n_CompareDays_Func_6400 ${value}`);
      expect(value).assertEqual(1);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_CompareDays_Func_6500
    * @tc.name:    test compareDays method
    * @tc.desc:    compare days between calendar and date
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_CompareDays_Func_6500', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      calendar.setTime(5000);
      let date: Date = new Date(4000);
      let value: number = calendar.compareDays(date);
      console.log(`SUB_Global_I18n_CompareDays_Func_6500 ${value}`);
      expect(value).assertEqual(-1);
    })

    /* *
    * @tc.number:  SUB_Global_I18n_CompareDays_Func_6600
    * @tc.name:    test compareDays method
    * @tc.desc:    compare days between calendar and date
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_I18n_CompareDays_Func_6600', 0, () => {
      let calendar: I18n.Calendar = I18n.getCalendar('zh-CN');
      calendar.setTime(5000);
      let date: Date = new Date(5000);
      let value: number = calendar.compareDays(date);
      console.log(`SUB_Global_I18n_CompareDays_Func_6600 ${value}`);
      expect(value).assertEqual(0);
    })
  })
}