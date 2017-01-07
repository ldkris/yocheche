//
//  OrderTrainDriveCell.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainDriveCell.h"
#import "OrderTrainDriveVC.h"
@implementation OrderTrainDriveCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.avatar0 setClipsToBounds:YES];
    [self.avatar0.layer setCornerRadius:PARENT_WIDTH(self.avatar0)/2.0];
    [self.avatar1 setClipsToBounds:YES];
    [self.avatar1.layer setCornerRadius:PARENT_WIDTH(self.avatar1)/2.0];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
    [MyFounctions setLineViewMoreThin:self.lineView3];
    [MyFounctions setLineViewMoreThin:self.lineView4];
    [MyFounctions setLineViewMoreThin:self.lineView5];
    [MyFounctions setLineViewMoreThin:self.lineView6];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self.lineView4 setBackgroundColor:YCC_GrayBG];
    [self.lineView5 setBackgroundColor:YCC_GrayBG];
    [self.lineView6 setBackgroundColor:YCC_GrayBG];

    self.lineViewDate=[[UIView alloc] initWithFrame:CGRectMake(0, 218, 64, 2)];
    [self.lineViewDate setBackgroundColor:YCC_Green];
    [self addSubview:self.lineViewDate];
    self.gou0.hidden=YES;
    self.gou1.hidden=YES;
    self.triangle0.hidden=YES;
    self.triangle1.hidden=YES;
    
    self.m_aryLabelDay=[NSMutableArray arrayWithObjects:self.labelDay0,self.labelDay1,self.labelDay2,self.labelDay3,self.labelDay4, nil];
    self.m_aryLabelWeek=[NSMutableArray arrayWithObjects:self.labelWeek0,self.labelWeek1,self.labelWeek2,self.labelWeek3,self.labelWeek4, nil];
    
    //longpress
    self.longPressing=0;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCoachCancelBundle1)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [self.btn1 addGestureRecognizer:longPress];
    UILongPressGestureRecognizer *longPress2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCoachCancelBundle2)];
    longPress2.minimumPressDuration = 0.8; //定义按的时间
    [self.btn2 addGestureRecognizer:longPress2];
}
-(void)updateView
{
    if ([self.coach2Data objectForKey:@"name"])
    {
        self.labelName0.text=[self.coach2Data objectForKey:@"name"];
        self.labelType0.text=@"科目二";
        [self.avatar0 setWebImageViewWithURL:[NSURL URLWithString:[self.coach2Data objectForKey:@"userpic"]]];
        self.addCoach0.hidden=YES;
    }
    else
    {
        self.addCoach0.hidden=NO;
    }
    if ([self.coach3Data objectForKey:@"name"])
    {
        self.labelName1.text=[self.coach3Data objectForKey:@"name"];
        self.labelType1.text=@"科目三";
        [self.avatar1 setWebImageViewWithURL:[NSURL URLWithString:[self.coach3Data objectForKey:@"userpic"]]];
        self.addCoach1.hidden=YES;
    }
    else
    {
        self.addCoach1.hidden=NO;
    }
    // select coach
    if (self.delegate.selectedCoach==0)
    {
        self.gou0.hidden=NO;
        self.triangle0.hidden=NO;
        self.gou1.hidden=YES;
        self.triangle1.hidden=YES;
    }
    else if (self.delegate.selectedCoach==1)
    {
        self.gou0.hidden=YES;
        self.triangle0.hidden=YES;
        self.gou1.hidden=NO;
        self.triangle1.hidden=NO;
    }
    
    //day
    [self.lineViewDate setFrame:CGRectMake(self.delegate.selectedDay*64, PARENT_Y(self.lineViewDate), PARENT_WIDTH(self.lineViewDate), PARENT_HEIGHT(self.lineViewDate))];
    NSInteger i=0;
    for (NSDictionary *dic in self.delegate.m_aryData)
    {
        if (i<5)
        {
            UILabel *labelday=[self.m_aryLabelDay objectAtIndex:i];
            UILabel *labelweek=[self.m_aryLabelWeek objectAtIndex:i];
            NSRange range=[[dic objectForKey:@"dateString"] rangeOfString:@":"];
            labelday.text=[[dic objectForKey:@"dateString"] substringToIndex:range.location];
            labelweek.text=[[dic objectForKey:@"dateString"] substringFromIndex:range.location+1];
        }
        i++;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)dateMenuBtnPreseed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    self.delegate.selectedDay=btn.tag;
    [self.lineViewDate setFrame:CGRectMake(btn.tag*64, PARENT_Y(self.lineViewDate), PARENT_WIDTH(self.lineViewDate), PARENT_HEIGHT(self.lineViewDate))];
    [self.delegate.m_tableView reloadData];
}
-(IBAction)coachBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        if (self.addCoach0.hidden==NO)
        {
            [self.delegate showBundleCoachVC:@"2"];
        }
        else
        {
            if([[self.coach2Data objectForKey:@"auditStudent"] integerValue]==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"教练认证审核中，暂不能预约" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                self.gou0.hidden=NO;
                self.triangle0.hidden=NO;
                self.gou1.hidden=YES;
                self.triangle1.hidden=YES;
                
                self.delegate.selectedCoach=0;
                [self.delegate updateDateAndTime:self.coach2Data];
            }
        }
    }
    else
    {
        if (self.addCoach1.hidden==NO)
        {
            [self.delegate showBundleCoachVC:@"3"];
        }
        else
        {
            if([[self.coach3Data objectForKey:@"auditStudent"] integerValue]==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"教练认证审核中，暂不能预约" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                self.gou0.hidden=YES;
                self.triangle0.hidden=YES;
                self.gou1.hidden=NO;
                self.triangle1.hidden=NO;
                
                self.delegate.selectedCoach=1;
                [self.delegate updateDateAndTime:self.coach3Data];
            }
        }
    }
}
-(void)longPressCoachCancelBundle1
{
    if([self.coach2Data objectForKey:@"name"]&&self.longPressing==0)
    {
        self.longPressing=1;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否取消绑定该教练" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=12;
        [alert show];
    }
}
-(void)longPressCoachCancelBundle2
{
    if([self.coach3Data objectForKey:@"name"]&&self.longPressing==0)
    {
        self.longPressing=1;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否取消绑定该教练" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=13;
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==12)
    {
        if (buttonIndex==1)
        {
            [self.delegate cancelBundleCoach:self.coach2Data type:@"2"];
        }
    }
    else if (alertView.tag==13)
    {
        if (buttonIndex==1)
        {
            [self.delegate cancelBundleCoach:self.coach3Data type:@"3"];
        }
    }
    self.longPressing=0;
}
@end
