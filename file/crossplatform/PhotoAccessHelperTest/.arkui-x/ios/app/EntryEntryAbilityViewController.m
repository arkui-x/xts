#import "EntryEntryAbilityViewController.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <PhotosUI/PHPicker.h>

typedef void(^CallBack)(NSArray<NSString *> * _Nonnull results, int errorCode);

@interface EntryEntryAbilityViewController ()<WKUIDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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
    NSLog(@"--jiayi--: 成功调用select");
    UIViewController *topController = [self getApplicationTopViewController];
    NSLog(@"--jiayi--: 1");
    if (topController == nil) {
        NSLog(@"--jiayi--:Top controller is nil");
        return;
    }
    if(@available(iOS 14, *)) {
        PHPickerViewController *picker = [self findPHPickerInViewController:topController];
        if (picker) {
            [self selectImageInPicker:picker];
            [picker dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"--jiayi--:Image picker not found in view controller hierarchy");
        }
    }else {
        UIImagePickerController *picker = [self findPHPickerInViewController:topController];
        if (picker) {
            [self selectImageInPicker:picker];
            [picker dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"--jiayi--:Image picker not found in view controller hierarchy");
        }
    }
  

//    UIImagePickerController *picker = [self findImagePickerInViewController:topController];
//    if (picker) {
//        [self selectImageInPicker:picker];
//        [picker dismissViewControllerAnimated:true completion:nil];
//    } else {
//        NSLog(@"--jiayi--:Image picker not found in view controller hierarchy");
//    }
}

- (UIViewController *)getApplicationTopViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (!window) {
        NSLog(@"--jiayi--:Window is nil");
        return nil;
    }
    UIViewController *viewController = window.rootViewController;
    if (!viewController) {
        NSLog(@"--jiayi--:Root view controller is nil");
        return nil;
    }
    return [self findTopViewController:viewController];
}

- (UIImagePickerController *)findImagePickerInViewController:(UIViewController *)viewController {
    if (!viewController) {
        NSLog(@"--jiayi--:viewController is nil");
        return nil;
    }
    NSLog(@"--jiayi--: a");
    NSLog(@"--jiayi--:Current top controller: %@", NSStringFromClass([viewController class]));
    return (UIImagePickerController *)viewController;
//    if ([viewController isKindOfClass:[UIImagePickerController class]]) {
//        NSLog(@"--jiayi--: a");
//        return (UIImagePickerController *)viewController;
//    }
//    NSLog(@"--jiayi--: b");
//    return [self findImagePickerInViewController:viewController.presentedViewController];
}

- (id)findPHPickerInViewController:(UIViewController *)viewController{
    if (!viewController) {
        return nil;
    }
    
    NSLog(@"Current top controller: %@", NSStringFromClass([viewController class]));
    
    if(@available(iOS 14, *)) {
        if ([viewController isKindOfClass:[PHPickerViewController class]]) {
            return (PHPickerViewController *)viewController;
        }
    } else {
        if ([viewController isKindOfClass:[UIImagePickerController class]]) {
            return (UIImagePickerController *)viewController;
        }
    }

    
    return [self findPHPickerInViewController:viewController.presentedViewController];
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

- (void)selectImageInPicker:(id)picker{
    NSObject *obj;
    if(@available(iOS 14, *)) {
        if ([picker isKindOfClass:[PHPickerViewController class]]) {
            PHPickerViewController * controller = (PHPickerViewController *)picker;
            obj = controller.delegate;
        }
    } else {
        if ([picker isKindOfClass:[UIImagePickerController class]]) {
            UIImagePickerController * controller = (UIImagePickerController *)picker;
            obj = controller.delegate;
        }
    }
    Ivar ivar = class_getInstanceVariable([obj class], "_currentPhotoPickerResult");
    if (!ivar) {
        NSLog(@"--jiayi--:_selectResult ivar not found");
        return;
    }

    CallBack block = object_getIvar(obj, ivar);
    
    if (block) {
        NSLog(@"--jiayi--:start select !!!");
        block(@[@"file:///var/mobile/Media/DCIM/100APPLE/IMG_0714.PNG"], 0);
    } else {
        NSLog(@"--jiayi--:Block is nil");
    }
}
//- (void)selectImageInPicker:(UIImagePickerController *)picker {
//    NSObject *obj = picker.delegate;
//    Ivar ivar = class_getInstanceVariable([obj class], "_selectResult");
//    if (!ivar) {
//        NSLog(@"_selectResult ivar not found");
//        return;
//    }
//
//    CallBack block = object_getIvar(obj, ivar);
//
//    if (block) {
//        block(@[@"file:///var/mobile/Media/DCIM/100APPLE/IMG_0714.PNG"], 0);
//    } else {
//        NSLog(@"Block is nil");
//    }
//}

@end

