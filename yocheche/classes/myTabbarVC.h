//
//  myTabbarVC.h
//  EStar
//
//  Created by KingRain on 13-12-26.
//  Copyright (c) 2013年 KingRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTabbarVC : UITabBarController
{
//UIButton *dongtaiBtn;
//UIButton *activityBtn;

//UIImageView *tabbarBG;
//UIImageView *itemBG;
}
@property(nonatomic,retain)UIButton *btn1;
@property(nonatomic,retain)UIButton *btn2;
@property(nonatomic,retain)UIButton *btn3;
@property(nonatomic,retain)UIButton *btn4;
@property(retain,nonatomic)UIImageView *tabbarBG;
@property(retain,nonatomic)UIImageView *itemBG;
@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)UILabel *label4;
@property(nonatomic,retain)UIView *notifyView1;
@property(nonatomic,retain)UIView *notifyView2;
@property(nonatomic,retain)UIView *notifyView3;
@property(nonatomic,retain)UIView *notifyView4;
- (void)createCustomTabBar; //创建自定义TabBar
- (void)showTabBar; //显示TabBar
- (void)hideTabBar; //隐藏TabBar
-(void)btn2Pressed;
-(void)btn3Pressed;
@end
