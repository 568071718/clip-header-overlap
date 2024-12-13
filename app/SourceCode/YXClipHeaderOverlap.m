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
    
    for (UIView *cell in visibleCells) {
        NSIndexPath *indexPath = [collectionView indexPathForCell:(UICollectionViewCell *)cell];
        
        double headerHeight = 0;
        if ([layout respondsToSelector:@selector(headerReferenceSize)]) {
            headerHeight = [layout headerReferenceSize].height;
        }
        id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)collectionView.delegate;
        if ([layoutDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headerHeight = [layoutDelegate collectionView:collectionView layout:collectionView.collectionViewLayout referenceSizeForHeaderInSection:indexPath.section].height;
        }
        double threshold = contentOffset.y + headerHeight;
        
        CALayer *maskLayer = cell.layer.mask;
        if (maskLayer == nil) {
            maskLayer = [CALayer layer];
            maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.layer.mask = maskLayer;
        }
        
        CGRect maskFrame = cell.bounds;
        if (cell.frame.origin.y < threshold) {
            double diff = threshold - cell.frame.origin.y;
            maskFrame.origin.y = diff;
        }
        
        if (cell == willDisplayCell) {
            maskFrame.size.height = 0;
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        maskLayer.frame = maskFrame;
        [CATransaction commit];
    }
}

+ (void)_adjustCellMaskForHeaderOverlapWithTableView:(UITableView *)tableView willDisplayCell:(UIView *)willDisplayCell {
    CGPoint contentOffset = tableView.contentOffset;
    NSMutableArray *visibleCells = [NSMutableArray arrayWithArray:[tableView visibleCells]];
    
    // 将要显示的 cell 也参与检测，修复下拉时顶部 cell 一闪一闪的问题
    if (willDisplayCell) {
        [visibleCells addObject:willDisplayCell];
    }
    
    for (UIView *cell in visibleCells) {
        NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell *)cell];
        
        double headerHeight = tableView.sectionHeaderHeight;
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            headerHeight = [tableView.delegate tableView:tableView heightForHeaderInSection:indexPath.section];
        }
        double threshold = contentOffset.y + headerHeight;
        
        CALayer *maskLayer = cell.layer.mask;
        if (maskLayer == nil) {
            maskLayer = [CALayer layer];
            maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.layer.mask = maskLayer;
        }
        
        CGRect maskFrame = cell.bounds;
        if (cell.frame.origin.y < threshold) {
            double diff = threshold - cell.frame.origin.y;
            maskFrame.origin.y = diff;
        }
        
        if (cell == willDisplayCell) {
            maskFrame.size.height = 0;
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        maskLayer.frame = maskFrame;
        [CATransaction commit];
    }
}
@end
