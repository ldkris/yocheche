//
//  RegisterVC.h
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface RegisterVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,assign)NSInteger registerIndex;//0:input phone 1:input verify code 2:input password
@property(nonatomic,assign)NSInteger registerOrForget;//0:register 1:forget password
@property(nonatomic,retain)NSString *mobile;
@property(nonatomic,retain)NSString *verifyCode;
@property(nonatomic,retain)NSString *password;
-(void)sendVerifyCode;
-(void)btnPressed:(NSString*)textFieldText;
@end
