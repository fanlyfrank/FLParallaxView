//
//  FLParallaxView.m
//  FLParallaxView
//  Created by fanly frank on 13-10-14.
//  Copyright (c) 2013 fanly frank. All rights reserved.
//

#import "FLParallaxView.h"

@interface FLParallaxView () {
    NSMutableArray *parallaxViews;
    NSMutableArray *borderViews;
    NSInteger hasLocatedIndex;
    NSInteger numberOfItemViews;
}

@end

@implementation FLParallaxView

/**
 * Designated initializer for this class
 * @author Fanly Frank
 **/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        parallaxViews = [[NSMutableArray alloc] initWithCapacity:3];
        borderViews = [[NSMutableArray alloc] initWithCapacity:6];
        
        hasLocatedIndex = -1;
        numberOfItemViews = -1;
        
        _borderColor = [UIColor blackColor];
        _leftBorderWidth = 2;
        _rightBorderWidth = 1;
        _parallaxCoefficient = .2;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self initParallaxViewIfNecessary];
    
    [self beginParallaxLayout];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIView *view in borderViews) {
        view.hidden = NO;
    }
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    for (UIView *view in borderViews) {
        view.hidden = YES;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = floor(scrollView.contentOffset.x
                     / self.frame.size.width);
    NSLog(@"current page is %d", page);
    if (page > numberOfItemViews)   return;

    UIView *parallaxView = [_parallaxViewDataSource parallaxView:self viewForIndex:page + 1];
    if (parallaxView && ![parallaxViews containsObject:parallaxView]) {
        [parallaxViews addObject:parallaxView];
        [self locateAndWarpParallaxViewInIndex:page + 1];
    }
}


#pragma mark - private method
- (void)initParallaxViewIfNecessary
{
    if (hasLocatedIndex == -1) {
        
        numberOfItemViews = [_parallaxViewDataSource numberOfItemViews];
      
        for (int i = 0; i < numberOfItemViews; i ++) {
            
            UIView *parallaxView = [_parallaxViewDataSource parallaxView:self viewForIndex:i];
            
            if (!parallaxView) {
                NSLog(@"index at %d need a view", i);
                abort();
            }
            
            [parallaxViews addObject:parallaxView];
            [self locateAndWarpParallaxViewInIndex:i];
        }
    }
}

- (void)beginParallaxLayout
{
    for (int i = 0; i < parallaxViews.count; i ++) {
        
        UIView *parallaxView = [parallaxViews objectAtIndex:i];
        
        CGRect frame = parallaxView.frame;
        
        frame.origin.x = self.contentOffset.x * _parallaxCoefficient -
        i * _parallaxCoefficient * self.frame.size.width;
        
        parallaxView.frame = frame;
        
    }
}

- (void)locateAndWarpParallaxViewInIndex:(NSInteger) index
{
    NSLog(@"current has located index %ld", hasLocatedIndex);
    if (index > hasLocatedIndex && index < numberOfItemViews) {
        
        self.contentSize = CGSizeMake(self.frame.size.width *
                                      parallaxViews.count,
                                      self.frame.size.height);
        
    
        //build content view
        UIView *subContentView = [[UIView alloc] initWithFrame:self.frame];
        
        CGRect frame = subContentView.frame;
        frame.origin.x = index * self.frame.size.width;
        subContentView.frame = frame;
        
        subContentView.clipsToBounds = YES;
        
        //get real parallax view
        UIView *realParallaxView = [parallaxViews objectAtIndex:index];
        
        CGRect rFrame = realParallaxView.frame;
        rFrame.size = self.frame.size;
        rFrame.origin.x = - index * _parallaxCoefficient * self.frame.size.width;
        realParallaxView.frame = rFrame;
        
        [subContentView addSubview:realParallaxView];
        
        //build border views
        UIView *_leftBorder = [[UIView alloc] initWithFrame:
                               CGRectMake(0, 0, _leftBorderWidth, frame.size.height)];
        UIView *_rightBorder = [[UIView alloc] initWithFrame:
                                CGRectMake(frame.size.width - _rightBorderWidth, 0,
                                   _rightBorderWidth, frame.size.height)];
        _leftBorder.hidden = YES;
        _rightBorder.hidden = YES;
        _leftBorder.backgroundColor = self.borderColor;
        _rightBorder.backgroundColor = self.borderColor;
        
        [subContentView addSubview:_leftBorder];
        [subContentView addSubview:_rightBorder];
        
        [borderViews addObject:_leftBorder];
        [borderViews addObject:_rightBorder];
        
        //build button for select event
        UIButton *btn = [[UIButton alloc]
                         initWithFrame:CGRectMake(0, 0,
                         subContentView.frame.size.width,
                         subContentView.frame.size.height)];
        
        btn.tag = index;
        [btn addTarget:self
                action:@selector(selectOneView:)
      forControlEvents:UIControlEventTouchUpInside];
        
        [subContentView addSubview:btn];
        
        [self addSubview:subContentView];
    
        hasLocatedIndex = index;
      
    }
}

- (void)selectOneView:(UIButton *)sender
{
    if (self.parallaxViewDelegate &&
        [self.parallaxViewDelegate
         respondsToSelector:
         @selector(selectParallaxViewAtIndex:)]) {
        [self.parallaxViewDelegate selectParallaxViewAtIndex:sender.tag];
    }
}

#pragma mark - instances method
- (UIView *)currentShowView
{
    int currentPage = floor(self.contentOffset.x / self.frame.size.width);
    return [parallaxViews objectAtIndex:currentPage];
}

@end
