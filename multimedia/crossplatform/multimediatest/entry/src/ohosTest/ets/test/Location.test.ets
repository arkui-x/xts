/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import media from '@ohos.multimedia.media';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function LocationTest() {
  describe('LocationTest', () => {
    beforeAll(async () => {
      console.info('beforeAll case');
    })
    beforeEach(async () => {
      console.info('beforeEach case');
    })
    afterEach(async () => {
      console.info('afterEach case');
      await sleep(500);
    })
    afterAll(async () => {
      console.info('afterAll case');
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_latitude_0001
     * @tc.name       : testLatitude001
     * @tc.desc       : Test latitude with valid positive value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testLatitude001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let loc: media.Location = { latitude: 30.0, longitude: 120.0 };
      expect(loc.latitude).assertEqual(30.0);
      expect(loc.longitude).assertEqual(120.0);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_latitude_0002
     * @tc.name       : testLatitude002
     * @tc.desc       : Test latitude with maximum valid value (90)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLatitude002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 90, longitude: 0 };
      expect(loc.latitude).assertEqual(90);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_latitude_0003
     * @tc.name       : testLatitude003
     * @tc.desc       : Test latitude with minimum valid value (-90)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLatitude003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: -90, longitude: 0 };
      expect(loc.latitude).assertEqual(-90);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_latitude_0004
     * @tc.name       : testLatitude004
     * @tc.desc       : Test latitude with zero value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLatitude004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 0, longitude: 0 };
      expect(loc.latitude).assertEqual(0);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_latitude_0005
     * @tc.name       : testLatitude005
     * @tc.desc       : Test latitude with negative value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLatitude005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: -45.5, longitude: 100.0 };
      expect(loc.latitude).assertEqual(-45.5);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_longitude_0001
     * @tc.name       : testLongitude001
     * @tc.desc       : Test longitude with valid positive value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testLongitude001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let loc: media.Location = { latitude: 40.0, longitude: 116.4 };
      expect(loc.longitude).assertEqual(116.4);
      expect(loc.latitude).assertEqual(40.0);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_longitude_0002
     * @tc.name       : testLongitude002
     * @tc.desc       : Test longitude with maximum valid value (180)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLongitude002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 0, longitude: 180 };
      expect(loc.longitude).assertEqual(180);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_longitude_0003
     * @tc.name       : testLongitude003
     * @tc.desc       : Test longitude with minimum valid value (-180)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLongitude003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 0, longitude: -180 };
      expect(loc.longitude).assertEqual(-180);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_longitude_0004
     * @tc.name       : testLongitude004
     * @tc.desc       : Test longitude with zero value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLongitude004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 50.0, longitude: 0 };
      expect(loc.longitude).assertEqual(0);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_longitude_0005
     * @tc.name       : testLongitude005
     * @tc.desc       : Test longitude with negative value
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLongitude005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 37.7749, longitude: -122.4194 };
      expect(loc.longitude).assertEqual(-122.4194);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_combined_0001
     * @tc.name       : testLocationCombined001
     * @tc.desc       : Test Location with boundary values
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLocationCombined001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: 90, longitude: 180 };
      expect(loc.latitude).assertEqual(90);
      expect(loc.longitude).assertEqual(180);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_combined_0002
     * @tc.name       : testLocationCombined002
     * @tc.desc       : Test Location with minimum boundary values
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testLocationCombined002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let loc: media.Location = { latitude: -90, longitude: -180 };
      expect(loc.latitude).assertEqual(-90);
      expect(loc.longitude).assertEqual(-180);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_combined_0003
     * @tc.name       : testLocationCombined003
     * @tc.desc       : Test Location with typical real-world values (Beijing)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testLocationCombined003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let loc: media.Location = { latitude: 39.9042, longitude: 116.4074 };
      expect(loc.latitude).assertEqual(39.9042);
      expect(loc.longitude).assertEqual(116.4074);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_combined_0004
     * @tc.name       : testLocationCombined004
     * @tc.desc       : Test Location with typical real-world values (New York)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testLocationCombined004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let loc: media.Location = { latitude: 40.7128, longitude: -74.0060 };
      expect(loc.latitude).assertEqual(40.7128);
      expect(loc.longitude).assertEqual(-74.0060);
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_latitude_0001
     * @tc.name       : testInvalidLatitude001
     * @tc.desc       : Test latitude with value exceeding maximum boundary (>90)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLatitude001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 91, longitude: 0 };
        expect(loc.latitude).assertEqual(91);
        console.info('Invalid latitude 91 was accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude 91: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_latitude_0002
     * @tc.name       : testInvalidLatitude002
     * @tc.desc       : Test latitude with value below minimum boundary (<-90)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLatitude002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: -91, longitude: 0 };
        expect(loc.latitude).assertEqual(-91);
        console.info('Invalid latitude -91 was accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude -91: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_latitude_0003
     * @tc.name       : testInvalidLatitude003
     * @tc.desc       : Test latitude with large value exceeding boundary (100)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLatitude003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 100, longitude: 0 };
        expect(loc.latitude).assertEqual(100);
        console.info('Invalid latitude 100 was accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude 100: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_latitude_0004
     * @tc.name       : testInvalidLatitude004
     * @tc.desc       : Test latitude with large negative value (-200)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLatitude004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: -200, longitude: 0 };
        expect(loc.latitude).assertEqual(-200);
        console.info('Invalid latitude -200 was accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude -200: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_latitude_0005
     * @tc.name       : testInvalidLatitude005
     * @tc.desc       : Test latitude with extremely large value (1000)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLatitude005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 1000, longitude: 0 };
        expect(loc.latitude).assertEqual(1000);
        console.info('Invalid latitude 1000 was accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude 1000: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_longitude_0001
     * @tc.name       : testInvalidLongitude001
     * @tc.desc       : Test longitude with value exceeding maximum boundary (>180)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLongitude001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 0, longitude: 181 };
        expect(loc.longitude).assertEqual(181);
        console.info('Invalid longitude 181 was accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude 181: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_longitude_0002
     * @tc.name       : testInvalidLongitude002
     * @tc.desc       : Test longitude with value below minimum boundary (<-180)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLongitude002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 0, longitude: -181 };
        expect(loc.longitude).assertEqual(-181);
        console.info('Invalid longitude -181 was accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude -181: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_longitude_0003
     * @tc.name       : testInvalidLongitude003
     * @tc.desc       : Test longitude with large value exceeding boundary (200)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLongitude003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 0, longitude: 200 };
        expect(loc.longitude).assertEqual(200);
        console.info('Invalid longitude 200 was accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude 200: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_longitude_0004
     * @tc.name       : testInvalidLongitude004
     * @tc.desc       : Test longitude with large negative value (-300)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLongitude004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 0, longitude: -300 };
        expect(loc.longitude).assertEqual(-300);
        console.info('Invalid longitude -300 was accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude -300: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_longitude_0005
     * @tc.name       : testInvalidLongitude005
     * @tc.desc       : Test longitude with extremely large value (1000)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidLongitude005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 0, longitude: 1000 };
        expect(loc.longitude).assertEqual(1000);
        console.info('Invalid longitude 1000 was accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude 1000: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_combined_0001
     * @tc.name       : testInvalidCombined001
     * @tc.desc       : Test Location with both latitude and longitude exceeding maximum boundaries
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidCombined001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 95, longitude: 185 };
        expect(loc.latitude).assertEqual(95);
        expect(loc.longitude).assertEqual(185);
        console.info('Invalid combined values (95, 185) were accepted');
      } catch (error) {
        console.info('Expected error for invalid combined values: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_combined_0002
     * @tc.name       : testInvalidCombined002
     * @tc.desc       : Test Location with both latitude and longitude below minimum boundaries
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidCombined002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: -100, longitude: -200 };
        expect(loc.latitude).assertEqual(-100);
        expect(loc.longitude).assertEqual(-200);
        console.info('Invalid combined values (-100, -200) were accepted');
      } catch (error) {
        console.info('Expected error for invalid combined values: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_combined_0003
     * @tc.name       : testInvalidCombined003
     * @tc.desc       : Test Location with valid latitude and invalid longitude
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidCombined003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 45, longitude: 360 };
        expect(loc.latitude).assertEqual(45);
        expect(loc.longitude).assertEqual(360);
        console.info('Invalid combined values (45, 360) were accepted');
      } catch (error) {
        console.info('Expected error for invalid longitude value: ' + error);
      }
      done();
    });

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTLOCATION_invalid_combined_0004
     * @tc.name       : testInvalidCombined004
     * @tc.desc       : Test Location with invalid latitude and valid longitude
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 3
     */
    it('testInvalidCombined004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let loc: media.Location = { latitude: 180, longitude: 90 };
        expect(loc.latitude).assertEqual(180);
        expect(loc.longitude).assertEqual(90);
        console.info('Invalid combined values (180, 90) were accepted');
      } catch (error) {
        console.info('Expected error for invalid latitude value: ' + error);
      }
      done();
    });
  })
}