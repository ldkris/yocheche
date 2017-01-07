//
//  StudyManageVC.m
//  yocheche
//
//  Created by carcool on 2/1/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "StudyManageVC.h"
#import "ManageNoCoachCell.h"
#import "ManageCoachCell.h"
#import "ManageNoOrderCell.h"
#import "ManageOrderCell.h"
#import "AddCoachVC.h"
#import "changeCoachVC.h"
#import "TrainOrderRecordsVC.h"
#import "BundleMobileForOrderVC.h"
#import "CommentCoachVC.h"
@interface StudyManageVC ()

@end

@implementation StudyManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认练车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"全部历史记录"];
    self.rightNaviBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    self.rightNaviBtn.frame=CGRectMake(0, 0, 80, 44);
    [self.rightNaviBtn addTarget:self action:@selector(showAllTrainOrders) forControlEvents:UIControlEventTouchUpInside];
    self.type=0;
    self.coachData=[NSDictionary dictionary];
    self.m_aryData=[NSMutableArray array];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self checkWeatherFillStudentInfo];
}
-(void)checkWeatherFillStudentInfo
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/checkStudentInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"status"] integerValue]==1)
            {
                BundleMobileForOrderVC *vc=[[BundleMobileForOrderVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [self getCoachInfo];
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
-(void)getCoachInfo
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getCurrentCoach.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"coachname"] isEqualToString:@""])
            {
                self.type=0;
            }
            else
            {
                self.type=1;
            }
            self.coachData=req.m_data;
            [self getOrderData];
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
-(void)getOrderData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getStudentSuccAppointList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"appoints"]];
            if (self.m_aryData.count>0)
            {
                self.type=2;
            }
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
        
    }];
}
-(void)showAllTrainOrders
{
    TrainOrderRecordsVC *vc=[[TrainOrderRecordsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type==0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==0)
    {
        ManageNoCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManageNoCoachCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ManageNoCoachCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        return cell;
    }
    else if (self.type==1)
    {
        if (indexPath.row==0)
        {
            ManageCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManageCoachCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ManageCoachCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=self.coachData;
            [cell updateView];
            return cell;
        }
        else if(indexPath.row==1)
        {
            ManageNoOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManageNoOrderCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ManageNoOrderCell" owner:nil options:nil] objectAtIndex:0];
            }
            return cell;
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            ManageCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManageCoachCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ManageCoachCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=self.coachData;
            [cell updateView];
            return cell;
        }
        else if(indexPath.row==1)
        {
            ManageOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManageOrderCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ManageOrderCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.m_aryData=self.m_aryData;
            [cell updateView];
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (self.type==0)
    {
        height=120;
    }
    else if (self.type==1)
    {
        if (indexPath.row==0)
        {
            height=100;
        }
        else if(indexPath.row==1)
        {
            height=60;
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            height=100;
        }
        else if(indexPath.row==1)
        {
            height=280;
        }
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
#pragma mark -------- event response ------------------
-(void)showAddCoachVC
{
    AddCoachVC *vc=[[AddCoachVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showChangeCoachVC
{
    changeCoachVC *vc=[[changeCoachVC alloc] init];
    vc.coachid=[[self.coachData objectForKey:@"coachid"] stringValue];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)cancelOrder:(NSString *)orderid
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/putCancelAppoint.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],orderid] forKeys:@[@"account",@"appointId"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self checkWeatherFillStudentInfo];
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
-(IBAction)confirmTrainComplete:(id)sender
{
    if (self.type==0)
    {
        [self showMessage:@"请先绑定教练"];
        return;
    }
//    else if (self.type==1)
//    {
//        [self showMessage:@"请先预约练车"];
//        return;
//    }
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否确认本次练车完成，将为你记录一个学时，请谨慎操作！" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=11;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)//confirm complete
    {
        if (buttonIndex==1)
        {
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            req.socialMethord=@"practice/putPracticeFinish.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.coachData objectForKey:@"coachid"]] forKeys:@[@"account",@"coachid"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
//                    [self showMessage:@"已确认本次练车"];
//                    [self checkWeatherFillStudentInfo];
                    CommentCoachVC *vc=[[CommentCoachVC alloc] init];
                    vc.orderID=[[req.m_data objectForKey:@"practiceId"] stringValue];
                    [self.navigationController pushViewController:vc animated:YES];
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
