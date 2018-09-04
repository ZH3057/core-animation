//
//  ViewController.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2018/9/4.
//  Copyright © 2018年 Jun Zhou. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addAnimation:[self backgroundColorAnimation] forKey:@"backgroundColorAnimation"];
    
    CALayer *a = [[CALayer alloc] init];
    a.frame = CGRectMake(100, 100, 100, 100);
    a.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:a];
    

    
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
