/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { describe, it, expect,  Level, Size, TestType } from '@ohos/hypium';
import image from '@ohos.multimedia.image';

export default function imageEnumsTest() {

  describe('ImageEnumsTest', () => {
    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_ENUM_0100
     * @tc.name      : testMultimediaImageEnum0001
     * @tc.desc      : test image Exif PropertyKey value
     * @tc.size      : MediumTest
     * @tc.type      : Functional
     * @tc.level     : Level 0
     */
    it('testMultimediaImageEnum0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(image.PropertyKey.BITS_PER_SAMPLE).assertEqual("BitsPerSample");
      expect(image.PropertyKey.IMAGE_LENGTH).assertEqual("ImageLength");
      expect(image.PropertyKey.ROLL_ANGLE).assertEqual("HwMnoteRollAngle");
      expect(image.PropertyKey.PITCH_ANGLE).assertEqual("HwMnotePitchAngle");
      expect(image.PropertyKey.SCENE_FOOD_CONF).assertEqual("HwMnoteSceneFoodConf");
      expect(image.PropertyKey.SCENE_STAGE_CONF).assertEqual("HwMnoteSceneStageConf");
      expect(image.PropertyKey.SCENE_BLUE_SKY_CONF).assertEqual("HwMnoteSceneBlueSkyConf");
      expect(image.PropertyKey.SCENE_GREEN_PLANT_CONF).assertEqual("HwMnoteSceneGreenPlantConf");
      expect(image.PropertyKey.SCENE_BEACH_CONF).assertEqual("HwMnoteSceneBeachConf");
      expect(image.PropertyKey.SCENE_SNOW_CONF).assertEqual("HwMnoteSceneSnowConf");
      expect(image.PropertyKey.SCENE_SUNSET_CONF).assertEqual("HwMnoteSceneSunsetConf");
      expect(image.PropertyKey.SCENE_FLOWERS_CONF).assertEqual("HwMnoteSceneFlowersConf");
      expect(image.PropertyKey.SCENE_NIGHT_CONF).assertEqual("HwMnoteSceneNightConf");
      expect(image.PropertyKey.SCENE_TEXT_CONF).assertEqual("HwMnoteSceneTextConf");
      expect(image.PropertyKey.FACE_COUNT).assertEqual("HwMnoteFaceCount");
      expect(image.PropertyKey.FOCUS_MODE).assertEqual("HwMnoteFocusMode");
      expect(image.PropertyKey.COMPRESSION).assertEqual("Compression");
      expect(image.PropertyKey.PHOTOMETRIC_INTERPRETATION).assertEqual("PhotometricInterpretation");
      expect(image.PropertyKey.STRIP_OFFSETS).assertEqual("StripOffsets");
      expect(image.PropertyKey.SAMPLES_PER_PIXEL).assertEqual("SamplesPerPixel");
      expect(image.PropertyKey.ROWS_PER_STRIP).assertEqual("RowsPerStrip");
      expect(image.PropertyKey.STRIP_BYTE_COUNTS).assertEqual("StripByteCounts");
      expect(image.PropertyKey.X_RESOLUTION).assertEqual("XResolution");
      expect(image.PropertyKey.Y_RESOLUTION).assertEqual("YResolution");
      expect(image.PropertyKey.PLANAR_CONFIGURATION).assertEqual("PlanarConfiguration");
      expect(image.PropertyKey.RESOLUTION_UNIT).assertEqual("ResolutionUnit");
      expect(image.PropertyKey.TRANSFER_FUNCTION).assertEqual("TransferFunction");
      expect(image.PropertyKey.SOFTWARE).assertEqual("Software");
      expect(image.PropertyKey.ARTIST).assertEqual("Artist");
      expect(image.PropertyKey.WHITE_POINT).assertEqual("WhitePoint");
      expect(image.PropertyKey.PRIMARY_CHROMATICITIES).assertEqual("PrimaryChromaticities");
      expect(image.PropertyKey.YCBCR_COEFFICIENTS).assertEqual("YCbCrCoefficients");
      expect(image.PropertyKey.YCBCR_SUB_SAMPLING).assertEqual("YCbCrSubSampling");
      expect(image.PropertyKey.YCBCR_POSITIONING).assertEqual("YCbCrPositioning");
      expect(image.PropertyKey.REFERENCE_BLACK_WHITE).assertEqual("ReferenceBlackWhite");
      expect(image.PropertyKey.JPEG_INTERCHANGE_FORMAT).assertEqual("JPEGInterchangeFormat");
      expect(image.PropertyKey.JPEG_INTERCHANGE_FORMAT_LENGTH).assertEqual("JPEGInterchangeFormatLength");
      expect(image.PropertyKey.EXPOSURE_PROGRAM).assertEqual("ExposureProgram");
      expect(image.PropertyKey.SPECTRAL_SENSITIVITY).assertEqual("SpectralSensitivity");
      expect(image.PropertyKey.OECF).assertEqual("OECF");
      expect(image.PropertyKey.EXIF_VERSION).assertEqual("ExifVersion");
      expect(image.PropertyKey.DATE_TIME_DIGITIZED).assertEqual("DateTimeDigitized");
      expect(image.PropertyKey.COMPONENTS_CONFIGURATION).assertEqual("ComponentsConfiguration");
      expect(image.PropertyKey.SHUTTER_SPEED).assertEqual("ShutterSpeedValue");
      expect(image.PropertyKey.BRIGHTNESS_VALUE).assertEqual("BrightnessValue");
      expect(image.PropertyKey.MAX_APERTURE_VALUE).assertEqual("MaxApertureValue");
      expect(image.PropertyKey.SUBJECT_DISTANCE).assertEqual("SubjectDistance");
      expect(image.PropertyKey.SUBJECT_AREA).assertEqual("SubjectArea");
      expect(image.PropertyKey.MAKER_NOTE).assertEqual("MakerNote");
      expect(image.PropertyKey.SUBSEC_TIME).assertEqual("SubsecTime");
      expect(image.PropertyKey.SUBSEC_TIME_ORIGINAL).assertEqual("SubsecTimeOriginal");
      expect(image.PropertyKey.SUBSEC_TIME_DIGITIZED).assertEqual("SubsecTimeDigitized");
      expect(image.PropertyKey.FLASHPIX_VERSION).assertEqual("FlashpixVersion");
      expect(image.PropertyKey.COLOR_SPACE).assertEqual("ColorSpace");
      expect(image.PropertyKey.RELATED_SOUND_FILE).assertEqual("RelatedSoundFile");
      expect(image.PropertyKey.FLASH_ENERGY).assertEqual("FlashEnergy");
      expect(image.PropertyKey.SPATIAL_FREQUENCY_RESPONSE).assertEqual("SpatialFrequencyResponse");
      expect(image.PropertyKey.FOCAL_PLANE_X_RESOLUTION).assertEqual("FocalPlaneXResolution");
      expect(image.PropertyKey.FOCAL_PLANE_Y_RESOLUTION).assertEqual("FocalPlaneYResolution");
      expect(image.PropertyKey.FOCAL_PLANE_RESOLUTION_UNIT).assertEqual("FocalPlaneResolutionUnit");
      expect(image.PropertyKey.SUBJECT_LOCATION).assertEqual("SubjectLocation");
      expect(image.PropertyKey.EXPOSURE_INDEX).assertEqual("ExposureIndex");
      expect(image.PropertyKey.SENSING_METHOD).assertEqual("SensingMethod");
      expect(image.PropertyKey.FILE_SOURCE).assertEqual("FileSource");
      expect(image.PropertyKey.CFA_PATTERN).assertEqual("CFAPattern");
      expect(image.PropertyKey.CUSTOM_RENDERED).assertEqual("CustomRendered");
      expect(image.PropertyKey.EXPOSURE_MODE).assertEqual("ExposureMode");
      expect(image.PropertyKey.DIGITAL_ZOOM_RATIO).assertEqual("DigitalZoomRatio");
      expect(image.PropertyKey.SCENE_CAPTURE_TYPE).assertEqual("SceneCaptureType");
      expect(image.PropertyKey.GAIN_CONTROL).assertEqual("GainControl");
      expect(image.PropertyKey.CONTRAST).assertEqual("Contrast");
      expect(image.PropertyKey.SATURATION).assertEqual("Saturation");
      expect(image.PropertyKey.SHARPNESS).assertEqual("Sharpness");
      expect(image.PropertyKey.DEVICE_SETTING_DESCRIPTION).assertEqual("DeviceSettingDescription");
      expect(image.PropertyKey.SUBJECT_DISTANCE_RANGE).assertEqual("SubjectDistanceRange");
      expect(image.PropertyKey.IMAGE_UNIQUE_ID).assertEqual("ImageUniqueID");
      expect(image.PropertyKey.GPS_VERSION_ID).assertEqual("GPSVersionID");
      expect(image.PropertyKey.GPS_ALTITUDE_REF).assertEqual("GPSAltitudeRef");
      expect(image.PropertyKey.GPS_ALTITUDE).assertEqual("GPSAltitude");
      expect(image.PropertyKey.GPS_SATELLITES).assertEqual("GPSSatellites");
      expect(image.PropertyKey.GPS_STATUS).assertEqual("GPSStatus");
      expect(image.PropertyKey.GPS_MEASURE_MODE).assertEqual("GPSMeasureMode");
      expect(image.PropertyKey.GPS_DOP).assertEqual("GPSDOP");
      expect(image.PropertyKey.GPS_SPEED_REF).assertEqual("GPSSpeedRef");
      expect(image.PropertyKey.GPS_SPEED).assertEqual("GPSSpeed");
      expect(image.PropertyKey.GPS_TRACK_REF).assertEqual("GPSTrackRef");
      expect(image.PropertyKey.GPS_TRACK).assertEqual("GPSTrack");
      expect(image.PropertyKey.GPS_IMG_DIRECTION_REF).assertEqual("GPSImgDirectionRef");
      expect(image.PropertyKey.GPS_IMG_DIRECTION).assertEqual("GPSImgDirection");
      expect(image.PropertyKey.GPS_MAP_DATUM).assertEqual("GPSMapDatum");
      expect(image.PropertyKey.GPS_DEST_LATITUDE_REF).assertEqual("GPSDestLatitudeRef");
      expect(image.PropertyKey.GPS_DEST_LATITUDE).assertEqual("GPSDestLatitude");
      expect(image.PropertyKey.GPS_DEST_LONGITUDE_REF).assertEqual("GPSDestLongitudeRef");
      expect(image.PropertyKey.GPS_DEST_LONGITUDE).assertEqual("GPSDestLongitude");
      expect(image.PropertyKey.GPS_DEST_BEARING_REF).assertEqual("GPSDestBearingRef");
      expect(image.PropertyKey.GPS_DEST_BEARING).assertEqual("GPSDestBearing");
      expect(image.PropertyKey.GPS_DEST_DISTANCE_REF).assertEqual("GPSDestDistanceRef");
      expect(image.PropertyKey.GPS_DEST_DISTANCE).assertEqual("GPSDestDistance");
      expect(image.PropertyKey.GPS_PROCESSING_METHOD).assertEqual("GPSProcessingMethod");
      expect(image.PropertyKey.GPS_AREA_INFORMATION).assertEqual("GPSAreaInformation");
      expect(image.PropertyKey.GPS_DIFFERENTIAL).assertEqual("GPSDifferential");
      expect(image.PropertyKey.BODY_SERIAL_NUMBER).assertEqual("BodySerialNumber");
      expect(image.PropertyKey.CAMERA_OWNER_NAME).assertEqual("CameraOwnerName");
      expect(image.PropertyKey.COMPOSITE_IMAGE).assertEqual("CompositeImage");
      expect(image.PropertyKey.COMPRESSED_BITS_PER_PIXEL).assertEqual("CompressedBitsPerPixel");
      expect(image.PropertyKey.DNG_VERSION).assertEqual("DNGVersion");
      expect(image.PropertyKey.DEFAULT_CROP_SIZE).assertEqual("DefaultCropSize");
      expect(image.PropertyKey.GAMMA).assertEqual("Gamma");
      expect(image.PropertyKey.ISO_SPEED_LATITUDE_YYY).assertEqual("ISOSpeedLatitudeyyy");
      expect(image.PropertyKey.ISO_SPEED_LATITUDE_ZZZ).assertEqual("ISOSpeedLatitudezzz");
      expect(image.PropertyKey.LENS_MAKE).assertEqual("LensMake");
      expect(image.PropertyKey.LENS_MODEL).assertEqual("LensModel");
      expect(image.PropertyKey.LENS_SERIAL_NUMBER).assertEqual("LensSerialNumber");
      expect(image.PropertyKey.LENS_SPECIFICATION).assertEqual("LensSpecification");
      expect(image.PropertyKey.NEW_SUBFILE_TYPE).assertEqual("NewSubfileType");
      expect(image.PropertyKey.OFFSET_TIME).assertEqual("OffsetTime");
      expect(image.PropertyKey.OFFSET_TIME_DIGITIZED).assertEqual("OffsetTimeDigitized");
      expect(image.PropertyKey.OFFSET_TIME_ORIGINAL).assertEqual("OffsetTimeOriginal");
      expect(image.PropertyKey.SOURCE_EXPOSURE_TIMES_OF_COMPOSITE_IMAGE)
        .assertEqual("SourceExposureTimesOfCompositeImage");
      expect(image.PropertyKey.SOURCE_IMAGE_NUMBER_OF_COMPOSITE_IMAGE).assertEqual("SourceImageNumberOfCompositeImage");
      expect(image.PropertyKey.SUBFILE_TYPE).assertEqual("SubfileType");
      expect(image.PropertyKey.GPS_H_POSITIONING_ERROR).assertEqual("GPSHPositioningError");
      expect(image.PropertyKey.PHOTOGRAPHIC_SENSITIVITY).assertEqual("PhotographicSensitivity");
      expect(image.PropertyKey.BURST_NUMBER).assertEqual("HwMnoteBurstNumber");
      expect(image.PropertyKey.FACE_CONF).assertEqual("HwMnoteFaceConf");
      expect(image.PropertyKey.FACE_LEYE_CENTER).assertEqual("HwMnoteFaceLeyeCenter");
      expect(image.PropertyKey.FACE_MOUTH_CENTER).assertEqual("HwMnoteFaceMouthCenter");
      expect(image.PropertyKey.FACE_POINTER).assertEqual("HwMnoteFacePointer");
      expect(image.PropertyKey.FACE_RECT).assertEqual("HwMnoteFaceRect");
      expect(image.PropertyKey.FACE_REYE_CENTER).assertEqual("HwMnoteFaceReyeCenter");
      expect(image.PropertyKey.FACE_SMILE_SCORE).assertEqual("HwMnoteFaceSmileScore");
      expect(image.PropertyKey.FACE_VERSION).assertEqual("HwMnoteFaceVersion");
      expect(image.PropertyKey.FRONT_CAMERA).assertEqual("HwMnoteFrontCamera");
      expect(image.PropertyKey.SCENE_POINTER).assertEqual("HwMnoteScenePointer");
      expect(image.PropertyKey.SCENE_VERSION).assertEqual("HwMnoteSceneVersion");
      expect(image.PropertyKey.IS_XMAGE_SUPPORTED).assertEqual("HwMnoteIsXmageSupported");
      expect(image.PropertyKey.XMAGE_MODE).assertEqual("HwMnoteXmageMode");
      expect(image.PropertyKey.XMAGE_LEFT).assertEqual("HwMnoteXmageLeft");
      expect(image.PropertyKey.XMAGE_TOP).assertEqual("HwMnoteXmageTop");
      expect(image.PropertyKey.XMAGE_RIGHT).assertEqual("HwMnoteXmageRight");
      expect(image.PropertyKey.XMAGE_BOTTOM).assertEqual("HwMnoteXmageBottom");
      expect(image.PropertyKey.CLOUD_ENHANCEMENT_MODE).assertEqual("HwMnoteCloudEnhancementMode");
      expect(image.PropertyKey.WIND_SNAPSHOT_MODE).assertEqual("HwMnoteWindSnapshotMode");
      expect(image.PropertyKey.GIF_LOOP_COUNT).assertEqual("GIFLoopCount");
      done();
    })
  })
}

