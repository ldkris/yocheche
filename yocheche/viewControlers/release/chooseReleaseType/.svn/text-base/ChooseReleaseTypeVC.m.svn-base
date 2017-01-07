//
//  ChooseReleaseTypeVC.m
//  yocheche
//
//  Created by carcool on 1/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ChooseReleaseTypeVC.h"
#import "WordReleaseVC.h"
#import "ReleaseVC.h"
@interface ChooseReleaseTypeVC ()

@end

@implementation ChooseReleaseTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"发布内容";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(dismissMyself) forControlEvents:UIControlEventTouchUpInside];
}
-(void)dismissMyself
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------- event response -----------
-(IBAction)wordBtnPressed:(id)sender
{
    WordReleaseVC *vc=[[WordReleaseVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)pictureBtnPressed:(id)sender
{
    ReleaseVC *vc=[[ReleaseVC alloc] init];
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
