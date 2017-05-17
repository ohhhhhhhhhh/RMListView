//
//  RMHomeListView.h
//  RWHMagic
//
//  Created by ohhh on 2017/5/11.
//  Copyright © 2017年 RWH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMHomeListView;
@protocol RMHomeListViewDelegate <NSObject>

@optional
// 点击事件
- (void)homeListView:(RMHomeListView *)listView buttonClick:(UIButton *)button selectedButtonText:(NSMutableArray *)seletedButtonText;

@end

@interface RMHomeListView : UIView

@property (nonatomic,  weak) id<RMHomeListViewDelegate> delegate;

/**
 ⚠️ 注意  如果要设置Button的属性 一定要在设置数据之前设置
 */
@property (nonatomic,strong) NSArray<NSString *> * list;

/***********************  Button的属性  **********************************/
// !!! 注意 默认button是不响应点击事件的
// 是否响应点击事件
@property (nonatomic,assign) BOOL isResponseAction;
// 边框颜色
@property (nonatomic,  copy) UIColor * buttonBorderColor;
// 边框线宽
@property (nonatomic,assign) CGFloat borderLineWidth;
// 圆角
@property (nonatomic,assign) CGFloat buttonCornerRadius;
// 选中的背景颜色
@property (nonatomic,  copy) UIColor * buttonSelectedBackgroundColor;
// 按钮背景颜色
@property (nonatomic,  copy) UIColor * buttonNormalBackgroundColor;
// 文字颜色 默认黑色
@property (nonatomic,  copy) UIColor * buttonTextColor;


@property (nonatomic,assign) CGFloat listViewHeight;

+ (instancetype)listViewWithFrame:(CGRect)frame;

@end
