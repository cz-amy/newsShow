//
//  URLMacros.h
//  MiAiApp
//
//  Created by tarena on 17/10/23.
//  Copyright © 2017年 Caizhi. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    0
#define TestSever       0
#define ProductSever    1

#if DevelopSever

/**开发服务器*/
#define URL_main @""

#elif TestSever

/**测试服务器*/
#define URL_main @""

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://www.oschina.net/"
#endif



#pragma mark - ——————— 详细接口地址 ————————

#define NEWSURL       @"action/openapi/news_list"

#define NEWSDETAILL   @"action/openapi/news_detail"

#pragma mark - ——————— 用户相关 ————————
//access_token
#define URL_ACCESS_TOKEN    @"action/openapi/token"


//用户信息
#define  USERURL @"/action/openapi/user"
//用户详情
#define URL_user_detail @"action/openapi/my_information"
//修改头像
#define URL_user_change_photo @"action/openapi/portrait_update"



#endif /* URLMacros_h */
