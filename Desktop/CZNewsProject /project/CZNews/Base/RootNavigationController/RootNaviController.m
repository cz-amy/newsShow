//
//  RootNaviController.m
//  TapShow
//
//  Created by XQSoft Game on 2017/7/13.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "RootNaviController.h"

@interface RootNaviController ()

@end

@implementation RootNaviController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self  initView];
    
}
//初始化界面设置
-(void)initView{
    self.navigationBar.titleTextAttributes =  @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                
                                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIImage * image =  [self createImageWithColor:[UIColor redColor]] ;
    
    [self.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    //    区边界线
    [self.navigationBar setShadowImage:[UIImage new]];
    
    
    
}
//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    //黑色
    //return UIStatusBarStyleDefault;
    //白色
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden

{
    
    return NO;// 返回YES表示隐藏，返回NO表示显示
    
}

-(UIButton *)createBtn:(NSString*)title backImg:(NSString*)imageName{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14 ]];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    
    return btn;
    
}

-(UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
