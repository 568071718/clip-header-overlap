

在使用 UICollectionViewFlowLayout 并且开启 header 吸附时，如果 header 的背景是透明的，会出现 header 跟 cell 重叠的现象，这个项目尝试解决这个问题  

| 问题 | 修复后 |
| - | - |
| ![img](./explain/1734076307168.614.gif) | ![img](./explain/1734076306715.399.gif) |

---  

* [Github](https://github.com/568071718/clip-header-overlap)    
* [Gitee](https://gitee.com/568071718/clip-header-overlap)  

## 集成  

* CocoaPods  
```
以下源选择一个配置到项目 Podfile 文件，执行 pod install  

# Github  
pod 'clip-header-overlap', :git => 'https://github.com/568071718/clip-header-overlap.git'  

# Gitee  
pod 'clip-header-overlap', :git => 'https://gitee.com/568071718/clip-header-overlap.git'  
```

## UICollectionView  

在 scrollViewDidScroll 和 willDisplayCell 里面执行 YXClipHeaderOverlap 提供的方法  
```swift
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_collectionView];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:collectionView willDisplayCell:cell];
}
```  

在搭配 MJRefresh 实现下拉刷新时，可能会出现 cell 丢失，数据显示不全的情况，解决方案是在列表更新数据后再执行一次裁剪方法  

```swift
- (void)pullRefreshCallBack {
    UICollectionView *collectionView = _collectionView;
    [collectionView.mj_header endRefreshing];
    [collectionView reloadData];
    
    // 在下拉刷新后的回调里执行 reloadData 之后，补充下面的代码修复 cell 丢失的问题
    // 这里必须通过 dispatch_async 包一下，否则跟 MJRefresh 的执行顺序可能会出现冲突
    dispatch_async(dispatch_get_main_queue(), ^{
        [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:collectionView];
    });
}
```

如果其他情况下还有这个问题的话，可以尝试在 UIViewController 的 viewDidLayoutSubviews 回调里也执行一次裁剪方法  

```swift
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_collectionView];
}
```

## UITableView  

UITableView 似乎只需要在 scrollViewDidScroll 里面执行裁剪业务就好   

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_tableView];
}
```

有碰到其他问题参考上面 UICollectionView 的解决方案  


