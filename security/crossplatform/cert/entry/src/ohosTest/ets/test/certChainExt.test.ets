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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from "@ohos/hypium";
import cert from '@ohos.security.cert';
import { BusinessError } from '@ohos.base';
import { sleep } from './utils/common/commonFunction';

export default function certFrameworkCertChainExtJsAPIFunctionTestUnit() {
  describe("certFrameworkCertChainExtJsAPIFunctionTestUnit", () => {
    afterEach(async () => {
      await sleep(1000)
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0100
     * @tc.name check buildX509CertChain with all correct param
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0100", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0100";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: 10,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2,
                nameConstraints: new Uint8Array([0x30, 0x53, 0xA0, 0x51, 0x30, 0x0E, 0x82, 0x0C, 0x77, 0x77, 0x77, 0x2E, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x6F, 0x72, 0x67, 0x30, 0x0A, 0x82, 0x08, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x63, 0x6F, 0x6D, 0x30, 0x0F, 0x81, 0x0D, 0x67, 0x6F, 0x6F, 0x64, 0x40, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x6F, 0x72, 0x67, 0x30, 0x0A, 0x81, 0x08, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x63, 0x6F, 0x6D, 0x30, 0x0A, 0x87, 0x08, 0x7F, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x30, 0x0A, 0x87, 0x08, 0xC0, 0xA8, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00])
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          expect(data.validationResult.trustAnchor.nameConstraints != null).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0200
     * @tc.name check buildX509CertChain with certMatchParameters.validDate has expired.
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0200", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0200";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '21231212080000Z'
          },
          maxLength: 10,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(err.code == cert.CertResult.INVALID_PARAMS).assertTrue();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0300
     * @tc.name check buildX509CertChain with certMatchParameters empty
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0300", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0300";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {},
          maxLength: 10,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0400
     * @tc.name check buildX509CertChain with maxlength=0
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0400", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0400";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: 0,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 1).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0500
     * @tc.name check buildX509CertChain with maxlength=1
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0500", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0500";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: 1,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0600
     * @tc.name check buildX509CertChain with maxlength>cert
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0600", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0600";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: 10,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });


    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0700
     * @tc.name check buildX509CertChain with maxlength<=cert
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0700", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0700";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: 1,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0800
     * @tc.name check buildX509CertChain with maxlength invalid
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0800", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0800";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          maxLength: -1,
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_0900
     * @tc.name check buildX509CertChain without maxlength
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_0900", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_0900";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(data.certChain.getCertList().length == 2).assertTrue();
          expect(data.validationResult.trustAnchor.CACert?.getNotBeforeTime() == '201212201944Z').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1000
     * @tc.name check buildX509CertChain with abnormal param trustAnchors.CACert
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1000", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1000";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert1
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(err.code == cert.CertResult.INVALID_PARAMS).assertTrue();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1100
     * @tc.name check buildX509CertChain with abnormal param trustAnchors.nameConstraints
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1100", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1100";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2,
                nameConstraints: new Uint8Array([0x40, 0x53, 0xA0, 0x51, 0x30, 0x0E, 0x82, 0x0C, 0x77, 0x77, 0x77, 0x2E, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x6F, 0x72, 0x67, 0x30, 0x0A, 0x82, 0x08, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x63, 0x6F, 0x6D, 0x30, 0x0F, 0x81, 0x0D, 0x67, 0x6F, 0x6F, 0x64, 0x40, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x6F, 0x72, 0x67, 0x30, 0x0A, 0x81, 0x08, 0x67, 0x6F, 0x6F, 0x64, 0x2E, 0x63, 0x6F, 0x6D, 0x30, 0x0A, 0x87, 0x08, 0x7F, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x30, 0x0A, 0x87, 0x08, 0xC0, 0xA8, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00])
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(err.code == cert.CertResult.INVALID_PARAMS).assertTrue();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1200
     * @tc.name check buildX509CertChain with validateParameters.date has expired.
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1200", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1200";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            date: '21231212080000Z',
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(err.code == cert.CertResult.INVALID_PARAMS).assertTrue();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1300
     * @tc.name check buildX509CertChain with validateParameters.date empty
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1300", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1300";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            date: '',
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(error.code == cert.CertResult.INVALID_PARAMS).assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1400
     * @tc.name check buildX509CertChain with validateParameters.trustAnchors empty
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1400", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1400";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            trustAnchors: [],
            certCRLs: [collection]
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(error.code == cert.CertResult.INVALID_PARAMS).assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_CertChainExt_Func_1500
     * @tc.name check buildX509CertChain with validateParameters.certCRLs empty
     * @tc.desc Use Promise Type
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_CertChainExt_Func_1500", 0, async (done: Function) => {
      let caseName = "SUB_Security_Cert_Framework_CertChainExt_Func_1500";
      let x509Cert1 = await createX509Cert1();
      let x509Cert2 = await createX509Cert2();
      const collection = cert.createCertCRLCollection([x509Cert1, x509Cert2]);
      try {
        let param: cert.CertChainBuildParameters = {
          certMatchParameters: {
            validDate: '20231212080000Z'
          },
          validationParameters: {
            trustAnchors: [
              {
                CACert: x509Cert2
              }
            ],
            certCRLs: []
          }
        }

        cert.buildX509CertChain(param).then((data) => {
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} createX509CertChain failed, err: ${JSON.stringify(err)}`);
          expect(null).assertFail();
          done();
        });
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(error.code == cert.CertResult.INVALID_PARAMS).assertTrue();
        done();
      }
    });
  });
}


async function createX509Cert1(): Promise<cert.X509Cert> {
  let certDataNC = "-----BEGIN CERTIFICATE-----\r\n" +
    "MIIDHTCCAgWgAwIBAgIBAjANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxUZXN0\r\n" +
    "IE5DIENBIDEwIBcNMjExMjAyMTcyNTAyWhgPMjEyMTEyMDMxNzI1MDJaMDwxIzAh\r\n" +
    "BgNVBAoMGkdvb2QgTkMgVGVzdCBDZXJ0aWZpY2F0ZSAxMRUwEwYDVQQDDAx3d3cu\r\n" +
    "Z29vZC5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDqx1t7HiPe\r\n" +
    "kRAWdiGUt4pklKGZ7338An6R7/y0e/8Grx2jeUfyc19BAB7MW1p8L+zdMjbclNE0\r\n" +
    "UZ6RZZNexfgMksNI/nW+4Lzu8qu2wFx1MjbTpMT8w/vnsGBMthxLu6+2wdnpdD1B\r\n" +
    "0led8xu7PSBgVULqyHcUvoLeRGEsB14yGx7dbIsokYxno1nr4u3BK5ic9KTTSxJR\r\n" +
    "Ig93qwo2pAZR7mfnOo33B9alhzvSwmEKJ9v7pERDnIP5ED0HaWFAeXl7GFgoH2y9\r\n" +
    "QDyJVuwWsoSWIx4Mr8UIr0IbVJU6KsqEiqqc5P5rX/y4tYMkpHZd9U1EONd2uwmX\r\n" +
    "dwSp0LEmQb/DAgMBAAGjTTBLMB0GA1UdDgQWBBSfJPZqs1tk+xjjDrovr13ORDWn\r\n" +
    "ojAfBgNVHSMEGDAWgBQI0Zv55tVkcKDxaxqe7VLa3fVQQzAJBgNVHRMEAjAAMA0G\r\n" +
    "CSqGSIb3DQEBCwUAA4IBAQAEKXs56hB4DOO1vJe7pByfCHU33ij/ux7u68BdkDQ8\r\n" +
    "S9SNaoD7h1XNSmC8kKULvpoKctJzJxh1IH4wtvGGGXsUt1By0a6Y5SnKW9/mG4NM\r\n" +
    "D4fGea0G2AeI8BHFs6vl8voYK9wgx9Ygus3Kj/8h6V7t2zB8ZhhVqpZkAQEjj0C2\r\n" +
    "1IV273wD0VdZl7uB+MEKk+7eTjNMeo6JzlBBf5GhtA1WbLNdszMfI0ljo7HAX+9L\r\n" +
    "yco0xKSKkZQ+v7VdJBfC6odp+epPMZqfyHrkFzUr8XRJfriP1lydPK7AbXLVrLJg\r\n" +
    "fIXCvUdxQx4B1LaclUDORL5r2tRhRYdAEKtUz7RpQzJK\r\n" +
    "-----END CERTIFICATE-----\r\n";

  let encodingBlob: cert.EncodingBlob = {
    data: stringToUint8Array(certDataNC),
    encodingFormat: cert.EncodingFormat.FORMAT_PEM
  };

  let x509Cert: cert.X509Cert = {} as cert.X509Cert;
  try {
    x509Cert = await cert.createX509Cert(encodingBlob);
  } catch (error) {
    console.error('createX509Cert failed, errCode: ' + error.code + ', errMsg: ' + error.message);
  }
  return x509Cert;
}

async function createX509Cert2(): Promise<cert.X509Cert> {
  let certDataNC = "-----BEGIN CERTIFICATE-----\r\n" +
    "MIIDZjCCAk6gAwIBAgIBAjANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdSb290\r\n" +
    "IENBMCAXDTIwMTIxMjIwMTk0NFoYDzIxMjAxMjEzMjAxOTQ0WjAXMRUwEwYDVQQD\r\n" +
    "DAxUZXN0IE5DIENBIDEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDC\r\n" +
    "XjL5JEImsGFW5whlXCfDTeqjZAVb+rSXAhZQ25bP9YvhsbmPVYe8A61zwGStl2rF\r\n" +
    "mChzN9/+LA40/lh0mjCV82mfNp1XLRPhE9sPGXwfLgJGCy/d6pp/8yGuFmkWPus9\r\n" +
    "bhxlOk7ADw4e3R3kVdwn9I3O3mIrI+I45ywZpzrbs/NGFiqhRxXbZTAKyI4INxgB\r\n" +
    "VZfkoxqesnjD1j36fq7qEVas6gVm27YA9b+31ofFLM7WN811LQELwTdWiF0/xXiO\r\n" +
    "XawU1QnkrNPxCSPWyeaM4tN50ZPRQA/ArV4I7szKhKskRzGwFgdaxorYn8c+2gTq\r\n" +
    "fedLPvNw1WPryAumidqTAgMBAAGjgb8wgbwwDwYDVR0TAQH/BAUwAwEB/zALBgNV\r\n" +
    "HQ8EBAMCAQYwHQYDVR0OBBYEFAjRm/nm1WRwoPFrGp7tUtrd9VBDMB8GA1UdIwQY\r\n" +
    "MBaAFI71Ja8em2uEPXyAmslTnE1y96NSMFwGA1UdHgRVMFOgUTAOggx3d3cuZ29v\r\n" +
    "ZC5vcmcwCoIIZ29vZC5jb20wD4ENZ29vZEBnb29kLm9yZzAKgQhnb29kLmNvbTAK\r\n" +
    "hwh/AAAB/////zAKhwjAqAAA//8AADANBgkqhkiG9w0BAQsFAAOCAQEAVyRsB6B8\r\n" +
    "iCYZxBTOO10Bor+Q4xxgs0udVR90/tM57P8GHd10e8suaW2Dtg9stxZJ3cmsn3zd\r\n" +
    "+QNxNIQuwHTNtVU0OSqKv6puj6ZQETSya4jDAmRqY47R866MHkSwLUYDMFtuM1Wy\r\n" +
    "gnoD5m1/Uy1K/Wvbnp1Zq4jtTB6su8TmIdJgtpEmte7tIQu5kPXsuJrz/x5a1TfR\r\n" +
    "hu7h4LJYwKlQtd/LRINnHKd241YSE7PVdG8SPxyrX11hJSC+1Z5Epxc6BCVDVN1E\r\n" +
    "fyVDdLXvKf30Nlbg2hZfO/cGTmwOt7RImygzhV/s41v4wtMW0EPuVanGQusRgHFm\r\n" +
    "3JC//UMgfkkwAA==\r\n" +
    "-----END CERTIFICATE-----\r\n";

  let encodingBlob: cert.EncodingBlob = {
    data: stringToUint8Array(certDataNC),
    encodingFormat: cert.EncodingFormat.FORMAT_PEM
  };

  let x509Cert: cert.X509Cert = {} as cert.X509Cert;
  try {
    x509Cert = await cert.createX509Cert(encodingBlob);
  } catch (error) {
    console.error('createX509Cert failed, errCode: ' + error.code + ', errMsg: ' + error.message);
  }
  return x509Cert;
}

function stringToUint8Array(str: string): Uint8Array {
  let arr: Array<number> = [];
  for (let i = 0, j = str.length; i < j; i++) {
    arr.push(str.charCodeAt(i));
  }
  return new Uint8Array(arr);
}