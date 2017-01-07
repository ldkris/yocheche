//
//  PayGuaranteeVC.m
//  yocheche
//
//  Created by carcool on 5/5/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "PayGuaranteeVC.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
//weichatsdk
#import "WXApi.h"
#import "PayGuaranteeSuccessVC.h"
#import "WebViewVC.h"
@interface PayGuaranteeVC ()

@end

@implementation PayGuaranteeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"支付";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnAliPay setColor:YCC_Green];
    [self.btnWeiPay setColor:YCC_Green];
    [self.bottomBG setFrame:CGRectMake(0, Screen_Height-80, Screen_Width, 80)];
    [self.view addSubview:self.bottomBG];
    
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPaySuccessVC) name:@"paySuccess" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paySuccess" object:nil];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getPayInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"account"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
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
    self.labelPrice.text=[NSString stringWithFormat:@"%.2f",[[self.data objectForKey:@"fee"] floatValue]];
    self.labelNote.text=[NSString stringWithFormat:@"平台将学费的%.2f元作为教学质量保证金，保证学员在学车过程中的良好体验。",[[self.data objectForKey:@"fee"] floatValue]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)weiPayBtnPressed:(id)sender
{
    self.payFrom=@"3";
    [self getPayData];
}
-(IBAction)aliPayBtnPressed:(id)sender
{
    self.payFrom=@"2";
    [self getPayData];
}
-(IBAction)showStudyProtocol:(id)sender
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=@"学车服务协议";
    vc.urlStr=[self.data objectForKey:@"protocolUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ========= pay data =================
-(void)getPayData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/putPayInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.coachId,self.did,self.payFrom,@"2"] forKeys:@[@"account",@"coachid",@"did",@"payType",@"source"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.payData=req.m_data;
            if ([self.payFrom integerValue]==2)//alipay
            {
                [self generateData];
                [self payWithAlipay];
            }
            else if ([self.payFrom integerValue]==3)//weipay
            {
                [self getWeipayData];
            }
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
    self.m_product.subject = [self.payData objectForKey:@"pname"];
    self.m_product.body =[self.payData objectForKey:@"pdesc"];
    
    self.m_product.price =[[self.data objectForKey:@"fee"] doubleValue];
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
    order.tradeNO = [self.payData objectForKey:@"orderNo"]; //订单ID（由商家自行制定）
    order.productName = self.m_product.subject; //商品标题
    order.productDescription = self.m_product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",self.m_product.price]; //商品价格
    order.notifyURL =  [self.payData objectForKey:@"notifyUrl"]; //回调URL
    
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
            if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000)
            {
                PayGuaranteeSuccessVC *vc=[[PayGuaranteeSuccessVC alloc] init];
                vc.did=self.did;
                vc.orderNo=[self.payData objectForKey:@"orderNo"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
    }
    
}
#pragma mark ========= weipay =================
-(void)getWeipayData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grab/getWxCallPayInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.payData objectForKey:@"orderNo"],@"1"] forKeys:@[@"account",@"orderNo",@"function"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
            appdelegate.handleURLtype=1;
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = [req.m_data objectForKey:@"partnerid"];
            request.prepayId= [req.m_data objectForKey:@"prepayid"];
            request.package = [req.m_data objectForKey:@"packagestr"];
            request.nonceStr= [req.m_data objectForKey:@"noncestr"];
            request.timeStamp=(UInt32)[[req.m_data objectForKey:@"timestamp"] doubleValue];
            request.sign= [req.m_data objectForKey:@"sign"];
            if([WXApi sendReq:request])
            {
                NSLog(@"send yes");
            }
            else
            {
                NSLog(@"send no");
            }
            
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

-(void)showPaySuccessVC
{
    PayGuaranteeSuccessVC *vc=[[PayGuaranteeSuccessVC alloc] init];
    vc.did=self.did;
    vc.orderNo=[self.payData objectForKey:@"orderNo"];
    [self.navigationController pushViewController:vc animated:YES];
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
