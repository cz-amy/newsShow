//
//  UserManger.m
//  LiveAuto
//
//  Created by XQSoft Game on 2017/6/3.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "UserManger.h"

@implementation UserManger

SINGLETON_FOR_CLASS(UserManger);

-(id)init
{
    if (self = [super init]) {
        //往往放一些要初始化的变量

    }
    return self;
}





#pragma mark ————— 储存用户信息 —————

//保存用户信息
-(void)saveUserMsgWith:(NSDictionary*)dic{
   //保存用户信息
    [kUserDefaults setObject:dic forKey:CZUserInfo];
    [kUserDefaults synchronize];

}



-(BOOL)loadUserInfo{
    
    NSDictionary * userDic = [kUserDefaults objectForKey:CZUserInfo];
    if (userDic) {
        return YES;
    }
    return NO;
}


#pragma mark ————— 退出登录 —————

- (void)logout{
//    账号登出
    [kUserDefaults removeObjectForKey:CZUserInfo];

    //    发出退出通知
     KPostNotification(KNotificationLoginOut, nil);
}

-(void)clearLocalUserInfo{
    
    [kUserDefaults removeObjectForKey:CZUserInfo];
    
}


@end
