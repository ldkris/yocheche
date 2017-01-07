//
//  AddCoachVC.m
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "AddCoachVC.h"
#import "changeCoachVC.h"
@interface AddCoachVC ()

@end

@implementation AddCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"添加教练";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldMobile.delegate=self;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)searchBtnPressed:(id)sender
{
    if ([self.textfieldMobile.text length]!=11||![MyFounctions isPureNumandCharacters:self.textfieldMobile.text])
    {
        [self showMessage:@"请输入正确手机号"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/changeCoach.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"1",self.textfieldMobile.text] forKeys:@[@"account",@"type",@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (!self.changeCoachDelegate)
            {
                [self popSelfViewContriller];
            }
            else
            {
                [self popSelfViewContriller];
                [self.changeCoachDelegate.navigationController popViewControllerAnimated:NO];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
