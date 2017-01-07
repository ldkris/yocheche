//
//  CancelOrderVC.h
//  yocheche
//
//  Created by carcool on 4/25/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface CancelOrderVC : YCCViewController<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet MyButton *btn;
@property(nonatomic,retain)NSString *did;
@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UIButton *btnWriteConetnt;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;
@property(nonatomic,retain)NSString *reasonStr;
@property(nonatomic,assign)IBOutlet UIImageView *img1;
@property(nonatomic,assign)IBOutlet UIImageView *img2;
@property(nonatomic,assign)IBOutlet UIImageView *img3;
@property(nonatomic,assign)IBOutlet UIImageView *img4;
@property(nonatomic,assign)IBOutlet UIImageView *img5;
@property(nonatomic,assign)IBOutlet UIImageView *img6;
@end
