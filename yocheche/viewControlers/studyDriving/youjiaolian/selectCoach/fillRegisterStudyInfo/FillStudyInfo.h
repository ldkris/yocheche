//
//  FillStudyInfo.h
//  yocheche
//
//  Created by carcool on 9/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "CoachDetailVC.h"
@interface FillStudyInfo : YCCViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)CoachDetailVC *delegate;
@property(nonatomic,retain)IBOutlet UITextField *textfieldName;
@property(nonatomic,retain)IBOutlet UITextField *textfieldMobile;
@property(nonatomic,retain)IBOutlet UITextField *textfieldIdentity;
@end
