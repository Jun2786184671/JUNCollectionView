//
//  UICollectionView+JUNex.h
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<UIView *> * _Nonnull (^JUNCollectionViewItemsBuilder)(void);
typedef UIView * _Nonnull (^JUNCollectionViewItemIndexBuilder)(NSUInteger index);
typedef UIView * _Nonnull (^JUNCollectionViewItemForEachBuilder)(NSUInteger index, id element);
typedef NSUInteger (^JUNCollectionViewCountBuilder)(void);

@interface UICollectionView (JUNex)

+ (instancetype)jun_collectionViewWithItems:(NSArray<UIView *> *)items direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemsBuilder:(JUNCollectionViewItemsBuilder)itemsBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemCountBuilder:(JUNCollectionViewCountBuilder)countBuilder itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNCollectionViewItemForEachBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;

// The following attribute assignments are only valid for CollectionViews created with the jun prefix methods above.
@property(nonatomic, assign) CGFloat jun_minimumLineSpacing;
@property(nonatomic, assign) CGFloat jun_minimumInteritemSpacing;
@property(nonatomic, assign) CGFloat jun_itemSize;
@property(nonatomic, assign) UIEdgeInsets jun_inset;

@end

NS_ASSUME_NONNULL_END
