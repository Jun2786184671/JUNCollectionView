//
//  JUNCollectionViewStaticBuilder.h
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewAbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNCollectionViewStaticBuilder : JUNCollectionViewAbstractBuilder

- (instancetype)initWithItemsBuiler:(NSArray<UIView *> *(^)(void))itemsBuilder;

@end

NS_ASSUME_NONNULL_END
