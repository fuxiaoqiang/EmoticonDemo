//
//  EmoticonViewController.h
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/24.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXQEmoticonMananger.h"
#import "FXQEmoticonBox.h"
#import "FXQEmoticon.h"
#import "UITextView+Extension.h"
@interface FXQEmoticonViewController : UIViewController

- (instancetype)initWithItemClick:(void (^)(FXQEmoticon *Emoticon))block;

@end
