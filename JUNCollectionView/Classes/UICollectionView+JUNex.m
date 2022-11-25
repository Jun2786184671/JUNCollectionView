//
//  UICollectionView+JUNex.m
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "UICollectionView+JUNex.h"
#import "JUNCollectionViewProxy.h"

@implementation UICollectionView (JUNex)
@dynamic jun_itemSize, jun_minimumLineSpacing, jun_minimumInteritemSpacing, jun_inset;

+ (instancetype)jun_collectionViewWithItems:(NSArray<UIView *> *)items direction:(UICollectionViewScrollDirection)direction {
    return (UICollectionView *)[[JUNCollectionViewProxy alloc] initWithItemsBuiler:^NSArray<UIView *> * _Nonnull{
        return items;
    } direction:direction];
}

+ (instancetype)jun_collectionViewWithItemsBuilder:(JUNCollectionViewItemsBuilder)itemsBuilder direction:(UICollectionViewScrollDirection)direction {
    return (UICollectionView *)[[JUNCollectionViewProxy alloc] initWithItemsBuiler:itemsBuilder direction:direction];
}

+ (instancetype)jun_collectionViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction {
    return (UICollectionView *)[[JUNCollectionViewProxy alloc] initWithItemCountBuilder:^NSUInteger{
        return itemCount;
    } itemBuilder:itemBuilder direction:direction];
}

+ (instancetype)jun_collectionViewWithItemCountBuilder:(JUNCollectionViewCountBuilder)countBuilder itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction {
    return (UICollectionView *)[[JUNCollectionViewProxy alloc] initWithItemCountBuilder:countBuilder itemBuilder:itemBuilder direction:direction];
}

+ (instancetype)jun_collectionViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNCollectionViewItemForEachBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction {
    return (UICollectionView *)[[JUNCollectionViewProxy alloc] initWithItemCountBuilder:^NSUInteger{
        return elements.count;
    } itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        return itemBuilder(index, elements[index]);
    } direction:direction];
}

@end
