//
//  FLViewController.m
//  FLParallaxView
//
//  Created by fanly frank on 13-10-15.
//  Copyright (c) 2013 fanly frank. All rights reserved.
//

#import "FLViewController.h"

@interface FLViewController ()

@end

@implementation FLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    FLParallaxView *parallaxView = [[FLParallaxView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    parallaxView.parallaxViewDataSource = self;
    parallaxView.parallaxViewDelegate = self;
    parallaxView.borderColor = [UIColor orangeColor];
    parallaxView.parallaxCoefficient = .5;
    
    [self.view addSubview:parallaxView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - FLParallaxViewDataSource and delegate
- (NSInteger)numberOfItemViews
{
    return 3;
}

- (UIView *)parallaxView:(FLParallaxView *)view viewForIndex:(NSInteger)index
{
    
    UIImageView *itemView = [[UIImageView alloc]
                            initWithImage:[UIImage imageNamed:
                                           [NSString stringWithFormat:@"hewanglan_%d.jpg", index]]];

    return itemView;
}

- (void)selectParallaxViewAtIndex:(NSInteger)index
{
    NSLog(@"Item view %d is selected!", index);
}
@end
