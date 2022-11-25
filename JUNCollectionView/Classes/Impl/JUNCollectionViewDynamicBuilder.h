//
//  JUNCollectionViewDynamicBuilder.h
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewAbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNCollectionViewDynamicBuilder : JUNCollectionViewAbstractBuilder

- (instancetype)initWithItemCountBuilder:(NSUInteger (^)(void))countBuilder itemBuilder:(UIView *(^)(NSUInteger index))itemBuilder;

@end

NS_ASSUME_NONNULL_END
