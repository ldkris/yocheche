//
//  MySocialCenterVC.m
//  yocheche
//
//  Created by carcool on 9/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MySocialCenterVC.h"
#import "PostDeatilVC.h"
#import "FansListVC.h"
#import "FollowListVC.h"
@interface MySocialCenterVC ()

@end

@implementation MySocialCenterVC
@synthesize m_myCenterView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人中心";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self creatMyCenterView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getMyCenterInfo];
}
-(void)creatMyCenterView
{
    self.m_myCenterView=[[MyCenterView alloc]
                         initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    self.m_myCenterView.delegate=self;
    [self.view addSubview:m_myCenterView];
}
-(void)getMyCenterInfo
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/userinfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[[MyFounctions getUserInfo] objectForKey:@"account"],@"1"] forKeys:@[@"account",@"otheraccount",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.m_myCenterView.data =req.m_data;
            //            [self.m_myCenterView.m_tableView reloadData];
            if ([self.m_myCenterView.m_aryData count]==0)
            {
                self.m_myCenterView.pageIndex=1;
                if (self.m_myCenterView.postType==0)
                {
                    [self getMyPostListPageIndex:[NSString stringWithFormat:@"%d",self.m_myCenterView.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.m_myCenterView.pageCount]];
                }
                else if (self.m_myCenterView.postType==1)
                {
                    [self getMyLikePostListPageIndex:[NSString stringWithFormat:@"%d",self.m_myCenterView.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.m_myCenterView.pageCount]];
                }
            }
            
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
-(void)getMyPostListPageIndex:(NSString*)Index PageCount:(NSString*)Count
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"invitation/userInvitationList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],Index,Count,@"210",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([Index integerValue]==1)
            {
                [self.m_myCenterView.m_aryData removeAllObjects];
            }
            [self.m_myCenterView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"invitations"]];
            [self.m_myCenterView.m_tableView reloadData];
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
        [self.m_myCenterView.refreshHeader endRefreshing];
        [self.m_myCenterView.refreshFooter endRefreshing];
    }];
    
}
-(void)getMyLikePostListPageIndex:(NSString*)Index PageCount:(NSString*)Count
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getMyLikeInvitationList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],Index,Count,@"210",@""] forKeys:@[@"account",@"pageindex",@"pagesize",@"imgWidth",@"imgHeight"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([Index integerValue]==1)
            {
                [self.m_myCenterView.m_aryData removeAllObjects];
            }
            [self.m_myCenterView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"invitations"]];
            [self.m_myCenterView.m_tableView reloadData];
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
        [self.m_myCenterView.refreshHeader endRefreshing];
        [self.m_myCenterView.refreshFooter endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------ event response -----------
-(void)showPostVC:(NSDictionary*)preData
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    PostDeatilVC *vc=[[PostDeatilVC alloc] init];
    vc.preData=preData;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showFollowOtherList
{
    FollowListVC *vc=[[FollowListVC alloc] init];
    vc.account=[[MyFounctions getUserInfo] objectForKey:@"account"];
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showFansList
{
    FansListVC *vc=[[FansListVC alloc] init];
    vc.account=[[MyFounctions getUserInfo] objectForKey:@"account"];
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
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
