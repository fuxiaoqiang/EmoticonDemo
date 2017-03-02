//
//  EmoticonMananger.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/27.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "FXQEmoticonMananger.h"
#import "FXQEmoticonBox.h"
@implementation FXQEmoticonMananger

- (instancetype)init
{
    self = [super init];
    if (self) {
        //最近
        self.emoticonArr = [NSMutableArray array];
        FXQEmoticonBox *recentlyBox = [[FXQEmoticonBox alloc] initWithStr:@""];
        [self.emoticonArr addObject:recentlyBox];
        //默认
        FXQEmoticonBox *defaultBox = [[FXQEmoticonBox alloc] initWithStr:@"com.sina.default"];
        [self.emoticonArr addObject:defaultBox];
        //Emoticon
        FXQEmoticonBox *emoticonBox = [[FXQEmoticonBox alloc] initWithStr:@"com.apple.emoji"];
        [self.emoticonArr addObject:emoticonBox];
        //浪小花
        FXQEmoticonBox *flowerBox = [[FXQEmoticonBox alloc] initWithStr:@"com.sina.lxh"];
        [self.emoticonArr addObject:flowerBox];
        
    }
    return self;
}

@end
