//
//  JUNCollectionViewDynamicBuilder.m
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewDynamicBuilder.h"

@interface JUNCollectionViewDynamicBuilder ()

@property(nonatomic, strong, readonly) NSUInteger (^countBuilder)(void);
@property(nonatomic, strong, readonly) UIView *(^itemBuilder)(NSUInteger index);

@property(nonatomic, readonly) NSUInteger cachedItemCount;

@end

@implementation JUNCollectionViewDynamicBuilder

- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView * _Nonnull (^)(NSUInteger))itemBuilder {
    if (self = [super init]) {
        _countBuilder = countBuilder;
        _itemBuilder = itemBuilder;
    }
    return self;
}

- (NSUInteger)_getItemCount {
    NSParameterAssert(self.countBuilder != nil);
    _cachedItemCount = self.countBuilder();
    return _cachedItemCount;
}

- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(self.itemBuilder != nil);
    return self.itemBuilder(indexPath.row);
}

@end
