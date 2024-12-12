

在使用 UICollectionViewFlowLayout 并且开启 header 吸附时，如果 header 的背景是透明的，会出现 header 跟 cell 重叠的现象，这个项目尝试解决这个问题  

## 集成  

* CocoaPods  
```
以下源选择一个配置到项目 Podfile 文件，执行 pod install  

# Github  
pod 'clip-header-overlap', :git => 'https://github.com/568071718/clip-header-overlap.git'  

# Gitee  
pod 'clip-header-overlap', :git => 'https://gitee.com/568071718/clip-header-overlap.git'  
```

## 使用  

在 scrollViewDidScroll 和 willDisplayCell 里面执行 YXClipHeaderOverlap 提供的方法  
```swift
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_collectionView];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:collectionView willDisplayCell:cell];
}
```  

一些时候可能会出现 cell 丢失，数据显示不全的情况，可以在 UIViewController 的 viewDidLayoutSubviews 回调里也执行一次修复这个问题  
```swift
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [YXClipHeaderOverlap adjustCellMaskForHeaderOverlapWithListView:_collectionView];
}
```


## 其他  
关于 UITableView 暂时是预留了一个接口，但内部还未实现，等后面不忙了可能会补充一下  

