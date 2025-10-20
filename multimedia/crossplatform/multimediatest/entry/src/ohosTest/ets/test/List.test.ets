/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import audioEnumsTest from './AudioEnums.test';
import audioRoutingManager from './AudioRoutingManager.test';
import audioRendererTest from './AudioRenderer.test';
import propertiesTest from './Properties.test';
import photoAccessHelperEnumsTest from './PhotoAccessHelperEnums.test';
import AVMetadataExtractorTest from './AVMetadataExtractorTest.test';
import AVMetadataTest from './AVMetadataTest.test';
import DecodingOptionsTest from './DecodingOptionsTest.test';
import imageEnumsTest from './ImageEnums.test';
import ImagePropertyOptionsTest from './GetImagePropertyOptionsTest.test';
import PixelMapTest from './PixelMapTest.test';
import imageSourceUpdateDataPropertyTest from './UpdateData.test';
import AVPlayerTest from "./AVPlayer.test";
import AvPlayerEnumTest from "./AVPlayerEnumTest.test";
import VideoPlayerEnumTest from "./VideoPlayerEnumTest.test";
import VideoSourceTypeEnumTest from "./VideoSourceTypeEnum.test";
import LocationTest from "./Location.test";

export default function testsuite() {
  audioEnumsTest();
  audioRoutingManager();
  audioRendererTest();
  propertiesTest();
  photoAccessHelperEnumsTest();
  PixelMapTest();
  imageSourceUpdateDataPropertyTest();
  AVMetadataExtractorTest();
  AVMetadataTest();
  DecodingOptionsTest();
  imageEnumsTest();
  ImagePropertyOptionsTest();
  AvPlayerEnumTest();
  VideoPlayerEnumTest();
  VideoSourceTypeEnumTest();
  LocationTest();
  AVPlayerTest();
}