//
//  MySignInListVC.m
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MySignInListVC.h"
#import "MySignInCell.h"
#import "OrderDriveDetailVC.h"
#import "ComplaintCoachVC.h"
#import "CommentSignInVC.h"
#import "SignInDetailVC.h"
#import "NoDataCell.h"
@interface MySignInListVC ()

@end

@implementation MySignInListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的签到";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"投诉"];
    [self.rightNaviBtn addTarget:self action:@selector(complaintCoach) forControlEvents:UIControlEventTouchUpInside];
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
    [MobClick beginLogPageView:@"MySignInListVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"MySignInListVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/getSignInfoList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"account",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"signInfos"]];
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
    
}
#pragma  mark ------ refresh delegate
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
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count>0?self.m_aryData.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        MySignInCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MySignInCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MySignInCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row];
        [cell updateView];
        return cell;
    }
    else
    {
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoDataCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"NoDataCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelDescription.text=@"暂无签到信息";
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        return 130;
    }
    else
    {
        return 300;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.m_aryData.count>0)
    {
        SignInDetailVC *vc=[[SignInDetailVC alloc] init];
        vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ---------- mysignincell delegate ---------
-(void)showCommentVC:(NSDictionary *)data
{
    CommentSignInVC *vc=[[CommentSignInVC alloc] init];
    vc.data=data;
    vc.delegate=self;
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
#pragma mark --------- event response ----------------
-(void)complaintCoach
{
    ComplaintCoachVC *vc=[[ComplaintCoachVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
