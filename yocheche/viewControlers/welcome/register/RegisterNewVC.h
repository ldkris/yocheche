//
//  RegisterNewVC.h
//  yocheche
//
//  Created by carcool on 9/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "WelcomeVC.h"
@interface RegisterNewVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,assign)WelcomeVC *delegate;
@property(nonatomic,assign)NSInteger registerIndex;//0:input phone 1:input verify code 2:input password
@property(nonatomic,assign)NSInteger registerOrForget;//0:register 1:forget password
@property(nonatomic,retain)NSString *mobile;
@property(nonatomic,retain)NSString *verifyCode;
@property(nonatomic,retain)NSString *password;

@property(nonatomic,retain)IBOutlet UITextField *textFieldPhone;
@property(nonatomic,retain)IBOutlet UITextField *textFieldVerify;
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,retain)IBOutlet UILabel *labelSendVerify;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPassword1;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPassword2;


@end
