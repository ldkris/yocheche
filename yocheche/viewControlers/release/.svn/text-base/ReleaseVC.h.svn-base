//
//  ReleaseVC.h
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import <PhotoEditFramework/PhotoEditFramework.h>
#import "SocialHomeVC.h"
@interface ReleaseVC : YCCViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,BMKLocationServiceDelegate,pg_edit_sdk_controller_delegate>
{
    BMKLocationService *_locService;
}
@property(nonatomic,assign)SocialHomeVC *delegate;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)IBOutlet UIView *actionSheetBG;
@property(nonatomic,retain)UIImagePickerController *picker;
@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;
@property(nonatomic,retain)IBOutlet UIView *topViewBG;
@property(nonatomic,retain)IBOutlet UITextView *textViewTag;
@property(nonatomic,retain)IBOutlet UILabel *labelTagDefault;
@property(nonatomic,retain)IBOutlet UIView *TagViewBG;
@property(nonatomic,retain)IBOutlet UILabel *labelInput;
@property(nonatomic,retain)UIImageView *imgRelease;
@property(nonatomic,retain)NSData *dataimg;
@property(nonatomic,assign)NSInteger haveShowedAlbum;
@property(nonatomic,retain)pg_edit_sdk_controller *m_editCtl;
@property(nonatomic,retain)pg_edit_sdk_controller_object *obje;
@property(nonatomic,retain)NSMutableArray *m_aryCategoryTags;
@end
