//
//  SlidePostVC.h
//  yocheche
//
//  Created by carcool on 9/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface SlidePostVC : YCCViewController<UIActionSheetDelegate>
@property(nonatomic,retain)SlideView *m_searchView;
@property(nonatomic,retain)UIActionSheet *m_actionSheet;
@property(nonatomic,retain)NSString *searchSex;
@property(nonatomic,retain)IBOutlet MyButton *btnUnlimited;
@property(nonatomic,retain)IBOutlet MyButton *btnBoy;
@property(nonatomic,retain)IBOutlet MyButton *btnGirl;
@property(nonatomic,retain)IBOutlet UIView *chooseSexBG;
@property(nonatomic,retain)UIView *screenBlackBG;
-(void)showChooseSex;
-(void)updateSlideViewDataLat:(NSString*)latitude Lng:(NSString*)longitude PageIndex:(NSString*)pageIndex PageSize:(NSString*)pageSize Type:(NSString*)type;
-(void)showSelectSearchSexActionSheet;
-(void)likePostOperateInvitationId:(NSString*)invitationId type:(NSString*)liketype;
-(void)showOtherCenterVC:(NSDictionary *)preData;
-(void)showPostVC:(NSDictionary*)preData;
@end
