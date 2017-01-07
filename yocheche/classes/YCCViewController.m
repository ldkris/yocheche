//
//  JERViewController.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface YCCViewController ()


@end

@implementation YCCViewController

@synthesize leftNaviBtn,rightNaviBtn,bg,m_tableView,currentRequest;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
//    [bg setImage:[UIImage imageNamed:@"bg"]];
    [self.bg setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]];
    [self.view insertSubview:self.bg atIndex:0];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.pageCount=10;
    self.pageIndex=1;
    self.totalRowCount=0;

}
- (void)dealloc
{
    if (self.refreshHeader)
    {
        [self.refreshHeader removeFromSuperview];
    }
    if (self.refreshFooter)
    {
         [self.refreshFooter removeFromSuperview];
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setMiddleNaviView:(UIView*)midView
{
    [midView setFrame:CGRectMake((Screen_Width-PARENT_WIDTH(midView))/2.0, 0, PARENT_WIDTH(midView), 44)];
    [self.navigationController.navigationBar addSubview:midView];
}
-(void)setLeftNaviBtnImage:(UIImage *)img
{
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNaviBtn.frame=CGRectMake(0, 0, 44, 44);
    [self.leftNaviBtn setImage:img forState:UIControlStateNormal];
    [self.leftNaviBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 32)];
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
}
-(void)setRightNaviBtnImage:(UIImage *)img
{
    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightNaviBtn setFrame:CGRectMake(0, 0, 44, 44)];
    self.rightNaviBtn.backgroundColor=[UIColor clearColor];
    
    UIImageView *imageview=[[UIImageView alloc] initWithImage:img];
    [self.rightNaviBtn setImage:img forState:UIControlStateNormal];
    [self.rightNaviBtn setImageEdgeInsets:UIEdgeInsetsMake((44-PARENT_HEIGHT(imageview))/2.0, 44-PARENT_WIDTH(imageview), (44-PARENT_HEIGHT(imageview))/2.0, 0)];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.rightNaviBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
}
-(void)setLeftNaviBtnTitle:(NSString *)str
{
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNaviBtn.frame=CGRectMake(0, 0, 44, 44);
    [self.leftNaviBtn setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.leftNaviBtn setTitle:str forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem=leftButton;
}
-(void)setRightNaviBtnTitle:(NSString *)str
{
    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNaviBtn.frame=CGRectMake(0, 0, 60, 44);
    [self.rightNaviBtn setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.rightNaviBtn setTitle:str forState:UIControlStateNormal];
    self.rightNaviBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.rightNaviBtn.backgroundColor=[UIColor clearColor];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.rightNaviBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
}
-(void)setRightNaviBtnTitleWithTwoWords:(NSString *)str
{
    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNaviBtn.frame=CGRectMake(0, 0, 44, 44);
    //    [self.leftNaviBtn setBackgroundImage:[UIImage imageNamed:@"home_edit.png"] forState:UIControlStateNormal];
    [self.rightNaviBtn setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.rightNaviBtn setTitle:str forState:UIControlStateNormal];
    self.rightNaviBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightNaviBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    self.rightNaviBtn.backgroundColor=[UIColor clearColor];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.rightNaviBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
}
-(void)addNotifyViewAtRight
{
    self.notifyRight=[[UIView alloc] initWithFrame:CGRectMake(60, 10, 6, 6)];
    [self.notifyRight setBackgroundColor:[UIColor redColor]];
    [self.notifyRight.layer setCornerRadius:3.0];
    [self.rightNaviBtn addSubview:self.notifyRight];
}
-(void)addNotifyLabelAtRightForFourWords
{
    self.labelNaviNum=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 11, 11)];
    [self.labelNaviNum setBackgroundColor:[UIColor redColor]];
    [self.labelNaviNum setClipsToBounds:YES];
    [self.labelNaviNum.layer setCornerRadius:5.5];
    [self.rightNaviBtn addSubview:self.labelNaviNum];
    self.labelNaviNum.text=@"22";
    [self.labelNaviNum setTextAlignment:NSTextAlignmentCenter];
    [self.labelNaviNum setTextColor:[UIColor whiteColor]];
    [self.labelNaviNum setFont:[UIFont systemFontOfSize:8.0]];
    self.labelNaviNum.hidden=YES;
}
-(void)popSelfViewContriller
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----- tableview
-(void)addTableView
{
    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-[UINavigationBar appearance].frame.size.height)];
    [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.view addSubview:m_tableView];
}
-(void)addTableViewWithStyle:(UITableViewStyle)style
{
    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-[UINavigationBar appearance].frame.size.height) style:style];
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.view addSubview:m_tableView];
    
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------- refresh view
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.m_tableView];
    
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
    _refreshHeader = refreshHeader;
//    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
//    refreshHeader.beginRefreshingOperation = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.totalRowCount = self.pageCount;
//            [self.m_tableView reloadData];
//            [weakRefreshHeader endRefreshing];
//        });
//    };
    
    // 进入页面自动加载一次数据
//    [refreshHeader beginRefreshing];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.m_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

-(void)headerRefresh
{
    
}
- (void)footerRefresh
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.totalRowCount += self.pageCount;
//        [self.m_tableView reloadData];
//        [self.refreshFooter endRefreshing];
//    });
}


#pragma mark -------- show alert view
-(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)msg cancelButton:(NSString*)cancel others:(NSString*)others
{
    //    if (self.blackBG==nil)
    //    {
    //        self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    //        [self.blackBG setBackgroundColor:[UIColor blackColor]];
    //        self.blackBG.alpha=0.4;
    //    }
    if (self.alertView==nil)
    {
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:others, nil];
        self.alertView.delegate=self;
    }
    else
    {
        self.alertView=nil;
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:others, nil];
        self.alertView.delegate=self;
    }
    
    
    //    [self.view addSubview:self.blackBG];
    [self.view addSubview:self.alertView];
    [self.alertView show];
}
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //    [self.blackBG removeFromSuperview];
    [self.alertView removeFromSuperview];
}
#pragma mark -------- loading waiting
-(void)showLoadingWithBG
{
    self.m_MessageBG=[[UIView alloc] initWithFrame:CGRectMake((Screen_Width-120)/2.0, (Screen_Height-120)/2.0, 120, 120)];
    [self.m_MessageBG setBackgroundColor:[UIColor darkGrayColor]];
    [self.m_MessageBG setClipsToBounds:YES];
    [self.m_MessageBG.layer setCornerRadius:7.0];
    [self.view addSubview:self.m_MessageBG];
    
    self.m_activitiIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.m_activitiIndicatorView setFrame:CGRectMake((120-60)/2.0, 30, 60, 60)];
    [self.m_activitiIndicatorView setBackgroundColor:[UIColor clearColor]];
    self.m_activitiIndicatorView.alpha=1;
    [self.m_activitiIndicatorView startAnimating];
    [self.m_MessageBG addSubview:self.m_activitiIndicatorView];
    
}
-(void)stopLoadingWithBG
{
    [self.m_activitiIndicatorView stopAnimating];
    [self.m_MessageBG removeFromSuperview];
    self.m_activitiIndicatorView=nil;
    self.m_MessageBG=nil;
}
-(void)startLoading
{
    self.m_activitiIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.m_activitiIndicatorView setFrame:CGRectMake((Screen_Width-60)/2.0, 300, 60, 60)];
    [self.m_activitiIndicatorView setBackgroundColor:[UIColor clearColor]];
    self.m_activitiIndicatorView.alpha=1;
    [self.view addSubview:self.m_activitiIndicatorView];
    [self.m_activitiIndicatorView startAnimating];
    
}
-(void)startLoadingGray
{
    self.m_activitiIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.m_activitiIndicatorView setFrame:CGRectMake((Screen_Width-60)/2.0, 300, 60, 60)];
    [self.m_activitiIndicatorView setBackgroundColor:[UIColor clearColor]];
    self.m_activitiIndicatorView.alpha=1;
    [self.view addSubview:self.m_activitiIndicatorView];
    [self.m_activitiIndicatorView startAnimating];
    
}
-(void)stopLoading
{
    [self.m_activitiIndicatorView stopAnimating];
    [self.m_activitiIndicatorView removeFromSuperview];
    self.m_activitiIndicatorView=nil;
}
-(void)startLoadingWithMyMessage:(NSString *)message
{
    self.m_MessageBG=[[UIView alloc] initWithFrame:CGRectMake((Screen_Width-200)/2.0, (Screen_Height-120)/2.0, 200, 120)];
    [self.m_MessageBG setBackgroundColor:[UIColor lightGrayColor]];
    [self.m_MessageBG setClipsToBounds:YES];
    [self.m_MessageBG.layer setCornerRadius:5.0];
    [self.view addSubview:self.m_MessageBG];
    
    self.m_activitiIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.m_activitiIndicatorView setFrame:CGRectMake((200-60)/2.0, 10, 60, 60)];
    [self.m_activitiIndicatorView setBackgroundColor:[UIColor clearColor]];
    self.m_activitiIndicatorView.alpha=1;
    [self.m_activitiIndicatorView startAnimating];
    [self.m_MessageBG addSubview:self.m_activitiIndicatorView];
    
    UILabel *labelMessage=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 200, 30)];
    [labelMessage setFont:[UIFont systemFontOfSize:14]];
    [labelMessage setTextColor:[UIColor blackColor]];
    [labelMessage setTextAlignment:NSTextAlignmentCenter];
    labelMessage.text=message;
    [self.m_MessageBG addSubview:labelMessage];
}
-(void)startLoadingWithMyMessageOnWindow:(NSString *)message
{
    self.m_MessageBG=[[UIView alloc] initWithFrame:CGRectMake((Screen_Width-200)/2.0, (Screen_Height-120)/2.0, 200, 120)];
    [self.m_MessageBG setBackgroundColor:[UIColor whiteColor]];
    [self.m_MessageBG setClipsToBounds:YES];
    [self.m_MessageBG.layer setCornerRadius:5.0];
    [[UIApplication sharedApplication].keyWindow addSubview:self.m_MessageBG];
    //    [self.view addSubview:self.m_MessageBG];
    
    self.m_activitiIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.m_activitiIndicatorView setFrame:CGRectMake((200-60)/2.0, 10, 60, 60)];
    [self.m_activitiIndicatorView setBackgroundColor:[UIColor clearColor]];
    self.m_activitiIndicatorView.alpha=1;
    [self.m_activitiIndicatorView startAnimating];
    [self.m_MessageBG addSubview:self.m_activitiIndicatorView];
    
    UILabel *labelMessage=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, 200, 30)];
    [labelMessage setFont:[UIFont systemFontOfSize:14]];
    [labelMessage setTextColor:[UIColor blackColor]];
    [labelMessage setTextAlignment:NSTextAlignmentCenter];
    labelMessage.text=message;
    [self.m_MessageBG addSubview:labelMessage];
}

-(void)stopLoadingWithMyMessage
{
    [self.m_activitiIndicatorView stopAnimating];
    [self.m_MessageBG removeFromSuperview];
    self.m_MessageBG=nil;
}
-(void)showMessage:(NSString *)str
{
    UILabel *myLabel=[[UILabel alloc] init];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont: [UIFont systemFontOfSize:15]];
    myLabel.text=str;
    [myLabel setFrame:CGRectMake(20, 20, [MyFounctions calculateTextWidth:str fontsize:15], 30)];
    UIImageView *m_imageview=[[UIImageView alloc] initWithFrame:CGRectMake((320-myLabel.frame.size.width-40)/2.0, 250, myLabel.frame.size.width+40, myLabel.frame.size.height+40)];
    [m_imageview setClipsToBounds:YES];
    [m_imageview.layer setCornerRadius:3.0];
    [m_imageview setBackgroundColor: [UIColor blackColor]];
    [m_imageview setAlpha:0.4];
    
    [self.view addSubview:m_imageview];
    [m_imageview addSubview:myLabel];
    
    [UIView animateWithDuration:0.3 delay:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        m_imageview.alpha=0;
        myLabel.alpha=0;
    } completion:^(BOOL finished) {
        [m_imageview removeFromSuperview];
        [myLabel removeFromSuperview];
    }];
    
}
-(void)showMessage:(NSString *)str seconds:(float)seconds
{
    UILabel *myLabel=[[UILabel alloc] init];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont: [UIFont systemFontOfSize:15]];
    myLabel.text=str;
    [myLabel setFrame:CGRectMake(20, 20, [MyFounctions calculateTextWidth:str fontsize:15], 30)];
    UIImageView *m_imageview=[[UIImageView alloc] initWithFrame:CGRectMake((320-myLabel.frame.size.width-40)/2.0, 300, myLabel.frame.size.width+40, myLabel.frame.size.height+40)];
    [m_imageview setClipsToBounds:YES];
    [m_imageview.layer setCornerRadius:3.0];
    [m_imageview setBackgroundColor: [UIColor blackColor]];
    [m_imageview setAlpha:0.4];
    
    [myLabel setFrame:CGRectMake((320-myLabel.frame.size.width)/2.0, 300+20, PARENT_WIDTH(myLabel), PARENT_HEIGHT(myLabel))];
    [self.view addSubview:m_imageview];
    [self.view addSubview:myLabel];
    
    [UIView animateWithDuration:0.3 delay:seconds options:UIViewAnimationOptionLayoutSubviews animations:^{
        m_imageview.alpha=0;
        myLabel.alpha=0;
    } completion:^(BOOL finished) {
        [m_imageview removeFromSuperview];
        [myLabel removeFromSuperview];
    }];
    
}

//add black bg
-(void)addBlackBGView
{
    if (self.blackBG==nil)
    {
        self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [self.blackBG setBackgroundColor:[UIColor blackColor]];
        self.blackBG.alpha=0.4;
    }
    [self.view addSubview:self.blackBG];
}
//add black bg
-(void)addBlackBGViewOnKeywindow
{
    if (self.blackBG==nil)
    {
        self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [self.blackBG setBackgroundColor:[UIColor blackColor]];
        self.blackBG.alpha=0.4;
    }
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.blackBG];
    
}
-(void)removeBLackBGView
{
    [self.blackBG removeFromSuperview];
    self.blackBG=nil;
}
#pragma mark -------network is not connected
-(void)showNetworkError
{
    [self showAlertViewWithTitle:nil message:@"请检查你的网络是否已连接" cancelButton:@"确定" others:nil];
}
//set line view thin
-(void)setLineViewMoreThin:(UIView*)line
{
    if (line.frame.size.height==1.0)
    {
        [line setFrame:CGRectMake(PARENT_X(line), PARENT_Y(line), PARENT_WIDTH(line), 0.5)];
    }
    else if (line.frame.size.width==1.0)
    {
        [line setFrame:CGRectMake(PARENT_X(line), PARENT_Y(line), 0.5, PARENT_HEIGHT(line))];
    }
    
}
@end
