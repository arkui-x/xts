/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
#import <WebKit/WebKit.h>
#import <objc/runtime.h>


typedef void(^CallBack)(NSArray<NSString *> * _Nonnull results, int errorCode);

@interface EntryEntryAbilityViewController ()<WKUIDelegate, UIDocumentPickerDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation EntryEntryAbilityViewController
- (instancetype)initWithInstanceName:(NSString *)instanceName {
    self = [super initWithInstanceName:instanceName];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;

}

- (void)select {
    UIViewController *topController = [self getApplicationTopViewController];
    UIDocumentPickerViewController *picker = [self findDocumentPickerInViewController:topController];
    if (picker) {
        NSObject *obj = picker.delegate;
        Ivar ivar = class_getInstanceVariable([obj class], "_selectResult");
        CallBack block = object_getIvar(obj, ivar);
        if (block) {
            block(@[@"file:///private/var/mobile/Containers/Shared/AppGroup/83D32F47-C05E-4703-86BF-DAA1E022DA5C/File%20Provider%20Storage/IMG_5166%202.JPG"], 0);
        }

        [picker dismissViewControllerAnimated:true completion:nil];
    }
}

- (UIDocumentPickerViewController * _Nullable)findDocumentPickerInViewController:(UIViewController * _Nullable)viewController {
    if (!viewController) {
        return nil;
    }

    if ([viewController isKindOfClass:[UIDocumentPickerViewController class]]) {
        return (UIDocumentPickerViewController *)viewController;
    }

    return [self findDocumentPickerInViewController:viewController.presentedViewController];
}

- (UIViewController * _Nullable)getApplicationTopViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (!window) {
        return nil;
    }
    UIViewController *viewController = window.rootViewController;
    return [self findTopViewController:viewController];
}

- (UIViewController *)findTopViewController:(UIViewController*)topViewController {
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]]
                    && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}


@end
