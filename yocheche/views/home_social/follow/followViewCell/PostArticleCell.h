//
//  PostArticleCell.h
//  yocheche
//
//  Created by carcool on 3/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostArticleCell;
@protocol PostArticleCellDelegate <NSObject>
-(void)showArticleVC:(NSDictionary*)postdata;
@end

@interface PostArticleCell : UITableViewCell
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,assign)id<PostArticleCellDelegate> delegate;
@property(nonatomic,assign)IBOutlet UIView *articleBG;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *articlePic;
@property(nonatomic,assign)IBOutlet UILabel *labelTitle;
-(void)updateView;
@end
