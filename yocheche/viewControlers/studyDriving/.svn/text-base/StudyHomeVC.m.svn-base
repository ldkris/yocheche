//
//  StudyHomeVC.m
//  yocheche
//
//  Created by carcool on 11/18/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyHomeVC.h"
#import "SelectProgressVC.h"
#import "KnowledgeVC.h"
#import "MyTrainAndOrderListVC.h"
#import "CoachListVC.h"
#import "StudyView.h"
#import "StudyViewCell.h"
#import "EmbedReaderViewController.h"
#import "FillStudentInfoVC.h"
#import "SchoolListVC.h"
@interface StudyHomeVC ()

@end

@implementation StudyHomeVC
@synthesize m_studyView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"优学车";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatStudyView];
    //creat study info view
    self.infoView.clipsToBounds=YES;
    [self.infoView.layer setCornerRadius:3.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.btnKe2.layer setBorderWidth:1.0];
    [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
    [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.btnKe3.layer setBorderWidth:1.0];
    [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"StudyHomeVC"];
    [self updateNewMessage];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"StudyHomeVC"];
}
-(void)updateNewMessage
{
    if (![[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        return;
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"message/remindMsgForNotEvaluate.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[req.m_data objectForKey:@"status"]  forKey:@"orderMessage"];//1:new 2:no new
            [userDefaults setObject:[[req.m_data objectForKey:@"num"] stringValue]  forKey:@"orderNum"];
            [userDefaults synchronize];
            if ([[userDefaults objectForKey:@"orderMessage"] integerValue]==1)
            {
                self.m_studyView.m_cell.labelNum.text=[userDefaults objectForKey:@"orderNum"];
                self.m_studyView.m_cell.labelNum.hidden=NO;
            }
            else
            {
                self.m_studyView.m_cell.labelNum.text=[userDefaults objectForKey:@"orderNum"];
                self.m_studyView.m_cell.labelNum.hidden=YES;
            }
            //sign in
            [self getSignInNewMessage];
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
-(void)getSignInNewMessage
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/remindMsgForNotEvaluate.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[[req.m_data objectForKey:@"num"] stringValue]  forKey:@"signInNum"];
            [userDefaults synchronize];
            if ([[userDefaults objectForKey:@"signInNum"] integerValue]>0)
            {
                self.m_studyView.m_cell.labelSignInNum.text=[userDefaults objectForKey:@"signInNum"];
                self.m_studyView.m_cell.labelSignInNum.hidden=NO;
            }
            else
            {
                self.m_studyView.m_cell.labelSignInNum.text=[userDefaults objectForKey:@"signInNum"];
                self.m_studyView.m_cell.labelSignInNum.hidden=YES;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatStudyView
{
    self.m_studyView=[[StudyView alloc]
                      initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    self.m_studyView.delegate=self;
    [self.view addSubview:m_studyView];
}
-(void)creatInfoView
{
    [self addBlackBGViewOnKeywindow];
    [self.infoView setFrame:CGRectMake(30, (Screen_Height-PARENT_HEIGHT(self.infoView))/2.0, PARENT_WIDTH(self.infoView), PARENT_HEIGHT(self.infoView))];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.infoView];
}
-(void)updateInfoView
{
    [self.avaterCoach setWebImageViewWithURL:[NSURL URLWithString:[self.dataSignIn objectForKey:@"headImgurl"]]];
    if ([[self.dataSignIn objectForKey:@"type"] integerValue]==1)
    {
        self.labelClass.text=@"全科";
        self.selectedClass=2;
        self.btnKe2.hidden=NO;
        self.btnKe3.hidden=NO;
    }
    else if ([[self.dataSignIn objectForKey:@"type"] integerValue]==2)
    {
        self.labelClass.text=@"科目二";
        self.selectedClass=2;
        self.btnKe2.hidden=NO;
        self.btnKe3.hidden=YES;
    }
    else if ([[self.dataSignIn objectForKey:@"type"] integerValue]==3)
    {
        self.labelClass.text=@"科目三";
        self.selectedClass=3;
        self.btnKe2.hidden=YES;
        self.btnKe3.hidden=NO;
    }
    self.labelName.text=[self.dataSignIn objectForKey:@"coachname"];
    self.labelSchool.text=[self.dataSignIn objectForKey:@"dsname"];
    if (self.selectedClass==2)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else if (self.selectedClass==3)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe3 setTitleColor:YCC_Green forState:UIControlStateNormal];
    }
}
#pragma mark -------- info view response ------------
-(IBAction)classBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    self.selectedClass=btn.tag;
    if (self.selectedClass==2)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe2 setTitleColor:YCC_Green forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else if (self.selectedClass==3)
    {
        [self.btnKe2.layer setBorderWidth:1.0];
        [self.btnKe2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.btnKe2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnKe3.layer setBorderWidth:1.0];
        [self.btnKe3.layer setBorderColor:[YCC_Green CGColor]];
        [self.btnKe3 setTitleColor:YCC_Green forState:UIControlStateNormal];
    }

}
-(IBAction)doneBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self.infoView removeFromSuperview];
        [self removeBLackBGView];
    }
    else if (btn.tag==1)
    {
        [self.infoView removeFromSuperview];
        [self removeBLackBGView];
        
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        req.socialMethord=@"sign/checkStudentInfo.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if ([[req.m_data objectForKey:@"status"] integerValue]==1)
                {
                    FillStudentInfoVC *vc=[[FillStudentInfoVC alloc] init];
                    vc.dataSignIn=[NSDictionary dictionaryWithDictionary:self.dataSignIn];
                    vc.selectedClass=self.selectedClass;
                    vc.coachID=self.coachID;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [self submitSignIn];
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
}
-(void)submitSignIn
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/putSignInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.coachID,[NSString stringWithFormat:@"%d",self.selectedClass]] forKeys:@[@"account",@"coachid",@"teaching_item"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"签到成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate=self;
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
#pragma mark -------- embeded reader QRCode VC delegate ------
-(void)scaneSuccess:(NSString *)result
{
    self.coachID=result;
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/getCoachInfoById.yo";
    [req setParams:@[result] forKeys:@[@"coachid"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.dataSignIn=[NSDictionary dictionaryWithDictionary:req.m_data];
            [self creatInfoView];
            [self updateInfoView];
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
#pragma mark ------- event response ------- study driving
-(void)showSelectProgressVC
{
    SelectProgressVC *vc=[[SelectProgressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSelectLocateVC
{
//    CoachListVC *vc=[[CoachListVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    SchoolListVC *vc=[[SchoolListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showKnowledgevc
{
    KnowledgeVC *vc=[[KnowledgeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)orderTrainDrive
{
    MyTrainAndOrderListVC *vc=[[MyTrainAndOrderListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scanAndRegister
{
    EmbedReaderViewController *vc=[[EmbedReaderViewController alloc] init];
    vc.m_delegate=self;
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
