//
//  JUNCollectionViewProxy.h
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNCollectionViewProxy : UIView

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> *(^)(void))itemsBuilder direction:(UICollectionViewScrollDirection)direction;
- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView *(^)(NSUInteger index))itemBuilder direction:(UICollectionViewScrollDirection)direction;

@end

NS_ASSUME_NONNULL_END
