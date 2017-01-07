//
//  RegisterNewVC.m
//  yocheche
//
//  Created by carcool on 9/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterNewVC.h"
#import "RegisterInfoVC.h"
@interface RegisterNewVC ()

@end

@implementation RegisterNewVC
@synthesize time;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.registerIndex=0;
    self.time=60;
    self.textFieldPassword1.secureTextEntry=YES;
    self.textFieldPassword2.secureTextEntry=YES;
    self.textFieldPhone.returnKeyType=UIReturnKeyDone;
    self.textFieldVerify.returnKeyType=UIReturnKeyDone;
    self.textFieldPassword1.returnKeyType=UIReturnKeyDone;
    self.textFieldPassword2.returnKeyType=UIReturnKeyDone;
    self.textFieldPassword1.delegate=self;
    self.textFieldPassword2.delegate=self;
    self.textFieldPhone.delegate=self;
    self.textFieldVerify.delegate=self;
    [self updateViews];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}
-(void)updateViews
{
    if (self.registerOrForget==0)
    {
        self.title=@"注册";
    }
    else
    {
        self.title=@"找回密码";
    }
}
-(void)sendVerifyCode
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[__BASE64(self.mobile),@"register.validatecode.get"] forKeys:@[@"mobile",@"method"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"验证码已发送"];
            self.verifyCode=[req.m_data objectForKey:@"validateCode"];
            self.registerIndex=1;
            [self updateTime];
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
-(void)registerMobile
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.register",__BASE64(self.mobile),[MyFounctions md5:self.password],@"1"] forKeys:@[@"method",@"account",@"password",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(self.mobile),[MyFounctions md5:self.password]] forKeys:@[@"account",@"password"]]];
            [MobClick profileSignInWithPUID:__BASE64(self.mobile)];
            RegisterInfoVC *vc=[[RegisterInfoVC alloc] init];
            vc.delegate=self;
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
-(void)sendVerifyCodeForResetPassword
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[__BASE64(self.mobile),@"findpassword.validatecode.get"] forKeys:@[@"mobile",@"method"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"验证码已发送"];
            self.verifyCode=[req.m_data objectForKey:@"validateCode"];
            self.registerIndex=1;
            [self updateTime];
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
-(void)resetPassword
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.findpassword",__BASE64(self.mobile),[MyFounctions md5:self.password]] forKeys:@[@"method",@"account",@"password"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showAlertViewWithTitle:nil message:@"密码修改成功，请登录" cancelButton:@"确定" others:nil];
            self.alertView.tag=1000;
            self.alertView.delegate=self;
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
#pragma  mark --------------- textfield delegate ---------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfiled_y=[textField convertRect:self.view.frame toView:nil].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),_y , PARENT_WIDTH(self.view)+_y, PARENT_HEIGHT(self.view))];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(PARENT_X(self.view),0 , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------------- verify code --------------
-(void)updateTime
{
    if (time>0)
    {
        [self.labelSendVerify setText:[NSString stringWithFormat:@"重发验证码(%d)",time]];
        [self.labelSendVerify setBackgroundColor:[UIColor lightGrayColor]];
        time--;
        [self performSelector:@selector(updateTime) withObject:nil afterDelay:1.0];
    }
    else
    {
        [self.labelSendVerify setBackgroundColor:YCC_Green];
        [self.labelSendVerify setText:[NSString stringWithFormat:@"重发"]];
        self.time=60;
    }
}

#pragma mark ------ event response
-(IBAction)resendVerifyCode:(id)sender
{
    if([self.textFieldPhone.text isEqualToString:@""])
    {
        [self showMessage:@"请输入手机号"];
        return;
    }
    if (![MyFounctions isValidateMobile:self.textFieldPhone.text])
    {
        [self showMessage:@"请输入正确手机号"];
        return;
    }
    if (self.time>=60)
    {
        if ([self.textFieldPhone.text isEqualToString:@""])
        {
            [self showMessage:@"请输入手机号"];
            return;
        }
        self.mobile=self.textFieldPhone.text;
        if(self.registerOrForget==0)
        {
            [self sendVerifyCode];
        }
        else
        {
            [self sendVerifyCodeForResetPassword];
        }
    }
}

-(IBAction)doneBtnPressed:(id)sender
{
    if ([self.textFieldPhone.text isEqualToString:@""])
    {
        [self showMessage:@"请输入手机号"];
        return;
    }
    else if ([self.textFieldVerify.text isEqualToString:@""])
    {
        [self showMessage:@"请输入验证码"];
        return;
    }
    else if ([self.textFieldPassword1.text isEqualToString:@""])
    {
        [self showMessage:@"请设置密码"];
        return;
    }
    else if (![self.textFieldPassword1.text isEqualToString:self.textFieldPassword2.text])
    {
        [self showMessage:@"两次输入密码不对"];
        return;
    }
    
    if ([self.verifyCode isEqualToString:self.textFieldVerify.text])
    {
        self.verifyCode=self.textFieldVerify.text;
        self.password=self.textFieldPassword1.text;
        if (self.registerOrForget==0)
        {
            [self registerMobile];
        }
        else
        {
            [self resetPassword];
        }
    }
    else
    {
        [self showMessage:@"验证码错误"];
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
