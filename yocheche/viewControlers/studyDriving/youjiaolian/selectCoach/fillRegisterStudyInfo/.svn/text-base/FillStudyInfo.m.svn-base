//
//  FillStudyInfo.m
//  yocheche
//
//  Created by carcool on 9/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FillStudyInfo.h"
#import "PayOrderVC.h"
@interface FillStudyInfo ()

@end

@implementation FillStudyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"预约报名";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    
    self.textfieldIdentity.delegate=self;
    self.textfieldMobile.delegate=self;
    self.textfieldName.delegate=self;
    self.textfieldIdentity.returnKeyType=UIReturnKeyDone;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
    
    [self getMyInfoMobile];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"FillStudyInfo"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"FillStudyInfo"];
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
            self.textfieldMobile.text=[req.m_data objectForKey:@"phone"];
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
#pragma mark ----------- textfield delegate -------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -------------- event response -----------------
-(IBAction)submitBtnPressed:(id)sender
{
    if ([self.textfieldName.text isEqualToString:@""]||[self.textfieldMobile.text isEqualToString:@""]||[self.textfieldIdentity.text isEqualToString:@""])
    {
        [self showMessage:@"请将信息填写完整"];
        return;
    }
    //submit
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"enroll.drivingschool.order",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%@",[[self.delegate.coachData objectForKey:@"id"] stringValue]],[[[self.delegate.feeArray objectAtIndex:self.delegate.selectedScheme] objectForKey:@"id"] stringValue],self.textfieldName.text,self.textfieldIdentity.text,self.textfieldMobile.text] forKeys:@[@"method",@"account",@"coachid",@"feeid",@"idc_name",@"idc_no",@"phone"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
//            PayOrderVC *vc=[[PayOrderVC alloc] init];
//            vc.preData=req.m_data;
//            [self.navigationController pushViewController:vc animated:YES];
            NSDictionary *preData=[NSDictionary dictionary];
            [self showLoadingWithBG];
            Http *req=[[Http alloc] init];
            [req setParams:@[@"order.user.pay",[[MyFounctions getUserInfo] objectForKey:@"account"],[preData objectForKey:@"orderid"],@"1"] forKeys:@[@"method",@"account",@"orderid",@"type"]];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预约报名成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    alert.tag=11;
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
#pragma mark ------ alert view delegate -------------
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
