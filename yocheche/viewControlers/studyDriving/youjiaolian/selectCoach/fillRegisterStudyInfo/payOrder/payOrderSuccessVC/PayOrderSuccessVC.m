//
//  PayOrderSuccessVC.m
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PayOrderSuccessVC.h"

@interface PayOrderSuccessVC ()

@end

@implementation PayOrderSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"支付成功";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    
    [self updateView];
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)updateView
{
    self.labelCoachAndSchool.text=[NSString stringWithFormat:@"%@,%@",[self.preData objectForKey:@"coachname"],[self.preData objectForKey:@"drivingschoolname"]];
    self.labelNeedPay.text=[NSString stringWithFormat:@"¥%@",[self.preData objectForKey:@"actualfee"] ];
    self.labelOldPay.text=[NSString stringWithFormat:@"¥%@",[self.preData objectForKey:@"fee"] ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------ event response ----------------
-(IBAction)goHomeVC:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
