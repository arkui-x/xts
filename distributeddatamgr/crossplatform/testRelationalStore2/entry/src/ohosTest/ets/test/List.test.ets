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
import error14800021Test from "./error14800021.test"
import error14800030Test from "./error14800030.test"
import rdbrootDirTest from "./rdbrootDir.test"
import rdbstoreEncryptTest from "./rdbstoreEncrypt.test"
import RdbStoreReadOnlyTest from "./RdbStoreReadOnly.test"
import RdbStoreValueTypeTest from "./RdbStoreValueType.test"
import relationalStoreBatchInsertErrcodeTest from "./relationalStoreBatchInsertErrcode.test"
import relationalStoreBatchinsertTransactionTest from "./relationalStoreBatchinsertTransaction.test"
import relationalStoreErrorCodeTest from "./relationalStoreErrorCode.test"
import relationalStoreErrorCode47Test from "./relationalStoreErrorCode47.test"
import relationalStoreMultiTransTest from "./relationalStoreMultiTrans.test"
import relationalStorePredicatesTest from "./relationalStorePredicates.test"
import SqlExecutionTimeTest from "./SqlExecutionTime.test"
import TransactionBatchinsertTestErrcode from "./TransactionBatchinsertErrcode.test"
import TransactionBatchinsertTestSyncErrcode from "./TransactionBatchinsertSyncErrcode.test"


export default function testsuite() {
  error14800021Test()
  error14800030Test()
  rdbrootDirTest()
  rdbstoreEncryptTest()
  RdbStoreReadOnlyTest()
  RdbStoreValueTypeTest()
  relationalStoreBatchInsertErrcodeTest()
  relationalStoreBatchinsertTransactionTest()
  relationalStoreErrorCodeTest()
  relationalStoreErrorCode47Test()
  relationalStoreMultiTransTest()
  relationalStorePredicatesTest()
  SqlExecutionTimeTest()
  TransactionBatchinsertTestErrcode()
  TransactionBatchinsertTestSyncErrcode()
}


