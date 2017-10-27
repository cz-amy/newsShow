//
//  HomeModel.h
//  TapShow
//
//  Created by XQSoft Game on 2017/8/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic,strong) NSNumber * newsID ;
@property(nonatomic,strong) NSString * author ;
@property(nonatomic,strong) NSString * title ;
@property(nonatomic,strong) NSNumber * authorid ;
@property(nonatomic,strong) NSString * pubDate;
@property(nonatomic,strong) NSNumber *commentCount;
@property (nonatomic,strong)NSNumber *type;

+(instancetype)modelWithDic:(NSDictionary*)dict;
-(instancetype)initWithDic:(NSDictionary*)dict;
@end
