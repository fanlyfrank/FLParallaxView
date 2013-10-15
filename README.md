FLParallaxView
==============

FLParallaxView make a parallax effect look like YahooWeather app.

Installation
============

To use FLParallaxView class in an app, just drag the FLParallaxView.h and FLParallaxView.m class files in your project.

Properties
==========

The FLParallaxView has the following properties:

    @property (nonatomic, weak) id<FLParallaxViewDataSource> parallaxViewDataSource;

An object that supports FLParallaxViewDataSource protocol and can provide views to populate the FLParallaxView.

    @property (nonatomic, weak) id<FLParallaxViewDelegate> parallaxViewDelegate;
    
An object that supports FLParallaxViewDelegate protocol and responed to FLParallaxView events.

    //parallax view's border color, default is black
    @property (nonatomic, strong) UIColor *borderColor;
    
The color of FLParallaxView's left and right border.

    //default is 2 pixels
    @property (nonatomic, assign) float leftBorderWidth;

The width of FLParallaxView's left border.

    //default is 1 pixels
    @property (nonatomic, assign) float rightBorderWidth;

The width of FLParallaxView's right border.

    //default is .2
    @property (nonatomic, assign) float parallaxCoefficient;
The coefficient of parallax.

Methods
=======

    //get current show view
    - (UIView *)currentShowView;
Get the current show item view.
