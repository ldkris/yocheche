//
//  CommentSignInVC.h
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MySignInListVC.h"
@interface CommentSignInVC : YCCViewController<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UIButton *btnSubmit;
@property(nonatomic,assign)MySignInListVC *delegate;

@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UIButton *btnWriteConetnt;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;

@property(nonatomic,retain)IBOutlet UIImageView *imgGood;
@property(nonatomic,assign)NSInteger goodFlag;
@end
