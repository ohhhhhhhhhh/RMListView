//
//  RMHomeAutoView.m
//  RWHMagic
//
//  Created by ohhh on 2017/5/11.
//  Copyright © 2017年 RWH. All rights reserved.
//

#import "RMHomeListView.h"

// 每一个button的高度
CGFloat listButtonHeight = 16.f;
// button之间间隔  XMargin == YMargin
CGFloat const listButtonMargin = 8.f;
// button tag 的起始值
int const buttonTag = 999;

@interface RMHomeListView ()

@end

@implementation RMHomeListView{

    CGFloat previousMaxX;
    CGFloat viewHeight;
    CGFloat viewWidth;
    NSMutableArray * selectedButtonText;
}

+ (instancetype)listViewWithFrame:(CGRect)frame{
    
    RMHomeListView * listView= [[self alloc]initWithFrame:frame];
    return listView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        selectedButtonText = [NSMutableArray array];
        viewWidth = CGRectGetWidth(self.bounds);
    }
    return self;
}

#pragma mark -setData
-(void)setList:(NSArray<NSString *> *)list{
    
    _list = list;
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    previousMaxX = 0.f;
    
    __block CGFloat x = listButtonMargin;
    __block CGFloat y = listButtonMargin;
    __block CGFloat width = 0.f;
    __block CGFloat MaxX = 0.f;
    
    __block UIButton * lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btn.tag = buttonTag + idx;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (self.isResponseAction) {
            [btn addTarget:self action:@selector(homeListButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (self.buttonBorderColor) {
            btn.layer.borderColor = self.buttonBorderColor.CGColor;
        }
        
        if (!(self.borderLineWidth == 0 || self.borderLineWidth == NSNotFound)) {
            btn.layer.borderWidth = self.borderLineWidth;
            listButtonHeight += self.borderLineWidth;
        }
        
        if (!(self.buttonCornerRadius == 0 || self.buttonCornerRadius == NSNotFound)) {
            btn.layer.cornerRadius = self.buttonCornerRadius;
        }
        
        if (self.buttonTextColor) {
            [btn setTitleColor:self.buttonTextColor forState:UIControlStateNormal];
        }
        
        if (self.buttonNormalBackgroundColor) {
            btn.backgroundColor = self.buttonNormalBackgroundColor;
        }
        
        width = [self caluteWidthWithString:obj height:listButtonHeight font:14.f];
        // for 边框看起来不挤
        width += listButtonMargin;
        
        width = width > viewWidth ? (viewWidth - 2*listButtonMargin): width;
        
        MaxX = previousMaxX + width + listButtonMargin;
        if (MaxX >= viewWidth || MaxX < 0) {
            
            x = listButtonMargin;
            y = y + listButtonMargin + listButtonHeight;
        }else{
            x = previousMaxX + listButtonMargin;
        }
        
        btn.frame = CGRectMake(x, y, width, listButtonHeight);
        previousMaxX = CGRectGetMaxX(btn.frame);
        
        lastButton = btn;
    }];
    
    viewHeight = CGRectGetMaxY(lastButton.frame)+listButtonMargin;
    self.listViewHeight = viewHeight;
    [self layoutIfNeeded];
}


#pragma mark -button Action
- (void)homeListButtonClick:(UIButton *)btn{
    
    if (btn.tag < buttonTag) {
        return;
    }
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        btn.backgroundColor = self.buttonSelectedBackgroundColor;
        [selectedButtonText addObject:self.list[btn.tag-buttonTag]];
    }else{
        btn.backgroundColor = self.buttonNormalBackgroundColor;
        [selectedButtonText removeObject:self.list[btn.tag-buttonTag]];
    }
    
    if ([self.delegate respondsToSelector:@selector(homeListView:buttonClick:selectedButtonText:)]) {
        [self.delegate homeListView:self buttonClick:btn selectedButtonText:selectedButtonText];
    }
}

#pragma mark-helper
- (CGFloat)caluteWidthWithString:(NSString *)string height:(CGFloat)height font:(CGFloat)fontSize{
    
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect rect = self.frame;
    rect.size.height = viewHeight;
    self.frame = rect;
}

@end
