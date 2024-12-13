//
//  YXClipHeaderOverlap.h
//  app
//
//  Created by ooc on 2024/12/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXClipHeaderOverlap : NSObject

/**
 * 在滚动过程中 ( scrollViewDidScroll: ) 实时的通过这个方法修改 cell 的 mask，裁掉 cell 跟 header 重叠的部分
 */
+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView;

/**
 * 对于 UICollectionView ，还需要额外的在 willDisplayCell 回调里执行这个方法，把将要显示的 cell 也管理起来，修复下拉时顶部闪烁的问题
 * UITableView 似乎不需要这个额外处理
 */
+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView willDisplayCell:(nullable UIView *)willDisplayCell;
@end

NS_ASSUME_NONNULL_END
