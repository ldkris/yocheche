//
//  ConfirmOrderVC.m
//  yocheche
//
//  Created by carcool on 9/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "ConfirmOrderCellCoach.h"
#import "ConfirmOrderCellTime.h"
#import "confirmOrderCellSchool.h"
@interface ConfirmOrderVC ()

@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认预约";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.contentHeight=0;
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    self.strTime=[NSMutableString stringWithString:@""];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self updateView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"ConfirmOrderVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"ConfirmOrderVC"];
}
-(void)updateView
{
    NSInteger i=0;
    for (NSArray *aryDay in self.m_arySelectedTime)
    {
        for (NSString *timeid in aryDay)
        {
            NSString *strShowTime=@"";
            for (NSDictionary *dic in [[self.m_aryData objectAtIndex:i] objectForKey:@"times"])
            {
                if ([[dic objectForKey:@"time_id"] integerValue]==[timeid integerValue])
                {
                    strShowTime=[NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"begin_time"],[dic objectForKey:@"end_time"]];
                    break;
                }
            }
            if (![self.strTime isEqualToString:@""])
            {
                [self.strTime appendString:[NSString stringWithFormat:@"\r\n%@ %@",[[self.m_aryData objectAtIndex:i] objectForKey:@"date"],strShowTime]];
            }
            else
            {
                [self.strTime appendString:[NSString stringWithFormat:@"%@ %@",[[self.m_aryData objectAtIndex:i] objectForKey:@"date"],strShowTime]];
            }
        }
        i++;
    }
    self.contentHeight=[MyFounctions calculateLabelHeightWithString:self.strTime Width:226 font:[UIFont systemFontOfSize:15.0]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        ConfirmOrderCellCoach *cell=[tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCellCoach"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderCellCoach" owner:nil options:nil] objectAtIndex:0];
        }
        [cell.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.currentCoachData objectForKey:@"userpic"]]];
        cell.labelName.text=[self.currentCoachData objectForKey:@"name"];
        if ([[self.currentCoachData objectForKey:@"kemu"] integerValue]==2)
        {
            cell.labelType.text=@"科目二";
            [cell.imgType setImage:[UIImage imageNamed:@"ke2"]];
        }
        else
        {
            cell.labelType.text=@"科目三";
            [cell.imgType setImage:[UIImage imageNamed:@"ke3"]];
        }
        return cell;
    }
    else if (indexPath.row==1)
    {
        ConfirmOrderCellTime *cell=[tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCellTime"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderCellTime" owner:nil options:nil] objectAtIndex:0];
        }
        [cell.labelTime removeFromSuperview];
        cell.labelTime=nil;
        cell.labelTime=[[UILabel alloc] initWithFrame:CGRectMake(86, 27, 226, self.contentHeight)];
        [cell.labelTime setFont:[UIFont systemFontOfSize:15.0]];
        [cell.labelTime setTextColor:[UIColor darkGrayColor]];
        cell.labelTime.text=self.strTime;
        cell.labelTime.numberOfLines=0;
        [cell addSubview:cell.labelTime];
        return cell;
    }
    else
    {
        confirmOrderCellSchool *cell=[tableView dequeueReusableCellWithIdentifier:@"confirmOrderCellSchool"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"confirmOrderCellSchool" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelSchool.text=[self.currentCoachData objectForKey:@"drivingschoolname"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=90;
    }
    else if (indexPath.row==1)
    {
        height=29+self.contentHeight+10;
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
#pragma mark ------------- event response ----------------
-(IBAction)btnPressed:(id)sender
{
    NSMutableString *timeIDStr=[NSMutableString stringWithString:@""];
    NSMutableString *dateStr=[NSMutableString stringWithString:@""];
    NSInteger i=0;
    for (NSArray *aryDay in self.m_arySelectedTime)
    {
        for (NSString *timeid in aryDay)
        {
            if (![timeIDStr isEqualToString:@""])
            {
                [timeIDStr appendString:[NSString stringWithFormat:@",%@",timeid]];
            }
            else
            {
                [timeIDStr appendString:timeid];
            }
            if (![dateStr isEqualToString:@""])
            {
                [dateStr appendString:[NSString stringWithFormat:@",%@",[[self.m_aryData objectAtIndex:i] objectForKey:@"date"]]];
            }
            else
            {
                [dateStr appendString:[[self.m_aryData objectAtIndex:i] objectForKey:@"date"]];
            }
        }
        i++;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"apply.coach.submit",[[self.currentCoachData objectForKey:@"id"] stringValue],[[MyFounctions getUserInfo] objectForKey:@"account"],timeIDStr,dateStr,[self.currentCoachData objectForKey:@"kemu"]] forKeys:@[@"method",@"coachid",@"account",@"timeid",@"date",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预约申请成功，请等待教练确认" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
        [self.navigationController popToRootViewControllerAnimated:YES];
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
