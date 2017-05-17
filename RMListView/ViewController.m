//
//  ViewController.m
//  RMListView
//
//  Created by ohhh on 2017/5/17.
//  Copyright © 2017年 ohhh. All rights reserved.
//

#import "ViewController.h"
#import "RMHomeListView.h"

@interface ViewController ()<RMHomeListViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray<NSString *> * arr = @[@"呵呵呵",@"哈哈哈",@"注意 默认button是不响应点击事件的",@"嘿嘿",@"吼吼",@"答应我,具体的用法和其他属性请看.h文件好吗",@"好的",@"嘎嘎嘎嘎嘎嘎嘎嘎",@"哇哇哇哇",@"注意  如果要设置Button的属性 一定要在设置数据之前设置"];
    
    RMHomeListView * listV = [RMHomeListView listViewWithFrame:CGRectMake(10, 50, self.view.bounds.size.width-20, 0)];
    
    listV.delegate = self;
    listV.borderLineWidth = 0.5;
    listV.buttonBorderColor = [UIColor redColor];
    listV.buttonTextColor = [UIColor grayColor];
    listV.buttonSelectedBackgroundColor = [UIColor orangeColor];
    listV.buttonNormalBackgroundColor = [UIColor yellowColor];
    listV.isResponseAction = YES;
    listV.buttonCornerRadius = 5;
    
    // !!! 如果要设置Button的属性 一定要在设置数据之前设置
    listV.list = arr;
    
    [self.view addSubview:listV];
}

-(void)homeListView:(RMHomeListView *)listView buttonClick:(UIButton *)button selectedButtonText:(NSMutableArray *)seletedButtonText{
    
    NSLog(@"selected text ================================================\n");
    
    [seletedButtonText enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"%@\n",obj);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
