//
//  EditTextInfoVC.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "EditTextInfoVC.h"

@interface EditTextInfoVC ()

@end

@implementation EditTextInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.textfieldBG.layer setBorderWidth:0.5];
    [self.textfieldBG.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.textfieldBG.layer setCornerRadius:3.0];
    [self.btnSearch setColor:YCC_Green];
    self.textFieldContent.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark --------- textfield delegate -----------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)saveBtnPressed:(id)sender
{
    if ([self.textFieldContent.text isEqualToString:@""])
    {
        [self showMessage:@"修改内容不能为空"];
        return;
    }
    if ([self.modifiedKey isEqualToString:@"phone"])
    {
        if ([self.textFieldContent.text length]!=11||![MyFounctions isPureNumandCharacters:self.textFieldContent.text])
        {
            [self showMessage:@"请输入正确手机号"];
            return;
        }
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        req.socialMethord=@"user/putUserMobileBind.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textFieldContent.text] forKeys:@[@"account",@"mobile"]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                [self popSelfViewContriller];
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
        [self showLoadingWithBG];
        Http *req=[[Http alloc] init];
        [req setParams:@[@"info.user.put",[[MyFounctions getUserInfo] objectForKey:@"account"],self.textFieldContent.text] forKeys:@[@"method",@"account",self.modifiedKey]];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                [self popSelfViewContriller];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
