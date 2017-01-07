//
//  TestPageView.h
//  weixueche
//
//  Created by carcool on 12/10/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestVC.h"
#import <AVFoundation/AVFoundation.h>
#import "TestImageCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TestMovieCell.h"
#import "TestResultCell.h"
#import "ExplainCell.h"
#import "TKRoundedView.h"
@interface TestPageView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UITableView *m_tableView;
@property(nonatomic,assign)TestVC *delegate;
@property(nonatomic,retain)NSDictionary *testDictionary;
@property(nonatomic,assign)NSInteger haveMediaFlag;
@property(nonatomic,assign)NSInteger MediaType;//0:img 1:movie
@property(nonatomic,assign)NSInteger mutableSelectFlag;
@property(nonatomic,assign)NSInteger answerIndex;//single select
@property(nonatomic,retain)NSMutableArray *answerIndexArray;//mutableselect 0,1,2,3
@property(nonatomic,retain)NSMutableArray *m_arySelectCells;
@property(nonatomic,assign)NSInteger haveShowAnswer;
@property(nonatomic,assign)NSInteger shouldShowAnswer;
@property(nonatomic,retain)AVPlayer *player;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,retain)TestImageCell *imagecell;
@property(nonatomic,retain)WebImageView *m_imageView;
@property(nonatomic,retain)UIView *blackBG;
@property(nonatomic,retain)UIImageView *largeImageView;
@property(nonatomic,retain)UIButton *btnDissmissLargeImage;
@property(nonatomic,retain)TestMovieCell *moviecell;
@property(nonatomic,retain)TestResultCell *resultcell;
@property(nonatomic,retain)ExplainCell *explainCell;
@property(nonatomic,retain)MPMoviePlayerViewController *moviePlayerView;
@property(nonatomic,assign)float questionHeight;
@property(nonatomic,retain)TKRoundedView *questionCellView;
@property(nonatomic,assign)float explainHeight;
-(void)updateViews;
-(void)showCurrentPageAnswer:(NSInteger)indexSelected;
-(void)showCurrentPageAnswer;
-(void)hideCurrentPageAnswer;
-(void)selectDoneForMutableSelect;
@end
