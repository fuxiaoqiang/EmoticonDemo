//
//  EmoticonBox.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/27.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "FXQEmoticonBox.h"
#import "FXQEmoticon.h"

@interface FXQEmoticonBox()

@end

@implementation FXQEmoticonBox

- (instancetype)initWithStr:(NSString *)str
{
    self = [super init];
    if (self) {
        self.emoticons = [NSMutableArray array];
        [self setupEmoticonWithStr:str];
    }
    return self;
}

- (void)setupEmoticonWithStr:(NSString *)str{
    if ([str isEqualToString:@""]) {
        [self addEmptyEmoticon:YES];
        return;
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    NSString *bundleStr = [NSString stringWithFormat:@"%@/%@/info1.plist",bundlePath,str];
    NSArray *arr = [NSArray arrayWithContentsOfFile:bundleStr];
    int index = 0;
    for (int i=0; i<arr.count; i++) {
        NSMutableDictionary *dict = arr[i];
        if (dict[@"png"]) {
            dict[@"png"] = [NSString stringWithFormat:@"%@/%@",str,dict[@"png"]];
        }
        
        [self.emoticons addObject:[[FXQEmoticon alloc] initWithDict:dict]];
        index++;
        if (index == 20) {
            FXQEmoticon *emoticon = [[FXQEmoticon alloc] init];
            emoticon.isRemove = YES;
            [self.emoticons addObject:emoticon];
            index = 0;
        }
        
    }
    [self addEmptyEmoticon:NO];
}

- (void)addEmptyEmoticon:(BOOL)isRecently{
    if (isRecently) {
        for (int i=0; i<20; i++) {
            FXQEmoticon *emoticon = [[FXQEmoticon alloc] init];
            emoticon.isEmpty = YES;
            [self.emoticons addObject:emoticon];
        }
        FXQEmoticon *emoticon = [[FXQEmoticon alloc] init];
        emoticon.isRemove = YES;
        [self.emoticons addObject:emoticon];
    }else{
        int count = self.emoticons.count%21;
        if (count) {
            for (int i = count; i < 20; i++) {
                FXQEmoticon *emoticon = [[FXQEmoticon alloc] init];
                emoticon.isEmpty = YES;
                [self.emoticons addObject:emoticon];
            }
            FXQEmoticon *emoticon = [[FXQEmoticon alloc] init];
            emoticon.isRemove = YES;
            [self.emoticons addObject:emoticon];
        }
    }
    
}

@end
