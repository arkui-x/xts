/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level } from '@ohos/hypium';
import effectKit from '@ohos.effectKit';
import image from '@ohos.multimedia.image';
import { BusinessError } from '@ohos.base';

export default function graphicEffect() {
  describe('graphicEffect', () => {
    beforeAll(async () => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : testCreateColorPicker_0100
     * @tc.name      : SUB_GRAPHIC_effect_createColorPicker_0100
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCreateColorPicker_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = " ====www data testCreateColorPicker_0100==== "
      try {
        // 创建用于图像效果的buffer
        const colorBuffer = new ArrayBuffer(96);
        // 设置图像初始化选项
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        };
        console.info('www data Succeeded in creating colorPicker 111.');
        // 创建PixelMap实例
        image.createPixelMap(colorBuffer, opts).then((pixelMap) => {
          // 创建ColorPicker实例
          effectKit.createColorPicker(pixelMap).then(colorPicker => {
            console.info('www data Succeeded in creating colorPicker 222.', JSON.stringify(colorPicker));
            let mainColor = colorPicker.getMainColorSync();
            console.info(msg + ' mainColor ', JSON.stringify(mainColor))
            expect(mainColor.red).assertEqual(0);
            expect(mainColor.green).assertEqual(0);
            expect(mainColor.blue).assertEqual(0);
            expect(mainColor.alpha).assertEqual(0);
            done()
          }).catch((err: BusinessError) => {
            console.error(`www data Failed to create colorPicker. Code: ${err.code}, message: ${err.message}`);
            expect().assertFail()
            done()
          });
        }).catch((err: BusinessError) => {
          console.error(`www data Failed to create createPixelMap. Code: ${err.code}, message: ${err.message}`);
          expect().assertFail()
          done()
        });
      } catch (err) {
        console.error(msg + " Failed in createColorPicker  " + JSON.stringify(err))
        console.error(msg + " Failed in createColorPicker  " + err)
        expect().assertFail()
        done()
      }
    })
    /**
     * @tc.number    : testCreateEffect_0100
     * @tc.name      : SUB_GRAPHIC_effect_createEffect_0100
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCreateEffect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = " ====www data testCreateEffect_0100==== "
      try {
        // 创建用于图像效果的buffer
        const colorBuffer = new ArrayBuffer(96);
        // 设置图像初始化选项
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        };
        console.info('www data Succeeded in creating colorPicker 111.');
        // 创建PixelMap实例
        image.createPixelMap(colorBuffer, opts).then((pixelMap) => {
          // 创建ColorPicker实例
          let headFilter = effectKit.createEffect(pixelMap);
          console.info(msg + ' createEffect success ', JSON.stringify(headFilter));
          try {
            headFilter.blur(10);
            console.info(msg + ' blur success ');
            done();
          } catch (err) {
            console.error(msg + ' blur failed ', JSON.stringify(err));
            expect().assertFail()
            done();
          }
        });
      } catch (err) {
        console.error(msg + " Failed in createPixelMap " + JSON.stringify(err))
        console.error(msg + " Failed in createPixelMap " + err)
        expect().assertFail()
        done()
      }
    })
    /**
     * @tc.number    : testCreateEffect_0200
     * @tc.name      : SUB_GRAPHIC_effect_createEffect_0200
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCreateEffect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = " ====www data testCreateEffect_0200==== "
      try {
        // 创建用于图像效果的buffer
        const colorBuffer = new ArrayBuffer(96);
        // 设置图像初始化选项
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        };
        console.info('www data Succeeded in creating colorPicker 111.');
        // 创建PixelMap实例
        image.createPixelMap(colorBuffer, opts).then(async (pixelMap) => {
          // 创建ColorPicker实例
          let headFilter = effectKit.createEffect(pixelMap);
          console.info(msg + ' createEffect success ', JSON.stringify(headFilter));
          try {
            let pixelMap = await headFilter.getEffectPixelMap();
            console.info(msg + ' getEffectPixelMap success ', pixelMap.isEditable);
            expect(pixelMap.isEditable).assertTrue();
            done();
          } catch (err) {
            console.error(msg + ' getEffectPixelMap failed ', JSON.stringify(err));
            expect().assertFail()
            done();
          }
        });
      } catch (err) {
        console.error(msg + " Failed in createPixelMap " + JSON.stringify(err))
        console.error(msg + " Failed in createPixelMap " + err)
        expect().assertFail()
        done()
      }
    })
    /**
     * @tc.number    : testCreateEffect_0300
     * @tc.name      : SUB_GRAPHIC_effect_createEffect_0300
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCreateEffect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = " ====www data testCreateEffect_0300==== "
      try {
        // 创建用于图像效果的buffer
        const colorBuffer = new ArrayBuffer(96);
        // 设置图像初始化选项
        let opts: image.InitializationOptions = {
          editable: false,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        };
        console.info('www data Succeeded in creating colorPicker 111.');
        // 创建PixelMap实例
        image.createPixelMap(colorBuffer, opts).then(async (pixelMap) => {
          // 创建ColorPicker实例
          let headFilter = effectKit.createEffect(pixelMap);
          console.info(msg + ' createEffect success ', JSON.stringify(headFilter));
          try {
            let pixelMap = await headFilter.getEffectPixelMap();
            console.info(msg + ' getEffectPixelMap success ', pixelMap.isEditable);
            expect(pixelMap.isEditable).assertTrue();
            done();
          } catch (err) {
            console.error(msg + ' getEffectPixelMap failed ', JSON.stringify(err));
            expect().assertFail()
            done();
          }
        });
      } catch (err) {
        console.error(msg + " Failed in getEffectPixelMap " + JSON.stringify(err))
        console.error(msg + " Failed in getEffectPixelMap " + err)
        expect().assertFail()
        done()
      }
    })

  })
}
