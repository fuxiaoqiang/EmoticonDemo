//
//  UITextView+Extension.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/3/2.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "UITextView+Extension.h"
#import "FXQEmoticonBox.h"
#import "FXQEmoticonMananger.h"
#import "FXQTextAttachment.h"
@implementation UITextView (Extension)
//插入表情
- (void)insertEmoticon:(FXQEmoticon *)emoticon{
    NSRange range = self.selectedRange;
    if (emoticon.isEmpty) {
        return ;
    }
    if (emoticon.isRemove) {
        [self deleteBackward];
        return;
    }
    if (emoticon.codePath) {
        
        UITextPosition *beginning = self.beginningOfDocument;
        UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
        
        UITextPosition *end = [self positionFromPosition:start offset:range.length];
        
        UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
        
        [self replaceRange:textRange withText:emoticon.codePath];
        return;
    }
    //图片表情

    FXQTextAttachment *textAttchment = [[FXQTextAttachment alloc] init];
    textAttchment.chs = emoticon.chs;
    UIFont *font = self.font;
    textAttchment.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
    textAttchment.image = [UIImage imageWithContentsOfFile:emoticon.pngPath];
    NSAttributedString *attriImage = [NSAttributedString attributedStringWithAttachment:textAttchment];
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [textAttrStr replaceCharactersInRange:range withAttributedString:attriImage];
    self.attributedText = textAttrStr;
    range = NSMakeRange(range.location+1, 0);
    self.font = font;
    self.selectedRange = range;

}
//获取字符串
- (NSString *)getEmoticonString{
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange rangStr = NSMakeRange(0, textStr.length);
    [textStr enumerateAttributesInRange:rangStr options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        FXQTextAttachment *attachMent = attrs[@"NSAttachment"];
        if (attachMent) {
            [textStr replaceCharactersInRange:range withString:attachMent.chs];
        }
    }];
    return textStr.string;
}
//表情替换字符串

- (NSAttributedString *)replaceStrWithEmoticon:(NSString *)str{
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"\\[.*?\\]" options:0 error:&error];
    if (error) {
        return nil;
    }
    NSArray *matchs = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if (!matchs.count) {
        return nil;
    }

    for (NSInteger i = matchs.count-1; i >=0 ; i--) {
        NSTextCheckingResult *result = matchs[i];
        NSString *chs = [str substringWithRange:result.range];
        NSString *pngPatn = nil;
        FXQEmoticonMananger *manager = [[FXQEmoticonMananger alloc] init];
        for (FXQEmoticonBox *box in manager.emoticonArr) {
            for (FXQEmoticon *emoticon in box.emoticons) {
                if ([emoticon.chs isEqualToString:chs]) {
                    pngPatn = emoticon.pngPath;
                }
            }
        }
        UIImage *image = [UIImage imageWithContentsOfFile:pngPatn];
        FXQTextAttachment *textAttchment = [[FXQTextAttachment alloc] init];
        textAttchment.chs = chs;
        UIFont *font = self.font;
        textAttchment.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
        textAttchment.image = image;
        NSAttributedString *attriImage = [NSAttributedString attributedStringWithAttachment:textAttchment];
        NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [textAttrStr replaceCharactersInRange:result.range withAttributedString:attriImage];
        self.attributedText = textAttrStr;
        self.font = font;
    }
    return self.attributedText;
}

@end
