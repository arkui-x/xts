/*
 *  Copyright (c) 2025 Huawei Device Co., Ltd.
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import collectionsArrayTest from './sendable_lib_collections/CollectionsArray.test';
import collectionsMapTest from './sendable_lib_collections/CollectionsMap.test';
import collectionsSetTest from './sendable_lib_collections/CollectionsSet.test';
import collectionsOtherTest from './sendable_lib_collections/CollectionOther.test';
import collectionsBitVectorTest from './sendable_lib_collections/CollectionBitVector.test';

export default function testsuite() {
  collectionsArrayTest();
  collectionsMapTest();
  collectionsSetTest();
  collectionsOtherTest();
  collectionsBitVectorTest();
}