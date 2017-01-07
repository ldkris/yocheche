//
//  AboutYochecheVC.m
//  yocheche
//
//  Created by carcool on 11/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AboutYochecheVC.h"
#import "AboutYochecheCell.h"
#import "AboutUsVC.h"
@interface AboutYochecheVC ()

@end

@implementation AboutYochecheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"关于优车车";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
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
    AboutYochecheCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"AboutYochecheCell" owner:nil options:nil] objectAtIndex:0];
    cell.delegate=self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
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
#pragma mark --------- event response ---------------
-(void)showAboutUsVC
{
    AboutUsVC *vc=[[AboutUsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)callThePhone
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"4006909879"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
-(void)clearRibbish
{
    float savedRubbish=[self fileSizeForDir:[self getImagePath:@""]];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"清理缓存%.2fM",savedRubbish] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=11;
    [alert show];
}
-(NSString*)getImagePath:(NSString *)name
{
        NSArray *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *docPath = [path objectAtIndex:0];
     docPath=[NSString stringWithFormat:@"%@/img/",docPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *finalPath = [docPath stringByAppendingPathComponent:name];
        
        // Remove the filename and create the remaining path
        [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent]withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    
        return docPath;
}
-(float)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array = [fileManager subpathsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
//
//        BOOL isDir;
//        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
//        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
//        }
//        else
//        {
//            [self fileSizeForDir:fullPath];
//        }
    }
//    [fileManager release];
    return size;
}
#pragma mark --------- alert view delegate ----------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==1)
        {
            [self performSelectorOnMainThread:@selector( showLoadingWithBG) withObject:nil waitUntilDone:YES];
            
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            NSArray* array = [fileManager subpathsOfDirectoryAtPath:[self getImagePath:@""] error:nil];
            for(int i = 0; i<[array count]; i++)
            {
                NSString *fullPath = [[self getImagePath:@""] stringByAppendingPathComponent:[array objectAtIndex:i]];
                if([fileManager fileExistsAtPath:fullPath])
                {
                    [fileManager removeItemAtPath:fullPath error:nil];
                }
            }
            [self performSelectorOnMainThread:@selector(stopLoadingWithBG) withObject:nil waitUntilDone:YES];

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
