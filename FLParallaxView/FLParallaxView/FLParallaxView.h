//
//  FLParallaxView.h
//  FLParallaxView
//
//  Created by fanly frank on 13-10-14.
//  Copyright (c) 2013年 fanly frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLParallaxView;

@protocol  FLParallaxViewDataSource <NSObject>

- (NSInteger)numberOfItemViews;

- (UIView *)parallaxView:(FLParallaxView *)view
              viewForIndex:(NSInteger)index;

@end

@protocol FLParallaxViewDelegate <NSObject>

@optional
- (void)selectParallaxViewAtIndex:(NSInteger)index;

@end

@interface FLParallaxView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<FLParallaxViewDataSource> parallaxViewDataSource;
@property (nonatomic, weak) id<FLParallaxViewDelegate> parallaxViewDelegate;

//parallax view's border color, default is black
@property (nonatomic, strong) UIColor *borderColor;

//default is 2 pixels
@property (nonatomic, assign) float leftBorderWidth;

//default is 1 pixels
@property (nonatomic, assign) float rightBorderWidth;

//default is .2
@property (nonatomic, assign) float parallaxCoefficient;

//get current show view
- (UIView *)currentShowView;

@end

