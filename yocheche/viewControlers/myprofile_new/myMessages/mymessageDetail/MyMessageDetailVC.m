//
//  MyMessageDetailVC.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyMessageDetailVC.h"

@interface MyMessageDetailVC ()

@end

@implementation MyMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的消息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgTriangle=[[UIImageView alloc] initWithFrame:CGRectMake(11,94,15,24)];
    [self.imgTriangle setImage:[UIImage imageNamed:@"triangle_message"]];
    self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(25, 80, 270, 300)];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:5.0];
    [self.contentBG.layer setBorderWidth:0.5];
    [self.contentBG.layer setBorderColor:[[UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1] CGColor]];
    [self.view addSubview:self.contentBG];
    [self.view addSubview:self.imgTriangle];
    
    [self updateView];
}
-(void)updateView
{
    float contentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:240 font:[UIFont systemFontOfSize:15.0]];
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 240,contentHeight)];
    self.labelContent.numberOfLines=0;
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    [self.labelContent setText:[self.data objectForKey:@"content"]];
    [self.labelContent setFont:[UIFont systemFontOfSize:15.0]];
    
    self.labelTime=[[UILabel alloc] initWithFrame:CGRectMake(15, 15+PARENT_HEIGHT(self.labelContent)+15, 240,20)];
    [self.labelTime setTextAlignment:NSTextAlignmentRight];
    [self.labelTime setTextColor:[UIColor darkGrayColor]];
    [self.labelTime setText:[self.data objectForKey:@"datetime"]];
    [self.labelTime setFont:[UIFont systemFontOfSize:15.0]];
    
    [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG),PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), 15+PARENT_HEIGHT(self.labelContent)+15+PARENT_HEIGHT(self.labelTime)+15)];
    [self.contentBG addSubview:self.labelTime];
    [self.contentBG addSubview:self.labelContent];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
