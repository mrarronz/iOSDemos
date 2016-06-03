//
//  QuartzFunView.m
//  QuartzFunDemo
//
//  Created by Arron Zhu on 16/6/3.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor+Random.h"

@implementation QuartzFunView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentColor = [UIColor redColor];
        _useRandomColor = NO;
        _drawImage = [UIImage imageNamed:@"xxx.jpg"];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_useRandomColor) {
        _currentColor = [UIColor randomColor];
    }
    UITouch *touch = touches.anyObject;
    _firstTouch = [touch locationInView:self];
    _lastTouch = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    _lastTouch = [touch locationInView:self];
    if (_shapeType == kImageShape) {
        CGFloat horizontalOffset = _drawImage.size.width/2;
        CGFloat verticalOffset = _drawImage.size.height/2;
        _redrawRect = CGRectUnion(_redrawRect,
                                      CGRectMake(_lastTouch.x - horizontalOffset,
                                                 _lastTouch.y - verticalOffset,
                                                 _drawImage.size.width,
                                                 _drawImage.size.height));
    }
    _redrawRect = CGRectUnion(_redrawRect, self.currentRect);
    [self setNeedsDisplayInRect:_redrawRect];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    _lastTouch = [touch locationInView:self];
    if (_shapeType == kImageShape) {
        CGFloat horizontalOffset = _drawImage.size.width/2;
        CGFloat verticalOffset = _drawImage.size.height/2;
        _redrawRect = CGRectUnion(_redrawRect,
                                      CGRectMake(_lastTouch.x - horizontalOffset,
                                                 _lastTouch.y - verticalOffset,
                                                 _drawImage.size.width,
                                                 _drawImage.size.height));
    } else {
        _redrawRect = CGRectUnion(_redrawRect, self.currentRect);
    }
    _redrawRect = CGRectInset(_redrawRect, -2.0, -2.0);
    [self setNeedsDisplayInRect:_redrawRect];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线条宽度和颜色
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetStrokeColorWithColor(context, _currentColor.CGColor);
    // 设置填充色
    CGContextSetFillColorWithColor(context, _currentColor.CGColor);
    
    switch (_shapeType) {
        case kLineShape:
            CGContextMoveToPoint(context, _firstTouch.x, _firstTouch.y);
            CGContextAddLineToPoint(context, _lastTouch.x, _lastTouch.y);
            CGContextStrokePath(context);
            break;
        case kRectShape:
            CGContextAddRect(context, self.currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kEllipseShape:
            CGContextAddEllipseInRect(context, self.currentRect);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kImageShape:
        {
            CGFloat horizontalOffset = _drawImage.size.width/2;
            CGFloat verticalOffset = _drawImage.size.height/2;
            CGPoint drawPoint = CGPointMake(_lastTouch.x - horizontalOffset, _lastTouch.y - verticalOffset);
            [_drawImage drawAtPoint:drawPoint];
        }
            break;
        default:
            break;
    }
}

- (CGRect)currentRect {
    return CGRectMake(_firstTouch.x,
                      _firstTouch.y,
                      _lastTouch.x - _firstTouch.x,
                      _lastTouch.y - _firstTouch.y);
}

@end
