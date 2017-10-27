//
//  HomeModel.m
//  TapShow
//
//  Created by XQSoft Game on 2017/8/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(instancetype)initWithDic:(NSDictionary*)dict{
    if (self=[super init]) {
//         self.author          =dict[@"author"]?:@"";
//         self.title           =dict[@"title"]?:@"";
//         self.type            =dict[@"type"]?:@0;
//         self.authorid        =dict[@"authorid"]?:@0;
//         self.pubDate         =dict[@"pubDate"]?:@"";
//         self.commentCount    =dict[@"commentCount"]?:@0;
        
        [self setValuesForKeysWithDictionary:dict];

    }
    return self;
}

+(instancetype)modelWithDic:(NSDictionary*)dict{
    
    return [[self alloc]initWithDic:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"key==+++++++++++++++++++%@",key);
    if ([key isEqualToString:@"id"]) {
        self.newsID = value;
        return;
    }
}
@end
