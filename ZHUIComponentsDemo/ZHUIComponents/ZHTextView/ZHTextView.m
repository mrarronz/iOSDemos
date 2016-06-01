//
//  ZHTextView.m
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ZHTextView.h"

@interface ZHTextView () {
    NSString *_hintString;
}

@end

@implementation ZHTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.font = [UIFont systemFontOfSize:12];
    _placeholderColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_placeholder && _placeholder.length > 0) {
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        textStyle.alignment = NSTextAlignmentLeft;
        [_hintString drawAtPoint:CGPointMake(0, 0)
                  withAttributes:@{NSFontAttributeName:self.font,
                                   NSForegroundColorAttributeName:_placeholderColor,
                                   NSParagraphStyleAttributeName:textStyle}];
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    _hintString = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)textDidChange:(NSNotification *)notification {
    if (self.text.length != 0) {
        _hintString = nil;
    } else {
        _hintString = _placeholder;
    }
    [self setNeedsDisplay];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
