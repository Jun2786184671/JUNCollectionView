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
    item = [self _wrapItem:item];
    [cell.contentView addSubview:item];
    [self _setUpCellConstraints:cell item:item];
}

- (UIView *)_wrapItem:(UIView *)item {
    item.translatesAutoresizingMaskIntoConstraints = false;
    UIView *itemWrapper = [[UIView alloc] init];
    itemWrapper.translatesAutoresizingMaskIntoConstraints = false;
    [itemWrapper addSubview:item];
    [itemWrapper addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:itemWrapper attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    return itemWrapper;
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
    [self _validateItemFrame:item];
    CGSize size = item.frame.size;
    if (size.width > 0.0f && size.height > 0.0f) return size;
    return self.itemSize;
}

// TODO: this method will be integrated to JUNFlex uiview's extension later
- (void)_validateItemFrame:(UIView *)item {
    CGRect frame = item.frame;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (!w || !h) {
        [item sizeToFit];
        w = w ? w : item.frame.size.width;
        h = h ? h : item.frame.size.height;
        frame.size.width = w;
        frame.size.height = h;
        item.frame = frame;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    NSParameterAssert([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]);
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    NSParameterAssert([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]);
    return self.minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.inset;
}

@end
