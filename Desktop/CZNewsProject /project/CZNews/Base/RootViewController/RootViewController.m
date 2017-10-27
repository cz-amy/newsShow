//
//  RootViewController.m
//  TapShow
//
//  Created by XQSoft Game on 2017/7/13.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= KWhiteColor;
    
    self.isShowLiftBack = YES;
   //为了添加侧滑返回
   //设置navigationController的代理为self,并实现其代理方法
    
    NSInteger VCCount = self.navigationController.viewControllers.count;
    if (VCCount>1) {
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            
        }
    }
    
}

//UIGestureRecognizerDelegate 重写侧滑协议

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController.viewControllers.count==1) {
        return NO;
    }else{
        return [self gestureRecognizerShouldBegin];

    }
    
}

- (BOOL)gestureRecognizerShouldBegin {
    
    return YES;
    
}




/**
 *  是否显示返回按钮
 */
- (void) setIsShowLiftBack:(BOOL)isShowLiftBack
{
    _isShowLiftBack = isShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        
        //        [self addNavigationItemWithTitles:@[@"back"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
        [self addNavigationItemWithImageNames:@[@"backButton"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
        
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}
- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        if(isLeft){
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
            
        }
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //调整按钮位置
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width= 10;
    [items addObject:spaceItem];
    
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, 30, 20);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}




@end
