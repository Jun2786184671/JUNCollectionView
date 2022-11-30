//
//  UICollectionViewAbstractBuilder.h
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *JUNCollectionViewCellReuseId;

@interface JUNCollectionViewAbstractBuilder : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (NSUInteger)_getItemCount;
- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic, assign) CGFloat minimumLineSpacing;
@property(nonatomic, assign) CGFloat minimumInteritemSpacing;
@property(nonatomic, assign) CGSize itemSize;
@property(nonatomic, assign) UIEdgeInsets inset;

@end

NS_ASSUME_NONNULL_END
