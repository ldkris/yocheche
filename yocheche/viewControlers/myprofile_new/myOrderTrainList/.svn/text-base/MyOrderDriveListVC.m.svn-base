//
//  MyOrderDriveListVC.m
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyOrderDriveListVC.h"
#import "MyOrderDriveCell.h"
#import "OrderDriveDetailVC.h"
#import "CommentVC.h"
#import "ComplaintCoachVC.h"
@interface MyOrderDriveListVC ()

@end

@implementation MyOrderDriveListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的练车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"投诉"];
    [self.rightNaviBtn addTarget:self action:@selector(complaintCoach) forControlEvents:UIControlEventTouchUpInside];
    self.pageCount=10;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self setupHeader];
    [self setupFooter];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.pageIndex=1;
    [self updateData];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"find.apply.list",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"method",@"account",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"applys"]];
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
    MyOrderDriveCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyOrderDriveCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyOrderDriveCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDriveDetailVC *vc=[[OrderDriveDetailVC alloc] init];
    vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------------- event response --------------
-(void)complaintCoach
{
    ComplaintCoachVC *vc=[[ComplaintCoachVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)cancelOrderDrive:(NSDictionary*)data
{
    self.operateData=data;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否确定取消预约" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=11;
    [alert show];
}
-(void)showCommentVC:(NSDictionary *)data
{
    CommentVC *vc=[[CommentVC alloc] init];
    vc.coachData=data;
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==1)
        {
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            [req setParams:@[@"apply.coach.cacel",[self.operateData objectForKey:@"applyid"]] forKeys:@[@"method",@"applyid"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    self.pageIndex=1;
                    [self updateData];
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
