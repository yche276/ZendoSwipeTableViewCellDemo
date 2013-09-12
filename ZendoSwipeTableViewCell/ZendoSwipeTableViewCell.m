//
//  ZendoSwipeTableViewCell.m
//  TestCell
//
//  Created by Victor Chen on 1/07/13.
//  Copyright (c) 2013 Mt. Zendo. All rights reserved.
//
//static CGFloat const 

#import "ZendoSwipeTableViewCell.h"


@interface ZendoSwipeTableViewCell () 

// Init
- (void)setup;

// Handle Gestures
- (void)onPanGestureRecognizer:(UIPanGestureRecognizer *)gesture;


//util
- (void)bounceBackWithPercentage:(float)prmPercentage;


@property (nonatomic, strong) UIView *rightIndictorView;
@property (nonatomic, strong) UIView *leftIndictorView;
@property (nonatomic, strong) UIImageView *leftImageView;
@end



@implementation ZendoSwipeTableViewCell

@synthesize delegate;
@synthesize enabled, dragEnabled;

@synthesize rightIndictorView, leftIndictorView;
@synthesize leftImageView;

@synthesize enableColor, disableColor, morePanelBackgroundColor;
@synthesize enableIconImage, disableIconImage;

-(void)dealloc{
    [self removeGestureRecognizer:_panGestureRecognizer];
}

-(void)setup{
    
    self.enabled = YES;
    self.dragEnabled = YES;
    
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureRecognizer:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    [_panGestureRecognizer setDelegate:self];
    
    
    UIView *holderView = [[UIView alloc] initWithFrame:self.bounds];
    holderView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    holderView.backgroundColor = [UIColor clearColor];
//    [self insertSubview:holderView belowSubview:self.contentView];
    [self insertSubview:holderView atIndex:0];
    
    
    
    UIView *aView1 = [[UIView alloc] init];
    
    [aView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.leftIndictorView = aView1;
    self.leftIndictorView.backgroundColor = [UIColor greenColor];
    [holderView addSubview:self.leftIndictorView];
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftIndictorView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:holderView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0f
                                                           constant:0.0]];
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftIndictorView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:holderView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.5f
                                                           constant:0.0]];
    
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftIndictorView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:holderView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0]];

    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftIndictorView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:holderView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0f
                                                           constant:0.0]];

    
    
    
    
    UIView *aView2 = [[UIView alloc] init];
    [aView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.rightIndictorView = aView2;
    self.rightIndictorView.backgroundColor = [UIColor darkGrayColor];
    [holderView addSubview:self.rightIndictorView];
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightIndictorView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:holderView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0f
                                                            constant:0.0]];
    
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightIndictorView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:holderView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:0.5f
                                                            constant:0.0]];
    
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightIndictorView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:holderView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [holderView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightIndictorView
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:holderView
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0f
                                                            constant:0.0]];
    
    
    
    
    
    
    self.leftImageView = [[UIImageView alloc] init];
    [self.leftImageView setContentMode:UIViewContentModeCenter];
    [self.leftIndictorView addSubview:self.leftImageView];
 
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Gesture Methods

- (void)onPanGestureRecognizer:(UIPanGestureRecognizer *)gesture{
    
    if (!self.dragEnabled) {
        return;
    }
    
    CGPoint translation = [gesture translationInView:self];
    _currentPercentage = self.contentView.frame.origin.x/self.frame.size.width;
    
    if (_currentPercentage < -1.0) {
        _currentPercentage = -1.0;
    }
    else if (_currentPercentage > 1.0){
        _currentPercentage = 1.0;
    }
    
    
    
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        if (gesture.state == UIGestureRecognizerStateBegan) {
            _needCheckState = YES;
            self.leftImageView.image = self.enabled?self.enableIconImage:self.disableIconImage;
        }
        
        if (_currentPercentage < 0.4f && _currentPercentage > -0.4f) {
            CGPoint center = {self.contentView.center.x + translation.x, self.contentView.center.y};
            [self.contentView setCenter:center];
            [gesture setTranslation:CGPointZero inView:self];
            if (_currentPercentage>=0) {//only for dragging to right
                CGPoint position = CGPointMake((self.frame.size.width*_currentPercentage)/2.0f, self.bounds.size.height/2.0f);
                CGSize imgSize = self.enabled?self.enableIconImage.size:self.disableIconImage.size;
                
                CGRect rect = CGRectMake(position.x-(imgSize.width/2), position.y-(imgSize.height/2), imgSize.width, imgSize.height);
                rect = CGRectIntegral(rect);
                [self.leftImageView setFrame:rect];
                
            }
        }
        
        if (_needCheckState && _currentPercentage<0.55f && _currentPercentage>0.3f) {
            //has changed for this time.
            _needCheckState = NO;
            self.enabled = !self.enabled;
            if (!self.enabled) {//disable
                self.leftIndictorView.backgroundColor = self.disableColor;
                self.leftImageView.image = self.disableIconImage;
            }
            else{//enable
                self.leftIndictorView.backgroundColor = self.enableColor;
                self.leftImageView.image = self.enableIconImage;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(mtTableviewCell:enableStateChanged:)]) {
                [self.delegate mtTableviewCell:self enableStateChanged:self.enabled];
            }
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (_currentPercentage < -0.1f) {
            
            if (_forceReturnToOriginalPostition) {
                //bounce back
                _forceReturnToOriginalPostition = NO;
                [self bounceBackWithPercentage:_currentPercentage];
            
            }
            else{
                [UIView animateWithDuration:0.2f
                                      delay:0
                                    options:(UIViewAnimationOptionCurveEaseOut)
                                 animations:^{
                                     CGPoint center = CGPointMake(0, self.contentView.center.y);
                                     [self.contentView setCenter:center];
                                 }
                                 completion:^(BOOL finished1) {}];
                
                
                
                
                _currentPercentage = 0;
                _needCheckState = NO;
                _forceReturnToOriginalPostition = YES;
            }
            
            
        }
        else{
            //bounce back
           [self bounceBackWithPercentage:_currentPercentage];
        }
        
        
    }//end else if
    
    
    
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer class] == [UIPanGestureRecognizer class]) {
        UIPanGestureRecognizer *g = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [g velocityInView:self];
        if (fabsf(point.x) > fabsf(point.y) ) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - Util

- (void)bounceBackWithPercentage:(float)prmPercentage{
    int kMCBounceAmplitude = 10;
    
    CGFloat bounceDistance = kMCBounceAmplitude * _currentPercentage;
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseOut)
                     animations:^{
                         CGRect frame = self.contentView.frame;
                         frame.origin.x = -bounceDistance;
                         [self.contentView setFrame:frame];
                     }
                     completion:^(BOOL finished1) {
                         
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              CGRect frame = self.contentView.frame;
                                              frame.origin.x = 0;
                                              [self.contentView setFrame:frame];
                                          }
                                          completion:^(BOOL finished2) {
                                              _currentPercentage = 0;
                                              _needCheckState = NO;
                                          }];
                     }];

}
@end




