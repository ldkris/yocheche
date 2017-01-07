//
//  WelcomeVC.h
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@interface WelcomeVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,retain)NSMutableDictionary *weixindata;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPhone;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPassword;
@property(nonatomic,retain)IBOutlet UIImageView *imgweixin;
@property(nonatomic,retain)IBOutlet UIImageView *imgweibo;
@property(nonatomic,retain)IBOutlet UILabel *labelweixin;
@property(nonatomic,retain)IBOutlet UILabel *labelweibo;
@property(nonatomic,retain)IBOutlet UIButton *btnweixin;
@property(nonatomic,retain)IBOutlet UIButton *btnweibo;
@end
