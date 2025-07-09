/*
 * Copyright (C) 2023-2025 Huawei Device Co., Ltd.
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

import fileIOClose from "./members/close.test";
import fileIOFdatasync from "./members/fdatasync.test";
import fileIOFsync from "./members/fsync.test";
import fileIOMkdir from "./members/mkdir.test";
import fileIOMkdtemp from "./members/mkdtemp.test";
import fileIOOpen from "./members/open.test";
import fileIORead from "./members/read.test";
import fileIORename from "./members/rename.test";
import fileIORmdir from "./members/rmdir.test";
import fileIOStat from "./members/stat.test";
import fileIOTruncate from "./members/truncate.test";
import fileIOUnlink from "./members/unlink.test";
import fileIOWrite from "./members/write.test";
import fileIOStatvfs from "./members/statvfs.test";
import fileIOHash from "./members/hash.test";
import fileIOAccess from "./members/access.test";
import fileIOCopyDir from "./members/copydir.test";
import fileIOSetxattr from "./members/setxattr.test";
import fileIOGetxattr from "./members/getxattr.test";
import fileIOMoveDir from "./members/moveDir.test";
import fileIOLstat from "./members/lstat.test";
import fileIOMoveFile from "./members/moveFile.test";
import fileIOReadtext from "./members/readtext.test";
import fileIOListfile from "./members/listFile.test";
import fileIOAtomicFile from './members/atomicFile.test'
import fileIOWatcher from './members/watcher.test'
import fileIORandomAccessFileClose from './class_randomAccessFile/close.test';
import fileIORandomAccessFileRead from './class_randomAccessFile/read.test';
import fileIORandomAccessFileSetFilePointer from './class_randomAccessFile/setFilePointer.test';
import fileIORandomAccessFileWrite from './class_randomAccessFile/write.test';
import fileIOCreateRandomAccessFile from './members/createRandomAccessFile.test';
import fileIOReadLines from "./members/readLines.test";
import fileIOLseek from "./members/lseek.test";
import fileIOUtimes from "./members/utimes.test";
import fileIOCreateStream from './members/createStream.test'
import fileIOFdOpenStream from './members/fdopenStream.test'
import fileIOStreamRead from './stream/read.test'
import fileIOStreamWrite from './stream/write.test'
import fileIOStreamClose from './stream/close.tes'
import fileIOStreamFlush from './stream/flush.test'
import fileIOCreateStreamRW from './stream/CreateStreamRW.test'
import deviceInfo from '@ohos.deviceInfo';

let osName:string = deviceInfo.osFullName;

export default function testsuite() {
  fileIOClose();
  fileIOFdatasync();
  fileIOFsync();
  fileIOMkdir();
  fileIOMkdtemp();
  fileIOOpen();
  fileIORead();
  fileIORename();
  fileIORmdir();
  fileIOStat();
  fileIOTruncate();
  fileIOUnlink();
  fileIOWrite();
  fileIOStatvfs();
  fileIOHash();
  fileIOAccess();
  fileIOCopyDir();
  fileIOSetxattr();
  fileIOGetxattr();
  fileIOMoveDir();
  fileIOLstat();
  fileIOMoveFile();
  fileIOReadtext();
  fileIOListfile();
  if (!osName.startsWith('iOS')) {
    fileIOWatcher();
  }
  fileIORandomAccessFileClose();
  fileIORandomAccessFileRead();
  fileIORandomAccessFileSetFilePointer();
  fileIORandomAccessFileWrite();
  fileIOCreateRandomAccessFile();
  fileIOReadLines();
  fileIOLseek();
  fileIOUtimes();
  fileIOCreateStream();
  fileIOFdOpenStream();
  fileIOStreamRead();
  fileIOStreamWrite();
  fileIOStreamClose();
  fileIOStreamFlush();
  fileIOCreateStreamRW();
  fileIOAtomicFile();
}
