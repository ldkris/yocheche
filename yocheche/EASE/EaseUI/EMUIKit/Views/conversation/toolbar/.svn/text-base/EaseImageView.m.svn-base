//
//  EMImageView.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseImageView.h"

@interface EaseImageView()

@property (strong, nonatomic) UILabel *badgeView;

@property (nonatomic) NSLayoutConstraint *badgeWidthConstraint;


@end


@implementation EaseImageView

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseImageView *imageView = [self appearance];
    imageView.badgeBackgroudColor = [UIColor redColor];
    imageView.badgeTextColor = [UIColor whiteColor];
    imageView.badgeFont = [UIFont boldSystemFontOfSize:11];
    imageView.imageCornerRadius = 0;
    imageView.badgeSize = 20;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setupSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubviews];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setupSubviews];
    }
    return self;
}

#pragma mark - private

- (void)_setupSubviews
{
    if (_imageView == nil) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] init];
        [_imageView setFrame:CGRectMake(5, 0, 40, 40)];
//        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.layer.cornerRadius = PARENT_WIDTH(_imageView)/2.0;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
        
        _badgeView = [[UILabel alloc] init];
//        _badgeView.translatesAutoresizingMaskIntoConstraints = NO;
        //yocheche
        [_badgeView setFrame:CGRectMake(PARENT_X(_imageView)+25, PARENT_Y(_imageView)-8, 20, 20)];
        //yocheche end
        _badgeView.textAlignment = NSTextAlignmentCenter;
        _badgeView.textColor = _badgeTextColor;
        _badgeView.backgroundColor = _badgeBackgroudColor;
        _badgeView.font = _badgeFont;
        _badgeView.hidden = YES;
        _badgeView.clipsToBounds = YES;
        _badgeView.layer.cornerRadius = PARENT_WIDTH(_badgeView)/2.0;
        [self addSubview:_badgeView];
        
//        [self _setupImageViewConstraint];
//        [self _setupBadgeViewConstraint];
    }
}

#pragma mark - Setup Constraint

- (void)_setupImageViewConstraint
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

- (void)_setupBadgeViewConstraint
{
    self.badgeWidthConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.badgeSize];
    [self addConstraint:self.badgeWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.badgeView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.imageCornerRadius + 3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-3]];
}

- (void)_updateBadgeViewWidthConstraint
{
    [self removeConstraint:self.badgeWidthConstraint];
    
    self.badgeWidthConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.badgeSize];
    [self addConstraint:self.badgeWidthConstraint];
}

#pragma mark - setter

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
    if (badge > 0) {
        self.badgeView.hidden = NO;
    }
    else{
        self.badgeView.hidden = YES;
    }
    
    if (badge > 99) {
        self.badgeView.text = @"N+";
    }
    else{
       self.badgeView.text = [NSString stringWithFormat:@"%ld", (long)_badge];
    }
}

- (void)setShowBadge:(BOOL)showBadge
{
    if (_showBadge != showBadge) {
        _showBadge = showBadge;
        self.badgeView.hidden = !_showBadge;
    }
}

- (void)setBadgeSize:(CGFloat)badgeSize
{
    if (_badgeSize != badgeSize) {
        _badgeSize = badgeSize;
        _badgeView.layer.cornerRadius = _badgeSize / 2;
        
        [self _updateBadgeViewWidthConstraint];
    }
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius
{
    if (_imageCornerRadius != imageCornerRadius) {
        _imageCornerRadius = imageCornerRadius;
        self.imageView.layer.cornerRadius = _imageCornerRadius;
    }
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
    _badgeFont = badgeFont;
    self.badgeView.font = badgeFont;
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    _badgeTextColor = badgeTextColor;
    self.badgeView.textColor = badgeTextColor;
}

- (void)setBadgeBackgroudColor:(UIColor *)badgeBackgroudColor
{
    _badgeBackgroudColor = badgeBackgroudColor;
    self.badgeView.backgroundColor = badgeBackgroudColor;
}
-(void)setWebImageViewWithURL:(NSURL *)url
{
    if (url==nil)
    {
        return;
    }
    NSString *strUrl=[url absoluteString];
    if(strUrl.length>0)
    {
        strUrl=[strUrl substringFromIndex:0];
    }
    else
    {
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]])
    {
        NSData *myData= [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]];
        if (myData.length>0)
        {
            self.image = [UIImage imageWithData:myData];
        }
        
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                if (imageData.length>0) {
                    self.image = [UIImage imageWithData:imageData];
                    if ([imageData writeToFile:[self getImagePath:strUrl] atomically:YES])
                    {
                        NSLog(@"saved");
                    }
                    
                }
                
            });
        });
        
        //        NSData *myData= UIImageJPEGRepresentation(self.image, 1.0);
        
    }
    
    
}
- (NSString*)getImagePath:(NSString *)name
{
    NSArray *path =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *finalPath = [docPath stringByAppendingPathComponent:name];
    
    // Remove the filename and create the remaining path
    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent]withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    
    return finalPath;
}
@end
