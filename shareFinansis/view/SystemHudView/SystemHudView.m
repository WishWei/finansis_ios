//
//  SystemHudView.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "SystemHudView.h"
#import "MBProgressHUD.h"

@interface SystemHudView()

@property (nonatomic, strong) MBProgressHUD *progressView;

@end

@implementation SystemHudView

+(instancetype) sharedInstance{
    static SystemHudView *hudView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        hudView = [[self alloc] init];
    });
    
    if (hudView.progressView.superview) {
        [hudView.progressView.superview bringSubviewToFront:hudView.progressView];
    }
    
    return hudView;
}

-(id) init{
    if (self = [super init]) {
        
        _progressView = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] delegate].window animated:NO];
        _progressView.animationType = MBProgressHUDAnimationFade;
        _progressView.removeFromSuperViewOnHide = NO;
    }
    return self;
}

-(void) showWaitHudViewWithTitle:(NSString *)title{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, 0, 37, 37);
    [indicator startAnimating];
    _progressView.mode = MBProgressHUDModeCustomView;
    _progressView.customView = indicator;
    _progressView.detailsLabelText = title;
    _progressView.labelText = @"";
    if(_progressView.alpha != 1.0f){
        [_progressView show:YES];
    }
}

-(void) showSuccessHudViewWithTitle:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Request_Success"]];
    imageView.frame = CGRectMake(0, 0, 37, 37);
    _progressView.mode = MBProgressHUDModeCustomView;
    _progressView.customView = imageView;
    _progressView.detailsLabelText = title;
    _progressView.labelText = @"";
    if (_progressView.alpha != 1.0f) {
        [_progressView show:YES];
    }
}

-(void) showFailedHudViewWithTitle:(NSString *)title{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Request_Error"]];
    imageView.frame = CGRectMake(0, 0, 37, 37);
    _progressView.mode = MBProgressHUDModeCustomView;
    _progressView.customView = imageView;
    _progressView.detailsLabelText = title;
    _progressView.labelText = @"";
    if (_progressView.alpha != 1.0f) {
        [_progressView show:YES];
    }
}

-(void) showCustomHudViewWithImage:(UIImage *)image title:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 37, 37);
    
    _progressView.customView = imageView;
    _progressView.detailsLabelText = title;
    if (_progressView.alpha != 1.0f) {
        [_progressView show:YES];
    }
}

-(void) hideHUDView{
    [self hideHUDViewAfterDelay:0 excuteBlock:NULL];
}

-(void) hideHUDViewWithAnimated:(BOOL)animated{
    [_progressView hide:animated];
}

-(void) hideHUDViewAfterDelay:(NSTimeInterval)delay{
    [self hideHUDViewAfterDelay:delay excuteBlock:NULL];
}

-(void) hideHUDViewAfterDelay:(NSTimeInterval)delay excuteBlock:(void (^)(void))competion{
    if (delay == 0) {
        [_progressView hide:YES ];
    }else{
        [_progressView hide:YES afterDelay:delay];
    }
    
    //有延时任务
    if (competion) {
        //设置延时任务
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            competion();
        });
    }
}

-(void) showToastViewWithTitle:(NSString *)title{
    _progressView.mode = MBProgressHUDModeText;
    _progressView.detailsLabelText = @"";
    _progressView.labelText = title;
    if (_progressView.alpha != 1.0f) {
        [_progressView show:YES];
    }
    
    [self hideHUDViewAfterDelay:1.0];
}

-(void) showToastViewWithTitle:(NSString *)title completionBlock:(void (^)(void))competion{
    _progressView.mode = MBProgressHUDModeText;
    _progressView.detailsLabelText = @"";
    _progressView.labelText = title;
    if (_progressView.alpha != 1.0f) {
        [_progressView show:YES];
    }
    if (competion) {
        [self hideHUDViewAfterDelay:1.0 excuteBlock:^{
            competion();
        }];
    }else{
        [self hideHUDViewAfterDelay:1.0];
    }
}
@end
