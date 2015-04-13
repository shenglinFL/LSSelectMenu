//
//  LSSelectMenuView.h
//  SelectMenu
//
//  Created by Sheng Lin on 15-3-31.
//  Copyright (c) 2015年 林盛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSelectMenuView : UIView
{
    float topOfCell;//cell的最高顶端y坐标
    float middleOfCell;//两组cell中间分隔的y坐标
    float width_cell;//cell的宽
    float width_cellSpace;//cell的间隙宽
    float height_cell;//cell的高
    float height_cellSpace;//cell的间隙高
    int numberOfCellInRow;//每行cell数量
    NSMutableArray * arrayOfCells;//cell的数组
    NSMutableArray * arrayOfCellsSelected;//已选菜单cell数组
    NSMutableArray * arrayOfCellsUnSelected;//未选菜单cell数组
    NSMutableArray * arrayOfSelectedMenuTitles;//已选择cell数组
    NSMutableArray * arrayOfUnSelectedMenuTitles;//未选择cell数组
    
    BOOL contain;//长按移动手势点是否在cell内
    CGPoint startPoint;//长按开始的点（相互对于cell）
    CGPoint originPoint;//长按中转所应该在的点
    CGPoint realOriginPoint;//长按开始的点
    CGPoint realNewPoint;//长按拖到时的新位置，相对于self
    NSInteger indexOfSelectedArray;//在selectedArray的序号
    NSInteger indexOfUnSelectedArray;//在unSelectedArray的序号
    NSInteger startIndexType;//为1时开始在已选择，为2时在未选择
    
    UIView * view_head;//头部View
    UIView * view_middle;//中部View
}


-(id)initWithFrame:(CGRect)frame andNumberOfCellForRow:(NSInteger)number andSelectedMenuTitles:(NSArray*)selectedMenuTitles andUnSelectedMenuTitles:(NSArray*)unSelectedMenuTitles;


-(NSArray*)getSelectedMenuTitles:(NSArray*)selectedMenuTitles;
-(NSArray*)getUnSeletedMenuTitles:(NSArray*)unSelectedMenuTitles;


@end
