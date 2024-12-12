//
//  ViewController.m
//  app
//
//  Created by ooc on 2023/8/23.
//

#import "ViewController.h"
#import "YXClipHeaderOverlap.h"

/**
 * 设置 0 查看默认的重叠情况
 * 设置 1 查看开启裁剪后的效果
 */
static NSInteger CLIP_FLAG = 1;

@interface ViewController () <UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource>

@property (strong ,nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 100;
    frame.size.height = frame.size.height - frame.origin.y;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.sectionHeadersPinToVisibleBounds = YES;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _collectionView.backgroundColor = [UIColor colorWithRed:222 / 255.0 green:222 / 255.0 blue:222 / 255.0 alpha:1.0];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.view addSubview:_collectionView];
}

#pragma mark - collection view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (CLIP_FLAG == 1) {
        [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_collectionView];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"Cell %@-%@",@(indexPath.section) ,@(indexPath.row)];
    [cell addSubview:label];
    
    [label sizeToFit];
    CGPoint center = CGPointZero;
    center.x = cell.frame.size.width * 0.5;
    center.y = cell.frame.size.height * 0.5;
    label.center = center;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    double width = collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right;
    return CGSizeMake(width, 44);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (CLIP_FLAG == 1) {
        [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:collectionView willDisplayCell:cell];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(collectionView.frame.size.width, 50);
    }
    if (section == 1) {
        return CGSizeMake(collectionView.frame.size.width, 70);
    }
    return CGSizeMake(collectionView.frame.size.width, 44);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    [header.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"Header %@" ,@(indexPath.section)];
    [header addSubview:label];
    
    [label sizeToFit];
    CGPoint center = CGPointZero;
    center.x = header.frame.size.width * 0.5;
    center.y = header.frame.size.height * 0.5;
    label.center = center;
    
    return header;
}

@end
