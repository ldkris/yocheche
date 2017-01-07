//
//  FansListVC.m
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FansListVC.h"
#import "FollowListCell.h"
#import "OtherCenterVC.h"
@interface FansListVC ()

@end

@implementation FansListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"粉丝";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.pageCount=10;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"FanListVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"FanListVC"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getUserFollowList.yo";
    [req setParams:@[self.account,self.otherAccount,[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"account",@"otheraccount",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"users"]];
            [self.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FollowListCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FollowListCell" owner:nil options:nil] objectAtIndex:0];
        cell.vcDelegate=self;
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"account"] forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- refresh delegate
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateData];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
}
#pragma mark ---------------- follow cell delegate
-(void)followTheAccount:(NSString *)account followCell:(FollowListCell *)followCell type:(NSString *)followType
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/focusTa.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],__BASE64(account),followType] forKeys:@[@"account",@"focusAccount",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([followType isEqualToString:@"1"])
            {
                [followCell.data setObject:@"1" forKey:@"status"];
            }
            else
            {
                [followCell.data setObject:@"2" forKey:@"status"];
            }
            [followCell updateView];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];

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
