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
 
#import <libarkui_ios/BridgeArray.h>
#import "BridgeImplJson.h"

@implementation BridgeImplJson
- (id)initBridgePlugin:(NSString *)bridgeName bridgeType:(BridgeType)type {
    self = [super initBridgePlugin:bridgeName bridgeType:type];
    if (self) {
        self.messageListener = self;
        self.methodResult = self;
    }
    return self;
}

#pragma mark - XTS 方法实现
// XTS method (callMethod)
- (NSString *)callMethodT0010 {
    return @"callMethodT0010 call success";
}
- (NSString *)callMethodT0010:(int)param {
    return @"callMethodT0010 call success";
}
- (NSString *)callMethodT0020:(NSString *)param {
    return param;
}

- (BOOL)callMethodT0030:(BOOL)param {
    
    return YES;
}

- (int)callMethodT0040:(NSNumber *)param {
    return [param intValue];
}

- (NSArray<NSString *> *)callMethodT0050:(NSArray<NSString *> *)param {
    return param;
}

- (NSArray<NSNumber *> *)callMethodT0060:(NSArray<NSNumber *> *)param {
    return param;
}

- (NSArray<NSNumber *> *)callMethodT0070:(NSArray<NSNumber *> *)param {
    return param;
}

// XTS method (callMethodSync)
- (NSString *)callMethodSyncT0010 {
    return @"callMethodSyncT0010 call success";
}

- (NSString *)callMethodSyncT0010:(int)param {
    return @"callMethodSyncT0010 call success";
}

- (NSString *)callMethodSyncT0020:(NSString *)param {
    return @"callMethodSyncT0020 call success";
}

- (BOOL)callMethodSyncT0030:(BOOL)param {
    return YES;
}

- (int)callMethodSyncT0040:(NSNumber *)param {
    return [param intValue];
}

- (NSArray<NSString *> *)callMethodSyncT0050:(NSArray<NSString *> *)param {
    return param;
}

- (NSArray<NSNumber *> *)callMethodSyncT0060:(NSArray<NSNumber *> *)param {
    return param;
}

- (NSArray<NSNumber *> *)callMethodSyncT0070:(NSArray<NSNumber *> *)param {
    return param;
}

- (NSString *)callMethodWithCallbackT0010 {
    [self callMethodJson:@"callMethodWithCallbackT0010" param:@"arkTsMethodWithCallback call success"];
    return @"callMethodWithCallbackT0010 call success";
}

- (NSString *)callMethodWithCallbackT0020:(NSString *)param {
    [self callMethodJson:@"callMethodWithCallbackT0020" param:param];
    return param;
}

- (BOOL)callMethodWithCallbackT0030:(BOOL)param {
    [self callMethodJson:@"callMethodWithCallbackT0030" param:@(param)];
    return param;
}

- (NSInteger)callMethodWithCallbackT0040:(NSInteger)param {
    [self callMethodJson:@"callMethodWithCallbackT0040" param:@(param)];
    return param;
}

- (NSArray<NSString *> *)callMethodWithCallbackT0050:(NSArray<NSString *> *)param {
    [self callMethodJson:@"callMethodWithCallbackT0050" param:param];
    return param;
}

- (NSArray<NSNumber *> *)callMethodWithCallbackT0060:(NSArray<NSNumber *> *)param {
    NSArray *arr = @[[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES]];
    [self callMethodJson:@"callMethodWithCallbackT0060" param:arr];
    return arr;
}

- (NSArray<NSNumber *> *)callMethodWithCallbackT0070:(NSArray<NSNumber *> *)param {
    [self callMethodJson:@"callMethodWithCallbackT0070" param:param];
    return param;
}

- (void)callMethodJson:(NSString *)method param:(id)params{
    params = @[params];
    MethodData *md = [[MethodData alloc]initMethodWithName:method parameter:params];
    [self callMethod:md];
}

- (void)onMessageHelper:(NSString *)data {
    if ([data isEqualToString:@"test setMessageListener"]) {
        [self sendMessage:@"setMessageListener success"];
    }
    
    if ([data isEqualToString:@"test registerMethod"]) {
        [self callMethodJson:@"arkTsMethod" param:@"arkTsMethod call success"];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0020"]) {
        [self callMethodJson:@"testRegisterMethod0020" param:@"testRegisterMethod0020 call success"];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0030"]) {
        [self callMethodJson:@"testRegisterMethod0030" param:@(YES)];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0040"]) {
        [self callMethodJson:@"testRegisterMethod0040" param:@(123)];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0050"]) {
        NSArray<NSString *> *param = @[@"hello", @"world"];
        [self callMethodJson:@"testRegisterMethod0050" param:param];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0060"]) {
        NSArray<NSNumber *> *param = @[@(NO), @(YES)];
        [self callMethodJson:@"testRegisterMethod0060" param:param];
    }
    
    if ([data isEqualToString:@"testRegisterMethod0070"]) {
        NSArray<NSNumber *> *param = @[@(100), @(200)];
        [self callMethodJson:@"testRegisterMethod0070" param:param];
    }
}


- (void)onError:(nonnull NSString *)methodName errorCode:(ErrorCode)errorCode errorMessage:(nonnull NSString *)errorMessage {
    
}

- (void)onMethodCancel:(nonnull NSString *)methodName {
    
}

- (void)onSuccess:(nonnull NSString *)methodName resultValue:(nonnull id)resultValue {
    
}

- (nonnull id)onMessage:(nonnull id)data {
    if (!data || [data isKindOfClass:[NSNull class]]) {
        return @"arkTS sendMessage null";
    }
    if ([data isKindOfClass:[NSString class]]) {
        NSString *strdata = [NSString stringWithFormat:@"%@",data]; // 相当于 toString()
        [self onMessageHelper:strdata];
    }
    
    
    return data; // 返回原对象
}

- (void)onMessageResponse:(nonnull id)data {
    
}

@end
