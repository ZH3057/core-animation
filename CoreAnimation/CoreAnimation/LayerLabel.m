//
//  LayerLabel.m
//  CoreAnimation
//
//  Created by Jun Zhou on 2019/4/24.
//  Copyright © 2019 Jun Zhou. All rights reserved.
//

#import "LayerLabel.h"

@interface LayerLabel ()

@property (nonatomic, strong) CATextLayer *textLayer;

@end


@implementation LayerLabel

+ (Class)layerClass {
    return CATextLayer.class;
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setup {
    self.textLayer.wrapped = YES;
    //self.textLayer.alignmentMode = kCAAlignmentJustified;
    [self.textLayer display];
}

- (instancetype)initWithFrame:(CGRect)frame {
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

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    self.textLayer.string = text;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.textLayer.backgroundColor = backgroundColor.CGColor;
}

@end
