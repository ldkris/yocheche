//
//  MyCenterVC.m
//  yocheche
//
//  Created by carcool on 9/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyCenterVC.h"
#import "MyInfoNewVC.h"
#import "MyMessagesVC.h"
#import "MyInvitesVC.h"
#import "MySignInListVC.h"
#import "MyOrderDriveListVC.h"
#import "OrderTrainDriveVC.h"
#import "FansListVC.h"
#import "MySocialCenterVC.h"
#import "OtherCenterVC.h"
#import "MyCoachListVC.h"
#import "AboutYochecheVC.h"
#import "MyIntegralVC.h"
#import "ChooseReleaseTypeVC.h"
#import "FollowListVC.h"
#import "MyStudyDriveVC.h"
@interface MyCenterVC ()

@end

@implementation MyCenterVC
@synthesize m_profileView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self creatMyProfileView];
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];
    self.navigationController.navigationBar.hidden=YES;
    [self updateMyInfo];
    
    [MobClick beginLogPageView:@"我"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"我"];
}

-(void)creatMyProfileView
{
    self.m_profileView=[[MyHomeProfileView alloc]
                        initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-49-64)];
    self.m_profileView.delegate=self;
    [self.view addSubview:m_profileView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------- event response --------- my profile
-(void)updateMyInfo
{
    if([[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        Http *req=[[Http alloc] init];
        [req setParams:@[@"info.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                self.m_profileView.data=req.m_data;
                [self.m_profileView.m_tableView reloadData];
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
}
#pragma mark ----------- top event response -------------
-(IBAction)showReleasePostVC:(id)sender
{
    ChooseReleaseTypeVC *vc=[[ChooseReleaseTypeVC alloc] init];
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
#pragma mark --------------- my profile new ---------------------
-(void)showMyMessagesVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    MyMessagesVC *vc=[[MyMessagesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyFollowVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    FollowListVC *vc=[[FollowListVC alloc] init];
    vc.account=[[MyFounctions getUserInfo] objectForKey:@"account"];
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyFansListVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    FansListVC *vc=[[FansListVC alloc] init];
    vc.account=[[MyFounctions getUserInfo] objectForKey:@"account"];
    vc.otherAccount=[[MyFounctions getUserInfo] objectForKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyStudyDriveVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    MyStudyDriveVC *vc=[[MyStudyDriveVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMySocialCenterVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.fromMyCenter=1;
    vc.preData=[NSDictionary dictionaryWithObject:[[MyFounctions getUserInfo] objectForKey:@"account"] forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyIntegralVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    MyIntegralVC *vc=[[MyIntegralVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyinfoVC:(NSDictionary*)predata
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    MyInfoNewVC *vc=[[MyInfoNewVC alloc] init];
    vc.preData=(NSMutableDictionary*)predata;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)showAboutYocheche
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    AboutYochecheVC *vc=[[AboutYochecheVC alloc] init];
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
