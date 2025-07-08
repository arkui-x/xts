/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import rdbstoreEncryptTest from "./relationalstore.test"
import relationalStoreMultiTransTest from "./relationalstore1.test"
import TransactionBatchinsertTestSyncErrcode from "./relationalstore10.test"
import relationalStoreErrorCodeTest from "./relationalstore11.test"
import error14800021Test from "./relationalstore12.test"
import error14800030Test from "./relationalstore13.test"
import RdbStoreValueTypeTest from "./relationalstore2.test"
import SqlExecutionTimeTest from "./relationalstore3.test"
import relationalStoreErrorCode47Test from "./relationalstore4.test"
import relationalStoreBatchinsertTransactionTest from "./relationalstore5.test"
import TransactionBatchinsertTestErrcode from "./relationalstore6.test"
import relationalStoreBatchInsertErrcodeTest from "./relationalstore7.test"
import rdbrootDirTest from "./relationalstore8.test"
import RdbStoreReadOnlyTest from "./relationalstore9.test"
import relationalStoreNoTest from "./relationalstore_no.test"


export default function testsuite() {
  rdbstoreEncryptTest()
  relationalStoreMultiTransTest()
  RdbStoreValueTypeTest()
  SqlExecutionTimeTest()
  relationalStoreErrorCode47Test()
  relationalStoreBatchinsertTransactionTest()
  TransactionBatchinsertTestErrcode()
  relationalStoreBatchInsertErrcodeTest()
  rdbrootDirTest()
  RdbStoreReadOnlyTest()
  TransactionBatchinsertTestSyncErrcode()
  relationalStoreErrorCodeTest()
  error14800021Test()
  error14800030Test()
  relationalStoreNoTest()
}


