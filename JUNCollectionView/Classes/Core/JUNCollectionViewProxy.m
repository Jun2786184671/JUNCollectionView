//
//  JUNCollectionViewProxy.m
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewProxy.h"
#import "JUNCollectionViewStaticBuilder.h"
#import "JUNCollectionViewDynamicBuilder.h"
#import <objc/runtime.h>

@interface JUNCollectionViewProxy () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *target;
@property(nonatomic, strong) JUNCollectionViewAbstractBuilder *builder;
@property(nonatomic, assign) UICollectionViewScrollDirection direction;
@property(nonatomic, weak) id<UICollectionViewDelegate> delegate;
@property(nonatomic, weak) id<UICollectionViewDataSource> dataSource;

@property(nonatomic, assign) CGFloat jun_minimumLineSpacing;
@property(nonatomic, assign) CGFloat jun_minimumInteritemSpacing;
@property(nonatomic, assign) CGSize jun_itemSize;
@property(nonatomic, assign) UIEdgeInsets jun_inset;

@end

@implementation JUNCollectionViewProxy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.target = nil;
    }
    return self;
}

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> * _Nonnull (^)(void))itemsBuilder direction:(UICollectionViewScrollDirection)direction {
    if (self = [super init]) {
        self.direction = direction;
        self.builder = [[JUNCollectionViewStaticBuilder alloc] initWithItemsBuiler:itemsBuilder];
    }
    return self;
}

- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))itemCountBuilder itemBuilder:(UIView * _Nonnull (^)(NSUInteger))itemBuilder direction:(UICollectionViewScrollDirection)direction {
    if (self = [super init]) {
        self.direction = direction;
        self.builder = [[JUNCollectionViewDynamicBuilder alloc] initWithItemCountBuilder:itemCountBuilder itemBuilder:itemBuilder];
    }
    return self;
}

- (UICollectionView *)target {
    if (_target == nil) {
        UICollectionViewLayout *layout = [self _createCollectionViewLayout];
        _target = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self _setUpTarget];
    }
    return _target;
}

- (UICollectionViewLayout *)_createCollectionViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = self.direction;
    return layout;
}

- (void)_setUpTarget {
    self.target.translatesAutoresizingMaskIntoConstraints = false;
    self.target.backgroundColor = [UIColor clearColor];
    [self.target registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:JUNCollectionViewCellReuseId];
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    _delegate = delegate;
    self.target.delegate = self;
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _dataSource = dataSource;
    self.target.dataSource = self;
}

- (void)setJun_itemSize:(CGSize)itemSize {
    _jun_itemSize = itemSize;
    self.builder.itemSize = itemSize;
}

- (void)setJun_minimumLineSpacing:(CGFloat)minimumLineSpacing {
    _jun_minimumLineSpacing = minimumLineSpacing;
    self.builder.minimumLineSpacing = minimumLineSpacing;
}

- (void)setJun_minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    _jun_minimumInteritemSpacing = minimumInteritemSpacing;
    self.builder.minimumInteritemSpacing = minimumInteritemSpacing;
}

- (void)setJun_inset:(UIEdgeInsets)jun_inset {
    _jun_inset = jun_inset;
    self.builder.inset = jun_inset;
}

- (void)didMoveToSuperview {
    if (self.target.superview) return;
    [self addSubview:self.target];
    self.target.delegate = self;
    self.target.dataSource = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.target.frame = self.bounds;
}

#pragma mark - Proxy

- (bool)respondsToSelector:(SEL)aSelector {
//    NSLog(@"%@, %d", NSStringFromSelector(aSelector), [self forwardingTargetForSelector:aSelector] != nil);
    if (aSelector == NSSelectorFromString(@"_diffableDataSourceImpl")) return false;
    if ([super respondsToSelector:aSelector]) return true;
    return [self forwardingTargetForSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.target respondsToSelector:aSelector]) {
        return self.target;
    } else if ([self _isCollectionViewDelegateMethod:aSelector] && [self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    } else if ([self _isCollectionViewDataSourceMethod:aSelector] && [self.dataSource respondsToSelector:aSelector]) {
        return self.dataSource;
    }
    return nil;
}

- (bool)_isCollectionViewDelegateMethod:(SEL)selector {
    return [self _protocol:@protocol(UICollectionViewDelegate) containsMethod:selector];
}

- (bool)_isCollectionViewDataSourceMethod:(SEL)selector {
    return [self _protocol:@protocol(UICollectionViewDataSource) containsMethod:selector];
}

- (bool)_protocol:(Protocol *)protocol containsMethod:(SEL)selector {
    struct objc_method_description desc;
    desc = protocol_getMethodDescription(protocol, selector, NO, YES);
    if(desc.name != nil) {
        return true;
    }
    desc = protocol_getMethodDescription(protocol, selector, YES, YES);
    if(desc.name != nil) {
        return true;
    }
    return false;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.builder collectionView:collectionView numberOfItemsInSection:section];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.builder collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - <UICollectionViewDelegate>

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.builder collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self.builder collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self.builder collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self.builder collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end
