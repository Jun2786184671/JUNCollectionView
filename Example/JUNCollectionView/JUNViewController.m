//
//  JUNViewController.m
//  JUNCollectionView
//
//  Created by Jun Ma on 11/25/2022.
//  Copyright (c) 2022 Jun Ma. All rights reserved.
//

#import "JUNViewController.h"
#import <JUNCollectionView/UICollectionView+JUNex.h>

@interface JUNViewController () <UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation JUNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView = [self testCreateMethod3];
    
    [self testSetProperties];
    
    self.collectionView.frame = self.view.bounds;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
}

- (UICollectionView *)testCreateMethod1 {
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"aLabel";
    aLabel.textColor = [UIColor blackColor];
    [aLabel sizeToFit];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"aButton" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [aButton sizeToFit];
    UISwitch *aSwitch = [[UISwitch alloc] init];
    [aSwitch sizeToFit];
    
    return [UICollectionView jun_collectionViewWithItems:@[
        aLabel,
        aButton,
        aSwitch,
    ] direction:UICollectionViewScrollDirectionHorizontal];
}

- (UICollectionView *)testCreateMethod2 {
    UICollectionView *collectionView = [UICollectionView jun_collectionViewWithItemCountBuilder:^NSUInteger{
        return arc4random_uniform(20);
    } itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        unsigned int type = index % 3;
        switch (type) {
            case 0: {
                UILabel *aLabel = [[UILabel alloc] init];
                aLabel.textColor = [UIColor blackColor];
                aLabel.text = [NSString stringWithFormat:@"label %lu", index];
                return aLabel;
            }
            case 1: {
                UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [aButton setTitle:[NSString stringWithFormat:@"button %lu", index] forState:UIControlStateNormal];
                [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                return aButton;
            }
            default: {
                UISwitch *aSwitch = [[UISwitch alloc] init];
                return aSwitch;
            }
        }
    } direction:UICollectionViewScrollDirectionHorizontal];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        [collectionView reloadData];
    }];
    
    return collectionView;
}

- (UICollectionView *)testCreateMethod3 {
    NSMutableArray *elements = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        [elements addObject:@(i)];
    }
    return [UICollectionView jun_collectionViewWithForEach:elements itemBuilder:^UIView * _Nonnull(NSUInteger index, id  _Nonnull element) {
        unsigned int type = [element integerValue] % 3;
        switch (type) {
            case 0: {
                UILabel *aLabel = [[UILabel alloc] init];
                aLabel.textColor = [UIColor blackColor];
                aLabel.text = [NSString stringWithFormat:@"label %lu", index];
                return aLabel;
            }
            case 1: {
                UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [aButton setTitle:[NSString stringWithFormat:@"button %lu", index] forState:UIControlStateNormal];
                [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                return aButton;
            }
            default: {
                UISwitch *aSwitch = [[UISwitch alloc] init];
                return aSwitch;
            }
        }
    } direction:UICollectionViewScrollDirectionHorizontal];
}

- (void)testSetProperties {
    self.collectionView.alwaysBounceVertical = true;
//    self.collectionView.jun_minimumLineSpacing = 30;
    self.collectionView.jun_minimumInteritemSpacing = 30;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}

@end
