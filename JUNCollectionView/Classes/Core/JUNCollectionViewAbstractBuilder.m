//
//  UICollectionViewAbstractBuilder.m
//  JUNCollectionView
//
//  Created by Jun Ma on 2022/11/25.
//

#import "JUNCollectionViewAbstractBuilder.h"

NSString *JUNCollectionViewCellReuseId = @"cell";

#define JUNKitInnerException(var_reason, var_userInfo) [NSException exceptionWithName:@"JUNKitInnerException" reason:var_reason userInfo:var_userInfo]

@implementation JUNCollectionViewAbstractBuilder

- (NSUInteger)_getItemCount {
    @throw JUNKitInnerException(nil, nil);
}

- (UIView *)_getItemForIndexPath:(NSIndexPath *)indexPath {
    @throw JUNKitInnerException(nil, nil);
}

- (void)_setUpCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *item = [self _getItemForIndexPath:indexPath];
    item.translatesAutoresizingMaskIntoConstraints = false;
    [cell.contentView addSubview:item];
    [self _setUpCellConstraints:cell item:item];
}

- (void)_setUpCellConstraints:(UICollectionViewCell *)cell item:(UIView *)item {
    [cell.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self _getItemCount];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JUNCollectionViewCellReuseId forIndexPath:indexPath];
    NSParameterAssert(cell != nil);
    [self _setUpCell:cell forIndexPath:indexPath];
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIView *item = [self _getItemForIndexPath:indexPath];
    CGSize size = item.frame.size;
    if (size.width > 0.0f && size.height > 0.0f) return size;
    [item sizeToFit];
    return item.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

@end
