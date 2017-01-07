//
//  EditTextInfoVC.h
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface EditTextInfoVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIView *textfieldBG;
@property(nonatomic,retain)IBOutlet MyButton *btnSearch;
@property(nonatomic,retain)IBOutlet UITextField *textFieldContent;
@property(nonatomic,retain)NSString *modifiedKey;
@end
