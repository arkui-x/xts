/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
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

import fileIO from "@ohos.file.fs";
import util from "@ohos.util";
import { describe, it, expect, afterEach } from "@ohos/hypium";
import { common } from '@kit.AbilityKit';

export const FILE_CONTENT = "hello world";

export function prepareFile(fpath:string, content:string) {
  try {
    let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
    fileIO.truncateSync(file.fd);
    fileIO.writeSync(file.fd, content);
    fileIO.fsyncSync(file.fd);
    fileIO.closeSync(file);
    return true;
  } catch (e) {
    console.log("Failed to prepareFile for " + e);
    return false;
  }
}

export async function nextFileName(testName:string) {
  let context: common.UIAbilityContext = globalThis.abilityContext;
  let data = context.cacheDir;
  let BASE_PATH = data + "/";
  return BASE_PATH + testName + "_" + randomString(testName.length);
}

export async function nextFileNameInFilesDir(testName:string) {
  let context: common.UIAbilityContext = globalThis.abilityContext;
  let data = context.filesDir;
  let BASE_PATH = data + "/";
  return BASE_PATH + testName + "_" + randomString(testName.length);
}

export async function fileName(testName:string) {
  let context: common.UIAbilityContext = globalThis.abilityContext;
  let data = context.filesDir;
  let BASE_PATH = data + "/";
  return BASE_PATH + testName + "_" + randomString(testName.length);
}

export function randomString(num:number) {
  let len = num;
  let $chars = "aaaabbbbcccc";
  let maxPos = $chars.length;
  let pwd = "";
  for (let i = 0; i < len; i++) {
    pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
  }
  return pwd;
}

function isIntNum(val:number) {
  return typeof val === "number" && val % 1 === 0;
}

function isBigInt(val:bigint) {
  return typeof val === "bigint";
}

function isString(str:string) {
  return typeof str == "string" && str.constructor == String;
}

function isBoolean(val:boolean) {
  return typeof val == "boolean";
}

export { fileIO, isIntNum, isBigInt, isString, isBoolean, describe, it, expect, util, afterEach };
