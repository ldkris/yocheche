//
//  WordReleaseCell.h
//  yocheche
//
//  Created by carcool on 1/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordReleaseVC;
@interface WordReleaseCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,assign)WordReleaseVC *delegate;
@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;

@property(nonatomic,retain)IBOutlet UITextView *textViewTag;
@property(nonatomic,retain)IBOutlet UILabel *labelTagDefault;
@property(nonatomic,retain)NSMutableArray *m_aryCategoryTags;
-(void)updateView;
@end
