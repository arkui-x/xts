/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
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

import fileIO from '@ohos.file.fs';

export async function prepareImageFileUrl(fpath: string, imageArray: Uint8Array) {
  try {
    let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
    fileIO.truncateSync(file.fd);
    fileIO.writeSync(file.fd, imageArray.buffer);
    fileIO.fsyncSync(file.fd);
    fileIO.closeSync(file);
    return true;
  }
  catch (e) {
    console.log('Failed to prepareFile for ' + e);
    return false;
  }
}

export async function prepareImageFileFd(fpath: string, imageArray: Uint8Array) {
  try {
    let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
    fileIO.truncateSync(file.fd);
    fileIO.writeSync(file.fd, imageArray.buffer);
    return file.fd;
  }
  catch (e) {
    console.log('Failed to prepareFile for ' + e);
  }
  return null;
}
