//
//  MyStudyDriveVC.m
//  yocheche
//
//  Created by carcool on 1/20/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyStudyDriveVC.h"
#import "MyOrderDriveListVC.h"
#import "MyCoachListVC.h"
#import "TrainOrderRecordsVC.h"
@interface MyStudyDriveVC ()

@end

@implementation MyStudyDriveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的学车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)showMyOrderDriveListVC:(id)sender
{
    TrainOrderRecordsVC *vc=[[TrainOrderRecordsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showMyCoachList:(id)sender
{
    MyCoachListVC *vc=[[MyCoachListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
