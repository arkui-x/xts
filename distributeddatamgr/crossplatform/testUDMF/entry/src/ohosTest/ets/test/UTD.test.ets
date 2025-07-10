/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { afterAll, afterEach, beforeAll, describe, expect, it } from '@ohos/hypium';
import UTD from '@ohos.data.uniformTypeDescriptor';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function UTDTest() {
  describe("UTDTest", () => {
    beforeAll(async () => {
      console.info("beforeAll");
    });

    afterAll(async () => {
      console.info("afterAll");

    });
    afterEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0100
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0100
     * @tc.desc      : Verify the properties of the entity type
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0100', 
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0100 start');

      let typeObj = UTD.getTypeDescriptor("general.entity");
      console.log("typeId:" + typeObj.typeId);
      console.log("belongingToTypes:" + typeObj.belongingToTypes);
      console.log("description:" + typeObj.description);
      console.log("referenceURL:" + typeObj.referenceURL);
      console.log("iconFile:" + typeObj.iconFile);
      console.log("filenameExtensions:" + typeObj.filenameExtensions.toString());
      console.log("mimeTypes:" + typeObj.mimeTypes.toString());
      expect(typeObj.typeId).assertEqual("general.entity");
      expect(typeObj.belongingToTypes.length).assertEqual(0);
      expect(typeObj.description).assertEqual("Base type for physical hierarchy.");
      expect(typeObj.referenceURL).assertEqual("");
      expect(typeObj.iconFile).assertEqual("");
      expect(typeObj.filenameExtensions.toString()).assertEqual("");
      expect(typeObj.mimeTypes.toString()).assertEqual("");
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0100 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0200
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0200
     * @tc.desc      : Verify the properties of the object type
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0200 start');

      let typeObj = UTD.getTypeDescriptor("general.object");
      console.log("typeId:" + typeObj.typeId);
      console.log("belongingToTypes:" + typeObj.belongingToTypes);
      console.log("description:" + typeObj.description);
      console.log("referenceURL:" + typeObj.referenceURL);
      console.log("iconFile:" + typeObj.iconFile);
      console.log("filenameExtensions:" + typeObj.filenameExtensions.toString());
      console.log("mimeTypes:" + typeObj.mimeTypes.toString());
      expect(typeObj.typeId).assertEqual("general.object");
      expect(typeObj.belongingToTypes.length).assertEqual(0);
      expect(typeObj.description).assertEqual("Base type for logical hierarchy.");
      expect(typeObj.referenceURL).assertEqual("");
      expect(typeObj.iconFile).assertEqual("");
      expect(typeObj.filenameExtensions.toString()).assertEqual("");
      expect(typeObj.mimeTypes.toString()).assertEqual("*/*");
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0200 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0300
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0300
     * @tc.desc      : Illegal parameters general.hello
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0300 start');
      try {
        let typeObj = UTD.getTypeDescriptor("general.hello");
        console.log('typeObj start' + typeObj);
        if (typeObj == null) {
          console.log("Illegal parameters general.hello is :" + (typeObj == null));
        }
        expect(typeObj == null).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0300 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0400
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0400
     * @tc.desc      : Illegal parameters ""
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0400 start');
      try {
        let typeObj = UTD.getTypeDescriptor("");
        console.log('typeObj start' + typeObj);
        expect(typeObj == null).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0400 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0500
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0500
     * @tc.desc      : parameter to getUniformDataTypeByFilenameExtension()  --parameter is ".xls"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0500 start');
      try {
        let result = UTD.getUniformDataTypeByFilenameExtension(".xls");
        console.log("result=====>" + result);
        expect(result == "com.microsoft.excel.xls").assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0500 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0600
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0600
     * @tc.desc      : Invalid parameter to getUniformDataTypeByFilenameExtension()  --parameter is null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0600 start');
      try {
        let result = UTD.getUniformDataTypeByFilenameExtension(null);
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0600 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0700
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0700
     * @tc.desc      : parameter to getUniformDataTypeByFilenameExtension()  --parameters are ".doc" and UTD.UniformDataType.WORD_DOC
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0700 start');
      try {
        let result = UTD.getUniformDataTypeByFilenameExtension(".doc", "com.microsoft.word.doc");
        console.log("result=====>" + result);
        expect(result == "com.microsoft.word.doc").assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0700 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0800
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0800
     * @tc.desc      : Invalid parameter to getUniformDataTypeByFilenameExtension()  --parameters are ".doc" and invalid parameter null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0800 start');
      try {
        let result = UTD.getUniformDataTypeByFilenameExtension(".wave", null);
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0800 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0900
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0900
     * @tc.desc      : Invalid  parameter to getUniformDataTypeByMIMEType() --parameter is "hello"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest0900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0900 start');
      try {
        let dynamicType = UTD.getUniformDataTypeByMIMEType("hello");
        console.log("dynamicType=====>" + dynamicType);
        let dynamicTypeObj = UTD.getTypeDescriptor(dynamicType);
        console.log("UDMF,typeId:" + dynamicTypeObj.typeId);
        console.log("UDMF,belongingToTypes:" + dynamicTypeObj.belongingToTypes);
        console.log("UDMF,filenameExtension:" + dynamicTypeObj.filenameExtensions);
        console.log("UDMF,mimeTypes:" + dynamicTypeObj.mimeTypes);
        expect(dynamicTypeObj.typeId).assertEqual(dynamicType);
        expect(dynamicTypeObj.belongingToTypes.length).assertEqual(0);
        expect(dynamicTypeObj.mimeTypes[0]).assertEqual("hello");
        expect(dynamicTypeObj.filenameExtensions.length).assertEqual(0);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_0900 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1000
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1000
     * @tc.desc      : Invalid  parameter to getUniformDataTypeByMIMEType() --parameter is ""
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1000 start');
      try {
        let result = UTD.getUniformDataTypeByMIMEType("");
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1000 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1100
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1100
     * @tc.desc      : parameter to getUniformDataTypeByMIMEType()  --parameter are "image/tiff" and "general.type-script"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1100 start');
      try {
        let result = UTD.getUniformDataTypeByMIMEType("audio/x-ms-wma", "com.microsoft.windows-media-wma");
        console.log("result=====>" + result);
        expect(result == "com.microsoft.windows-media-wma").assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1100 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1200
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1200
     * @tc.desc      : Invalid  parameter to getUniformDataTypeByMIMEType() --parameter are "image/tiff"and invalid parameter "general.type-script"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1200 start');
      try {
        let dynamicType = UTD.getUniformDataTypeByMIMEType("image/tiff", "general.type-script");
        console.log("dynamicType=====>" + dynamicType);
        let dynamicTypeObj = UTD.getTypeDescriptor(dynamicType);
        console.log("UDMF,typeId:" + dynamicTypeObj.typeId);
        console.log("UDMF,belongingToTypes:" + dynamicTypeObj.belongingToTypes);
        console.log("UDMF,filenameExtension:" + dynamicTypeObj.filenameExtensions);
        console.log("UDMF,mimeTypes:" + dynamicTypeObj.mimeTypes);
        expect(dynamicTypeObj.typeId).assertEqual(dynamicType);
        expect(dynamicTypeObj.belongingToTypes[0]).assertEqual("general.type-script");
        expect(dynamicTypeObj.mimeTypes[0]).assertEqual("image/tiff");
        expect(dynamicTypeObj.filenameExtensions.length).assertEqual(0);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1200 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1300
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1300
     * @tc.desc      : Invalid  parameter to getUniformDataTypeByMIMEType() --parameter are "image/tiff"and invalid parameter null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1300 start');
      try {
        let result = UTD.getUniformDataTypeByMIMEType("image/tiff", null);
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1300 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1400
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1400
     * @tc.desc      : parameter to getUniformDataTypesByFilenameExtension()  --parameter is ".xls"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1400 start');
      try {
        let result = UTD.getUniformDataTypesByFilenameExtension(".xls");
        console.log("result=====>" + JSON.stringify(result));
        expect(result[0]).assertEqual("com.microsoft.excel.xls")
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1400 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1500
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1500
     * @tc.desc      : Invalid parameter to getUniformDataTypesByFilenameExtension()  --parameter is null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1500 start');
      try {
        let result = UTD.getUniformDataTypesByFilenameExtension(null);
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1500 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1600
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1600
     * @tc.desc      : parameter to getUniformDataTypesByMIMEType() --"image/tiff"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1600 start');
      try {
        let result = UTD.getUniformDataTypesByMIMEType("image/tiff");
        console.log("result=====>" + result);
        expect(result[0] == "general.tiff").assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1600 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1700
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1700
     * @tc.desc      : Invalid  parameter to getUniformDataTypesByMIMEType() --parameter is null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1700 start');
      try {
        let result = UTD.getUniformDataTypesByMIMEType(null);
        console.log("result=====>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1700 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1800
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1800
     * @tc.desc      : parameter to getUniformDataTypesByMIMEType()  --parameter are "image/tiff" and "general.type-script"
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1800 start');
      try {
        let result = UTD.getUniformDataTypesByMIMEType("audio/x-ms-wma", "com.microsoft.windows-media-wma");
        console.log("result=====>" + result);
        expect(result[0] == "com.microsoft.windows-media-wma").assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1800 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1900
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1900
     * @tc.desc      : Invalid parameter to belongsTo() --The relationship between the object of the parameter and null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest1900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1900 start');
      let typeObj1 = UTD.getTypeDescriptor("general.contact");
      try {
        let result = typeObj1.belongsTo(null);
        console.log("result==>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_1900 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2000
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2000
     * @tc.desc      : parameter to belongsTo()-- The relationship between the object of the parameter and the parameter at the same level
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2000 start');
      let typeObj1 = UTD.getTypeDescriptor("general.entity");
      try {
        let result = typeObj1.belongsTo("general.object");
        console.log("result==>" + result);
        expect(result == false).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2000 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2100
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2100
     * @tc.desc      : parameter to belongsTo()-- The relationship between the object of the parameter and the parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2100 start');
      let typeObj1 = UTD.getTypeDescriptor("general.calendar");
      try {
        let result = typeObj1.belongsTo("general.calendar");
        console.log("result==>" + result);
        expect(result).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2100 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2200
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2200
     * @tc.desc      : parameter to isLowerLevelType() --The low-level relationship between the object of a parameter and the previous level of the parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2200 start');
      let typeObj1 = UTD.getTypeDescriptor("general.navigation");
      try {
        let result = typeObj1.isLowerLevelType("general.object");
        console.log("result==>" + result);
        expect(result).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2200 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2300
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2300
     * @tc.desc      : parameter to isLowerLevelType() --The low-level relationship between the object of a parameter and the lower two levels of the parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2300 start');
      let typeObj1 = UTD.getTypeDescriptor("general.object");
      try {
        let result = typeObj1.isLowerLevelType("general.location");
        console.log("result==>" + result);
        expect(result == false).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2300 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2400
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2400
     * @tc.desc      : Invalid parameter to isLowerLevelType()--The low-level relationship of the object of the parameter to null.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2400 start');
      let typeObj1 = UTD.getTypeDescriptor('general.navigation');
      try {
        let result = typeObj1.isLowerLevelType(null);
        console.log("result==>" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2400 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2500
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2500
     * @tc.desc      : parameter to isHigherLevelType()--The high-level relationship between the object of a parameter and the level above the parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2500 start');
      let typeObj1 = UTD.getTypeDescriptor("general.object");
      try {
        let result = typeObj1.isHigherLevelType('general.navigation');
        console.log("result==>" + result);
        expect(result == true).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2500 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2600
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2600
     * @tc.desc      : parameter to isHigherLevelType() --The high-level relationship between the object of a parameter and the level below the parameter
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2600 start');
      let typeObj1 = UTD.getTypeDescriptor("general.navigation");
      try {
        let result = typeObj1.isHigherLevelType("general.object");
        console.log("result==>" + result);
        expect(result == false).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2600 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2700
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2700
     * @tc.desc      : Dynamic vs. Illegal Types  parameter to isHigherLevelType()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2700 start');
      let result1 = UTD.getUniformDataTypeByFilenameExtension(".mytext", "general.text");
      let typeObj1 = UTD.getTypeDescriptor(result1);
      try {
        let result = typeObj1.isHigherLevelType(null);
        console.log("result==>" + result);
        expect(result).assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code).assertEqual("401");
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2700 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2800
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2800
     * @tc.desc      : Equals the same parameter types
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2800 start');
      try {
        let typeObj1 = UTD.getTypeDescriptor('general.message');
        let typeObj2 = UTD.getTypeDescriptor('general.message');
        let result = typeObj1.equals(typeObj2);
        expect(result == true).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2800 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2900
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2900
     * @tc.desc      : Equals the different parameter types
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest2900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2900 start');
      try {
        let typeObj1 = UTD.getTypeDescriptor('general.message');
        let typeObj2 = UTD.getTypeDescriptor('general.navigation');
        let result = typeObj1.equals(typeObj2);
        expect(result == false).assertEqual(true);
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect().assertFail();
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_2900 end");
    });

    /**
     * @tc.name      : testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest3000
     * @tc.number    : SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_3000
     * @tc.desc      : Equals the different parameter types -- Illegal params null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSUBDistributedDataUDMFSDKUniformTypeDescriptorAPITest3000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.log('SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_3000 start');
      let typeObj1 = UTD.getTypeDescriptor('general.navigation');
      try {
        let result = typeObj1.equals(null);
        console.log("result" + result);
        expect().assertFail();
      } catch (err) {
        console.log("err message:" + err.message + ";err code:" + err.code);
        expect(err.code == "401").assertEqual(true);
      }
      console.log("SUB_DistributedData_UDMF_SDK_UniformTypeDescriptorAPITest_3000 end");
    });
  });
}
