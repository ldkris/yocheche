//
//  TrainOrdersVC.m
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainOrderRecordsVC.h"
#import "MyOrderDriveCell.h"
#import "TrainDetailVC.h"
#import "CommentCoachVC.h"
#import "OrderRecordCell.h"
#import "TrainRecordCell.h"
#import "NoDataCell.h"
#import "TrainRecordWithFeeCell.h"
@interface TrainOrderRecordsVC ()

@end

@implementation TrainOrderRecordsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"全部历史记录";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.type=0;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+40, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    self.topLineView=[[UIView alloc] initWithFrame:CGRectMake(0,38, 160, 2)];
    [self.topLineView setBackgroundColor:YCC_Green];
    [self.topbg addSubview:self.topLineView];
    [self.labelOrder setTextColor:YCC_Green];
    [self.labelRecord setTextColor:YCC_DarkGray];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.pageIndex=1;
    [self updateData];
}
-(void)updateData
{
    if (self.type==0)//order record
    {
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        req.socialMethord=@"appoint/getStudentAppointList.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"account",@"pageindex",@"pagesize"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if (self.pageIndex==1)
                {
                    [self.m_aryData removeAllObjects];
                }
                [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"appoints"]];
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
    else//train record
    {
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        req.socialMethord=@"practice/getStudentPracticeList.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"account",@"pageindex",@"pagesize"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if (self.pageIndex==1)
                {
                    [self.m_aryData removeAllObjects];
                }
                [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"practices"]];
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
    return self.m_aryData.count>0?self.m_aryData.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        if (self.type==0)
        {
            OrderRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderRecordCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderRecordCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row];
            [cell updateView];
            return cell;
        }
        else
        {
            if ([[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"fee"] integerValue]==0)
            {
                TrainRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainRecordCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainRecordCell" owner:nil options:nil] objectAtIndex:0];
                    cell.delegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:indexPath.row];
                [cell updateView];
                return cell;
            }
            else
            {
                TrainRecordWithFeeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TrainRecordWithFeeCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"TrainRecordWithFeeCell" owner:nil options:nil] objectAtIndex:0];
                    cell.delegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:indexPath.row];
                [cell updateView];
                return cell;
            }
        }
    }
    else
    {
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoDataCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"NoDataCell" owner:nil options:nil] objectAtIndex:0];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        if (self.type==1)
        {
            if ([[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"fee"] integerValue]==0)
            {
                return 100;
            }
            else
            {
                return 130;
            }
        }
        else
        {
            return 100;
        }
        
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
    if (self.m_aryData.count>0)
    {
        if (self.type==1)
        {
            TrainDetailVC *vc=[[TrainDetailVC alloc] init];
            vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------- event response ------- top menu
-(IBAction)topMenuBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<2)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(btn.tag*160, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:btn.tag];
        }];
    }
}
-(void)setTopMenuLabelColor:(NSInteger)index
{
    [self.labelOrder setTextColor:YCC_DarkGray];
    [self.labelRecord setTextColor:YCC_DarkGray];
    switch (index)
    {
        case 0:
            [self.labelOrder setTextColor:YCC_Green];
            break;
        case 1:
            [self.labelRecord setTextColor:YCC_Green];
            break;
        default:
            break;
    }
    
    self.type=index;
    self.pageIndex=1;
    [self updateData];
}
#pragma mark --------- event response -------------
//order record cell delegate
-(void)cancelOrderDrive:(NSDictionary*)data
{
    self.operateData=data;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否确定取消预约" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=11;
    [alert show];
}
//train record cell delegate
-(void)showCommentVC:(NSDictionary *)data
{
    CommentCoachVC *vc=[[CommentCoachVC alloc] init];
    vc.orderID=[[data objectForKey:@"practiceId"] stringValue];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)//cancel order
    {
        if (buttonIndex==1)
        {
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            req.socialMethord=@"appoint/putCancelAppoint.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[[self.operateData objectForKey:@"appointId"] stringValue]] forKeys:@[@"account",@"appointId"]];
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
