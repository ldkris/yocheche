//
//  AddCoachVC.h
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class changeCoachVC;
@interface AddCoachVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,assign)changeCoachVC *changeCoachDelegate;
@property(nonatomic,assign)IBOutlet UITextField *textfieldMobile;
@end
