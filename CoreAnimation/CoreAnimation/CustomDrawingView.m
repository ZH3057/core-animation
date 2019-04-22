//
//  CustomDrawingView.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2019/4/19.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "CustomDrawingView.h"

@interface CustomDrawingView () <CALayerDelegate>

@end


@implementation CustomDrawingView

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect: - current thread: %@", [NSThread currentThread]);
}


/* If defined, called by the default implementation of the -display
 * method, in which case it should implement the entire display
 * process (typically by setting the `contents' property). */

- (void)displayLayer:(CALayer *)layer {
    NSLog(@"displayLayer: - current thread: %@", [NSThread currentThread]);
    
    UIImage *image = [UIImage imageNamed:@"question"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.layer.contents = (__bridge id)image.CGImage;
        self.layer.contentsGravity = kCAGravityResizeAspect;
        self.layer.backgroundColor = UIColor.cyanColor.CGColor;
    });
    
}

/*
 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
 与
 - (void)displayLayer:(CALayer *)layer
 方法二选一
 
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"drawLayer:inContext: - current thread: %@", [NSThread currentThread]);
    
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}
*/


- (void)layerWillDraw:(CALayer *)layer {
    NSLog(@"layerWillDraw: - current thread: %@", [NSThread currentThread]);
}


- (void)layoutSublayersOfLayer:(CALayer *)layer {
    NSLog(@"layoutSublayersOfLayer: - current thread: %@", [NSThread currentThread]);
}



- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
   // NSLog(@"actionForLayer: - current thread: %@", [NSThread currentThread]);
    
    return nil;
}

@end
