//
//  CoachListSmallAvatarVC.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachListSmallAvatarVC.h"
#import "CoachSmallAvatarCell.h"
#import "CoachDetailVC.h"
@interface CoachListSmallAvatarVC ()

@end

@implementation CoachListSmallAvatarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"本校教练";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lineView1 setBackgroundColor:YCC_BorderColor];
    
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame: CGRectMake(0,64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"教练列表"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"教练列表"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"ds/getDsCoachList.yo";
    [req setParams:@[self.dsid,[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"dsid",@"pageindex",@"pagesize"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"coachList"]];
            self.labelTotal.text=[NSString stringWithFormat:@"共%d位教练",[[req.m_data objectForKey:@"coachNum"] integerValue]];
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
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoachSmallAvatarCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachSmallAvatarCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachSmallAvatarCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeader;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
