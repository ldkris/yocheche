//
//  OrderTrainingVC.m
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTrainingVC.h"
#import "OrderNoCoachCell.h"
#import "OrderCoachCell.h"
#import "OrderTimeCell.h"
#import "OrderItemCell.h"
#import "AddCoachVC.h"
#import "changeCoachVC.h"
#import "BundleMobileForOrderVC.h"
#import "StudentItemView.h"
#import "OtherCenterVC.h"
@interface OrderTrainingVC ()

@end

@implementation OrderTrainingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"预约";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    self.type=0;
    self.selectedDay=0;//first day
    self.notUpdate=0;
    self.coachData=[NSDictionary dictionary];
    self.m_aryTimes=[NSMutableArray array];
    self.m_aryDay1=[NSMutableArray array];
    self.m_aryDay2=[NSMutableArray array];
    self.m_aryDay3=[NSMutableArray array];
    self.m_aryDay4=[NSMutableArray array];
    self.m_aryDay5=[NSMutableArray array];
    self.m_arySelectedDay=[NSMutableArray array];
    self.m_aryStudentView=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.notUpdate==0)
    {
        [self checkWeatherFillStudentInfo];
    }
    else
    {
        self.notUpdate=0;
    }
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
            self.coachData=req.m_data;
            if ([[req.m_data objectForKey:@"coachname"] isEqualToString:@""])
            {
                self.type=0;
                [self getCoachOrderTimes];
            }
            else
            {
                self.type=1;
                [self getCoachOrderTimes];
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
-(void)getCoachOrderTimes
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getCoachAppointPeriodList.yo";
    [req setParams:@[self.type==0?@"":[[self.coachData objectForKey:@"coachid"] stringValue]] forKeys:@[@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryTimes removeAllObjects];
            [self.m_aryTimes addObjectsFromArray:[req.m_data objectForKey:@"days"]];
            
            [self.m_aryDay1 removeAllObjects];
            [self.m_aryDay2 removeAllObjects];
            [self.m_aryDay3 removeAllObjects];
            [self.m_aryDay4 removeAllObjects];
            [self.m_aryDay5 removeAllObjects];
            [self.m_aryDay1 addObjectsFromArray:[[self.m_aryTimes objectAtIndex:0] objectForKey:@"periods"]];
            [self.m_aryDay2 addObjectsFromArray:[[self.m_aryTimes objectAtIndex:1] objectForKey:@"periods"]];
            [self.m_aryDay3 addObjectsFromArray:[[self.m_aryTimes objectAtIndex:2] objectForKey:@"periods"]];
            [self.m_aryDay4 addObjectsFromArray:[[self.m_aryTimes objectAtIndex:3] objectForKey:@"periods"]];
            [self.m_aryDay5 addObjectsFromArray:[[self.m_aryTimes objectAtIndex:4] objectForKey:@"periods"]];
            for (NSMutableDictionary *dic in self.m_aryDay1)
            {
                [dic setObject:@"0" forKey:@"flag"];
            }
            for (NSMutableDictionary *dic in self.m_aryDay2)
            {
                [dic setObject:@"0" forKey:@"flag"];
            }
            for (NSMutableDictionary *dic in self.m_aryDay3)
            {
                [dic setObject:@"0" forKey:@"flag"];
            }
            for (NSMutableDictionary *dic in self.m_aryDay4)
            {
                [dic setObject:@"0" forKey:@"flag"];
            }
            for (NSMutableDictionary *dic in self.m_aryDay5)
            {
                [dic setObject:@"0" forKey:@"flag"];
            }
            self.selectedDay=0;
            self.m_arySelectedDay=self.m_aryDay1;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+self.m_arySelectedDay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        if (self.type==0)//no coach
        {
            OrderNoCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderNoCoachCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderNoCoachCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            return cell;
        }
        else
        {
            OrderCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderCoachCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderCoachCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=self.coachData;
            [cell updateView];
            return cell;
        }
    }
    else if (indexPath.row==1)
    {
        OrderTimeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTimeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTimeCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.m_aryDays=[NSArray arrayWithArray:self.m_aryTimes];
        [cell updateView];
        return cell;
    }
    else
    {
        OrderItemCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderItemCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderItemCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.data=[self.m_arySelectedDay objectAtIndex:indexPath.row-2];
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        if (self.type==0)//no coach
        {
            height=80;
        }
        else
        {
            height=90;
        }
    }
    else if (indexPath.row==1)
    {
        height=75;
    }
    else
    {
        height=45;
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
-(IBAction)orderBtnPressed:(id)sender
{
    if (self.type==0)
    {
        [self showMessage:@"请先添加教练"];
        return;
    }
    NSMutableArray *aryDayAndTime=[NSMutableArray array];
    NSMutableArray *arySelected=[NSMutableArray array];
    
    for (NSDictionary *dic in self.m_aryDay1)
    {
        if ([[dic objectForKey:@"flag"] integerValue]==1)
        {
            [arySelected addObject:[NSDictionary dictionaryWithObject:[dic objectForKey:@"timeId"] forKey:@"timeId"]];
        }
    }
    if (arySelected.count>0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[[self.m_aryTimes objectAtIndex:0] objectForKey:@"date"],[NSArray arrayWithArray:arySelected]] forKeys:@[@"date",@"times"]];
        [aryDayAndTime addObject:dic];
    }
    
    [arySelected removeAllObjects];
    for (NSDictionary *dic in self.m_aryDay2)
    {
        if ([[dic objectForKey:@"flag"] integerValue]==1)
        {
            [arySelected addObject:[NSDictionary dictionaryWithObject:[dic objectForKey:@"timeId"] forKey:@"timeId"]];
        }
    }
    if (arySelected.count>0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[[self.m_aryTimes objectAtIndex:1] objectForKey:@"date"],[NSArray arrayWithArray:arySelected]] forKeys:@[@"date",@"times"]];
        [aryDayAndTime addObject:dic];
    }
    
    [arySelected removeAllObjects];
    for (NSDictionary *dic in self.m_aryDay3)
    {
        if ([[dic objectForKey:@"flag"] integerValue]==1)
        {
            [arySelected addObject:[NSDictionary dictionaryWithObject:[dic objectForKey:@"timeId"] forKey:@"timeId"]];
        }
    }
    if (arySelected.count>0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[[self.m_aryTimes objectAtIndex:2] objectForKey:@"date"],[NSArray arrayWithArray:arySelected]] forKeys:@[@"date",@"times"]];
        [aryDayAndTime addObject:dic];
    }
    
    [arySelected removeAllObjects];
    for (NSDictionary *dic in self.m_aryDay4)
    {
        if ([[dic objectForKey:@"flag"] integerValue]==1)
        {
            [arySelected addObject:[NSDictionary dictionaryWithObject:[dic objectForKey:@"timeId"] forKey:@"timeId"]];
        }
    }
    if (arySelected.count>0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[[self.m_aryTimes objectAtIndex:3] objectForKey:@"date"],[NSArray arrayWithArray:arySelected]] forKeys:@[@"date",@"times"]];
        [aryDayAndTime addObject:dic];
    }
    
    [arySelected removeAllObjects];
    for (NSDictionary *dic in self.m_aryDay5)
    {
        if ([[dic objectForKey:@"flag"] integerValue]==1)
        {
            [arySelected addObject:[NSDictionary dictionaryWithObject:[dic objectForKey:@"timeId"] forKey:@"timeId"]];
        }
    }
    if (arySelected.count>0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[[self.m_aryTimes objectAtIndex:4] objectForKey:@"date"],[NSArray arrayWithArray:arySelected]] forKeys:@[@"date",@"times"]];
        [aryDayAndTime addObject:dic];
    }
    
    if (aryDayAndTime.count<=0)
    {
        [self showMessage:@"请选择预约时段"];
        return;
    }
    
    NSData *jsonData=[self toJSONData:aryDayAndTime];
    NSString *jsonStr=[[NSString alloc] initWithData:jsonData
                                            encoding:NSUTF8StringEncoding];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/putAppointCoach.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[[self.coachData objectForKey:@"coachid"] stringValue],jsonStr] forKeys:@[@"account",@"coachid",@"days"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预约申请已发送" message:@"教练通过预约后,请准时参加练车" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate=self;
            alert.tag=11;
            [alert show];
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
    }
}
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
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
        item.delegate=self;
        item.account=[dic objectForKey:@"account"];
        [item.avatar setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]];
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
    [self.studentItemViewBG removeFromSuperview];
    [self removeBLackBGView];
}
-(void)showStudentDetailVC:(NSString*)account
{
    if ([account isEqualToString:@""])
    {
        return;
    }
    self.notUpdate=1;
    [self removeStudentsItemView];
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:account forKey:@"account"];
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
