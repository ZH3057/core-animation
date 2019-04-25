//
//  ScrollLayerView.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2019/4/25.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "ScrollLayerView.h"

@implementation ScrollLayerView

+ (Class)layerClass {
    return CAScrollLayer.class;
}

- (void)setup {
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];

}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

@end
