//
//  ViewController.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/24.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "ViewController.h"
#import "FXQEmoticonViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取字符串" style:UIBarButtonItemStylePlain target:self action:@selector(getStr)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"替换字符串" style:UIBarButtonItemStylePlain target:self action:@selector(replaceStr)];
    self.title = @"自定义表情键盘";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    __weak typeof (self) weakSelf = self;
    self.textView.font = [UIFont systemFontOfSize:18];
    FXQEmoticonViewController *emView = [[FXQEmoticonViewController alloc] initWithItemClick:^(FXQEmoticon *emoticon) {
        //插入表情
        [weakSelf.textView insertEmoticon:emoticon];
    }];
    self.textView.inputView = emView.view;
    [self.textView becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)getStr{
    NSString *str = [self.textView getEmoticonString];
    self.textView.text = str;
}

- (void)replaceStr{
    NSAttributedString *str = [self.textView replaceStrWithEmoticon:self.textView.text];
    self.textView.attributedText = str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
