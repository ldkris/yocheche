//
//  PayOrderVC.h
//  yocheche
//
//  Created by carcool on 9/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <Foundation/Foundation.h>
@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@end

@interface PayOrderVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)IBOutlet UIView *textfieldBG;
@property(nonatomic,retain)IBOutlet MyButton *btnSearch;
@property(nonatomic,retain)IBOutlet UIView *inviteSuccessBG;
@property(nonatomic,retain)IBOutlet UITextField *textfieldInviteCode;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *inviteAvatar;
@property(nonatomic,retain)IBOutlet UILabel *labelNameAndCode;
@property(nonatomic,retain)IBOutlet UILabel *labelBalance;
@property(nonatomic,retain)IBOutlet UILabel *labelPay;
@property(nonatomic,retain)IBOutlet UILabel *labelDescription;
@property(nonatomic,retain)IBOutlet UILabel *labelInviteDescription;
@property(nonatomic,retain)IBOutlet UIView *balancePayBG;
@property(nonatomic,retain)IBOutlet UIView *aliPayBG;
@property(nonatomic,retain)NSDictionary *successData;
//pay
@property(nonatomic,retain)NSString *orderID;
@property(nonatomic,retain)Product *m_product;
@property(nonatomic,retain)NSString *payType;
-(void)updateView;
@end
