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

import { describe, beforeAll, beforeEach, afterEach, it, expect, Level, Size, TestType } from '@ohos/hypium';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import common from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { BusinessError } from '@ohos.base';

const WAIT_INTERVAL_MS: number = 50;
const WAIT_EACH_MS: number = 500;
const WAIT_CALLBACK_MS: number = 1500;
const RANDOM_DB_SUFFIX_RANGE: number = 1000;
const INVALID_SUBSCRIBE_TYPE: number = -1;
const EXPECTED_PARAM_ERROR_CODE: string = '401';
const EXPECTED_CLOSED_ERROR_CODE: string = '14800014';
const DEFAULT_AGE: number = 25;
const UPDATED_AGE: number = 26;

type DetailObserver = (info: Array<relationalStore.ChangeInfo>) => void;

interface ObserverRecord {
  table: string;
  inserted: Array<string>;
  updated: Array<string>;
  deleted: Array<string>;
  changeType: number;
}

class ObserverBucket {
  records: Array<ObserverRecord> = [];

  observer: DetailObserver = (info: Array<relationalStore.ChangeInfo>) => {
    info.forEach((item: relationalStore.ChangeInfo) => {
      this.records.push({
        table: item.table,
        inserted: normalizeKeys(item.inserted),
        updated: normalizeKeys(item.updated),
        deleted: normalizeKeys(item.deleted),
        changeType: item.type,
      });
    });
  };
}

class RdbObserverEnv {
  context: common.Context;
  dbName: string;
  store: relationalStore.RdbStore | null = null;

  constructor(context: common.Context, dbName: string) {
    this.context = context;
    this.dbName = dbName;
  }

  async open(): Promise<relationalStore.RdbStore> {
    this.store = await relationalStore.getRdbStore(this.context, {
      name: this.dbName,
      securityLevel: relationalStore.SecurityLevel.S1,
    });
    return this.store;
  }

  async recreateTable(tableName: string, createClause: string): Promise<void> {
    const store = this.requireStore();
    await store.executeSql(`DROP TABLE IF EXISTS ${tableName}`);
    await store.executeSql(`CREATE TABLE ${tableName} (${createClause})`);
  }

  async closeAndDelete(): Promise<void> {
    if (this.store !== null) {
      try {
        this.store.off('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS);
      } catch (err) {
        console.error(`closeAndDelete off error: ${err}`);
      }
      try {
        await this.store.close();
      } catch (err) {
        console.error(`closeAndDelete close error: ${err}`);
      }
      this.store = null;
    }
    try {
      await relationalStore.deleteRdbStore(this.context, this.dbName);
    } catch (err) {
      console.error(`closeAndDelete deleteRdbStore error: ${err}`);
    }
  }

  requireStore(): relationalStore.RdbStore {
    if (this.store === null) {
      throw new Error('RdbStore has not been created');
    }
    return this.store;
  }
}

function sleep(time: number): Promise<void> {
  return new Promise<void>((resolve: () => void) => setTimeout(resolve, time));
}

function normalizeKeys(keys: Array<string> | Array<number>): Array<string> {
  let normalized: Array<string> = [];
  for (const item of keys) {
    normalized.push(String(item));
  }
  return normalized;
}

function createDbName(caseId: string): string {
  return `RelationalStoreObserver_${caseId}_${Date.now()}_${Math.floor(Math.random() * RANDOM_DB_SUFFIX_RANGE)}.db`;
}

async function waitForRecord(
  bucket: ObserverBucket,
  matcher: (record: ObserverRecord) => boolean,
  timeoutMs: number = WAIT_CALLBACK_MS,
): Promise<ObserverRecord | null> {
  const endTime = Date.now() + timeoutMs;
  while (Date.now() <= endTime) {
    const matched = bucket.records.find(matcher);
    if (matched !== undefined) {
      return matched;
    }
    await sleep(WAIT_INTERVAL_MS);
  }
  return null;
}

function insertMatcher(tableName: string, key: string): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && record.inserted.includes(key);
}

function updateMatcher(tableName: string, key: string): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && record.updated.includes(key);
}

function deleteMatcher(tableName: string, key: string): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && record.deleted.includes(key);
}

function containsAllKeys(actual: Array<string>, expected: Array<string>): boolean {
  for (const key of expected) {
    if (!actual.includes(key)) {
      return false;
    }
  }
  return true;
}

function containsExactlyKeys(actual: Array<string>, expected: Array<string>): boolean {
  return actual.length === expected.length && containsAllKeys(actual, expected);
}

function insertKeysMatcher(tableName: string, keys: Array<string>): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && containsExactlyKeys(record.inserted, keys) &&
    record.updated.length === 0 && record.deleted.length === 0;
}

function updateKeysMatcher(tableName: string, keys: Array<string>): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && containsExactlyKeys(record.updated, keys) &&
    record.inserted.length === 0 && record.deleted.length === 0;
}

function deleteKeysMatcher(tableName: string, keys: Array<string>): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName && containsExactlyKeys(record.deleted, keys) &&
    record.inserted.length === 0 && record.updated.length === 0;
}

function mixedCrudMatcher(tableName: string, insertedKey: string, updatedKey: string,
  deletedKey: string): (record: ObserverRecord) => boolean {
  return (record: ObserverRecord) => record.table === tableName &&
    containsExactlyKeys(record.inserted, [insertedKey]) &&
    containsExactlyKeys(record.updated, [updatedKey]) &&
    containsExactlyKeys(record.deleted, [deletedKey]);
}

function hasRecord(bucket: ObserverBucket, matcher: (record: ObserverRecord) => boolean): boolean {
  return bucket.records.find(matcher) !== undefined;
}

async function waitForNoRecord(
  bucket: ObserverBucket,
  matcher: (record: ObserverRecord) => boolean,
  timeoutMs: number = WAIT_CALLBACK_MS,
): Promise<boolean> {
  const endTime = Date.now() + timeoutMs;
  while (Date.now() <= endTime) {
    if (hasRecord(bucket, matcher)) {
      return false;
    }
    await sleep(WAIT_INTERVAL_MS);
  }
  return !hasRecord(bucket, matcher);
}

async function rowExists(store: relationalStore.RdbStore, tableName: string, name: string): Promise<boolean> {
  const predicates = new relationalStore.RdbPredicates(tableName);
  predicates.equalTo('name', name);
  const resultSet = await store.query(predicates, ['id']);
  try {
    return resultSet.rowCount > 0;
  } finally {
    resultSet.close();
  }
}

async function getContextFromTopAbility(): Promise<common.Context> {
  const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
  const ability = await delegator.getCurrentTopAbility();
  if (ability === undefined || ability.context === undefined) {
    throw new Error('Failed to get test context from top ability');
  }
  return ability.context;
}

export default function relationalStoreObserverTest() {
  describe('relationalStoreObserverTest', () => {
    let testContext: common.Context;
    let activeEnvs: Array<RdbObserverEnv> = [];

    const trackEnv = (env: RdbObserverEnv): RdbObserverEnv => {
      activeEnvs.push(env);
      return env;
    };

    beforeAll(async () => {
      testContext = await getContextFromTopAbility();
    });

    beforeEach(async () => {
      activeEnvs = [];
    });

    afterEach(async () => {
      for (const env of activeEnvs) {
        await env.closeAndDelete();
        await sleep(WAIT_EACH_MS);
      }
      activeEnvs = [];
    });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0100
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0100
     * @tc.desc Register local details observer on integer primary key table and receive inserted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0100';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_insert_int_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const rowId = await store.insert(tableName, { name: `${caseName}_name` });
          const record = await waitForRecord(bucket, insertMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.updated.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0200
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0200
     * @tc.desc Update data after subscription and receive updated rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0200';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_update_int_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          const rowId = await store.insert(tableName, { name: `${caseName}_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('id', rowId);
          await store.update({ name: `${caseName}_after` }, predicates);
          const record = await waitForRecord(bucket, updateMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0300
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0300
     * @tc.desc Delete data after subscription and receive deleted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0300';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_delete_int_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          const rowId = await store.insert(tableName, { name: `${caseName}_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('id', rowId);
          await store.delete(predicates);
          const record = await waitForRecord(bucket, deleteMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.updated.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0400
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0400
     * @tc.desc Register local details observer on string primary key table and receive inserted key.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0400';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_insert_str_pk';
        const bucket = new ObserverBucket();
        const primaryKey = `${caseName}_pk`;
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id TEXT PRIMARY KEY, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await store.insert(tableName, { id: primaryKey, name: `${caseName}_name` });
          const record = await waitForRecord(bucket, insertMatcher(tableName, primaryKey));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.includes(primaryKey)).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0500
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0500
     * @tc.desc Register local details observer on string primary key table and receive updated key.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0500';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_update_str_pk';
        const bucket = new ObserverBucket();
        const primaryKey = `${caseName}_pk`;
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id TEXT PRIMARY KEY, name TEXT');
          await store.insert(tableName, { id: primaryKey, name: `${caseName}_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('id', primaryKey);
          await store.update({ name: `${caseName}_after` }, predicates);
          const record = await waitForRecord(bucket, updateMatcher(tableName, primaryKey));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0600
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0600
     * @tc.desc Register local details observer on string primary key table and receive deleted key.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0600';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_delete_str_pk';
        const bucket = new ObserverBucket();
        const primaryKey = `${caseName}_pk`;
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id TEXT PRIMARY KEY, name TEXT');
          await store.insert(tableName, { id: primaryKey, name: `${caseName}_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('id', primaryKey);
          await store.delete(predicates);
          const record = await waitForRecord(bucket, deleteMatcher(tableName, primaryKey));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.updated.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0700
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0700
     * @tc.desc Register local details observer on table without primary key and receive inserted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0700';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_insert_no_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'name TEXT, age INTEGER');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const rowId = await store.insert(tableName, { name: `${caseName}_name`, age: DEFAULT_AGE });
          const record = await waitForRecord(bucket, insertMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.updated.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0800
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0800
     * @tc.desc Register local details observer on table without primary key and receive updated rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0800';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_update_no_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'name TEXT, age INTEGER');
          const rowId = await store.insert(tableName, { name: `${caseName}_before`, age: DEFAULT_AGE });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('name', `${caseName}_before`);
          await store.update({ name: `${caseName}_after`, age: UPDATED_AGE }, predicates);
          const record = await waitForRecord(bucket, updateMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_0900
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_0900
     * @tc.desc Register local details observer on table without primary key and receive deleted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_0900';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_delete_no_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'name TEXT, age INTEGER');
          const rowId = await store.insert(tableName, { name: `${caseName}_before`, age: DEFAULT_AGE });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('name', `${caseName}_before`);
          await store.delete(predicates);
          const record = await waitForRecord(bucket, deleteMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.updated.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1000
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1000
     * @tc.desc Register local details observer on composite primary key table and receive inserted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1000';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_insert_composite_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName,
            'part_a TEXT, part_b TEXT, content TEXT, PRIMARY KEY(part_a, part_b)');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const rowId = await store.insert(tableName, {
            part_a: `${caseName}_a`,
            part_b: `${caseName}_b`,
            content: `${caseName}_content`,
          });
          const record = await waitForRecord(bucket, insertMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.updated.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1100
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1100
     * @tc.desc Register local details observer on composite primary key table and receive updated rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1100';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_update_composite_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName,
            'part_a TEXT, part_b TEXT, content TEXT, PRIMARY KEY(part_a, part_b)');
          const rowId = await store.insert(tableName, {
            part_a: `${caseName}_a`,
            part_b: `${caseName}_b`,
            content: `${caseName}_before`,
          });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('part_a', `${caseName}_a`);
          predicates.equalTo('part_b', `${caseName}_b`);
          await store.update({ content: `${caseName}_after` }, predicates);
          const record = await waitForRecord(bucket, updateMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1200
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1200
     * @tc.desc Register local details observer on composite primary key table and receive deleted rowid.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1200';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_delete_composite_pk';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName,
            'part_a TEXT, part_b TEXT, content TEXT, PRIMARY KEY(part_a, part_b)');
          const rowId = await store.insert(tableName, {
            part_a: `${caseName}_a`,
            part_b: `${caseName}_b`,
            content: `${caseName}_before`,
          });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const predicates = new relationalStore.RdbPredicates(tableName);
          predicates.equalTo('part_a', `${caseName}_a`);
          predicates.equalTo('part_b', `${caseName}_b`);
          await store.delete(predicates);
          const record = await waitForRecord(bucket, deleteMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.updated.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1300
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1300
     * @tc.desc Register local details observer and receive all rowids from one multi-row insert statement.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1300';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_multi_row_insert';
        const bucket = new ObserverBucket();
        const rowIds = ['130001', '130002', '130003'];
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await store.executeSql(`INSERT INTO ${tableName} (id, name) VALUES ` +
            `(${rowIds[0]}, '${caseName}_name_1'), (${rowIds[1]}, '${caseName}_name_2'), ` +
            `(${rowIds[2]}, '${caseName}_name_3')`);
          const record = await waitForRecord(bucket, insertKeysMatcher(tableName, rowIds));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.updated.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1400
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1400
     * @tc.desc Register local details observer and receive all rowids from one multi-row update statement.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1400';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_multi_row_update';
        const bucket = new ObserverBucket();
        const rowIds = ['140001', '140002', '140003'];
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY, name TEXT');
          await store.executeSql(`INSERT INTO ${tableName} (id, name) VALUES ` +
            `(${rowIds[0]}, '${caseName}_before'), (${rowIds[1]}, '${caseName}_before'), ` +
            `(${rowIds[2]}, '${caseName}_before')`);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await store.executeSql(`UPDATE ${tableName} SET name='${caseName}_after' WHERE name='${caseName}_before'`);
          const record = await waitForRecord(bucket, updateKeysMatcher(tableName, rowIds));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.deleted.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1500
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1500
     * @tc.desc Register local details observer and receive all rowids from one multi-row delete statement.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1500';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_multi_row_delete';
        const bucket = new ObserverBucket();
        const rowIds = ['150001', '150002', '150003'];
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY, name TEXT');
          await store.executeSql(`INSERT INTO ${tableName} (id, name) VALUES ` +
            `(${rowIds[0]}, '${caseName}_before'), (${rowIds[1]}, '${caseName}_before'), ` +
            `(${rowIds[2]}, '${caseName}_before')`);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await store.executeSql(`DELETE FROM ${tableName} WHERE name='${caseName}_before'`);
          const record = await waitForRecord(bucket, deleteKeysMatcher(tableName, rowIds));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record!.inserted.length).assertEqual(0);
          expect(record!.updated.length).assertEqual(0);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1600
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1600
     * @tc.desc Local details observer receives insert, update and delete details after one committed transaction.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1600';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_transaction_mixed';
        const bucket = new ObserverBucket();
        const insertedKey = '160001';
        const updatedKey = '160002';
        const deletedKey = '160003';
        let transactionStarted = false;
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY, name TEXT');
          await store.insert(tableName, { id: Number(updatedKey), name: `${caseName}_update_before` });
          await store.insert(tableName, { id: Number(deletedKey), name: `${caseName}_delete_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          store.beginTransaction();
          transactionStarted = true;
          await store.insert(tableName, { id: Number(insertedKey), name: `${caseName}_insert` });
          const updatePredicates = new relationalStore.RdbPredicates(tableName);
          updatePredicates.equalTo('id', Number(updatedKey));
          await store.update({ name: `${caseName}_update_after` }, updatePredicates);
          const deletePredicates = new relationalStore.RdbPredicates(tableName);
          deletePredicates.equalTo('id', Number(deletedKey));
          await store.delete(deletePredicates);
          store.commit();
          transactionStarted = false;
          const record = await waitForRecord(bucket, mixedCrudMatcher(tableName, insertedKey, updatedKey, deletedKey));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
        } catch (err) {
          if (transactionStarted) {
            try {
              env.requireStore().rollBack();
            } catch (_) {
            }
          }
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1700
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1700
     * @tc.desc Local details observer receives no change notification for rolled back transaction operations.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1700';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_transaction_rollback';
        const bucket = new ObserverBucket();
        const insertedKey = 170001;
        const updatedKey = 170002;
        const deletedKey = 170003;
        let transactionStarted = false;
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY, name TEXT');
          await store.insert(tableName, { id: updatedKey, name: `${caseName}_update_before` });
          await store.insert(tableName, { id: deletedKey, name: `${caseName}_delete_before` });
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          store.beginTransaction();
          transactionStarted = true;
          await store.insert(tableName, { id: insertedKey, name: `${caseName}_insert` });
          const updatePredicates = new relationalStore.RdbPredicates(tableName);
          updatePredicates.equalTo('id', updatedKey);
          await store.update({ name: `${caseName}_update_after` }, updatePredicates);
          const deletePredicates = new relationalStore.RdbPredicates(tableName);
          deletePredicates.equalTo('id', deletedKey);
          await store.delete(deletePredicates);
          store.rollBack();
          transactionStarted = false;
          const noRecord = await waitForNoRecord(bucket,
            (record: ObserverRecord) => record.table === tableName &&
              (record.inserted.length > 0 || record.updated.length > 0 || record.deleted.length > 0));
          expect(noRecord).assertTrue();
          expect(await rowExists(store, tableName, `${caseName}_update_before`)).assertTrue();
          expect(await rowExists(store, tableName, `${caseName}_update_after`)).assertFalse();
          expect(await rowExists(store, tableName, `${caseName}_delete_before`)).assertTrue();
          expect(await rowExists(store, tableName, `${caseName}_insert`)).assertFalse();
        } catch (err) {
          if (transactionStarted) {
            try {
              env.requireStore().rollBack();
            } catch (_) {
            }
          }
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1800
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1800
     * @tc.desc Two observers registered on the same store both receive the same change notification.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1800';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_two_observers';
        const bucket1 = new ObserverBucket();
        const bucket2 = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket1.observer);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket2.observer);
          const rowId = await store.insert(tableName, { name: `${caseName}_name` });
          const record1 = await waitForRecord(bucket1, insertMatcher(tableName, String(rowId)));
          const record2 = await waitForRecord(bucket2, insertMatcher(tableName, String(rowId)));
          expect(record1 !== null).assertTrue();
          expect(record1!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record2 !== null).assertTrue();
          expect(record2!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_1900
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_1900
     * @tc.desc Local details observer distinguishes changes from multiple tables in the same database.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_1900';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName1 = 'observe_multi_table_a';
        const tableName2 = 'observe_multi_table_b';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName1, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          await env.recreateTable(tableName2, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const rowId1 = await store.insert(tableName1, { name: `${caseName}_table_a` });
          const rowId2 = await store.insert(tableName2, { name: `${caseName}_table_b` });
          const record1 = await waitForRecord(bucket, insertMatcher(tableName1, String(rowId1)));
          const record2 = await waitForRecord(bucket, insertMatcher(tableName2, String(rowId2)));
          expect(record1 !== null).assertTrue();
          expect(record1!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record2 !== null).assertTrue();
          expect(record2!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2000
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2000
     * @tc.desc Observers registered on two databases receive only their own database changes.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2000';
        const env1 = trackEnv(new RdbObserverEnv(testContext, createDbName(`${caseName}_db1`)));
        const env2 = trackEnv(new RdbObserverEnv(testContext, createDbName(`${caseName}_db2`)));
        const tableName1 = 'observe_two_db_a';
        const tableName2 = 'observe_two_db_b';
        const bucket1 = new ObserverBucket();
        const bucket2 = new ObserverBucket();
        try {
          const store1 = await env1.open();
          const store2 = await env2.open();
          await env1.recreateTable(tableName1, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          await env2.recreateTable(tableName2, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store1.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket1.observer);
          store2.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket2.observer);
          const rowId1 = await store1.insert(tableName1, { name: `${caseName}_db1` });
          const rowId2 = await store2.insert(tableName2, { name: `${caseName}_db2` });
          const record1 = await waitForRecord(bucket1, insertMatcher(tableName1, String(rowId1)));
          const record2 = await waitForRecord(bucket2, insertMatcher(tableName2, String(rowId2)));
          expect(record1 !== null).assertTrue();
          expect(record1!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record2 !== null).assertTrue();
          expect(record2!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(hasRecord(bucket1, insertMatcher(tableName2, String(rowId2)))).assertFalse();
          expect(hasRecord(bucket2, insertMatcher(tableName1, String(rowId1)))).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2100
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2100
     * @tc.desc Observers on different databases remain isolated when table names are the same.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2100';
        const env1 = trackEnv(new RdbObserverEnv(testContext, createDbName(`${caseName}_db1`)));
        const env2 = trackEnv(new RdbObserverEnv(testContext, createDbName(`${caseName}_db2`)));
        const tableName = 'observe_same_name_table';
        const bucket1 = new ObserverBucket();
        const bucket2 = new ObserverBucket();
        const primaryKey1 = `${caseName}_db1_pk`;
        const primaryKey2 = `${caseName}_db2_pk`;
        try {
          const store1 = await env1.open();
          const store2 = await env2.open();
          await env1.recreateTable(tableName, 'id TEXT PRIMARY KEY, name TEXT');
          await env2.recreateTable(tableName, 'id TEXT PRIMARY KEY, name TEXT');
          store1.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket1.observer);
          store2.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket2.observer);
          await store1.insert(tableName, { id: primaryKey1, name: `${caseName}_db1` });
          await store2.insert(tableName, { id: primaryKey2, name: `${caseName}_db2` });
          const record1 = await waitForRecord(bucket1, insertMatcher(tableName, primaryKey1));
          const record2 = await waitForRecord(bucket2, insertMatcher(tableName, primaryKey2));
          expect(record1 !== null).assertTrue();
          expect(record1!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(record2 !== null).assertTrue();
          expect(record2!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(hasRecord(bucket1, insertMatcher(tableName, primaryKey2))).assertFalse();
          expect(hasRecord(bucket2, insertMatcher(tableName, primaryKey1))).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2200
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2200
     * @tc.desc Register observer before table creation and still receive callback after the table is created.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2200';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_before_create';
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          const rowId = await store.insert(tableName, { name: `${caseName}_name` });
          const record = await waitForRecord(bucket, insertMatcher(tableName, String(rowId)));
          expect(record !== null).assertTrue();
          expect(record!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2300
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2300
     * @tc.desc Calling on with an invalid subscribe type throws a parameter error.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2300';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable('observe_invalid_type_on', 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          let error: BusinessError | null = null;
          try {
            store.on('dataChange', INVALID_SUBSCRIBE_TYPE, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.on('dataChange', 999, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.on('dataChange', undefined, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.on('dataChange', null, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2400
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2400
     * @tc.desc Off with a specific observer stops further callbacks for that observer.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2400';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_off_specific';
        const bucket = new ObserverBucket();
        const activeBucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, activeBucket.observer);
          store.off('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          const rowId = await store.insert(tableName, { name: `${caseName}_name` });
          const activeRecord = await waitForRecord(activeBucket, insertMatcher(tableName, String(rowId)));
          expect(activeRecord !== null).assertTrue();
          expect(activeRecord!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(hasRecord(bucket, insertMatcher(tableName, String(rowId)))).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2500
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2500
     * @tc.desc Off without observer removes all local details observers of the store.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2500';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const tableName = 'observe_off_all';
        const bucket1 = new ObserverBucket();
        const bucket2 = new ObserverBucket();
        const activeBucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable(tableName, 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket1.observer);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket2.observer);
          store.off('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS);
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, activeBucket.observer);
          const rowId = await store.insert(tableName, { name: `${caseName}_name` });
          const activeRecord = await waitForRecord(activeBucket, insertMatcher(tableName, String(rowId)));
          expect(activeRecord !== null).assertTrue();
          expect(activeRecord!.changeType).assertEqual(relationalStore.ChangeType.DATA_CHANGE);
          expect(hasRecord(bucket1, insertMatcher(tableName, String(rowId)))).assertFalse();
          expect(hasRecord(bucket2, insertMatcher(tableName, String(rowId)))).assertFalse();
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2600
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2600
     * @tc.desc Calling off with an invalid subscribe type throws a parameter error.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2600';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable('observe_invalid_type_off', 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          let error: BusinessError | null = null;
          try {
            store.off('dataChange', INVALID_SUBSCRIBE_TYPE, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.off('dataChange', 999, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.off('dataChange', undefined, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);

          error = null;
          try {
            store.off('dataChange', null, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_PARAM_ERROR_CODE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2700
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2700
     * @tc.desc Calling on after store is closed throws error 14800014.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2700';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable('observe_closed_on', 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          await store.close();
          let error: BusinessError | null = null;
          try {
            store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_CLOSED_ERROR_CODE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_ArkTS_RelationalStore_OnOff_2800
     * @tc.name ArkUIX_ArkTS_RelationalStore_OnOff_2800
     * @tc.desc Calling off after store is closed throws error 14800014.
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_RelationalStore_OnOff_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        const caseName = 'ArkUIX_ArkTS_RelationalStore_OnOff_2800';
        const env = trackEnv(new RdbObserverEnv(testContext, createDbName(caseName)));
        const bucket = new ObserverBucket();
        try {
          const store = await env.open();
          await env.recreateTable('observe_closed_off', 'id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT');
          store.on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          await store.close();
          let error: BusinessError | null = null;
          try {
            store.off('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_LOCAL_DETAILS, bucket.observer);
          } catch (err) {
            error = err as BusinessError;
          }
          expect(error !== null).assertTrue();
          expect(error!.code).assertEqual(EXPECTED_CLOSED_ERROR_CODE);
        } catch (err) {
          console.error(`${caseName} failed: ${(err as Error).message}`);
          expect().assertFail();
        }
        done();
      });

  });
}
