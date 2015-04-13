# LSSelectMenu
Select Menu View Like BaiduNews&amp;WangyiNews
模范百度新闻和网易新闻制作的菜单选择控件（持续更新）
===============================================
Email:linsheng77777@163.com 欢迎大家反馈问题。
--------------------------------------------

###使用方法
####初始化:
```
-(id)initWithFrame:(CGRect)frame andNumberOfCellForRow:(NSInteger)number andSelectedMenuTitles:(NSArray*)selectedMenuTitles andUnSelectedMenuTitles:(NSArray*)unSelectedMenuTitles;
```
####选择完毕后获取数据：
```
-(NSArray*)getSelectedMenuTitles:(NSArray*)selectedMenuTitles;
-(NSArray*)getUnSeletedMenuTitles:(NSArray*)unSelectedMenuTitles;
```

