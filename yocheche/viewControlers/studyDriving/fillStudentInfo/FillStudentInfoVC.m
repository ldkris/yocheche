//
//  FillStudentInfoVC.m
//  yocheche
//
//  Created by carcool on 11/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FillStudentInfoVC.h"

@interface FillStudentInfoVC ()

@end

@implementation FillStudentInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"完善信息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitleWithTwoWords:@"确定"];
    [self.rightNaviBtn addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
    
    self.textFieldIdentify.delegate=self;
    self.textFieldName.delegate=self;
    self.textFieldPhone.delegate=self;
    self.textFieldIdentify.returnKeyType=UIReturnKeyDone;
    self.textFieldName.returnKeyType=UIReturnKeyDone;
    self.textFieldPhone.returnKeyType=UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------- text field delegate ----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)submitInfo
{
    if ([self.textFieldIdentify.text isEqualToString:@""]||[self.textFieldName.text isEqualToString:@""]||[self.textFieldPhone.text isEqualToString:@""])
    {
        [self showMessage:@"请将信息填写完整"];
        return;
    }
    else if (![MyFounctions isValidateMobile:self.textFieldPhone.text])
    {
        [self showMessage:@"请输入正确手机号"];
        return;
    }
    else if (![MyFounctions validateIdentityCard:self.textFieldIdentify.text])
    {
        [self showMessage:@"请输入正确身份证号码"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"sign/putSignStudentInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textFieldName.text,self.textFieldPhone.text,self.textFieldIdentify.text,self.coachID,[NSString stringWithFormat:@"%d",self.selectedClass]] forKeys:@[@"account",@"studentname",@"mobile",@"idc_code",@"coachid",@"teaching_item"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self submitSignIn];
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
            alert.tag=11;
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
#pragma mark ---------- alert view delegate -------
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
