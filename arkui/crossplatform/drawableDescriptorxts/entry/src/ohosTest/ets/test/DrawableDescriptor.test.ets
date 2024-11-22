/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import image from '@ohos.multimedia.image';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { describe, it, expect } from '@ohos/hypium';
import { DrawableDescriptor, LayeredDrawableDescriptor } from '@ohos.arkui.drawableDescriptor';

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function drawableDescriptorTest() {
  describe('DawableDescriptorTest', () => {

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0010
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate PNG Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0010', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_png: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.icon').id));
        await sleep(1000);
        let drawable_id_png_PixelMap: image.PixelMap = drawable_id_png.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0010 PixelMap is' + drawable_id_png_PixelMap);
        expect(drawable_id_png_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0010 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0010 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0020
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate JPG Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0020', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_jpg: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.jpg').id));
        await sleep(1000);
        let drawable_id_jpg_PixelMap: image.PixelMap = drawable_id_jpg.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0020 PixelMap is' + drawable_id_jpg_PixelMap);
        expect(drawable_id_jpg_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0020 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0020 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0030
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate BMP Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0030', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_bmp: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.bmp').id));
        await sleep(1000);
        let drawable_id_bmp_PixelMap: image.PixelMap = drawable_id_bmp.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0030 PixelMap is' + drawable_id_bmp_PixelMap);
        expect(drawable_id_bmp_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0030 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0030 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0040
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate svg Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0040', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_svg: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.svg').id));
        await sleep(1000);
        console.log('SUB_Test_DrawableDescriptor_Func_0040 drawable_id_svg is' + drawable_id_svg);
        let drawable_id_svg_PixelMap: image.PixelMap = drawable_id_svg.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0040 PixelMap is' + drawable_id_svg_PixelMap);
        expect(drawable_id_svg_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0040 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0040 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0050
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate gif Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0050', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_gif: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.gif').id));
        await sleep(1000);
        let drawable_id_gif_PixelMap: image.PixelMap = drawable_id_gif.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0050 PixelMap is' + drawable_id_gif_PixelMap);
        expect(drawable_id_gif_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0050 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0050 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0060
     * @tc.name   : DrawableDescriptor
     * @tc.desc   : Test Generate webp Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0060', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_webp: DrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.webp').id));
        await sleep(1000);
        let drawable_id_webp_PixelMap: image.PixelMap = drawable_id_webp.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0060 PixelMap is' + drawable_id_webp_PixelMap);
        expect(drawable_id_webp_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0060 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0060 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0070
     * @tc.name   : LayeredDrawableDescriptor
     * @tc.desc   : Test Generate JSON Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0070', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_json_lay: LayeredDrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.drawble')
          .id, 240, 1)) as LayeredDrawableDescriptor;
        await sleep(1000);
        let drawable_id_json_PixelMap_lay: image.PixelMap = drawable_id_json_lay.getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0070 PixelMap is' + drawable_id_json_PixelMap_lay);
        expect(drawable_id_json_PixelMap_lay != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0070 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0070 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0080
     * @tc.name   : LayeredDrawableDescriptor
     * @tc.desc   : Test Generate JSON Foreground Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0080', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_json_lay: LayeredDrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.drawble')
          .id, 240, 1)) as LayeredDrawableDescriptor;
        await sleep(1000);
        let lay_drawable_id_json_Foreground_PixelMap: image.PixelMap = drawable_id_json_lay.getForeground()
          .getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0080 PixelMap is' + lay_drawable_id_json_Foreground_PixelMap);
        expect(lay_drawable_id_json_Foreground_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0080 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0080 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_0090
     * @tc.name   : LayeredDrawableDescriptor
     * @tc.desc   : Test Generate JSON Background Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_0090', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_json_lay: LayeredDrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.drawble')
          .id, 240, 1)) as LayeredDrawableDescriptor;
        await sleep(1000);
        let lay_drawable_id_json_Background_PixelMap: image.PixelMap = drawable_id_json_lay.getBackground()
          .getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_0090 PixelMap is' + lay_drawable_id_json_Background_PixelMap);
        expect(lay_drawable_id_json_Background_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_0090 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_0090 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_00100
     * @tc.name   : LayeredDrawableDescriptor
     * @tc.desc   : Test Generate JSON Mask Pixlmap display image
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_00100', 0, async (done: Function) => {
      try {
        let resManager = context.resourceManager
        let drawable_id_json_lay: LayeredDrawableDescriptor = (resManager.getDrawableDescriptor($r('app.media.drawble')
          .id, 240, 1)) as LayeredDrawableDescriptor;
        await sleep(1000);
        let lay_drawable_id_json_Mask_PixelMap: image.PixelMap = drawable_id_json_lay.getMask().getPixelMap()
        console.log('SUB_Test_DrawableDescriptor_Func_00100 PixelMap is' + lay_drawable_id_json_Mask_PixelMap);
        expect(lay_drawable_id_json_Mask_PixelMap != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_00100 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_00100 message is' + error.message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_Test_DrawableDescriptor_Func_00110
     * @tc.name   : LayeredDrawableDescriptor
     * @tc.desc   : Test getMaskClipPath
     * @tc.level  : Level 1
     */
    it('SUB_Test_DrawableDescriptor_Func_00110', 0, async (done: Function) => {
      try {
        let maskClipPath = LayeredDrawableDescriptor.getMaskClipPath()
        console.log('SUB_Test_DrawableDescriptor_Func_00110 getMaskClipPath is' + maskClipPath);
        expect(maskClipPath != null).assertTrue();
        done();
      } catch (error) {
        console.log('SUB_Test_DrawableDescriptor_Func_00110 error code is' + error.code);
        console.log('SUB_Test_DrawableDescriptor_Func_00110 message is' + error.message);
        expect().assertFail();
        done();
      }
    })
  })
}