//
//  EmoticonViewController.m
//  EmotconDemo
//
//  Created by 付晓强 on 17/2/24.
//  Copyright © 2017年 付晓强. All rights reserved.
//

#import "FXQEmoticonViewController.h"
#import "FXQCollectionViewCell.h"

static NSString *identifier = @"FXQCollectionViewCell";

@interface FXQEmoticonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (retain,nonatomic) UICollectionView *collectionView;
@property (retain,nonatomic) UIToolbar *toolBar;
@property (copy,nonatomic) void (^block)(FXQEmoticon *emoticon);
@property (retain,nonatomic) FXQEmoticonMananger *manager;
@end

@implementation FXQEmoticonViewController

- (instancetype)initWithItemClick:(void (^)(FXQEmoticon *emoticon))block
{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[FXQEmoticonMananger alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)setUpUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolBar];
    [_collectionView registerClass:[FXQCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDic = @{@"toolBar" : _toolBar, @"collectionView" : _collectionView};
    NSArray *con1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|" options:0 metrics:nil views:viewsDic];
    NSArray *con2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-[toolBar]-0-|" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:viewsDic];
    [self.view addConstraints:con1];
    [self.view addConstraints:con2];
    int inset = (int)(_collectionView.frame.size.height - 3*([UIScreen mainScreen].bounds.size.width/7))/2;
    _collectionView.contentInset = UIEdgeInsetsMake(inset, 0, inset, 0);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)viewDidLayoutSubviews{
    NSLog(@"%@",NSStringFromCGRect(_collectionView.frame));
    [self setUpUI];
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        NSArray *tiltleArr = @[@"最近", @"默认", @"emoji", @"浪小花"];
        NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray array];
        for (int i=0; i<tiltleArr.count; i++) {
            UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithTitle:tiltleArr[i] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
            tempItem.tag = i;
            [items addObject:tempItem];
            UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:spaceItem];
        }
        [items removeLastObject];
        _toolBar.tintColor = [UIColor orangeColor];
        _toolBar.items = (NSArray *)items;
    }
    return _toolBar;
}

- (void)itemClick:(UIBarButtonItem *)item{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:item.tag];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemHW = [UIScreen mainScreen].bounds.size.width/7;
        layout.itemSize = CGSizeMake(itemHW, itemHW);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.manager.emoticonArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FXQEmoticonBox *box = self.manager.emoticonArr[section];
    return box.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXQCollectionViewCell *cell = (FXQCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    FXQEmoticonBox *box = self.manager.emoticonArr[indexPath.section];
    cell.emoticon = box.emoticons[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld",(long)indexPath.item);
    
    FXQEmoticonBox *box = self.manager.emoticonArr[indexPath.section];
    FXQEmoticon *emoticon = box.emoticons[indexPath.item];
    FXQEmoticonBox *box1 = self.manager.emoticonArr.firstObject;
    if (emoticon.isEmpty||emoticon.isRemove) {
        self.block(emoticon);
        return;
    }
    if ([box1.emoticons containsObject:emoticon]) {
        [box1.emoticons removeObject:emoticon];
    }else{
        [box1.emoticons removeObjectAtIndex:19];
    }
    
    [box1.emoticons insertObject:emoticon atIndex:0];
    
    self.block(emoticon);
}


@end
