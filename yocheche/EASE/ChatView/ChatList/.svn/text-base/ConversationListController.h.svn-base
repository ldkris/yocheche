//
//  ConversationListController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//
#import "ConversationListNaviView.h"
@interface ConversationListController : EaseConversationListViewController
@property(nonatomic,retain)ConversationListNaviView *naviView;
@property(nonatomic,assign)BOOL haveShowedView;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;
-(void)showReleasePostVC;
-(void)tableViewDidTriggerHeaderRefresh;
@end
