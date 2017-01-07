//
//  FirstProOrderExamDoneVC.m
//  weixueche
//
//  Created by carcool on 12/12/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "FirstProOrderExamDoneVC.h"

@interface FirstProOrderExamDoneVC ()

@end

@implementation FirstProOrderExamDoneVC
@synthesize btnBack;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约·申请考试";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnBack setColor:Green_btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)rebackToHomePage:(id)sender
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
