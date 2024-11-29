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
    UIViewController *topController = [self getApplicationTopViewController];
    if (topController == nil) {
        return;
    }
    if (@available(iOS 14, *)) {
        PHPickerViewController *picker = [self findPHPickerInViewController:topController];
        if (picker) {
            [self selectImageInPicker:picker];
            [picker dismissViewControllerAnimated:true completion:nil];
        }
    } else {
        UIImagePickerController *picker = [self findPHPickerInViewController:topController];
        if (picker) {
            [self selectImageInPicker:picker];
            [picker dismissViewControllerAnimated:true completion:nil];
        }
    }
}

- (UIViewController *)getApplicationTopViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (!window) {
        return nil;
    }
    UIViewController *viewController = window.rootViewController;
    if (!viewController) {
        return nil;
    }
    return [self findTopViewController:viewController];
}

- (UIImagePickerController *)findImagePickerInViewController:(UIViewController *)viewController {
    if (!viewController) {
        return nil;
    }
    return (UIImagePickerController *)viewController;
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
        return;
    }

    CallBack block = object_getIvar(obj, ivar);
    
    if (block) {
        block(@[@"file:///var/mobile/Media/DCIM/100APPLE/IMG_0714.PNG"], 0);
    } else {
        NSLog(@"Block is nil");
    }
}

@end
