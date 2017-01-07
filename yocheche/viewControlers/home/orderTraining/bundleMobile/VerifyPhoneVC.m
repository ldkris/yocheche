//
//  VerifyPhoneVC.m
//  yocheche
//
//  Created by carcool on 2/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "VerifyPhoneVC.h"
#import "BundleMobileForOrderVC.h"
@interface VerifyPhoneVC ()

@end

@implementation VerifyPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"手机验证";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.time=0;
    [self sendBtnPressed:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sendBtnPressed:(id)sender
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getStudentMobileValidateCode.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.phone] forKeys:@[@"account",@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"验证码已发送"];
            self.code=[req.m_data objectForKey:@"validateCode"];
            if (self.time==0)
            {
                self.time=59;
                [self.labelSend setBackgroundColor:[UIColor lightGrayColor]];
                [self.labelSend setText:[NSString stringWithFormat:@"%d秒重新发送",self.time]];
                [self performSelector:@selector(deleteTimeBySecond) withObject:nil afterDelay:1.0];
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
-(void)deleteTimeBySecond
{
    self.time--;
    if (self.time>0)
    {
        [self.labelSend setText:[NSString stringWithFormat:@"%d秒重新发送",self.time]];
        [self performSelector:@selector(deleteTimeBySecond) withObject:nil afterDelay:1.0];
    }
    else
    {
        [self.labelSend setBackgroundColor:YCC_Green];
        [self.labelSend setText:@"获取验证码"];
    }
}
-(IBAction)doneBtnPressed:(id)sender
{
    if ([self.textfieldCode.text isEqualToString:@""])
    {
        [self showMessage:@"请输入验证码"];
        return;
    }
    if ([self.textfieldCode.text isEqualToString:self.code])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.orderBundleDelegate submitStudentInfo];
    }
    else
    {
        [self showMessage:@"验证码错误"];
        return;
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
