//
//  JUNCollectionViewStaticBuilder.m
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewStaticBuilder.h"

@interface JUNCollectionViewStaticBuilder ()

@property(nonatomic, strong, readonly) NSArray<UIView *> *(^itemsBuilder)(void);

@property(nonatomic, strong, readonly) NSArray<UIView *> *cachedItems;

@end

@implementation JUNCollectionViewStaticBuilder

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> * _Nonnull (^)(void))itemsBuilder {
    if (self = [super init]) {
        _itemsBuilder = itemsBuilder;
    }
    return self;
}

- (NSUInteger)_getItemCount {
    NSParameterAssert(self.itemsBuilder != nil);
    _cachedItems = self.itemsBuilder();
    return _cachedItems.count;
}

- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath {
    return self.cachedItems[indexPath.row];
}

@end
