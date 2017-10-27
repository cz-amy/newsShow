//
//  HomeController.m
//  CZNews
//
//  Created by tarena on 17/10/22.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "HomeController.h"
#import "HomeModel.h"
#import "MJRefresh.h"
#import "HomePageCell.h"
#import "CZNewsDetailsVC.h"


@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
{
    
     NSInteger page_num;
    
    //  按需显示
    NSMutableArray *needLoadArr;
    
    BOOL scrollToToping;

}
@property (nonatomic,strong)UITableView          * homeTable;
@property (nonatomic,strong)NSMutableArray       * dataArray;

@end

@implementation HomeController
static NSString * CellID = @"HomePageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self           initProperty];
    [self.view      addSubview:self.homeTable];
    [self           refreshData];
    
    [self           loadNewsData];
    
    
}


-(void)initProperty{
    
    self.title     = @"新闻";
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    needLoadArr    = [[NSMutableArray alloc] init];
    page_num       = 0;
    
}

#pragma mark ----------------------------初始化table-----------------------------------
-(UITableView*)homeTable{
    if (!_homeTable) {
        _homeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-NaviStatusHeight) style:UITableViewStylePlain];
        _homeTable.delegate = self;
        _homeTable.dataSource=self;
        _homeTable.showsVerticalScrollIndicator = NO;
        _homeTable.showsHorizontalScrollIndicator=NO;
        _homeTable.separatorStyle               =UITableViewCellSeparatorStyleNone;
        [_homeTable registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    
    return _homeTable;
}

-(void)refreshData{
    
    kWeakSelf(self);
    
    self.homeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page_num  = 0;    [weakself.dataArray removeAllObjects];
        [weakself loadNewsData];
    }];
    
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）上拉刷新
    self.homeTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page_num +=1;
        
        [weakself loadNewsData];
        
    }];
    
}

//加载数据
/*
 access_token	true	string	oauth2_token获取的access_token
 user	false	long	用户ID [ 0：最新动弹，-1：热门动弹，其它：我的动弹 ]
 pageSize	true	int	每页条数
 page/pageIndex	true	int	页数
 dataType	true	string	返回数据类型['json'|'jsonp'|'xml']

 */
-(void)loadNewsData{
    NSString * newsUrl     = [NSString stringWithFormat:@"%@%@",URL_main,NEWSURL];
    NSDictionary * userDic = [kUserDefaults objectForKey:CZUserInfo];
    NSString * access_token= [userDic objectForKey:@"access_token"];
    NSInteger userID       = (NSInteger)[userDic objectForKey:@"uid"];
    NSString * dataType    = @"json";
    NSDictionary * paramesDic = @{@"access_token":access_token,@"user":@(userID),@"pageIndex":@(page_num),@"dataType":dataType};
    kWeakSelf(self);
    [[CZNetWorkTool sharedManager]requestWithMethod:POST WithPath:newsUrl WithParams:paramesDic WithSuccessBlock:^(NSDictionary *dic) {
         NSArray * list  = [dic objectForKey:@"newslist"];
        if (list.count>0) {
            
                        for (NSDictionary * dict in list) {
                            HomeModel * model = [HomeModel modelWithDic:dict];
                            NSLog(@"id=====%@==%@",model.newsID,dict);
                            [weakself.dataArray addObject:model];
        
                        }
            [self    stopRefresh];
            [self.homeTable reloadData];
 
        }
        
        
    } WithFailurBlock:^(NSError *error) {
           [self    stopRefresh];
         [JRToast showWithText:@"请求失败"];
        
    }];

}

//停止请求
-(void)stopRefresh
{
    [self.homeTable.mj_header endRefreshing];
    [self.homeTable.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomePageCell* pageCell   = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    pageCell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (self.dataArray.count>0) {
        HomeModel * model = self.dataArray[indexPath.row];
        pageCell.titleText = model.title;
        pageCell.contentText = @"没有内容";
        NSLog(@"pageCell==%@",model.title);
        pageCell.commentCount = [NSString stringWithFormat:@"%@条评论",model.commentCount];
        
    }
    
    [self drawCell:pageCell withIndexPath:indexPath];
    return pageCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZNewsDetailsVC * detailsVC = [[CZNewsDetailsVC alloc]init];
    HomeModel * model = self.dataArray[indexPath.row];
    detailsVC.newsID            = model.newsID;
    [self.navigationController pushViewController:detailsVC animated:YES];
}


//快速滑动，显示目标范围内的cell
- (void)drawCell:(HomePageCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    cell.hidden         = YES;
    if (needLoadArr.count>0&&[needLoadArr indexOfObject:indexPath]==NSNotFound) {
        cell.hidden     = YES;
        return;
    }
    if (scrollToToping) {
        return;
    }
    cell.hidden         = NO;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}
//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
//indexPathsForVisibleRows--------返回所有可见行的路径
//C 库函数 long int labs(long int x) 返回 x 的绝对值。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    //   目标行
    NSIndexPath *ip  = [self.homeTable indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[self.homeTable indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 8;
    //  滑动到停止的范围 cip.row-ip.row
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [self.homeTable indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.homeTable.width, self.homeTable.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        //  向上滑动
        if (velocity.y<0){
            
            NSIndexPath *indexPath = [temp lastObject];
            
            if (indexPath.row+3<self.dataArray.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
            }
        } else {
            
            NSIndexPath *indexPath = [temp firstObject];
            
            if (indexPath.row>3) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            }
            
        }
        [needLoadArr addObjectsFromArray:arr];
    }
}

//将要滚动到顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    scrollToToping = YES;
    return YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    scrollToToping = NO;
    [self loadContent];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    scrollToToping = NO;
    [self loadContent];
}

#pragma mark ----------------------------快速滚动加载数据-----------------------------------

- (void)loadContent{
    if (scrollToToping) {
        return;
    }
    if (self.homeTable.indexPathsForVisibleRows.count<=0) {
        return;
    }
    if (self.homeTable.visibleCells&&self.homeTable.visibleCells.count>0) {
        for (id temp in [self.homeTable.visibleCells copy]) {
            HomePageCell *cell = (HomePageCell *)temp;
            cell.hidden        = NO;
        }
    }
}


#pragma HomePageCellDelegate



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

//  删除
-(void)dealloc{
   
    
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
