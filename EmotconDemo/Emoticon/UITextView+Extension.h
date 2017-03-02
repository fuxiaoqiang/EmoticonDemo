//
//  UITextView+Extension.h
//  EmotconDemo
//
//  Created by 付晓强 on 17/3/2.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXQEmoticon.h"
@interface UITextView (Extension)

- (NSString *)getEmoticonString;

- (void)insertEmoticon:(FXQEmoticon *)emoticon;

- (NSAttributedString *)replaceStrWithEmoticon:(NSString *)str;

@end
