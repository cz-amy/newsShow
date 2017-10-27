//
//  AppDelegate+AppService.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "LoginViewController.h"
#import "HomeController.h"
#import "MineViewController.h"
#import "OAuthController.h"

@implementation AppDelegate (AppService)


#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    
   
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    CYTabBarController * tabbar = [[CYTabBarController alloc]init];
    [CYTabBarConfig shared].selectIndex = 0;
    HomeController * homeVC     = [[HomeController alloc]init];
    RootNaviController * nav1   = [[RootNaviController alloc]initWithRootViewController:homeVC];
    [tabbar addChildController:nav1 title:@"首页" imageName:@"etcn" selectedImageName:@"etcsel"];
    
    MineViewController * mineVC  = [[MineViewController alloc]init];
     RootNaviController * nav2   = [[RootNaviController alloc]initWithRootViewController:mineVC];
    [tabbar addChildController:nav2 title:@"我的" imageName:@"recordn" selectedImageName:@"recordsel"];
    
    
    self.mainTabBar              = tabbar;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];

    
  
}


#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    
   
    
    if ( [[UserManger sharedUserManger]loadUserInfo]) {
        
        self.window.rootViewController = self.mainTabBar;
        
    }else{
        RootNaviController *loginNavi =[[RootNaviController alloc] initWithRootViewController:[LoginViewController new]];
        self.window.rootViewController = loginNavi;
        
    }
    
    
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
        self.window.rootViewController = self.mainTabBar;
        
    }else {//登陆失败加载登陆页面控制器
        
        self.mainTabBar = nil;
        RootNaviController *loginNavi =[[RootNaviController alloc] initWithRootViewController:[LoginViewController new]];
        self.window.rootViewController = loginNavi;
        
    }
}





+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
