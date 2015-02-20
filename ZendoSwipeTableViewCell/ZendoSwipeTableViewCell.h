//
//  ZendoSwipeTableViewCell.h
//  TestCell
//
//  Created by Victor Chen on 1/07/13.
//  Copyright (c) 2013 Mt. Zendo. All rights reserved.
//
typedef void (^BLOCK)();

#import <UIKit/UIKit.h>

@protocol ZendoSwipeTableViewCellDelegate;

@interface ZendoSwipeTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *_panGestureRecognizer;
    CGFloat _currentPercentage;
    
    BOOL _needCheckState;
    BOOL _forceReturnToOriginalPostition;
}
@property (nonatomic, assign) id<ZendoSwipeTableViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL dragEnabled;


@property (nonatomic, strong) UIColor *enableColor;
@property (nonatomic, strong) UIColor *disableColor;
@property (nonatomic, strong) UIColor *morePanelBackgroundColor;

@property (nonatomic, strong) UIImage *enableIconImage;
@property (nonatomic, strong) UIImage *disableIconImage;
@end


@protocol ZendoSwipeTableViewCellDelegate <NSObject>

@optional
-(void)mtTableviewCell:(UITableViewCell *)cell enableStateChanged:(BOOL)enable;
-(void)mtzendoTableViewCell:(UITableViewCell *)cell onDeleteBtn:(id)sender;
-(void)mtzendoTableViewCell:(UITableViewCell *)cell onMoreBtn:(id)sender;

@end