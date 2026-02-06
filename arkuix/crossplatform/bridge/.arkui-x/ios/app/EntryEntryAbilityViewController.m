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

#import "EntryEntryAbilityViewController.h"

#import "BridgeImplJson.h"
#import "BridgeImplBinary.h"

#import <libarkui_ios/BridgePlugin.h>
@interface EntryEntryAbilityViewController ()
{
    BridgeImplJson *biJsongObject;
    BridgeImplJson *biJsongObjectCallBack;
    BridgeImplJson *biJsongObjectCallMethod;
    BridgeImplJson *biJsongObjectError;
    
    BridgeImplBinary *biBinary;
    BridgeImplBinary *biBinaryError;
    BridgeImplBinary *biBinaryCallBack;
    BridgeImplBinary *biBinaryCallMethod;
    
}

@end

@implementation EntryEntryAbilityViewController
- (instancetype)initWithInstanceName:(NSString *)instanceName {
    self = [super initWithInstanceName:instanceName];
    if (self) {

        biJsongObject = [[BridgeImplJson alloc]initBridgePlugin:@"testXts" bridgeType:JSON_TYPE];
        biJsongObjectCallBack = [[BridgeImplJson alloc]initBridgePlugin:@"testXtsCallBack" bridgeType:JSON_TYPE];
        biJsongObjectCallMethod = [[BridgeImplJson alloc]initBridgePlugin:@"testXtsCallMethod" bridgeType:JSON_TYPE];
        biJsongObjectError = [[BridgeImplJson alloc]initBridgePlugin:@"testXtsError" bridgeType:JSON_TYPE];
        
        biBinary = [[BridgeImplBinary alloc]initBridgePlugin:@"testXtsBinary" bridgeType:BINARY_TYPE];
        biBinaryCallBack = [[BridgeImplBinary alloc]initBridgePlugin:@"testXtsBinaryCallBack" bridgeType:BINARY_TYPE];
        biBinaryError = [[BridgeImplBinary alloc]initBridgePlugin:@"testXtsBinaryError" bridgeType:BINARY_TYPE];
        biBinaryCallMethod = [[BridgeImplBinary alloc]initBridgePlugin:@"testXtsBinaryCallMethod" bridgeType:BINARY_TYPE];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
}
@end
