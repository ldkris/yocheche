//
//  EmbedReaderViewController.h
//  snailSwitch
//
//  Created by carcool on 5/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "YCCViewController.h"
@protocol  EmbedReaderViewControllerDelegate<NSObject>

@required
-(void)scaneSuccess:(NSString*)result;

@end

@interface EmbedReaderViewController:YCCViewController<ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate>
{
//    ZBarReaderView *readerView;
//    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property(nonatomic,assign)id <EmbedReaderViewControllerDelegate> m_delegate;
@property(nonatomic,retain)UIImagePickerController *picker;
@property(nonatomic,retain)UIImageView *scanLine;
@end

