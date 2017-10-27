//
//  CZNetWorkTool.m
//  CZNews
//
//  Created by tarena on 17/10/22.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "CZNetWorkTool.h"

@implementation CZNetWorkTool
+ (instancetype)sharedManager {
    static CZNetWorkTool *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{

        manager = [self  manager];
       
    });
    return manager;
}


- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
@end
