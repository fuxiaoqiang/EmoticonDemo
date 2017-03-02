//
//  EmoticonBox.h
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/27.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXQEmoticonBox : NSObject

- (instancetype)initWithStr:(NSString *)str;

@property (retain,nonatomic) NSMutableArray *emoticons;

@end
