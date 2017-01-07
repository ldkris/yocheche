//
//  MyIntegralVC.m
//  yocheche
//
//  Created by carcool on 11/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyIntegralVC.h"

@interface MyIntegralVC ()

@end

@implementation MyIntegralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的积分";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnSubmitCode setColor:YCC_Green];
    self.textfieldCode.delegate=self;
    self.textfieldCode.returnKeyType=UIReturnKeyDone;
    
    [self updateData];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"user/getUserIntegral.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [req startWithBlock:^{
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSDictionary dictionaryWithDictionary:req.m_data];
            [self updateView];
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
-(void)updateView
{
    self.labelIntegral.text=[[self.data objectForKey:@"integral"] stringValue];
    if ([[self.data objectForKey:@"invitedCode"] isEqualToString:@""])
    {
        self.inputBG.hidden=NO;
        self.showUsedBG.hidden=YES;
    }
    else
    {
        self.inputBG.hidden=YES;
        self.showUsedBG.hidden=NO;
        self.labelUsedCode.text=[self.data objectForKey:@"invitedCode"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------- text field delegate --------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------ event response ----------
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
            [self updateData];
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
