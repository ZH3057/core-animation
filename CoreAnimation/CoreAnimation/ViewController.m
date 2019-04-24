//
//  ViewController.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2018/9/4.
//  Copyright © 2018年 Jun Zhou. All rights reserved.
//

#import "ViewController.h"
#import "CustomDrawingView.h"
#import <GLKit/GLKit.h>
#import "LayerLabel.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;

@property (nonatomic, strong) UIView *view5;
@property (nonatomic, strong) UIView *view6;

@property (nonatomic, strong) CustomDrawingView *view7;

@property (nonatomic, strong) UIView *layerView8;
@property (nonatomic, strong) UIView *layerView9;
@property (nonatomic, strong) UIView *view10;
@property (nonatomic, strong) UIView *view11;
@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) NSMutableArray<UIView *> *faces;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *transformlayerView;

@property (nonatomic, weak) UIView *lastView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(ios 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
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

// ********************* 阴影裁剪
    
    self.layerView8 = [[UIView alloc] init];
    self.layerView8.backgroundColor = UIColor.whiteColor;
    self.layerView8.frame = CGRectMake(40, CGRectGetMaxY(self.lastView.frame) + 40, 100, 100);
    self.layerView8.layer.cornerRadius = 20.0f;
    self.layerView8.layer.cornerRadius = 20.0f;
    self.layerView8.layer.borderWidth = 5.0f;
    self.layerView8.layer.shadowOpacity = 0.5f;
    self.layerView8.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView8.layer.shadowRadius = 5.0f;
    [self.scrollView addSubview:self.layerView8];
    
    self.view10 = [[UIView alloc] init];
    self.view10.frame = CGRectMake(-15, -15, 50, 50);
    self.view10.backgroundColor = UIColor.redColor;
    [self.layerView8 addSubview:self.view10];
    
    
    self.shadowView = [[UIView alloc] init];
    self.shadowView.backgroundColor = UIColor.whiteColor;
    self.shadowView.frame = CGRectMake(40 + CGRectGetMaxX(self.layerView8.frame), CGRectGetMaxY(self.lastView.frame) + 40, 100, 100);
    self.shadowView.layer.cornerRadius = 20.0f;
    self.shadowView.layer.cornerRadius = 20.0f;
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    [self.scrollView addSubview:self.shadowView];
    
    self.layerView9 = [[UIView alloc] init];
    self.layerView9.backgroundColor = UIColor.whiteColor;
    self.layerView9.frame = CGRectMake(0, 0, 100, 100);
    self.layerView9.layer.cornerRadius = 20.0f;
    self.layerView9.layer.cornerRadius = 20.0f;
    self.layerView9.layer.borderWidth = 5.0f;
    self.layerView9.layer.masksToBounds = YES;
    [self.shadowView addSubview:self.layerView9];

    self.view11 = [[UIView alloc] init];
    self.view11.frame = CGRectMake(-15, -15, 50, 50);
    self.view11.backgroundColor = UIColor.redColor;
    [self.layerView9 addSubview:self.view11];
    
    self.lastView = self.shadowView;

// ********************* shadowPath
    
    UIImageView *layerView12 = [[UIImageView alloc] init];
    layerView12.layer.shadowOpacity = 0.5f;
    layerView12.image = [UIImage imageNamed:@"cool"];
    layerView12.frame = CGRectMake(10, CGRectGetMaxY(self.lastView.frame) + 40, 100, 100);
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, layerView12.bounds);
    layerView12.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
    [self.scrollView addSubview:layerView12];
    self.lastView = layerView12;
    
    
// ********************* 图层蒙板
    
    UIImageView *view13 = [[UIImageView alloc] init];
    view13.backgroundColor = UIColor.lightGrayColor;
    //view13.image = [UIImage imageNamed:@"question"];
    view13.frame = CGRectMake(40, CGRectGetMaxY(self.lastView.frame) + 30, 100, 100);
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = view13.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"question"];
    maskLayer.contents = (__bridge id _Nullable)(maskImage.CGImage);
    view13.layer.mask = maskLayer;
    
    [self.scrollView addSubview:view13];
    self.lastView = view13;
    
    
    
// ********************* 拉伸过滤 让图片拉伸后显示清晰
    
    UIView *view14 = [[UIView alloc] init];
    view14.frame = CGRectMake(10, CGRectGetMaxY(self.lastView.frame) + 40, CGRectGetWidth(self.view.bounds) - 20, CGRectGetWidth(self.view.bounds) - 20);
    view14.layer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"king"].CGImage;
    view14.layer.contentsGravity = kCAGravityResizeAspect;
    view14.backgroundColor = UIColor.cyanColor;
    view14.layer.contentsRect = CGRectMake(0, 0, 0.5, 1.0);
    view14.layer.magnificationFilter = kCAFilterTrilinear; // kCAFilterLinear / kCAFilterNearest / kCAFilterTrilinear
    
    [self.scrollView addSubview:view14];
    self.lastView = view14;
    

// ********************* 组透明
    
    UIView *view15 = [[UIView alloc] init];
    view15.frame = CGRectMake(10, CGRectGetMaxY(self.lastView.frame) + 40, 150, 50);
    view15.layer.cornerRadius = 10;
    view15.backgroundColor = UIColor.lightGrayColor;
    view15.alpha = 0.5;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(20, 10, 110, 30);
    label1.text = @"Hello World";
    label1.textAlignment = NSTextAlignmentCenter;
    
    [self.scrollView addSubview:view15];
    [view15 addSubview:label1];
    
    UIView *view16 = [[UIView alloc] init];
    view16.frame = CGRectMake(CGRectGetMaxX(view15.frame) + 10, CGRectGetMaxY(self.lastView.frame) + 40, 150, 50);
    view16.layer.cornerRadius = 10;
    view16.backgroundColor = UIColor.lightGrayColor;
    view16.alpha = 0.5;
    view16.layer.shouldRasterize = YES;
    view16.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(20, 10, 110, 30);
    label2.text = @"Hello World";
    label2.textAlignment = NSTextAlignmentCenter;
    
    [self.scrollView addSubview:view16];
    [view16 addSubview:label2];
    
     self.lastView = view16;
    
    
// ********************* 仿射变换
    
    UIView *view17 = [[UIView alloc] init];
    view17.frame = CGRectMake(60, CGRectGetMaxY(self.lastView.frame) + 40, 80, 80);
    view17.backgroundColor = UIColor.cyanColor;
    view17.layer.contents = (__bridge id)[UIImage imageNamed:@"cool"].CGImage;
    view17.layer.contentsGravity = kCAGravityResizeAspectFill;
    [self.scrollView addSubview:view17];
    self.lastView = view17;

    //create a new transform
    CGAffineTransform transform = CGAffineTransformIdentity;
    //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.8);
    //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
    //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 0, 30);
    //apply transform to layer
    view17.layer.affineTransform = transform;
    //NSLog(@"transRotate frame: %@", NSStringFromCGRect(view17.frame)); frame发生了变化
    
// ********************* 3D变换
    
    UIView *view18 = [[UIView alloc] init];
    view18.frame =CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + 40, CGRectGetWidth(self.view.bounds), 200);
    
    UIView *view19 = [[UIView alloc] init];
    view19.frame = CGRectMake(50, 50, 100, 100);
    view19.backgroundColor = UIColor.cyanColor;
    view19.layer.contents = (__bridge id)[UIImage imageNamed:@"question"].CGImage;
    view19.layer.contentsGravity = kCAGravityResizeAspectFill;
    
    UIView *view20 = [[UIView alloc] init];
    view20.frame = CGRectMake(CGRectGetMaxX(view19.frame) + 40, 50, 100, 100);
    view20.backgroundColor = UIColor.cyanColor;
    view20.layer.contents = (__bridge id)[UIImage imageNamed:@"question"].CGImage;
    view20.layer.contentsGravity = kCAGravityResizeAspectFill;
    
    [view18 addSubview:view19];
    [view18 addSubview:view20];
    
    /*
     CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，
     但和对一个图层的变换不同，它影响到所有的子图层。
     这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法
     */
    //apply perspective transform to container
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    view18.layer.sublayerTransform = perspective;
    //rotate layerView1 by 45 degrees along the Y axis
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    view19.layer.transform = transform1;
    //rotate layerView2 by 45 degrees along the Y axis
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    view20.layer.transform = transform2;
    
    [self.scrollView addSubview:view18];
    self.lastView = view18;
    
// ********************* 扁平化图层
    
    UIView *outerView = [[UIView alloc] init];
    outerView.backgroundColor = UIColor.lightGrayColor;
    outerView.frame = CGRectMake(20, CGRectGetMaxY(self.lastView.frame) + 20, 180, 180);
    
    UIView *innerView = [[UIView alloc] init];
    innerView.backgroundColor = UIColor.cyanColor;
    innerView.frame = CGRectMake(40, 40, 100, 100);
    
    [outerView addSubview:innerView];
    [self.scrollView addSubview:outerView];
    self.lastView = outerView;
    
    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    outerView.layer.transform = outer;
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    innerView.layer.transform = inner;
    
// ********************* 固体对象
    //set up the container sublayer transform
    
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = UIColor.lightGrayColor;
    self.containerView.frame = CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + 20, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
    CATransform3D pers = CATransform3DIdentity;
    pers.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pers;
    
    self.faces = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] init];
        view.bounds = CGRectMake(0, 0, 200, 200);
        view.backgroundColor = [self randomColor];
        UILabel *idxLabel = [[UILabel alloc] init];
        idxLabel.text = [NSString stringWithFormat:@"%d", i + 1];
        idxLabel.bounds = CGRectMake(0, 0, 60, 60);
        [view addSubview:idxLabel];
        idxLabel.center = CGPointMake(100, 100);
        idxLabel.textColor = UIColor.whiteColor;
        [self.faces addObject:view];
    }
    
    [self setupFaces];
    
    [self.scrollView addSubview:self.containerView];
    self.lastView = self.containerView;
    
// ********************* CAShapeLayer
    
    /*
     渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多
     高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存
     不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制 图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉
     不会出现像素化。给CAShapeLayer做3D变换时，不像一个有寄宿图的普通图层一样变得像素化
     */
    
    UIView *view21 = [[UIView alloc] init];
    view21.frame = CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + 20, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
    [self.scrollView addSubview:view21];
    self.lastView = view21;
    
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [view21.layer addSublayer:shapeLayer];
    
    
// ********************* CATextLayer
    
    LayerLabel *layerLabel = [[LayerLabel alloc] init];
    layerLabel.frame = CGRectMake(40, CGRectGetMaxY(self.lastView.frame) + 20, 200, 100);
    layerLabel.backgroundColor = UIColor.cyanColor;
    layerLabel.textColor = UIColor.whiteColor;
    layerLabel.font = [UIFont systemFontOfSize:14];
    layerLabel.text = @"Nothing matters to me but you.\n"
                       "And everyday I am alive, I'm aware of this.\n"
                       "I loved you the day I met you, I love you today...\n"
                       "And I will love you to rest of my life.";
    [self.scrollView addSubview:layerLabel];
    self.lastView = layerLabel;
    
// ********************* CATransformLayer
    
    self.transformlayerView = [[UIView alloc] init];
    self.transformlayerView.frame = CGRectMake(0, CGRectGetMaxY(self.lastView.frame) + 20, CGRectGetWidth(self.view.bounds), 300);
    self.transformlayerView.backgroundColor = UIColor.cyanColor;
    [self.scrollView addSubview:self.transformlayerView];
    self.lastView = self.transformlayerView;
    
    [self setupCATransformLayer];
    
// ********************* CAGradientLayer
    
    UIView *view22 = [[UIView alloc] init];
    view22.frame = CGRectMake(44, CGRectGetMaxY(self.lastView.frame) + 20, 200, 100);
    CAGradientLayer *grandientlayr = [CAGradientLayer layer];
    grandientlayr.frame = view22.bounds;
    [view22.layer addSublayer:grandientlayr];
    
    grandientlayr.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id) [UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    
    //set locations
    grandientlayr.locations = @[@0.0, @0.25, @0.5, @0.75, @1];
    grandientlayr.startPoint = CGPointMake(0, 1);
    grandientlayr.endPoint = CGPointMake(1, 1);
    
    [self.scrollView addSubview:view22];
    self.lastView = view22;
    
// ********************* CAReplicatorLayer
    
    UIView *view23 = [[UIView alloc] init];
    view23.frame = CGRectMake(20, CGRectGetMaxY(self.lastView.frame) + 20, CGRectGetWidth(self.view.bounds) - 40, 200);
    view23.backgroundColor = UIColor.lightGrayColor;
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = view23.bounds;
    [view23.layer addSublayer:replicator];
    replicator.instanceCount = 10;
    
    CATransform3D repCt = CATransform3DIdentity;
    repCt = CATransform3DTranslate(repCt, 0, 30, 0);
    repCt = CATransform3DRotate(repCt, M_PI / 5.0, 0, 0, 1);
    repCt = CATransform3DTranslate(repCt, 0, -30, 0);
    replicator.instanceTransform = repCt;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(80.0f, 80.0f, 80.0f, 80.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
    [self.scrollView addSubview:view23];
    self.lastView = view23;
    
// ********************* CAReplicatorLayer 反射
    
    [self updateScrollViewContentSize];
}




- (void)updateScrollViewContentSize {
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.lastView.frame) + CGRectGetHeight(self.view.bounds) * 0.4);
    
    CGFloat offsetY = self.scrollView.contentSize.height - CGRectGetHeight(self.view.bounds);
    [self.scrollView setContentOffset:CGPointMake(0, offsetY)];
}

- (void)setupCATransformLayer {
    //set up the perspective transform
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.transformlayerView.layer.sublayerTransform = pt;
    
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.transformlayerView.layer addSublayer:cube1];
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.transformlayerView.layer addSublayer:cube2];
}


- (CALayer *)faceWithTransform:(CATransform3D)transform {
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    //apply the transform and return
    cube.transform = transform;
    return cube;
}


- (void)setupFaces {
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    //apply lighting
    [self applyLightingToFace:face.layer];
}

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

- (void)applyLightingToFace:(CALayer *)face {
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
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

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}

@end
