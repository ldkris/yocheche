//
//  OrderTrainDriveVC.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainDriveVC.h"
#import "OrderTrainDriveCell.h"
#import "OrderTrainTimeCell.h"
#import "BundleCoachVC.h"
#import "ConfirmOrderVC.h"
#import "MyOrderDriveListVC.h"
#import "StudentItemView.h"
#import "OtherCenterVC.h"
@interface OrderTrainDriveVC ()

@end

@implementation OrderTrainDriveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择练车时间";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
//    [self setRightNaviBtnTitle:@"我的练车"];
//    [self.rightNaviBtn addTarget:self action:@selector(showMyTrainList) forControlEvents:UIControlEventTouchUpInside];
    [self addNotifyViewAtRight];

    
    self.selectedCoach=-1;
    self.selectedDay=0;
    self.m_aryData=[NSMutableArray array];
    self.m_aryCoach=[NSMutableArray array];
    self.m_arySelectedTime=[NSMutableArray arrayWithObjects:@[],@[],@[],@[],@[], nil];
    self.m_aryStudentView=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];

    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.btn setBackgroundColor:YCC_Green];
    [self.view addSubview:self.btn];
    
    [self.studentItemViewBG setClipsToBounds:YES];
    [self.studentItemViewBG.layer setCornerRadius:4.0];
    [self.lineViewBG setBackgroundColor:YCC_BorderColor];
    
}
-(void)updateNewMessage
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"message/remindMsgForNotEvaluate.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[req.m_data objectForKey:@"status"]  forKey:@"orderMessage"];//1:new 2:no new
            [userDefaults setObject:[req.m_data objectForKey:@"num"]  forKey:@"orderNum"];
            [userDefaults synchronize];
            if ([[userDefaults objectForKey:@"orderMessage"] integerValue]==1)
            {
                self.notifyRight.hidden=NO;
            }
            else
            {
                self.notifyRight.hidden=YES;
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

-(void)viewWillAppear:(BOOL)animated
{
    [self getMyBundleCoaches];
    [self updateNewMessage];
    [MobClick beginLogPageView:@"OrderTrainDriveVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"OrderTrainDriveVC"];
}
-(void)getMyBundleCoaches
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"find.coach.bind",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.m_aryCoach=[NSMutableArray arrayWithArray:[req.m_data objectForKey:@"infos"]];
            [self.m_tableView reloadData];
            [self.m_tableView layoutIfNeeded];
//            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新完成
                UIButton *btnSender=[UIButton buttonWithType:UIButtonTypeCustom];
                if ([self.m_orderDriveCell.coach2Data objectForKey:@"name"])
                {
                    btnSender.tag=0;
                    [self.m_orderDriveCell coachBtnPressed:btnSender];
                }
                else if ([self.m_orderDriveCell.coach3Data objectForKey:@"name"])
                {
                    btnSender.tag=1;
                    [self.m_orderDriveCell coachBtnPressed:btnSender];
                }
//            });
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
-(void)updateDateAndTime:(NSDictionary*)coachData
{
    self.currentCoachData=coachData;
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"apply.coach.timeList",[[self.currentCoachData objectForKey:@"id"] stringValue],[NSString stringWithFormat:@"%d",self.selectedCoach+2]] forKeys:@[@"method",@"coachid",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.m_arySelectedTime=[NSMutableArray arrayWithObjects:@[],@[],@[],@[],@[], nil];
            self.m_aryData=[NSMutableArray arrayWithArray:[req.m_data objectForKey:@"data"]];
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
-(void)showMyTrainList
{
    MyOrderDriveListVC *vc=[[MyOrderDriveListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.m_aryData.count>0)
    {
        return 1+[(NSArray*)[[self.m_aryData objectAtIndex:self.selectedDay] objectForKey:@"times"] count];
    }
    else
    {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        self.m_orderDriveCell=[tableView dequeueReusableCellWithIdentifier:@"OrderTrainDriveCell"];
        if (self.m_orderDriveCell==nil)
        {
            self.m_orderDriveCell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTrainDriveCell" owner:nil options:nil] objectAtIndex:0];
            self.m_orderDriveCell.delegate=self;
        }
        self.m_orderDriveCell.coach2Data=[NSDictionary dictionary];
        self.m_orderDriveCell.coach3Data=[NSDictionary dictionary];
        for (NSDictionary *dic in self.m_aryCoach)
        {
            if ([[dic objectForKey:@"kemu"] integerValue]==2)
            {
                self.m_orderDriveCell.coach2Data=dic;
            }
            else if ([[dic objectForKey:@"kemu"] integerValue]==3)
            {
                self.m_orderDriveCell.coach3Data=dic;
            }
        }
        [self.m_orderDriveCell updateView];
        return self.m_orderDriveCell;
    }
    else
    {
        OrderTrainTimeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTrainTimeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTrainTimeCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.Index=indexPath.row-1;
        cell.dayIndex=self.selectedDay;
        cell.data=[[[self.m_aryData objectAtIndex:self.selectedDay] objectForKey:@"times"] objectAtIndex:indexPath.row-1];
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 220;
    }
    else
    {
        return 60;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0)
    {
        NSInteger total= [[[[[self.m_aryData objectAtIndex:self.selectedDay] objectForKey:@"times"] objectAtIndex:indexPath.row-1] objectForKey:@"max_num"] integerValue];
        NSInteger current= [[[[[self.m_aryData objectAtIndex:self.selectedDay] objectForKey:@"times"] objectAtIndex:indexPath.row-1] objectForKey:@"cur_num"] integerValue];
        if (current>=total)
        {
            [self showMessage:@"该时段预约已满"];
        }
        else
        {
            NSDictionary *aryTimesInDay=[self.m_aryData objectAtIndex:self.selectedDay];
            NSString *timeId=[[[[aryTimesInDay objectForKey:@"times"] objectAtIndex:indexPath.row-1] objectForKey:@"time_id"] stringValue];
            
            NSMutableArray *arySelectedTimesInDay=[NSMutableArray arrayWithArray:[self.m_arySelectedTime objectAtIndex:self.selectedDay]];
            NSLog(@"arySelectedTimesInDay :%@",arySelectedTimesInDay);
            NSInteger haveSelect=0;
            for (NSString *time in arySelectedTimesInDay)
            {
                if ([time isEqualToString:timeId])
                {
                    haveSelect=1;
                    break;
                }
            }
            if (haveSelect==0)
            {
                [arySelectedTimesInDay addObject:timeId];
            }
            else
            {
                [arySelectedTimesInDay removeObject:timeId];
            }
            [self.m_arySelectedTime replaceObjectAtIndex:self.selectedDay withObject:arySelectedTimesInDay];
            [self.m_tableView reloadData];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------------- event response
-(void)showBundleCoachVC:(NSString*)type
{
    BundleCoachVC *vc=[[BundleCoachVC alloc] init];
    vc.type=type;
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)orderTrainDrive:(id)sender
{
    NSInteger haveSelectTime=0;
    for (NSArray *ary in self.m_arySelectedTime)
    {
        if (ary.count>0)
        {
            haveSelectTime=1;
            break;
        }
    }
    if (haveSelectTime==0)
    {
        [self showMessage:@"请选择预约教练和时段"];
        return;
    }
    ConfirmOrderVC *vc=[[ConfirmOrderVC alloc] init];
    vc.currentCoachData=self.currentCoachData;
    vc.m_aryData=self.m_aryData;
    vc.m_arySelectedTime=self.m_arySelectedTime;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
    }
}
#pragma mark -------------- student event response ----------
-(void)showAllOrderedStudent:(NSArray *)students
{
    for (StudentItemView *view in self.m_aryStudentView)
    {
        [view removeFromSuperview];
    }
    [self.m_aryStudentView removeAllObjects];
    
    [self addBlackBGViewOnKeywindow];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btn addTarget:self action:@selector(removeStudentsItemView) forControlEvents:UIControlEventTouchUpInside];
    [self.blackBG addSubview:btn];
    
    AppDelegate *appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [self.studentItemViewBG setFrame:CGRectMake(60, (Screen_Height-(40+students.count*90))/2.0, 200, 40+students.count*90)];
    [appdelegate.window addSubview:self.studentItemViewBG];
    NSInteger i=0;
    for (NSDictionary *dic in students)
    {
        StudentItemView *item=[[[NSBundle mainBundle] loadNibNamed:@"StudentItemView" owner:nil options:nil] objectAtIndex:0];
        [item setFrame:CGRectMake(0, 40+i*90, PARENT_WIDTH(item), PARENT_HEIGHT(item))];
        item.delegate=(id)self;
        item.account=[dic objectForKey:@"account"];
        [item.avatar setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"userpic"]]];
        item.labelName.text=[dic objectForKey:@"nickname"];
        item.labelSign.text=[dic objectForKey:@"resume"];
        [self.studentItemViewBG addSubview:item];
        [self.m_aryStudentView addObject:item];
        i++;
    }
    self.labelTitle.text=[NSString stringWithFormat:@"%d人已预约",students.count];
    
}
-(void)removeStudentsItemView
{
    [self removeBLackBGView];
    [self.studentItemViewBG removeFromSuperview];
}
-(void)showStudentDetailVC:(NSString*)account
{
    [self removeStudentsItemView];
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
    [self.navigationController pushViewController:vc animated:YES];
}
//////////////////cancel bundle coach ////////////////////////
-(void)cancelBundleCoach:(NSDictionary*)dic type:(NSString*)coachtype
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"coach.user.cacelbind",[[dic objectForKey:@"id"] stringValue],[[MyFounctions getUserInfo] objectForKey:@"account"],coachtype] forKeys:@[@"method",@"coachid",@"account",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryCoach removeAllObjects];
            if (self.selectedCoach==[coachtype integerValue]-2)
            {
                self.selectedCoach=-1;
            }
            [self getMyBundleCoaches];
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
