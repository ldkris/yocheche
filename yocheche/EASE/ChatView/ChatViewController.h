//
//  ChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

@interface ChatViewController : EaseMessageViewController
@property(nonatomic,retain)NSString *avatarURl;
@property(nonatomic,retain)NSString *avatarURlOther;
@property(nonatomic,retain)NSString *idMy;
@property(nonatomic,retain)NSString *idOther;
@property(nonatomic,retain)NSString *accountMy;
@property(nonatomic,retain)NSString *accountOther;
@property(nonatomic,retain)NSString *nameMy;
@property(nonatomic,retain)NSString *nameOther;
@end
