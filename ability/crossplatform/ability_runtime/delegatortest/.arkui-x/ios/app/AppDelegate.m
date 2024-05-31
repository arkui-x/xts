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
#import "FeatureassistFeatureassistAbilityViewController.h"
#import "FeatureassistaFeatureassistaAbilityViewController.h"
#import "FeatureassistbFeatureassistbAbilityViewController.h"
#import "FeatureassistcFeatureassistcAbilityViewController.h"
#import "FeatureassistdFeatureassistdAbilityViewController.h"
#import "EntryMainAbilityViewController.h"
#import "EntryMain2AbilityViewController.h"
#import "EntryMain3AbilityViewController.h"
#import "EntryMain4AbilityViewController.h"
#import "EntryEntryAbilityViewController.h"
#import <libarkui_ios/StageApplication.h>

#define BUNDLE_DIRECTORY @"arkui-x"
#define BUNDLE_NAME @"com.example.delegatortest"

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
    } else if ([moduleName isEqualToString:@"featureassist"] && [abilityName   isEqualToString:@"FeatureassistAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistFeatureassistAbilityViewController *entryOtherVC = [[FeatureassistFeatureassistAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistFeatureassistAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"featureassista"] && [abilityName   isEqualToString:@"FeatureassistaAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistaFeatureassistaAbilityViewController *entryOtherVC = [[FeatureassistaFeatureassistaAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistaFeatureassistaAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"featureassistb"] && [abilityName   isEqualToString:@"FeatureassistbAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistbFeatureassistbAbilityViewController *entryOtherVC = [[FeatureassistbFeatureassistbAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistbFeatureassistbAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"featureassistc"] && [abilityName   isEqualToString:@"FeatureassistcAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistcFeatureassistcAbilityViewController *entryOtherVC = [[FeatureassistcFeatureassistcAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistcFeatureassistcAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"featureassistd"] && [abilityName   isEqualToString:@"FeatureassistdAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        FeatureassistdFeatureassistdAbilityViewController *entryOtherVC = [[FeatureassistdFeatureassistdAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (FeatureassistdFeatureassistdAbilityViewController *)entryOtherVC;
    } else if ([moduleName isEqualToString:@"entry"] && [abilityName isEqualToString:@"MainAbility"]) {
        NSString *instanceName = [NSString stringWithFormat:@"%@:%@:%@",bundleName, moduleName, abilityName];
        EntryMainAbilityViewController *entryOtherVC = [[EntryMainAbilityViewController alloc] initWithInstanceName:instanceName];
        entryOtherVC.params = params;
        subStageVC = (EntryMainAbilityViewController *)entryOtherVC;
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
