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

+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView;
+ (void)adjustCellMaskForHeaderOverlapWithListView:(UIScrollView *)listView willDisplayCell:(nullable UIView *)willDisplayCell;
@end

NS_ASSUME_NONNULL_END
