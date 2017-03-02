//
//  FXQCollectionViewCell.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/24.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "FXQCollectionViewCell.h"

@interface FXQCollectionViewCell()

@property (nonatomic,retain) UIButton *btn;
//@property (nonatomic,retain) Emoticon *emoticon;

@end

@implementation FXQCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.userInteractionEnabled = NO;
        _btn.frame = self.contentView.bounds;
        [self.contentView addSubview:_btn];
    }
    return self;
}

- (void)setEmoticon:(FXQEmoticon *)emoticon{
    [self.btn setTitle:emoticon.codePath forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageWithContentsOfFile:emoticon.pngPath] forState:UIControlStateNormal];
    if (emoticon.isRemove) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
        NSString *deletePngPath = [bundlePath stringByAppendingPathComponent:@"emotion_delete"];
        [self.btn setImage:[UIImage imageWithContentsOfFile:deletePngPath] forState:UIControlStateNormal];
    }
}

@end
