//
//  MineViewController.m
//  CZNews
//
//  Created by tarena on 17/10/22.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "MineViewController.h"
#import "MineIconCell.h"
#import "MineCell.h"
#import "MineDetailsVC.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * lbl;
}
@property (nonatomic,strong)UITableView * myTableView;
@property (nonatomic,strong)NSArray     * dataAry;
@property (nonatomic,strong)NSDictionary* userDic;
@property (nonatomic,strong)NSDictionary* userDetailsDic;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title    = @"我";
    // Do any additional setup after loading the view.
    self.dataAry  = @[@"帮助",@"相册",@"收藏",@"设置"];
    
    [self.view addSubview:self.myTableView];
    [self  loadUserDetails];
    
}

-(void)loadUserDetails{
    NSString * newsUrl     = [NSString stringWithFormat:@"%@%@",URL_main,URL_user_detail];
    NSDictionary * userDic = [kUserDefaults objectForKey:CZUserInfo];
    NSString * access_token= [userDic objectForKey:@"access_token"];
    NSString * dataType    = @"json";
    NSDictionary * paramesDic = @{@"access_token":access_token,@"dataType":dataType};
    kWeakSelf(self);
    [[CZNetWorkTool sharedManager]requestWithMethod:POST WithPath:newsUrl WithParams:paramesDic WithSuccessBlock:^(NSDictionary *dic) {
        if (dic) {
            weakself.userDetailsDic = dic;
            [self.myTableView reloadData];
        }
        
    } WithFailurBlock:^(NSError *error) {
        
        [JRToast showWithText:@"请求失败"];

        
    }];

    
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        [_myTableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"MineCell"];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate   = self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.scrollEnabled = NO;

    }
    
    return _myTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.dataAry.count ;
 
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 50;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * IconID = @"iconCell";
    
    if(indexPath.section==0) {
        MineIconCell * iconCell = [tableView dequeueReusableCellWithIdentifier:IconID];
        iconCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!iconCell) {
            iconCell = [[MineIconCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IconID];
        }
        if (self.userDetailsDic) {
            iconCell.nameLabel.text = [self.userDetailsDic objectForKey:@"name"];

        }
        
        return iconCell;
        
        
    }else{
        MineCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
        mineCell.titleLabel.text = self.dataAry[indexPath.row];
        return mineCell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MineDetailsVC * detailsVC = [[MineDetailsVC alloc]init];
        detailsVC.userInfo = self.userDetailsDic;
        [self.navigationController pushViewController:detailsVC animated:YES];
        
    }
    
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
