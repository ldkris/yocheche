//
//  PayGuaranteeVC.h
//  yocheche
//
//  Created by carcool on 5/5/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
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

@interface PayGuaranteeVC : YCCViewController<WXApiDelegate>
@property(nonatomic,retain)IBOutlet UIView *bottomBG;
@property(nonatomic,assign)IBOutlet MyButton *btnWeiPay;
@property(nonatomic,assign)IBOutlet MyButton *btnAliPay;
@property(nonatomic,assign)IBOutlet UILabel *labelPrice;
@property(nonatomic,assign)IBOutlet UILabel *labelNote;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSString *did;//订单id
@property(nonatomic,retain)NSString *coachId;
@property(nonatomic,retain)NSString *payFrom;//2:alipay 3:weipay
@property(nonatomic,retain)NSString *source;
@property(nonatomic,retain)NSDictionary *payData;//alipay data
@property(nonatomic,retain)NSDictionary *weipayData;//weipay data
//ali pay
@property(nonatomic,retain)NSString *orderID;
@property(nonatomic,retain)Product *m_product;
@property(nonatomic,retain)NSString *payType;
@end
