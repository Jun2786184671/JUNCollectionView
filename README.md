# JUNCollectionView

[![Version](https://img.shields.io/cocoapods/v/JUNCollectionView.svg?style=flat)](https://cocoapods.org/pods/JUNCollectionView)
[![License](https://img.shields.io/cocoapods/l/JUNCollectionView.svg?style=flat)](https://cocoapods.org/pods/JUNCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/JUNCollectionView.svg?style=flat)](https://cocoapods.org/pods/JUNCollectionView)

## Demo

To run the demo project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JUNCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JUNCollectionView'
```

## Guide
1. ```#import <JUNCollectionView/UICollectionView+JUNex.h>``` into your project's pch file, otherwise you will need to import this header in anywhere you want to quickly create a collection view.

2. There are a couple of methods that you can use to create a collection view quickly and elegantly.
```objc
+ (instancetype)jun_collectionViewWithItems:(NSArray<UIView *> *)items direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemsBuilder:(JUNCollectionViewItemsBuilder)itemsBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemCount:(NSUInteger)itemCount itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithItemCountBuilder:(JUNCollectionViewCountBuilder)countBuilder itemBuilder:(JUNCollectionViewItemIndexBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;
+ (instancetype)jun_collectionViewWithForEach:(NSArray<id> *)elements itemBuilder:(JUNCollectionViewItemForEachBuilder)itemBuilder direction:(UICollectionViewScrollDirection)direction;
```
Don't worry about not specifying some of the parameter types in these methods, when you type these methods in XCode, you'll immediately know what to do next.

3. Here are some examples.
```objc
[UICollectionView jun_collectionViewWithItems:@[
    aLabel,
    aButton,
    aSwitch,
] direction:UICollectionViewScrollDirectionHorizontal];
```
```objc
[UICollectionView jun_collectionViewWithItemCountBuilder:^NSUInteger{
    return arc4random_uniform(20);
} itemBuilder:^UIView * _Nonnull(NSUInteger index) {
    switch (index % 3) {
        case 0:
            return aLabel;
        case 1:
            return aButton;
        default:
            return aSwitch;
    }
} direction:UICollectionViewScrollDirectionHorizontal];

[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
    [collectionView reloadData];
}];
```
```objc
[UICollectionView jun_collectionViewWithForEach:elements itemBuilder:^UIView *(NSUInteger index, id  element) {
    if ([element isEqual:@"text"]) {
        return aUILabel;
    } else if ([element isEqual:@"button"]) {
        return aUIButton;
    } else {
        // Fall on other conditions...
    }
} direction:UICollectionViewScrollDirectionHorizontal];
```

4. A created collection view can set the delegate and datasource as normal.
```objc
collectionView.delegate = anyDelegate;
collectionView.dataSouce = anyDataSource;
```

5. Collection view created by the above methods has some additional properties.
```objc
@property(nonatomic, assign) CGFloat jun_minimumLineSpacing;
@property(nonatomic, assign) CGFloat jun_minimumInteritemSpacing;
@property(nonatomic, assign) CGFloat jun_itemSize;
```
You can go to ```<JUNCollectionView/UICollectionView+JUNex.h>``` to see in detail.

## Author

Jun Ma, maxinchun5@gmail.com

## License

JUNCollectionView is available under the MIT license. See the LICENSE file for more info.
