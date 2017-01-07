//
//  ConversationListController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "ConversationListController.h"

#import "ChatViewController.h"
#import "EMSearchBar.h"
#import "EMSearchDisplayController.h"
//#import "RobotManager.h"
//#import "RobotChatViewController.h"
#import "UserProfileManager.h"
#import "RealtimeSearchUtil.h"
#import "ChooseReleaseTypeVC.h"
@implementation EMConversation (search)

//根据用户昵称,环信机器人名称,群名称进行搜索
- (NSString*)showName
{
//    if (self.conversationType == eConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:self.chatter]) {
//            return [[RobotManager sharedInstance] getRobotNickWithUsername:self.chatter];
//        }
//        return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.chatter];
//    } else if (self.conversationType == eConversationTypeGroupChat) {
//        if ([self.ext objectForKey:@"groupSubject"] || [self.ext objectForKey:@"isPublic"]) {
//            return [self.ext objectForKey:@"groupSubject"];
//        }
//    }
    return self.chatter;
}

@end

@interface ConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource,UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIView *networkStateView;
@property (nonatomic, strong) EMSearchBar           *searchBar;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"聊天";
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    [bgView setBackgroundColor:YCC_BlackColor];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithUIView:bgView] forBarMetrics:UIBarMetricsDefault];
    //yocheche
    self.navigationController.navigationBar.hidden=YES;
    [self createNaviView];
    //yocheche end
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    // Do any additional setup after loading the view.
    self.haveShowedView=NO;
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    [self tableViewDidTriggerHeaderRefresh];
    
//    [self.view addSubview:self.searchBar];

    self.tableView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44 -49);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self networkStateView];
    
    [self searchController];
    [self removeEmptyConversationsFromDB];
    [self updateData];
}
//view to image
- (UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
-(void)createNaviView
{
    self.naviView=[[[NSBundle mainBundle] loadNibNamed:@"ConversationListNaviView" owner:nil options:nil] objectAtIndex:0];
    self.naviView.delegate=self;
    [self.naviView setFrame:CGRectMake(0, 0, Screen_Width, 64)];
    [self.view addSubview:self.naviView];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.haveShowedView==NO)
    {
        self.haveShowedView=YES;
    }
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];
    self.navigationController.navigationBar.hidden=YES;
    [self tableViewDidTriggerHeaderRefresh];
}
-(void)viewDidAppear:(BOOL)animated
{
}
-(void)updateData
{
    if (self.haveShowedView==NO)
    {
        return;
    }
    //yocheche
    NSLog(@"self.dataArray :%@",self.dataArray);
    NSMutableString *chatterID= [NSMutableString stringWithString:@""];
    for (EaseConversationModel *model in self.dataArray)
    {
        if ([chatterID isEqualToString:@""])
        {
            [chatterID appendString:model.chatterID];
        }
        else
        {
            [chatterID appendString:[NSString stringWithFormat:@",%@",model.chatterID]];
        }
    }
    NSLog(@"chatterID :%@",chatterID);
    [self getUserAvatarAndNickName:chatterID];
    //yochecheend
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0+64, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _searchController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
        
        __weak ConversationListController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
            EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            id<IConversationModel> model = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.model = model;
            
            cell.detailLabel.text = [weakSelf conversationListViewController:weakSelf latestMessageTitleForConversationModel:model];
            cell.detailLabel.attributedText = [EaseEmotionEscape attStringFromTextForChatting:cell.detailLabel.text];
            cell.timeLabel.text = [weakSelf conversationListViewController:weakSelf latestMessageTimeForConversationModel:model];
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return [EaseConversationCell cellHeightWithModel:nil];
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [weakSelf.searchController.searchBar endEditing:YES];
            id<IConversationModel> model = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            EMConversation *conversation = model.conversation;
            ChatViewController *chatController;
                chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
                chatController.title = [conversation showName];
            [weakSelf.navigationController pushViewController:chatController animated:YES];
        }];
    }
    
    return _searchController;
}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel)
    {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation)
        {
            AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.tabBarController hideTabBar];
            self.navigationController.navigationBar.hidden=NO;
                ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
                chatVC.title = conversationModel.title;
            chatVC.accountMy=[[MyFounctions getUserInfo] objectForKey:@"account"];
            chatVC.accountOther=conversationModel.accountOther;
            chatVC.idMy=[[MyFounctions getUserInfo] objectForKey:@"chatAccount"];
            chatVC.idOther=conversation.chatter;
            chatVC.avatarURl=[[MyFounctions getUserInfo] objectForKey:@"avatar"];
            chatVC.avatarURlOther=conversationModel.avatarURLPath;
            chatVC.nameMy=[[MyFounctions getUserInfo] objectForKey:@"nickName"];
            chatVC.nameOther=conversationModel.title;
            [self.navigationController pushViewController:chatVC animated:YES];
        }
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    NSLog(@"self.dataArray :%@",self.dataArray);
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.conversationType == eConversationTypeChat)
    {
    }
    else if (model.conversation.conversationType == eConversationTypeGroupChat)
    {
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"groupSubject"] || ![conversation.ext objectForKey:@"isPublic"])
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    model.title = group.groupSubject;
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    model.avatarImage = [UIImage imageNamed:imageName];
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        else
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    NSString *groupSubject = [ext objectForKey:@"groupSubject"];
                    NSString *conversationSubject = [conversation.ext objectForKey:@"groupSubject"];
                    if (groupSubject && conversationSubject && ![groupSubject isEqualToString:conversationSubject]) {
                        conversation.ext = ext;
                    }
                    break;
                }
            }
            model.title = [conversation.ext objectForKey:@"groupSubject"];
            imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
            model.avatarImage = [UIImage imageNamed:imageName];
        }
    }
    model.chatterID=model.title;
    model.accountOther=model.accountOther;
    return model;
}
#pragma mark ---------------- get user avatar and nickname -------------
-(void)getUserAvatarAndNickName:(NSString*)chatterID
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"chat/getUserChatList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],chatterID] forKeys:@[@"account",@"chatusers"]];
    [req startWithBlock:^{
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSArray *aryData=[req.m_data objectForKey:@"users"];
            for (EaseConversationModel *model in self.dataArray)
            {
                for (NSDictionary *dic in aryData)
                {
                    if ([model.chatterID isEqualToString:[dic objectForKey:@"chatAccount"]])
                    {
                        model.title=[dic objectForKey:@"nickname"];
                        model.avatarURLPath=[dic objectForKey:@"headImgUrl"];
                        model.accountOther=[dic objectForKey:@"account"];
                        break;
                    }
                }
            }
            [self.tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                
            }
            else
            {
            }
            
        }
        
    }];
    
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case eMessageBodyType_File: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    return latestMessageTime;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataArray searchText:(NSString *)searchText collationStringSelector:@selector(title) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.searchController.resultsSource removeAllObjects];
                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
                [weakSelf.searchController.searchResultsTableView reloadData];
            });
        }
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark ------- refresh delegate -------
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload
{
    [super tableViewDidFinishTriggerHeader:YES reload:YES];
    [self updateData];
}
#pragma mark - public

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
}

- (void)didFinishedReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
}
-(void)didReceiveMessage:(EMMessage *)message
{
    NSLog(@"ok");
}
#pragma mark -------- event response -------
-(void)showReleasePostVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    self.navigationController.navigationBar.hidden=NO;
    
    ChooseReleaseTypeVC *vc=[[ChooseReleaseTypeVC alloc] init];
    [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}
@end
