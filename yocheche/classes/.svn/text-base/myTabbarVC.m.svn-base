//
//  myTabbarVC.m
//  EStar
//
//  Created by KingRain on 13-12-26.
//  Copyright (c) 2013年 KingRain. All rights reserved.
//

#import "myTabbarVC.h"
#import "MyFounctions.h"
@interface myTabbarVC ()

@end

@implementation myTabbarVC
@synthesize tabbarBG,btn1,btn2,itemBG,btn3,btn4;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //hide the original tabbar.
    self.tabBar.hidden=YES;
    [self createCustomTabBar];
}
- (void)createCustomTabBar
{
    self.tabbarBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-49, Screen_Width, 49)];
//    tabbarBG.image = [UIImage imageNamed:@"tabbar_bg"];
    [tabbarBG setBackgroundColor:YCC_Tabbar_Color];
    tabbarBG.userInteractionEnabled = YES;
    [tabbarBG.layer setBorderWidth:0.5];
    [tabbarBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.view addSubview:tabbarBG];
    
    self.label1=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 27, Screen_Width/4.0, 19)];
    [self.label1 setTextColor:YCC_Green];
    [self.label1 setTextAlignment:NSTextAlignmentCenter];
    [self.label1 setText:@"首页"];
    [self.label1 setFont:[UIFont systemFontOfSize:10.0]];
    [tabbarBG addSubview:self.label1];
    self.notifyView1=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/4.0*0+47, 5, 8, 8)];
    [self.notifyView1 setBackgroundColor:[UIColor redColor]];
    [self.notifyView1.layer setCornerRadius:4.0];
    [tabbarBG addSubview:self.notifyView1];
    self.notifyView1.hidden=YES;
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 0;
    btn1.frame = CGRectMake(0.0, 0.0, Screen_Width/4.0, 49.0);
    [btn1 setImage:[UIImage imageNamed:@"tab_home_2"] forState:UIControlStateNormal];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake((49-21)/2.0-6, (Screen_Width/4.0-21)/2.0+2, (49-21)/2.0+10, (Screen_Width/4.0-21)/2.0+2)];
    [btn1 addTarget:self action:@selector(btn1Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn1];
    
    self.label2=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/4.0, 27, Screen_Width/4.0, 19)];
    [self.label2 setTextColor:YCC_DarkGray];
    [self.label2 setTextAlignment:NSTextAlignmentCenter];
    [self.label2 setText:@"发现"];
    [self.label2 setFont:[UIFont systemFontOfSize:10.0]];
    [tabbarBG addSubview:self.label2];
    self.notifyView2=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/4.0+50, 5, 8, 8)];
    [self.notifyView2 setBackgroundColor:[UIColor redColor]];
    [self.notifyView2.layer setCornerRadius:4.0];
    [tabbarBG addSubview:self.notifyView2];
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 1;
    btn2.frame = CGRectMake(Screen_Width/4.0, 0.0, Screen_Width/4.0, 49.0);
    [btn2 setImage:[UIImage imageNamed:@"tab_social_1"] forState:UIControlStateNormal];
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake((49-21)/2.0-6, (Screen_Width/4.0-21)/2.0+2, (49-21)/2.0+10, (Screen_Width/4.0-21)/2.0+2)];
    [btn2 addTarget:self action:@selector(btn2Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn2];
    
    self.label3=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/4.0*2, 27, Screen_Width/4.0, 19)];
    [self.label3 setTextColor:YCC_DarkGray];
    [self.label3 setTextAlignment:NSTextAlignmentCenter];
    [self.label3 setText:@"消息"];
    [self.label3 setFont:[UIFont systemFontOfSize:10.0]];
    [tabbarBG addSubview:self.label3];
    self.notifyView3=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/4.0*2+50, 5, 8, 8)];
    [self.notifyView3 setBackgroundColor:[UIColor redColor]];
    [self.notifyView3.layer setCornerRadius:4.0];
    self.notifyView3.hidden=YES;
    [tabbarBG addSubview:self.notifyView3];
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 1;
    btn3.frame = CGRectMake(Screen_Width/4.0*2, 0.0, Screen_Width/4.0, 49.0);
    [btn3 setImage:[UIImage imageNamed:@"tab_message_1"] forState:UIControlStateNormal];
    [btn3 setImageEdgeInsets:UIEdgeInsetsMake((49-21)/2.0-6, (Screen_Width/4.0-21)/2.0+2, (49-21)/2.0+10, (Screen_Width/4.0-21)/2.0+2)];
    [btn3 addTarget:self action:@selector(btn3Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn3];
    
    self.label4=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/4.0*3, 27, Screen_Width/4.0, 19)];
    [self.label4 setTextColor:YCC_DarkGray];
    [self.label4 setTextAlignment:NSTextAlignmentCenter];
    [self.label4 setText:@"我的"];
    [self.label4 setFont:[UIFont systemFontOfSize:10.0]];
    [tabbarBG addSubview:self.label4];
    self.notifyView4=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/4.0*3+50, 5, 8, 8)];
    [self.notifyView4 setBackgroundColor:[UIColor redColor]];
    [self.notifyView4.layer setCornerRadius:4.0];
    [tabbarBG addSubview:self.notifyView4];
    self.notifyView4.hidden=YES;
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.tag = 1;
    btn4.frame = CGRectMake(Screen_Width/4.0*3, 0.0, Screen_Width/4.0, 49.0);
    [btn4 setImage:[UIImage imageNamed:@"tab_mycenter_1"] forState:UIControlStateNormal];
    [btn4 setImageEdgeInsets:UIEdgeInsetsMake((49-21)/2.0-6, (Screen_Width/4.0-21)/2.0+2, (49-21)/2.0+10, (Screen_Width/4.0-21)/2.0+2)];
    [btn4 addTarget:self action:@selector(btn4Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn4];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    tabbarBG.frame = CGRectMake(0, Screen_Height-49, 320, 49);
    [UIView commitAnimations];
}
- (void)hideTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    tabbarBG.frame = CGRectMake(0, Screen_Height, 320, 49);
    [UIView commitAnimations];
}
-(void)btn1Pressed
{
    [self setSelectedIndex:0];
    [btn1 setImage:[UIImage imageNamed:@"tab_home_2"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"tab_social_1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"tab_message_1"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"tab_mycenter_1"] forState:UIControlStateNormal];
    [self.label1 setTextColor:YCC_Green];
    [self.label2 setTextColor:YCC_DarkGray];
    [self.label3 setTextColor:YCC_DarkGray];
    [self.label4 setTextColor:YCC_DarkGray];
    
}
-(void)btn2Pressed
{
    [self setSelectedIndex:1];
    [btn1 setImage:[UIImage imageNamed:@"tab_home_1"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"tab_social_2"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"tab_message_1"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"tab_mycenter_1"] forState:UIControlStateNormal];
    [self.label1 setTextColor:YCC_DarkGray];
    [self.label2 setTextColor:YCC_Green];
    [self.label3 setTextColor:YCC_DarkGray];
    [self.label4 setTextColor:YCC_DarkGray];
    self.notifyView2.hidden=YES;
}
-(void)btn3Pressed
{
    [self setSelectedIndex:2];
    [btn1 setImage:[UIImage imageNamed:@"tab_home_1"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"tab_social_1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"tab_message_2"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"tab_mycenter_1"] forState:UIControlStateNormal];
    [self.label1 setTextColor:YCC_DarkGray];
    [self.label2 setTextColor:YCC_DarkGray];
    [self.label3 setTextColor:YCC_Green];
    [self.label4 setTextColor:YCC_DarkGray];
}
-(void)btn4Pressed
{
    [self setSelectedIndex:3];
    [btn1 setImage:[UIImage imageNamed:@"tab_home_1"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"tab_social_1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"tab_message_1"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"tab_mycenter_2"] forState:UIControlStateNormal];
    [self.label1 setTextColor:YCC_DarkGray];
    [self.label2 setTextColor:YCC_DarkGray];
    [self.label3 setTextColor:YCC_DarkGray];
    [self.label4 setTextColor:YCC_Green];
}
@end
