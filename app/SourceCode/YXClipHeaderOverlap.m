//
//  YXClipHeaderOverlap.m
//  app
//
//  Created by ooc on 2024/12/12.
//

#import "YXClipHeaderOverlap.h"

@implementation YXClipHeaderOverlap

+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView {
    [self adjustCellMaskForHeaderOverlapWithListView:listView willDisplayCell:nil];
}

+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView willDisplayCell:(UIView *)willDisplayCell {
    if ([listView isKindOfClass:[UICollectionView class]]) {
        [self _adjustCellMaskForHeaderOverlapWithCollectionView:(UICollectionView *)listView willDisplayCell:willDisplayCell];
        return;
    }
    if ([listView isKindOfClass:[UITableView class]]) {
        [self _adjustCellMaskForHeaderOverlapWithTableView:(UITableView *)listView willDisplayCell:willDisplayCell];
        return;
    }
}

+ (void)_adjustCellMaskForHeaderOverlapWithCollectionView:(UICollectionView *)collectionView willDisplayCell:(UIView *)willDisplayCell {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGPoint contentOffset = collectionView.contentOffset;
    NSMutableArray *visibleCells = [NSMutableArray arrayWithArray:[collectionView visibleCells]];
    // 将要显示的 cell 也参与检测，修复下拉时顶部 cell 一闪一闪的问题
    if (willDisplayCell) {
        [visibleCells addObject:willDisplayCell];
    }
    
    for (UICollectionViewCell *cell in visibleCells) {
        CALayer *maskLayer = cell.layer.mask;
        if (maskLayer == nil) {
            maskLayer = [CALayer layer];
            maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.layer.mask = maskLayer;
        }
        
        CGRect frame = cell.bounds;
        
        NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
        
        double headerHeight = 0;
        if ([layout respondsToSelector:@selector(headerReferenceSize)]) {
            headerHeight = [layout headerReferenceSize].height;
        }
        id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)collectionView.delegate;
        if ([layoutDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headerHeight = [layoutDelegate collectionView:collectionView layout:collectionView.collectionViewLayout referenceSizeForHeaderInSection:indexPath.section].height;
        }
        double threshold = contentOffset.y + headerHeight;
        
        if (cell.frame.origin.y < threshold) {
            double diff = threshold - cell.frame.origin.y;
            frame.origin.y = diff;
        }
        
        if (cell == willDisplayCell) {
            frame.size.height = 0;
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        maskLayer.frame = frame;
        [CATransaction commit];
    }
}

+ (void)_adjustCellMaskForHeaderOverlapWithTableView:(UITableView *)tableView willDisplayCell:(UIView *)willDisplayCell {
    // 暂不支持
}
@end
