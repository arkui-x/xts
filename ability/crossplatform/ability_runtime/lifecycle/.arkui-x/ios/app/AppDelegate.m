/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

#import "AppDelegate.h"
#import "EntryMain1AbilityViewController.h"
#import "EntryMain2AbilityViewController.h"
#import "EntryMain3AbilityViewController.h"
#import "EntryMain4AbilityViewController.h"
#import "EntryMain5AbilityViewController.h"
#import "EntryMain6AbilityViewController.h"
#import "EntryMain7AbilityViewController.h"
#import "EntryMain8AbilityViewController.h"
#import "EntryMain9AbilityViewController.h"
#import "EntryMain10AbilityViewController.h"
#import "EntryMain11AbilityViewController.h"
#import "EntryMain12AbilityViewController.h"
#import "EntryMain13AbilityViewController.h"
#import "EntryMain14AbilityViewController.h"
#import "EntryHap1Main1AbilityViewController.h"
#import "EntryHap1Main2AbilityViewController.h"
#import "EntryMultiMainAbilityViewController.h"
#import "FeatureassistaFeatureassistaAbilityViewController.h"
#import "EntryEntryAbilityViewController.h"
#import <libarkui_ios/StageApplication.h>

#define BUNDLE_DIRECTORY @"arkui-x"
#define BUNDLE_NAME @"com.example.lifecycle"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [StageApplication configModuleWithBundleDirectory:BUNDLE_DIRECTORY];
    [StageApplication launchApplication];
    
    NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",BUNDLE_NAME, @"entry", @"EntryAbility"];
    EntryEntryAbilityViewController *mainView = [[EntryEntryAbilityViewController alloc] initWithInstanceName:instanceName];
    [self setNavRootVC:mainView];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSLog(@"appdelegate openUrl callback, url : %@", url.absoluteString); // eg: (com.entry.arkui://entry?OtherAbility)
    
    NSString *bundleName = url.scheme;
    NSString *moduleName = url.host;
    NSString *abilityName, *params;

    NSURLComponents * urlComponents = [NSURLComponents componentsWithString:url.absoluteString];
    NSArray <NSURLQueryItem *> *array = urlComponents.queryItems;
    for (NSURLQueryItem * item in array) {
        if ([item.name isEqualToString:@"abilityName"]) {
            abilityName = item.value;
        } else if ([item.name isEqualToString:@"params"]) {
            params = item.value;
        }
    }

    [self handleOpenUrlWithBundleName:bundleName
                           moduleName:moduleName
                          abilityName:abilityName
                               params:params, nil];
    
    return YES;
}

- (BOOL)handleOpenUrlWithBundleName:(NSString *)bundleName
                         moduleName:(NSString *)moduleName
                        abilityName:(NSString *)abilityName
                             params:(NSString *)params, ...NS_REQUIRES_NIL_TERMINATION {
    
    id rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    BOOL hasRoot = NO;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        hasRoot = YES;
    }
    
    id subStageVC = nil;
    
    if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"EntryAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryEntryAbilityViewController *entryOtherVC = [[EntryEntryAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryEntryAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main1Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain1AbilityViewController *entryOtherVC = [[EntryMain1AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain1AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main2Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain2AbilityViewController *entryOtherVC = [[EntryMain2AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain2AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main3Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain3AbilityViewController *entryOtherVC = [[EntryMain3AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain3AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main4Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain4AbilityViewController *entryOtherVC = [[EntryMain4AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain4AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main5Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain5AbilityViewController *entryOtherVC = [[EntryMain5AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain5AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main6Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain6AbilityViewController *entryOtherVC = [[EntryMain6AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain6AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main7Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain7AbilityViewController *entryOtherVC = [[EntryMain7AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain7AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main8Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain8AbilityViewController *entryOtherVC = [[EntryMain8AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain8AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main9Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain9AbilityViewController *entryOtherVC = [[EntryMain9AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain9AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main10Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain10AbilityViewController *entryOtherVC = [[EntryMain10AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain10AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main11Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain11AbilityViewController *entryOtherVC = [[EntryMain11AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain11AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main12Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain12AbilityViewController *entryOtherVC = [[EntryMain12AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain12AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main13Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain13AbilityViewController *entryOtherVC = [[EntryMain13AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain13AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Main14Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMain14AbilityViewController *entryOtherVC = [[EntryMain14AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMain14AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Hap1Main1Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryHap1Main1AbilityViewController *entryOtherVC = [[EntryHap1Main1AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryHap1Main1AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"Hap1Main2Ability"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryHap1Main2AbilityViewController *entryOtherVC = [[EntryHap1Main2AbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryHap1Main2AbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"MultiMainAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMultiMainAbilityViewController *entryOtherVC = [[EntryMultiMainAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMultiMainAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"featureassista"] && [abilityName   isEqualToString:@"FeatureassistaAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistaFeatureassistaAbilityViewController *entryOtherVC = [[FeatureassistaFeatureassistaAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistaFeatureassistaAbilityViewController *)entryOtherVC;
    } // other ViewController
    
    if (!subStageVC) {
        return NO;
    }
    
    if (!hasRoot) {
        [self setNavRootVC:subStageVC];
    } else {
        UINavigationController *rootNav = (UINavigationController *)self.window.rootViewController;
        [rootNav pushViewController:subStageVC animated:YES];
    }
    return YES;
}

- (void)setNavRootVC:(id)viewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self setNaviAppearance:navi];
    self.window.rootViewController = navi;
}

- (void)setNaviAppearance:(UINavigationController *)navi {
    UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = UIColor.whiteColor;
    navi.navigationBar.standardAppearance = appearance;
    navi.navigationBar.scrollEdgeAppearance = navi.navigationBar.standardAppearance;
}

@end
