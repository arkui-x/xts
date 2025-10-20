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

import geolocationTest_GeoErr from './GeocoderErrorTest.test'
import geolocationTest_geoM from './GeocoderMTest.test'
import geoLocationManager_nop_test from './GeoLocationManager_Nop_Test.test'
import geolocationTest_geo4 from './GetCountryCode.test'
import geolocationTest_geo1 from './ListeningError.test'
import geolocationTest_geo2 from './LocationErrorTest.test'
import geolocationTest_geo3 from './LocationMTest.test'
import geolocationTest_geo5 from './LocationMTest02.test'

export default function testsuite() {
    geolocationTest_GeoErr()
    geolocationTest_geoM()
    geoLocationManager_nop_test()
    geolocationTest_geo4()
    geolocationTest_geo1()
    geolocationTest_geo2()
    geolocationTest_geo3()
    geolocationTest_geo5()
}
