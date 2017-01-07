//
//  PayVC.h
//  yocheche
//
//  Created by carcool on 8/7/15.
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

@interface PayVC : YCCViewController
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)NSDictionary *dataBalance;
@property(nonatomic,retain)NSDictionary *dataCoupon;
@property(nonatomic,retain)NSString *inviteCode;
@property(nonatomic,retain)NSString *orderID;
@property(nonatomic,retain)IBOutlet UILabel *labelBalance;
@property(nonatomic,retain)IBOutlet UILabel *labelNeedPay;
@property(nonatomic,retain)IBOutlet UILabel *labelAttention;
@property(nonatomic,retain)IBOutlet UILabel *labelCoupon;
@property(nonatomic,retain)Product *m_product;

@end
