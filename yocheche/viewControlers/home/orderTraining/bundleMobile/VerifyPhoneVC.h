//
//  VerifyPhoneVC.h
//  yocheche
//
//  Created by carcool on 2/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class BundleMobileForOrderVC;
@interface VerifyPhoneVC : YCCViewController
@property(nonatomic,assign)IBOutlet UITextField *textfieldCode;
@property(nonatomic,assign)IBOutlet UIButton *btnSend;
@property(nonatomic,assign)IBOutlet UILabel *labelSend;
@property(nonatomic,assign)NSInteger time;//wait time
@property(nonatomic,retain)NSString *phone;
@property(nonatomic,retain)NSString *code;
@property(nonatomic,assign)BundleMobileForOrderVC *orderBundleDelegate;
@end
