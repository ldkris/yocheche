//
//  SelectProgressVC.m
//  yocheche
//
//  Created by carcool on 6/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SelectProgressVC.h"
#import "FirstProgressVC.h"
@interface SelectProgressVC ()

@end

@implementation SelectProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择科目";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bg0 setClipsToBounds:YES];
    [self.bg0.layer setCornerRadius:3.0];
    [self.bg1 setClipsToBounds:YES];
    [self.bg1.layer setCornerRadius:3.0];
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"SelectProgressVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"SelectProgressVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)//progress1
    {
        FirstProgressVC *vc=[[FirstProgressVC alloc] init];
        vc.progressIndex=1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else//progress4
    {
        FirstProgressVC *vc=[[FirstProgressVC alloc] init];
        vc.progressIndex=4;
        [self.navigationController pushViewController:vc animated:YES];
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
