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

import ConcatArrayTest from './normal/ConcatArray.test';
import ArrayTest from './normal/Array.test';
import MapTest from './normal/Map.test';
import ArrayBufferTest from './normal/ArrayBuffer.test';
import Uint8ArrayTest from './normal/TypedArray/Uint8Array.test';
import Int8ArrayTest from './normal/TypedArray/Int8Array.test';
import Int16ArrayTest from './normal/TypedArray/Int16Array.test';
import Uint16ArrayTest from './normal/TypedArray/Uint16Array.test';
import Uint32ArrayTest from './normal/TypedArray/Uint32Array.test';
import Int32ArrayTest from './normal/TypedArray/Int32Array.test';
import Uint8ClampedArrayTest from './normal/TypedArray/Uint8ClampedArray.test';
import Float32ArrayTest from './normal/TypedArray/Float32Array.test';
import BitVectorTest from './normal/BitVector.test';
import SetTest from './normal/Set.test';

export default function testsuite() {
  ConcatArrayTest();
  ArrayTest();
  MapTest();
  ArrayBufferTest();
  Uint8ArrayTest();
  Int8ArrayTest();
  Int16ArrayTest();
  Uint16ArrayTest();
  Uint32ArrayTest();
  Int32ArrayTest();
  Uint8ClampedArrayTest();
  Float32ArrayTest();
  BitVectorTest();
  SetTest();
}