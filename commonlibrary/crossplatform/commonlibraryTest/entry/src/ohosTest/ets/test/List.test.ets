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

import ConvertXML from './convertXML.test'

import ExecutePeriodically from './executePeriodically.test'
import GetTaskPoolInfo from './getTaskPoolInfo.test'
import IsCanceled from './isCanceled.test'
import IsConcurrent from './isConcurrent.test'
import RemoveDependency from './removeDependency.test'
import TaskpoolIDLE from './taskpoolIDLE.test'
import TaskProperty from './taskpoolProperty.test'
import TaskState from './taskpoolState.test'
import TerminateTask from './terminateTask.test'

import AddQueryValue from './addQueryValue.test'
import CheckHierarchical from './checkHierarchical.test'
import CheckOpaque from './checkOpaque.test'
import CheckRelative from './checkRelative.test'
import ClearQuery from './clearQuery.test'
import CreateFromParts from './createFromParts.test'
import EncodedAuthority from './encodedAuthority.test'
import EncodedFragment from './encodedFragment.test'
import EncodedPath from './encodedPath.test'
import EncodedQuery from './encodedQuery.test'
import EncodedSSP from './encodedSSP.test'
import EncodedUserInfo from './encodedUserInfo.test'
import GetLastSegment from './getLastSegment.test'
import GetQueryNames from './getQueryNames.test'
import GetQueryValue from './getQueryValue.test'
import GetSegment from './getSegment.test'

import Create from './create.test'
import GetHash from './getHash.test'
import UtilType from './utilType.test'

import BigIntMode from './bigIntMode.test'

import DuplexCork from './duplexCork.test'
import DuplexEnd from './duplexEnd.test'
import DuplexSetDefaultEncoding from './duplexSetDefaultEncoding.test'
import Readable from './readable.test'
import ReadableOff from './readableOff.test'
import ReadableProperties from './readableProperties.test'
import ReadablePush from './readablePush.test'
import ReadableSetEncoding from './readableSetEncoding.test'
import SetDefaultEncoding from './setDefaultEncoding.test'
import Writable from './writable.test'
import WritableCorked from './writableCorked.test'
import WritableDoInitialize from './writableDoInitialize.test'
import WritableEnd from './writableEnd.test'
import WritableEnded from './writableEnded.test'
import WritableHighWatermark from './writableHighWatermark.test'
import WritableLength from './writableLength.test'
import WritableObjectMode from './writableObjectMode.test'
import WritableOnOff from './writableOn_Off.test'

import DecimalPlacesTest from './decimalPlaces.test'
import RandomTest from './random.test'
import ToNearestTest from './toNearest.test'
import ToPrecisionTest from './toPrecision.test'
import ToSignificantDigitsTest from './toSignificantDigits.test'
import TruncTest from './trunc.test'
import ValueOfTest from './valueOf.test'
import AbsTest from './abs.test'
import AddTest from './add.test'
import CbrtTest from './cbrt.test'
import CeilTest from './ceil.test'
import ClampTest from './clamp.test'
import DivTest from './div.test'
import ExpTest from './exp.test'
import FloorTest from './floor.test'
import LnTest from './ln.test'
import LogTest from './log.test'
import Log10Test from './log10.test'
import Log2Test from './log2.test'
import ModTest from './mod.test'
import MulTest from './mul.test'
import PowTest from './pow.test'
import SqrtTest from './sqrt.test'
import SubTest from './sub.test'
import RoundTest from './round.test'
import AsinTest from './asin.test'
import AcosTest from './acos.test'
import AtanTest from './atan.test'
import Atan2Test from './atan2.test'
import AsinhTest from './asinh.test'
import AcoshTest from './acosh.test'
import AtanhTest from './atanh.test'
import SinTest from './sin.test'
import CosTest from './cos.test'
import TanTest from './tan.test'
import CoshTest from './cosh.test'
import TanhTest from './tanh.test'
import SinhTest from './sinh.test'
import SignTest from './sign.test'

import arraySymbolIteratorTest from "./arraySymbolIterator.test"
import float32ArrayTest from "./float32Array.test"
import int16ArrayTest from "./int16Array.test"
import int32ArrayTest from "./int32Array.test"
import int8ArrayTest from "./int8Array.test"
import mapSymbolIteratorTest from "./mapSymbolIterator.test"
import setSymbolIteratorTest from "./setSymbolIterator.test"
import uint16ArrayTest from "./uint16Array.test"
import uint32ArrayTest from "./uint32Array.test"
import uint8ClampedArrayTest from "./uint8ClampedArray.test"
import duplexTest from "./duplex.test"
import dispatchEventTest from "./dispatchEvent.test"
import eventTypeTest from "./eventType.test"
import addEmptyElementTest from "./addEmptyElement.test"
import endElementTest from "./endElement.test"
import setAttributesTest from "./setAttributes.test"
import setCdataTest from "./setCdata.test"
import setCommentTest from "./setComment.test"
import setDeclarationTest from "./setDeclaration.test"
import setDocTypeTest from "./setDocType.test"
import setNamespaceTest from "./setNamespace.test"
import setTextTest from "./setText.test"
import startElementTest from "./startElement.test"

export default function TestSuite() {
  ConvertXML()
  ExecutePeriodically()
  // GetTaskPoolInfo() //需要单独测试
  IsCanceled()
  IsConcurrent()
  RemoveDependency()
  TaskpoolIDLE()
  TaskProperty()
  TaskState()
  // TerminateTask() //需要单独测试
  AddQueryValue()
  CheckHierarchical()
  CheckOpaque()
  CheckRelative()
  ClearQuery()
  CreateFromParts()
  EncodedAuthority()
  EncodedFragment()
  EncodedPath()
  EncodedQuery()
  EncodedSSP()
  EncodedUserInfo()
  GetLastSegment()
  GetQueryNames()
  GetQueryValue()
  GetSegment()
  Create()
  GetHash()
  UtilType()
  BigIntMode()
  DuplexCork()
  DuplexEnd()
  DuplexSetDefaultEncoding()
  Readable()
  ReadableOff()
  ReadableProperties()
  ReadablePush()
  ReadableSetEncoding()
  SetDefaultEncoding()
  Writable()
  WritableCorked()
  WritableDoInitialize()
  WritableEnd()
  WritableEnded()
  WritableHighWatermark()
  WritableLength()
  WritableObjectMode()
  WritableOnOff()
  ToNearestTest()
  ToPrecisionTest()
  ToSignificantDigitsTest()
  ValueOfTest()
  DecimalPlacesTest()
  AbsTest()
  FloorTest()
  CeilTest()
  TruncTest()
  ClampTest()
  AddTest()
  SubTest()
  MulTest()
  DivTest()
  ModTest()
  SqrtTest()
  CbrtTest()
  PowTest()
  ExpTest()
  LogTest()
  LnTest()
  Log2Test()
  Log10Test()
  SinTest()
  CosTest()
  TanTest()
  SinhTest()
  CoshTest()
  TanhTest()
  AsinTest()
  AcosTest()
  AtanTest()
  AsinhTest()
  AcoshTest()
  AtanhTest()
  Atan2Test()
  RandomTest()
  SignTest()
  RoundTest()
  duplexTest()
  dispatchEventTest()
  eventTypeTest()
  addEmptyElementTest()
  endElementTest()
  setAttributesTest()
  setCdataTest()
  setCommentTest()
  setDeclarationTest()
  setDocTypeTest()
  setNamespaceTest()
  setTextTest()
  startElementTest()
  arraySymbolIteratorTest()
  setSymbolIteratorTest()
  mapSymbolIteratorTest()
  int8ArrayTest()
  uint8ClampedArrayTest()
  uint8ClampedArrayTest()
  int16ArrayTest()
  uint16ArrayTest()
  int32ArrayTest()
  uint32ArrayTest()
  float32ArrayTest()
}