//
//  MyIntegralVC.h
//  yocheche
//
//  Created by carcool on 11/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface MyIntegralVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet MyButton *btnSubmitCode;
@property(nonatomic,assign)IBOutlet UILabel *labelIntegral;
@property(nonatomic,assign)IBOutlet UILabel *labelUsedCode;
@property(nonatomic,assign)IBOutlet UITextField *textfieldCode;
@property(nonatomic,assign)IBOutlet UIView *inputBG;
@property(nonatomic,assign)IBOutlet UIView *showUsedBG;
@end
