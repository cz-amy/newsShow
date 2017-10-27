//
//  CZNewsDetailsVC.m
//  CZNews
//
//  Created by tarena on 17/10/25.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "CZNewsDetailsVC.h"

@interface CZNewsDetailsVC ()

@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UILabel   * titleLabel;

@end

@implementation CZNewsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self loadNewsData];
}
-(void)creatUI{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = SYSTEMFONT(18);
    self.titleLabel.textColor     = KBlackColor;
    [self.view addSubview:self.titleLabel];
    self.webView.frame            = CGRectMake(0, 50, KScreenWidth, 200);
    [self.view addSubview:self.webView];
    
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}


-(void)loadNewsData{
    NSDictionary * userDic = [kUserDefaults objectForKey:CZUserInfo];
    NSString     * access_token = [userDic objectForKey:@"access_token"];
    NSString     * dataType= @"json";
    NSDictionary * parames = @{@"access_token":access_token,@"dataType":dataType,@"id":self.newsID};
    NSString     * detailUrl = [NSString stringWithFormat:@"%@%@",URL_main,NEWSDETAILL];
    [[CZNetWorkTool sharedManager]requestWithMethod:POST WithPath:detailUrl WithParams:parames WithSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"xianqing==%@",dic);
        NSString * title = [dic objectForKey:@"title"];
        self.titleLabel.text = title;
        NSString * body  = [dic objectForKey:@"body"];
        [self.webView loadHTMLString:body baseURL:nil];
        
        
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
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
