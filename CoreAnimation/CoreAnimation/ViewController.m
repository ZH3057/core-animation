//
//  ViewController.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2018/9/4.
//  Copyright © 2018年 Jun Zhou. All rights reserved.
//

#import "ViewController.h"
#import "CustomDrawingView.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;

@property (nonatomic, strong) UIView *view5;
@property (nonatomic, strong) UIView *view6;

@property (nonatomic, strong) CustomDrawingView *view7;

@property (nonatomic, weak) UIView *lastView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    CGFloat topMargin = 44;
    CGFloat halfWidth = CGRectGetWidth(self.view.bounds) * 0.5;
    CGFloat itemHeight = 100;

// ********************* Layer contentsRect
    self.view1 = [[UIView alloc] init];
    self.view1.frame = CGRectMake(0, topMargin, halfWidth, itemHeight);
    self.view2 = [[UIView alloc] init];
    self.view2.frame = CGRectMake(halfWidth, topMargin, halfWidth, itemHeight);
    self.view3 = [[UIView alloc] init];
    self.view3.frame = CGRectMake(0, topMargin + itemHeight, halfWidth, itemHeight);
    self.view4 = [[UIView alloc] init];
    self.view4.frame = CGRectMake(halfWidth, topMargin + itemHeight, halfWidth, itemHeight);
    
    self.view1.backgroundColor = UIColor.lightGrayColor;
    self.view2.backgroundColor = UIColor.cyanColor;
    self.view3.backgroundColor = UIColor.cyanColor;
    self.view4.backgroundColor = UIColor.lightGrayColor;
    
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];
    [self.scrollView addSubview:self.view4];
    self.lastView = self.view4;
    
    UIImage *contentRectImage = [UIImage imageNamed:@"test_carnival_unlocked"];
    [self addImage:contentRectImage withContentRect:CGRectMake(0, 0, 0.5, 0.5) ￼toLayer:self.view1.layer];
    [self addImage:contentRectImage withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) ￼toLayer:self.view2.layer];
    [self addImage:contentRectImage withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) ￼toLayer:self.view3.layer];
    [self addImage:contentRectImage withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) ￼toLayer:self.view4.layer];
    
// ********************* Layer contentsCenter
    self.view5 = [[UIView alloc] init];
    self.view5.frame = CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + topMargin, halfWidth, itemHeight);
    self.view6 = [[UIView alloc] init];
    self.view6.frame = CGRectMake(halfWidth, CGRectGetMaxY(self.lastView.frame) + topMargin, halfWidth, itemHeight);
    
    self.view5.backgroundColor = UIColor.lightGrayColor;
    self.view6.backgroundColor = UIColor.cyanColor;
    
    [self.scrollView addSubview:self.view5];
    [self.scrollView addSubview:self.view6];
    self.lastView = self.view6;
    
    UIImage *contentCenterImage = [UIImage imageNamed:@"king"];
    [self addStretchableImage:contentCenterImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.view5.layer];
    [self addStretchableImage:contentCenterImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.view6.layer];
    
// ********************* Custom Drawing
    
    /**
     实现了- (void)displayLayer:(CALayer *)layer协议方法 需要实现整个绘制过程
     */
    self.view7 = [[CustomDrawingView alloc] init];
    self.view7.frame = CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + topMargin, halfWidth, itemHeight);
    self.view7.backgroundColor = UIColor.cyanColor;
    [self.scrollView addSubview:self.view7];
    self.lastView = self.view7;
    
    [self updateScrollViewContentSize];
}

- (void)updateScrollViewContentSize {
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.lastView.frame));
}

// MARK: - Layer contentsRect

- (void)addImage:(UIImage *)image withContentRect:(CGRect)rect ￼toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect 在图层边框里显示寄宿图的一个子域
    layer.contentsRect = rect;
}

// MARK: - Layer contentsCenter

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer {
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}


- (CABasicAnimation*)backgroundColorAnimation; {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [anim setDuration:5.0];
    [anim setFromValue:(id)[[UIColor redColor] CGColor]];
    [anim setToValue:(id)[[UIColor greenColor] CGColor]];
    return anim;
}

- (void)frameAnimation {
    
}

@end
