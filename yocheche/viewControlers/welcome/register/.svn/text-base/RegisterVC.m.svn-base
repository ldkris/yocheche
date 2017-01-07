//
//  RegisterVC.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterCellPhone.h"
#import "RegisterCellVerify.h"
#import "RegisterCellPassword.h"
@interface RegisterVC ()

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.registerIndex=0;
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
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
-(void)registerMobile
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"user.register",__BASE64(self.mobile),[MyFounctions md5:self.password],@"1"] forKeys:@[@"method",@"account",@"password",@"type"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showAlertViewWithTitle:nil message:@"注册成功，请登录" cancelButton:@"确定" others:nil];
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
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.registerIndex==0)
    {
        RegisterCellPhone *cell=[[[NSBundle mainBundle] loadNibNamed:@"RegisterCellPhone" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
    else if (self.registerIndex==1)
    {
        RegisterCellVerify *cell=[[[NSBundle mainBundle] loadNibNamed:@"RegisterCellVerify" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
    else
    {
        RegisterCellPassword *cell=[[[NSBundle mainBundle] loadNibNamed:@"RegisterCellPassword" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
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
#pragma mark ------ alert delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark ------ event response
-(void)btnPressed:(NSString*)textFieldText
{
    if (self.registerIndex==0)
    {
        self.mobile=textFieldText;
        if(self.registerOrForget==0)
        {
            [self sendVerifyCode];
        }
        else
        {
            [self sendVerifyCodeForResetPassword];
        }
    }
    else if (self.registerIndex==1)
    {
        if ([self.verifyCode isEqualToString:textFieldText])
        {
            self.verifyCode=textFieldText;
            self.registerIndex=2;
            [self.m_tableView reloadData];
        }
        else
        {
            [self showMessage:@"验证码错误"];
        }
    }
    else
    {
        self.password=textFieldText;
        if (self.registerOrForget==0)
        {
             [self registerMobile];
        }
        else
        {
            [self resetPassword];
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
