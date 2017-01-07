//
//  BundleMobileForOrderVC.m
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "BundleMobileForOrderVC.h"
#import "VerifyPhoneVC.h"
@interface BundleMobileForOrderVC ()

@end

@implementation BundleMobileForOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"预约练车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:4.0];
    self.textfieldMobile.delegate=self;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
    self.textfieldName.delegate=self;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)doneBtnPressed:(id)sender
{
    if ([self.textfieldMobile.text isEqualToString:@""])
    {
        [self showMessage:@"请输入手机号"];
        return;
    }
    else if ([self.textfieldName.text isEqualToString:@""])
    {
        [self showMessage:@"请输入姓名"];
        return;
    }
    
    if ([[[MyFounctions getUserInfo] objectForKey:@"account"] isEqualToString:__BASE64(self.textfieldMobile.text)])
    {
        [self submitStudentInfo];
    }
    else
    {
        VerifyPhoneVC *vc=[[VerifyPhoneVC alloc] init];
        vc.phone=self.textfieldMobile.text;
        vc.orderBundleDelegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)submitStudentInfo
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/putStudentInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldMobile.text,self.textfieldName.text] forKeys:@[@"account",@"mobile",@"studentname"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.navigationController popViewControllerAnimated:YES];
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
