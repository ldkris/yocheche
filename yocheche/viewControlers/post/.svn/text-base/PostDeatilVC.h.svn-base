//
//  PostVC.h
//  yocheche
//
//  Created by carcool on 8/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "PostNameCell.h"
#import "VIPhotoView.h"
#import "PostPicCell.h"
#import "PostArticleCell.h"
@interface PostDeatilVC : YCCViewController<UITextFieldDelegate,PostInfoCellDelegate,PostNameCellDelegate,UIActionSheetDelegate,PostPicCellDelegate,PostArticleCellDelegate>
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)IBOutlet UIView *CommentBG;
@property(nonatomic,retain)IBOutlet UITextField *textFieldComment;
@property(nonatomic,retain)UIActionSheet *m_actionSheet;
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)WebImageViewNormal *bigImg;
@property(nonatomic,retain)PostPicCell *picCell;
@property(nonatomic,retain)VIPhotoView *bigView;
@property(nonatomic,retain)IBOutlet MyButton *btnComment;
@property(nonatomic,retain)IBOutlet UIView *commentLineView;
@property(nonatomic,retain)NSString *commentType;//1评论 2回复 3@用户
@property(nonatomic,retain)NSString *replyAccount;
@property(nonatomic,retain)NSString *replyNickname;
-(void)createScreenView;
@end
