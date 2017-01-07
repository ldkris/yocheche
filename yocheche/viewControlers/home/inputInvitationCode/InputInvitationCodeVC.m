//
//  InputInvitationCodeVC.m
//  yocheche
//
//  Created by carcool on 11/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InputInvitationCodeVC.h"

@interface InputInvitationCodeVC ()

@end

@implementation InputInvitationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的邀请码";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.textfieldCode.delegate=self;
    self.textfieldCode.returnKeyType=UIReturnKeyDone;
    
    [self SaveShowedInveteCodeVC];
}
-(void)SaveShowedInveteCodeVC
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"1" forKey:@"inviteVCShowed"];
    [userDefault synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- textfield delegate ----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark --------- event response ------------
-(IBAction)submitBtnPressed:(id)sender
{
    if ([self.textfieldCode.text isEqualToString:@""])
    {
        [self showMessage:@"请输入邀请码"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/putMarketInvitedCode.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldCode.text] forKeys:@[@"account",@"invitedCode"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
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
-(IBAction)skipBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
