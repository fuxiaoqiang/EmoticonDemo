//
//  Emoticon.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/27.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "FXQEmoticon.h"

@interface FXQEmoticon()

@property (copy,nonatomic) NSString *code;

@property (copy,nonatomic) NSString *png;

@end

@implementation FXQEmoticon

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //KVC容错处理
}
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)
- (void)setCode:(NSString *)code{
    char *charCode = (char *)code.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    NSString * s = [NSString stringWithFormat:@"%ld",intCode];
    int symbol = EmojiCodeToSymbol([s intValue]);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }

    self.codePath = string;

}

- (void)setPng:(NSString *)png{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
    self.pngPath = [bundlePath stringByAppendingPathComponent:png];
}


@end
