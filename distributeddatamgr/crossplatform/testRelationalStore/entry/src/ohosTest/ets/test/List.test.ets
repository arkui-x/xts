/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import RdbPredicates from './RdbPredicates.test'
import ResultSet from './ResultSet.test'
import RdbStoreInsert from './RdbStoreInsert.test'
import RdbStoreUpdate from './RdbStoreUpdate.test'
import RdbStoreDelete from './RdbStoreDelete.test'
import RdbStoreQuery from './RdbStoreQuery.test'
import RdbStoreQuerySql from './RdbStoreQuerySql.test'
import RdbStoreExecuteSql from './RdbStoreExecuteSql.test'
import RdbStoreTransaction from './RdbStoreTransaction.test'
import RdbStoreBackupRestore from './RdbStoreBackupRestore.test'
import RelationalStore from './RelationalStore.test'
import relationalStoreAssetResultSetTest from './AssetResultSet.test'
import RelationalStoreSyncApiTest from './RelationalStoreSyncApiTest.test'

export default function testsuite() {
  RdbPredicates()
  ResultSet()
  RdbStoreInsert()
  RdbStoreUpdate()
  RdbStoreDelete()
  RdbStoreQuery()
  RdbStoreQuerySql()
  RdbStoreExecuteSql()
  RdbStoreTransaction()
  RdbStoreBackupRestore()
  RelationalStore()
  relationalStoreAssetResultSetTest()
  RelationalStoreSyncApiTest()
}