//
//  NoteContentCell.h
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteContentCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *labelContent;
@property(nonatomic,retain)NSString *strNote;
@property(nonatomic,assign)float strHeight;
-(void)updateView;
@end
