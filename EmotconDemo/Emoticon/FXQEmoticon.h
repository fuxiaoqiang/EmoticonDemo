//
//  Emoticon.h
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/27.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXQEmoticon : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

@property (copy,nonatomic) NSString *chs;

@property (assign,nonatomic) BOOL isEmpty;

@property (assign,nonatomic) BOOL isRemove;

@property (copy,nonatomic) NSString *codePath;

@property (copy,nonatomic) NSString *pngPath;

@end
