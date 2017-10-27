//
//  OAuthController.h
//  CZNews
//
//  Created by tarena on 17/10/23.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "RootViewController.h"
#import <WebKit/WebKit.h>
@interface OAuthController : RootViewController
/**
 *  origin url
 */
@property (nonatomic)NSString* url;

/**
 *  embed webView
 */
//@property (nonatomic)UIWebView* webView;

/**
 *  tint color of progress view
 */
@property (nonatomic)UIColor* progressViewColor;

/**
 *  get instance with url
 *
 *  @param url url
 *
 *  @return instance
 */
-(instancetype)initWithUrl:(NSString *)url;


-(void)reloadWebView;

@end
