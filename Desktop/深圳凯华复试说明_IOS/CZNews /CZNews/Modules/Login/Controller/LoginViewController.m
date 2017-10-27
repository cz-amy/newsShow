//
//  LoginViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "LoginViewController.h"
#import "OAuthController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    self.title        = @"登录";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.frame      = CGRectMake(100, 100, 200, 60);
    button.center     = self.view.center;
    button.layer.cornerRadius = 30;
    button.layer.masksToBounds= YES;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
      
    
}
-(void)load{
   
    
    OAuthController * oauthVC = [[OAuthController alloc]initWithUrl:@"https://www.oschina.net/action/oauth2/authorize?response_type=code&state=xyz&client_id=BtZoBtnOjnUc3tPlkwXs&redirect_uri=http://www.travelease.com.cn"];
    
    [self.navigationController pushViewController:oauthVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
