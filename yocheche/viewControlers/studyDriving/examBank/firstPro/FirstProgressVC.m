//
//  FirstProgressVC.m
//  weixueche
//
//  Created by carcool on 12/6/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "FirstProgressVC.h"
#import "TestVC.h"
#import "MyScoresVC.h"
#import "FirstProgressCell.h"
@interface FirstProgressVC ()

@end

@implementation FirstProgressVC
@synthesize m_logInfo,testVC,progressIndex;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"科目一·理论";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width,Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    self.m_tableView.scrollEnabled=NO;
    
    //bottom
    UIView *bottom=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    [bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottom];
    
    float btnWidth=Screen_Width/3.0;
    UIButton *scroebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [scroebtn setFrame:CGRectMake(0, 0, btnWidth, 49)];
    [scroebtn addTarget:self action:@selector(myScoreBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *score=[[UIImageView alloc] initWithFrame:CGRectMake((PARENT_WIDTH(scroebtn)-50)/2.0, (PARENT_HEIGHT(scroebtn)-17)/2.0, 50,17)];
    [score setImage:[UIImage imageNamed:@"myscore"]];
    [scroebtn addSubview:score];
    [bottom addSubview:scroebtn];
    
    UIButton *errortn=[UIButton buttonWithType:UIButtonTypeCustom];
    [errortn setFrame:CGRectMake(btnWidth, 0, btnWidth, 49)];
    [errortn addTarget:self action:@selector(myErrorBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *error=[[UIImageView alloc] initWithFrame:CGRectMake((PARENT_WIDTH(errortn)-50)/2.0, (PARENT_HEIGHT(errortn)-17)/2.0, 50,17)];
    [error setImage:[UIImage imageNamed:@"myerror"]];
    [errortn addSubview:error];
    [bottom addSubview:errortn];
    
    UIButton *savebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setFrame:CGRectMake(btnWidth*2, 0, btnWidth, 49)];
    [savebtn addTarget:self action:@selector(mySavedBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *save=[[UIImageView alloc] initWithFrame:CGRectMake((PARENT_WIDTH(savebtn)-50)/2.0, (PARENT_HEIGHT(savebtn)-17)/2.0, 50,17)];
    [save setImage:[UIImage imageNamed:@"mysave"]];
    [savebtn addSubview:save];
    [bottom addSubview:savebtn];
    
    //get test pro1 data
    if (self.progressIndex==1)
    {
        self.title=@"科目一·理论";
        NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString* savePath = [NSString stringWithFormat:@"%@/pro1",[array objectAtIndex: 0]];
        self.m_aryTestsPro1= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath] ;
        //get my log info
        if ([MyFounctions getLogInfo])
        {
            self.m_logInfo=[LogInfo initLogInfoWithObject:[MyFounctions getLogInfo]];
        }
        else
        {
            self.m_logInfo=[[LogInfo alloc] init];
            [MyFounctions saveLogInfo:[LogInfo returnToDictionary:self.m_logInfo]];
        }
    }
    else
    {
        self.title=@"科目四·理论";
        NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString* savePath = [NSString stringWithFormat:@"%@/pro4",[array objectAtIndex: 0]];
        self.m_aryTestsPro1= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath] ;
        //get my log info
        if ([MyFounctions getLogInfoPro4])
        {
            self.m_logInfo=[LogInfo initLogInfoWithObject:[MyFounctions getLogInfoPro4]];
        }
        else
        {
            self.m_logInfo=[[LogInfo alloc] init];
            [MyFounctions saveLogInfoPro4:[LogInfo returnToDictionary:self.m_logInfo]];
        }
    }
    
    
    //guide new show last test bank
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/lasttestbank",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]]])
    {
        [self showMessage:@"2015年最新考试题库" seconds:2.5];
        //save  data
        NSData *mydata=[[NSData alloc] init];
        NSArray *array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString *path = [NSString stringWithFormat:@"%@/lasttestbank",[array objectAtIndex: 0]];
        [mydata writeToFile:path atomically:NO];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.progressIndex==1)
    {
        //get my log info
        if ([MyFounctions getLogInfo])
        {
            self.m_logInfo=[LogInfo initLogInfoWithObject:[MyFounctions getLogInfo]];
        }
        else
        {
            self.m_logInfo=[[LogInfo alloc] init];
            [MyFounctions saveLogInfo:[LogInfo returnToDictionary:self.m_logInfo]];
        }
    }
    else
    {
        //get my log info
        if ([MyFounctions getLogInfoPro4])
        {
            self.m_logInfo=[LogInfo initLogInfoWithObject:[MyFounctions getLogInfoPro4]];
        }
        else
        {
            self.m_logInfo=[[LogInfo alloc] init];
            [MyFounctions saveLogInfoPro4:[LogInfo returnToDictionary:self.m_logInfo]];
        }
    }
    
    [MobClick beginLogPageView:@"FirstProgressVC"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"FirstProgressVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstProgressCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FirstProgressCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FirstProgressCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
#pragma mark ---------actions
-(void)testBtnPressed:(NSInteger)index
{
    self.testVC=[[TestVC alloc] init];
    self.testVC.delegateVC=self;
    if (index==0)
    {
        testVC.title=@"顺序练习";
//        NSLog(@"self.m_aryTestsPro1 :%@",self.m_aryTestsPro1);
        testVC.mytestmodel=[[TestModel alloc] init];
        [testVC.m_aryTests addObjectsFromArray:self.m_aryTestsPro1];
        testVC.mytestmodel.type=@"0";
        testVC.mytestmodel.pageCurrent=@"1";
        testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
        testVC.m_loginfo=self.m_logInfo;
        if (![self.m_logInfo.pro1Index isEqualToString:@"1"])
        {
            [self showAlertViewWithTitle:nil message:@"从上次退出考题位置开始做题？" cancelButton:@"重新开始" others:@"继续上次"];
            self.alertView.delegate=self;
            self.alertView.tag=0;//顺序练习
        }
        else
        {
            [self.navigationController pushViewController:testVC animated:YES];
        }
    }
    else if (index==1)
    {
        testVC.title=@"随机练习";
        testVC.mytestmodel=[[TestModel alloc] init];
        
        NSMutableArray *array=[NSMutableArray arrayWithArray:self.m_aryTestsPro1];
        srand(time(0));
        NSInteger indexRand=0;
        NSInteger i=0;
        while (i<self.m_aryTestsPro1.count)
        {
            indexRand=rand()%array.count;
            [testVC.m_aryTests addObject:[array objectAtIndex:indexRand]];
            [array removeObjectAtIndex:indexRand];
            i++;
        }
        
        testVC.mytestmodel.type=@"1";
        testVC.mytestmodel.pageCurrent=@"1";
        testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
        testVC.m_loginfo=self.m_logInfo;
        [self.navigationController pushViewController:testVC animated:YES];
    }
    else if (index==2)
    {
        [self showAlertViewWithTitle:@"满分100分 90分合格" message:@"00:45:00" cancelButton:@"取消" others:@"确定"];
        self.alertView.tag=12;
        self.alertView.delegate=self;
    }

}
-(void)myScoreBtnPressed
{
    MyScoresVC *vc=[[MyScoresVC alloc] init];
    vc.delegate=self;
    [vc updateViews];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myErrorBtnPressed
{
    if (self.m_logInfo.pro1ErrorArray.count<1)
    {
        [self showMessage:@"暂无错题！"];
        return;
    }
    self.testVC=[[TestVC alloc] init];
    self.testVC.delegateVC=self;
    testVC.title=@"我的错题";
    testVC.mytestmodel=[[TestModel alloc] init];
    for (NSString *pagenum in self.m_logInfo.pro1ErrorArray)
    {
        for (NSDictionary *test in self.m_aryTestsPro1)
        {
            if ([pagenum isEqualToString:[test objectForKey:@"index"]])
            {
                [testVC.m_aryTests addObject:test];
                break;
            }
        }
    }
    testVC.mytestmodel.type=@"4";  //错题库
    testVC.mytestmodel.pageCurrent=@"1";
    testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
    testVC.m_loginfo=self.m_logInfo;
    [self.navigationController pushViewController:testVC animated:YES];
}
-(void)mySavedBtnPressed
{
    if (self.m_logInfo.pro1SavedArray.count<1)
    {
        [self showMessage:@"暂无收藏！"];
        return;
    }
    self.testVC=[[TestVC alloc] init];
    self.testVC.delegateVC=self;
    testVC.title=@"我的收藏";
    testVC.mytestmodel=[[TestModel alloc] init];
    NSMutableArray *tests=[NSMutableArray array];
    for (NSString *pagenum in self.m_logInfo.pro1SavedArray)
    {
        for (NSDictionary *test in self.m_aryTestsPro1)
        {
            if ([pagenum isEqualToString:[test objectForKey:@"index"]])
            {
                [tests addObject:test];
                break;
            }
        }
    }
    [testVC.m_aryTests addObjectsFromArray:tests];
    testVC.mytestmodel.type=@"3";  //收藏
    testVC.mytestmodel.pageCurrent=@"1";
    testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
    testVC.m_loginfo=self.m_logInfo;
    [self.navigationController pushViewController:testVC animated:YES];
}
#pragma mark -----------alert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0)
    {
        if (buttonIndex==1)
        {
            testVC.mytestmodel.pageCurrent=self.m_logInfo.pro1Index;
            
        }
        [self.navigationController pushViewController:testVC animated:YES];
    }
    else if (alertView.tag==12)
    {
        if (buttonIndex==1)
        {
            testVC.title=@"模拟考试";
            
            NSMutableArray *array=[NSMutableArray arrayWithArray:self.m_aryTestsPro1];
            srand(time(0));
            NSInteger indexRand=0;
            NSInteger i=0;
            while (i<(self.progressIndex==1?100:50))
            {
                indexRand=rand()%array.count;
                [testVC.m_aryTests addObject:[array objectAtIndex:indexRand]];
                [array removeObjectAtIndex:indexRand];
                i++;
            }
            
            testVC.mytestmodel=[[TestModel alloc] init];
            testVC.mytestmodel.type=@"2";
            testVC.mytestmodel.pageCurrent=@"1";
            testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
            testVC.m_loginfo=self.m_logInfo;
            [self.navigationController pushViewController:testVC animated:YES];

        }
        
    }
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
