//
//  PayVC.m
//  yocheche
//
//  Created by carcool on 8/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PayVC.h"
#import "PaySuccessVC.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation Product


@end
@interface PayVC ()

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"支付定金";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    
    [self updateData];
    
    [self generateData];
}
-(void)updateData
{
    //get my balance
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    [req setParams:@[@"balance.user.get",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"method",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.dataBalance=req.m_data;
            self.dataCoupon=[[MyFounctions getUserInfo] objectForKey:@"coupon"];
            [self updateView];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];

    
}
-(void)updateView
{
    self.labelBalance.text=[NSString stringWithFormat:@"¥%.1f",[[self.dataBalance objectForKey:@"balance"] floatValue]];
    if ([self.inviteCode isEqualToString:@""])
    {
        self.labelNeedPay.text=[NSString stringWithFormat:@"¥%.1f",[[self.dataCoupon objectForKey:@"pay"] floatValue]];
        self.labelCoupon.text=[NSString stringWithFormat:@"      定金为付¥%d抵¥%d",[[self.dataCoupon objectForKey:@"pay"] integerValue],[[self.dataCoupon objectForKey:@"deduction"] integerValue]];
    }
    else
    {
        self.labelNeedPay.text=[NSString stringWithFormat:@"¥%.1f",[[self.dataCoupon objectForKey:@"pay"] floatValue]-[[self.dataCoupon objectForKey:@"invite"] floatValue]];
         self.labelCoupon.text=[NSString stringWithFormat:@"      定金为付¥%d抵¥%d，由于你已获得¥%d的好友邀请优惠，定金只需支付¥%d。",[[self.dataCoupon objectForKey:@"pay"] integerValue],[[self.dataCoupon objectForKey:@"deduction"] integerValue],[[self.dataCoupon objectForKey:@"invite"] integerValue],[[self.dataCoupon objectForKey:@"pay"] integerValue]-[[self.dataCoupon objectForKey:@"invite"] integerValue]];
    }
    
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



#pragma mark -
#pragma mark   ==============产生订单信息==============

- (void)generateData{
        self.m_product = [[Product alloc] init];
        self.m_product.subject = @"商品标题";
        self.m_product.body =@"body";
        
        self.m_product.price = 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)payWithAlipay
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */

    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088021386948283";
    NSString *seller = @"registration@yocheche.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMvvX4t4N6l1wUjk8cOkZQjx0XvNirwnqG9vDWQbXv23l//Juxu29/LKrIoXOY+8Pc+E7sC8urTtglJxHXu5JMc673DzmMleaV8QCLBNxvM8AKgJnZkWdnmz7IIMShhwRQmy7EumbmmfZAQXujLGZIn40K/dbEBH7ryUlF1+UDmpAgMBAAECgYAO7iFyloSMtYBHE+vXROvYscuCYtPrXoPoVJsIXzCfJpfMNDqslsKkVc439edS7Jch4DuShL6ujEzkOD/OVQmqIuJd8KBSYXGMVN4TRdtGhFMYyuWZ8H+S8pgE4W0ikRk71wzXpRGLig0RTevqe8fb0fqta9aWcaTyp0Bk8jJ/WQJBAOh+4X9hhgc+y7DHyjmOcQr60SlxX+ldNjSPYQbUKOcLOu76dFFSLWsx7bpl26+N7CGtjJxa1NLUzgXC4q8d3acCQQDgjVQR0HJOUCZl2Q+zMOmCW3gCg0FH6L1aSI/RK+Dndl6YzAdAIaUfWsdYdlwDnLGXMNQnWaXsOS6uPf6Q6DgvAkBxEFsbNlMWrOwjwVVP3jyNKWKUc+U/uKvGrb9ysbRef7CeTUBJ19vsmHBSyHwoiK0/x4Vs+CMtkH3MgXT50l1bAkEAugo9Ybj6Swm6ll0c1dArVpYjuqk2N7aK0rcVeC5LWllGjH9Vbnuxi2WxjQgaud9jfyi0TJnIjwrdMv0n4LSUfwJAaT84PW52txe2HA2oGwkwX8wnVhI2bSI5v00Sz5rkdW/JD6mNDRgqoB2/TVSyso6MLnUnxOdOUKgDIzOzWts69Q==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = self.m_product.subject; //商品标题
    order.productDescription = self.m_product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",self.m_product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aliyocheche";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil)
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        appdelegate.handleURLtype=21;
        
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
    }

}
-(IBAction)payBtnPressed:(id)sender
{
    [self payWithAlipay];
    
//    NSLog(@"user :%@",[MyFounctions getUserInfo]);
//    //creat order
//    [self showLoadingWithBG];
//    Http *req=[[Http alloc] init];
//    NSMutableDictionary *user=(NSMutableDictionary*)[MyFounctions getUserInfo];
//    [req setParams:@[@"order.user.pay",[user objectForKey:@"account"],self.orderID] forKeys:@[@"method",@"account",@"orderid"]];
//    [req startWithBlock:^{
//        [self stopLoadingWithBG];
//        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//        {
//            PaySuccessVC *vc=[[PaySuccessVC alloc] init];
//            vc.data=req.m_data;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        else
//        {
//            if ([req.m_data valueForKey:@"msg"])
//            {
//                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
//            }
//            else
//            {
//                [self showNetworkError];
//            }
//            
//        }
//        
//    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
