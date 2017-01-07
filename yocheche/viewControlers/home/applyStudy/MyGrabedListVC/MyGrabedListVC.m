//
//  MyGrabedListVC.m
//  yocheche
//
//  Created by carcool on 3/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyGrabedListVC.h"
#import "MyGrabedListCell0.h"
#import "MyGrabedListCell1.h"
#import "CancelOrderVC.h"
#import "PayGuaranteeVC.h"
@interface MyGrabedListVC ()

@end

@implementation MyGrabedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"抢单";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"取消订单"];
    [self.rightNaviBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.enableUpdateData=YES;
    [self updateData];
}
-(void)popToRootVC
{
    self.enableUpdateData=NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getUserOrderDetail.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
//    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.enableUpdateData==YES)
            {
                self.data=req.m_data;
                [self.m_aryData removeAllObjects];
                [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"coaches"]];
                [self.m_tableView reloadData];
                
                if ([[self.data objectForKey:@"status"] integerValue]==1)
                {
                    [self performSelector:@selector(updateData) withObject:nil afterDelay:5];
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
-(void)cancelOrder
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否确定取消订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=31;//cancel
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==21)
    {
        if (buttonIndex==1)
        {
            self.enableUpdateData=NO;
            PayGuaranteeVC *vc=[[PayGuaranteeVC alloc] init];
            vc.did=self.m_did;
            vc.coachId=self.m_coachId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (alertView.tag==31)
    {
        if (buttonIndex==1)
        {
            self.enableUpdateData=NO;
            CancelOrderVC *vc=[[CancelOrderVC alloc] init];
            vc.did=[[self.data objectForKey:@"did"] stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        MyGrabedListCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"MyGrabedListCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyGrabedListCell0" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=self.data;
        [cell updateView];
        return cell;
    }
    else
    {
        MyGrabedListCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"MyGrabedListCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyGrabedListCell1" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row-1];
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=160;
    }
    else
    {
        height=170;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- event response ---------------
-(void)submitCallEvent:(NSString*)orderid coachId:(NSString*)coachid
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/putUserDialingRecord.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],orderid,coachid] forKeys:@[@"account",@"did",@"coachid"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            
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
-(void)showSignInNoteAlert:(NSString*)orderid coachId:(NSString*)coachid
{
    self.m_did=orderid;
    self.m_coachId=coachid;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"试学满意后再报名，报名需线上缴纳教学质量保证金，您确定要报名？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=21;
    [alert show];
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
