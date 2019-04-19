//
//  ViewController.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2018/9/4.
//  Copyright © 2018年 Jun Zhou. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong)  UIView *view1;
@property (nonatomic, strong)  UIView *view2;
@property (nonatomic, strong)  UIView *view3;
@property (nonatomic, strong)  UIView *view4;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view1 = [[UIView alloc] init];
    self.view1.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds) * 0.5, 100);
    self.view2 = [[UIView alloc] init];
    self.view2.frame = CGRectMake(CGRectGetWidth(self.view.bounds) * 0.5, 100, CGRectGetWidth(self.view.bounds) * 0.5, 100);
    self.view3 = [[UIView alloc] init];
    self.view3.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.bounds) * 0.5, 100);
    self.view4 = [[UIView alloc] init];
    self.view4.frame = CGRectMake(CGRectGetWidth(self.view.bounds) * 0.5, 200, CGRectGetWidth(self.view.bounds) * 0.5, 100);
    
    self.view1.backgroundColor = UIColor.lightGrayColor;
    self.view2.backgroundColor = UIColor.lightTextColor;
    self.view3.backgroundColor = UIColor.lightTextColor;
    self.view4.backgroundColor = UIColor.lightGrayColor;
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    [self.view addSubview:self.view4];
    
    UIImage *image = [UIImage imageNamed:@"test_carnival_unlocked"];
    [self addImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) ￼toLayer:self.view1.layer];
    [self addImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) ￼toLayer:self.view2.layer];
    [self addImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) ￼toLayer:self.view3.layer];
    [self addImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) ￼toLayer:self.view4.layer];
    
}

- (void)addImage:(UIImage *)image withContentRect:(CGRect)rect ￼toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect 在图层边框里显示寄宿图的一个子域
    layer.contentsRect = rect;
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
