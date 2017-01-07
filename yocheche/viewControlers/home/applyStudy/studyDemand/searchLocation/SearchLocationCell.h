//
//  SearchLocationCell.h
//  yocheche
//
//  Created by carcool on 3/17/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchLocationVC;
@interface SearchLocationCell : UITableViewCell
@property(nonatomic,assign)SearchLocationVC *delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UILabel *labelAddress;
@property(nonatomic,assign)IBOutlet UILabel *labelArea;
@property(nonatomic,assign)IBOutlet UIImageView *imgSelect;
@property(nonatomic,assign)NSInteger index;
-(void)updateView;
@end
