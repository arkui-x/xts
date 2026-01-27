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

import KvStoreResultSetTest from './DistributedKVStoreEtsTest/KvStoreResultSetKVEtsTest.test';
import kvStoreBackupPromiseJsunittest from './DistributedKVStoreEtsTest/KvStoreBackupPromiseEtsTest.test';
import kvStoreBackupCallbackJsunittest from './DistributedKVStoreEtsTest/KvStoreBackupCallbackEtsTest.test';
import SingleKvStoreCallbackTest from './DistributedKVStoreEtsTest/SingleKvStoreKVCallbackEtsTest.test';
import SingleKvStorePromiseTest from './DistributedKVStoreEtsTest/SingleKvStoreKVPromiseEtsTest.test';
import singleKvStoreEnumTest from './DistributedKVStoreEtsTest/SingleKvStoreEnumEtsTest.test';
import queryTest from './DistributedKVStoreEtsTest/QueryKvEtsTest.test';
import schemaTest from './DistributedKVStoreEtsTest/SchemaEts.test';
import schemaFieldNode from './DistributedKVStoreEtsTest/SchemaFieldNode.test'
import SingleKvStoreErrCodeTest from "./DistributedKVStoreEtsTest/SingleKvStoreErrCodeEtsTest.test";
import SingleKvStoreReturnValue from './DistributedKVStoreEtsTest/SingleKvStoreReturnValue.test';
import KVStoreResultSetReturnValue from './DistributedKVStoreEtsTest/KVStoreResultSetReturnValue.test';

import fieldNodeStage from './KvStoreStagetest/FieldNodeStage.test'
import kvManagerCallbackStage from './KvStoreStagetest/KvManagerCallbackStage.test'
import kvManagerPromiseStage from './KvStoreStagetest/KvManagerPromiseStage.test'
import schemaStage from './KvStoreStagetest/SchemaStage.test'
import singleKvStoreCallbackStage from './KvStoreStagetest/SingleKvStoreCallbackStage.test'
import singleKvStorePromiseStage from './KvStoreStagetest/SingleKvStorePromiseStage.test'

import KvStoreEtsTestStatic from './KvStoreEtsTestStatic/KvStoreEtsTestStatic.test'

export default function testsuite() {
  KvStoreResultSetTest();
  kvStoreBackupPromiseJsunittest();
  kvStoreBackupCallbackJsunittest();
  SingleKvStoreCallbackTest();
  SingleKvStorePromiseTest();
  singleKvStoreEnumTest();
  queryTest();
  schemaTest();
  schemaFieldNode();
  SingleKvStoreErrCodeTest();
  SingleKvStoreReturnValue();
  KVStoreResultSetReturnValue();

  fieldNodeStage();
  kvManagerCallbackStage();
  kvManagerPromiseStage();
  schemaStage();
  singleKvStoreCallbackStage();
  singleKvStorePromiseStage();

  KvStoreEtsTestStatic()
}