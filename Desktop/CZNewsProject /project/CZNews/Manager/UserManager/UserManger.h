//
//  UserManger.h
//  LiveAuto
//
//  Created by XQSoft Game on 2017/6/3.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);


#define userManger [UserManger sharedUserManger]


@interface UserManger : NSObject


//单例
SINGLETON_FOR_HEADER(UserManger)

#pragma mark - ——————— 登录相关 ————————






//保存用户信息
-(void)saveUserMsgWith:(NSDictionary*)dic;

//是否存在
-(BOOL)loadUserInfo;
//退出登录
- (void)logout;

@end
