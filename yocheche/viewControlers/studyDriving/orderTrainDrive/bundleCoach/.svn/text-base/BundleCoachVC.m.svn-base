//
//  BundleCoachVC.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BundleCoachVC.h"

@interface BundleCoachVC ()

@end

@implementation BundleCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"添加教练";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldMobile.delegate=self;
    self.textfieldMyIdentity.delegate=self;
    self.textfieldMyMobile.delegate=self;
    self.textfieldMyName.delegate=self;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
    self.textfieldMyIdentity.returnKeyType=UIReturnKeyDone;
    self.textfieldMyMobile.returnKeyType=UIReturnKeyDone;
    self.textfieldMyName.returnKeyType=UIReturnKeyDone;
    UIColor *color = [UIColor redColor];
    self.textfieldMyIdentity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入正确身份证号码" attributes:@{NSForegroundColorAttributeName: color}];
    [self.textfieldBG.layer setBorderWidth:0.5];
    [self.textfieldBG.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.textfieldBG.layer setCornerRadius:3.0];
    [self.btnSearch setColor:YCC_Green];
    [self.nameBG.layer setBorderWidth:0.5];
    [self.nameBG.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.nameBG.layer setCornerRadius:3.0];
    [self.phoneBG.layer setBorderWidth:0.5];
    [self.phoneBG.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.phoneBG.layer setCornerRadius:3.0];
    [self.identityBG.layer setBorderWidth:0.5];
    [self.identityBG.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.identityBG.layer setCornerRadius:3.0];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    
    self.imgNotFound.hidden=YES;
    self.resultBG.hidden=YES;
    [self getMyInfoMobile];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"BundleCoachVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"BundleCoachVC"];
}
-(void)getMyInfoMobile
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"info.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.textfieldMyMobile.text=[req.m_data objectForKey:@"phone"];
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
-(void)updateView
{
    if ([self.data objectForKey:@"name"])
    {
        self.imgNotFound.hidden=YES;
        self.resultBG.hidden=NO;
        self.labelName.text=[self.data objectForKey:@"name"];
        self.labelClass.text=[self.data objectForKey:@"kemu"];
        [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    }
    else
    {
        self.imgNotFound.hidden=NO;
        self.resultBG.hidden=YES;
    }
}
#pragma mark ------------- textfield delegate --------------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfiled_y=[textField convertRect:self.view.frame toView:nil].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT-80)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y-80;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),_y , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view setFrame:CGRectMake(PARENT_X(self.view),0 , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)searchBtnPressed:(id)sender
{
    [self.textfieldMobile resignFirstResponder];
    if ([self.textfieldMobile.text isEqualToString:@""])
    {
        [self showMessage:@"请输入教练手机号"];
        return;
    }
    else if (![MyFounctions isValidateMobile:self.textfieldMobile.text])
    {
        [self showMessage:@"请输入正确手机号码"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"find.coach.mobile",self.textfieldMobile.text,self.type] forKeys:@[@"method",@"mobile",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([(NSArray*)[req.m_data objectForKey:@"infos"] count]>0)
            {
                self.data=[[req.m_data objectForKey:@"infos"] objectAtIndex:0];
                [self updateView];
            }
            else
            {
                self.data=[NSDictionary dictionary];
                [self updateView];
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
-(IBAction)bundleBtnPressed:(id)sender
{
    if ([self.data objectForKey:@"name"])
    {
        if([self.textfieldMyMobile.text isEqualToString:@""]||[self.textfieldMyIdentity.text isEqualToString:@""]||[self.textfieldMyName.text isEqualToString:@""])
        {
            [self showMessage:@"请将信息填写完整"];
            return;
        }
        else if (![MyFounctions validateIdentityCard:self.textfieldMyIdentity.text])
        {
            [self showMessage:@"请输入正确的身份证号码"];
            return;
        }
        else if (![MyFounctions isValidateMobile:self.textfieldMyMobile.text])
        {
            [self showMessage:@"请输入自己正确的手机号码"];
            return;
        }
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        [req setParams:@[@"coach.user.bind",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"id"]integerValue]],self.textfieldMyName.text,self.textfieldMyIdentity.text,self.textfieldMyMobile.text,self.type] forKeys:@[@"method",@"account",@"coachid",@"idc_name",@"idc_no",@"mobile",@"type"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"绑定成功,请等待教练审核" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aler.tag=11;
                [aler show];
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
    else
    {
        [self showMessage:@"请先输入教练手机号查找"];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
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
