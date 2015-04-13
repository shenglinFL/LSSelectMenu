//
//  LSSelectMenuView.m
//  SelectMenu
//
//  Created by Sheng Lin on 15-3-31.
//  Copyright (c) 2015年 林盛. All rights reserved.
//

#import "LSSelectMenuView.h"


#define HEIGHT_MIDDLE_VIEW 50.0f
#define Duration 0.17

@implementation LSSelectMenuView



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame andNumberOfCellForRow:(NSInteger)number andSelectedMenuTitles:(NSArray *)selectedMenuTitles andUnSelectedMenuTitles:(NSArray *)unSelectedMenuTitles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        width_cellSpace = 10;
        width_cell = (self.frame.size.width-(number+1)*width_cellSpace)/number;
        height_cell = 35;
        height_cellSpace = 10;
        topOfCell = 40;
        
        //初始化数组
        arrayOfCells = [[NSMutableArray alloc]initWithCapacity:10];
        arrayOfSelectedMenuTitles = [[NSMutableArray alloc]initWithCapacity:10];
        arrayOfUnSelectedMenuTitles = [[NSMutableArray alloc]initWithCapacity:10];
        arrayOfCellsSelected = [[NSMutableArray alloc]initWithCapacity:10];
        arrayOfCellsUnSelected = [[NSMutableArray alloc]initWithCapacity:10];
        
        arrayOfSelectedMenuTitles = [NSMutableArray arrayWithArray:selectedMenuTitles];
        arrayOfUnSelectedMenuTitles = [NSMutableArray arrayWithArray:unSelectedMenuTitles];
        
    }
    //设置一行cell数量
    numberOfCellInRow = (int)number;
    
    //设置头部View
    [self createHeadView];
    
    //设置中间的View
    [self createMiddleView];
    
    //设置selectedMenus
    [self createSelectedMenuWithTitles:selectedMenuTitles];
    
    //设置unSelectedMenus
    [self createUnSelectedMenuWithTitles:unSelectedMenuTitles];
    
    
    
    
    return self;
}

#pragma mark - 设置头部View
-(void)createHeadView
{
    view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, topOfCell)];
    view_head.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(width_cellSpace, 0, view_head.frame.size.width-width_cellSpace*2, view_head.frame.size.height)];
    label.text = @"栏目";
    [view_head addSubview:label];
    
    [self addSubview:view_head];
}

#pragma mark - 创建middleView
-(void)createMiddleView
{
    view_middle = [[UIView alloc]initWithFrame:CGRectMake(0, middleOfCell+height_cellSpace, self.frame.size.width, HEIGHT_MIDDLE_VIEW-height_cellSpace)];
    view_middle.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(width_cellSpace, 0, view_middle.frame.size.width-width_cellSpace*2, view_middle.frame.size.height)];
    label.text = @"更多栏目";
    [view_middle addSubview:label];
    
    
    [self addSubview:view_middle];
}

#pragma mark - 重新设置middleView
-(void)adjustMiddleView
{
    view_middle.frame = CGRectMake(0, middleOfCell+height_cellSpace, self.frame.size.width, HEIGHT_MIDDLE_VIEW-height_cellSpace);
}

-(void)createSelectedMenuWithTitles:(NSArray*)titles
{
    for (int i = 0; i<titles.count; i++) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        
        float x_view = width_cellSpace+(width_cellSpace+width_cell)*(i%numberOfCellInRow);
        float y_view = topOfCell + height_cellSpace + (height_cellSpace+height_cell)*(i/numberOfCellInRow);
        view.frame = CGRectMake(x_view, y_view, width_cell, height_cell);
        
        CALayer * la = view.layer;
        la.shadowColor = [UIColor blackColor].CGColor;
        la.shadowOffset = CGSizeMake(0.0f, 2.0f);
        la.shadowOpacity = 0.0f;
        
        //备用方法
        //la.borderColor = [UIColor grayColor].CGColor;
        //la.borderWidth = 1;
        
        
        //添加View控件
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        imageView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        [view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [titles objectAtIndex:i];
        [view addSubview:label];
        
        [self addSubview:view];
        
        //添加长按手势
        UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(buttonLongPressed:)];
        longGesture.minimumPressDuration = 0.4;
        [view addGestureRecognizer:longGesture];
        //添加点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTap:)];
        [view addGestureRecognizer:tap];
        
        
        
        
        [arrayOfCells addObject:view];
        [arrayOfCellsSelected addObject:view];
        //更改middleOfCell
        middleOfCell = view.frame.origin.y+view.frame.size.height;
        [self adjustMiddleView];
    }
}

-(void)createUnSelectedMenuWithTitles:(NSArray*)titles
{
    for (int i = 0; i<titles.count; i++) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        
        float x_view = width_cellSpace+(width_cellSpace+width_cell)*(i%numberOfCellInRow);
        float y_view = (middleOfCell + HEIGHT_MIDDLE_VIEW) + height_cellSpace + (height_cellSpace+height_cell)*(i/numberOfCellInRow);
        view.frame = CGRectMake(x_view, y_view, width_cell, height_cell);
        
        CALayer * la = view.layer;
        la.shadowColor = [UIColor blackColor].CGColor;
        la.shadowOffset = CGSizeMake(0.0f, 2.0f);
        la.shadowOpacity = 0.0f;
        
        //备用方法
        //la.borderColor = [UIColor grayColor].CGColor;
        //la.borderWidth = 1;
        
        
        //添加View控件
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        imageView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        [view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [titles objectAtIndex:i];
        [view addSubview:label];
        
        [self addSubview:view];
        
        //添加手势
        UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(buttonLongPressed:)];
        longGesture.minimumPressDuration = 0.4;
        [view addGestureRecognizer:longGesture];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTap:)];
        [view addGestureRecognizer:tap];
        
        [arrayOfCells addObject:view];
        [arrayOfCellsUnSelected addObject:view];
        
    }
}


-(void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
//    NSLog(@"长按");
    UIView * view = sender.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        //放到最前面
        [self bringSubviewToFront:view];
//        view.layer.shadowOpacity = 0.25;
        
        
        
        startPoint = [sender locationInView:sender.view];
        originPoint = view.center;//中转点
        realOriginPoint = view.center;//真实初始点
        
        
        //判断长按的店的index序号，不再范围内则返回-1
            indexOfSelectedArray = [self indexOfPointInSeletedView:view.center];
            indexOfUnSelectedArray = [self indexOfPointInUnSeletedView:view.center];

        if (indexOfSelectedArray >= 0) {
            startIndexType = 1;
        }
        if (indexOfUnSelectedArray >= 0) {
            startIndexType = 2;
        }
        
        
        [UIView animateWithDuration:Duration animations:^{
            view.transform = CGAffineTransformMakeScale(1.2, 1.2);
            view.alpha = 0.8;
            for (id obj in view.subviews) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView * imageView = obj;
                    imageView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
                }
            }
        }];
        
    }else if (sender.state == UIGestureRecognizerStateChanged){
//        NSLog(@"移动");
        CGPoint newPoint = [sender locationInView:sender.view];
        realNewPoint = [sender locationInView:self];
        CGFloat deltaX = newPoint.x - startPoint.x;
        CGFloat deltaY = newPoint.y - startPoint.y;
        view.center = CGPointMake(view.center.x + deltaX, view.center.y + deltaY);
        //判断位置在第indexInSelected个
        NSInteger indexInSelected = [self indexInSelectedOfPoint:view.center withButton:view];
        NSInteger indexInUnSelected = [self indexInUnSelectedOfPoint:view.center withButton:view];
        
        if (indexOfSelectedArray >=0 && indexInSelected >= 0) {
            if (indexOfSelectedArray < indexInSelected) {
                for (int j=0; j<indexInSelected-indexOfSelectedArray; j++) {
                    
                    [arrayOfCellsSelected exchangeObjectAtIndex:indexOfSelectedArray+j+1 withObjectAtIndex:indexOfSelectedArray+j];
                    [arrayOfSelectedMenuTitles exchangeObjectAtIndex:indexOfSelectedArray+j+1 withObjectAtIndex:indexOfSelectedArray+j];
                }
                indexOfSelectedArray = indexInSelected;//替换位置index
                [self sortSeletcedViewsWithoutIndex:indexInSelected];//排序
            }else{
                for (int j=0; j<indexOfSelectedArray-indexInSelected; j++) {
                    
                    [arrayOfCellsSelected exchangeObjectAtIndex:indexOfSelectedArray-j-1 withObjectAtIndex:indexOfSelectedArray-j];
                    [arrayOfSelectedMenuTitles exchangeObjectAtIndex:indexOfSelectedArray-j-1 withObjectAtIndex:indexOfSelectedArray-j];
                }
                indexOfSelectedArray = indexInSelected;
                [self sortSeletcedViewsWithoutIndex:indexInSelected];//
            }
            
        }else if (indexOfSelectedArray >=0 && indexInUnSelected >=0){
            [arrayOfCellsUnSelected insertObject:[arrayOfCellsSelected objectAtIndex:indexOfSelectedArray] atIndex:indexInUnSelected];
            [arrayOfUnSelectedMenuTitles insertObject:[arrayOfSelectedMenuTitles objectAtIndex:indexOfSelectedArray] atIndex:indexInUnSelected];
            [arrayOfCellsSelected removeObjectAtIndex:indexOfSelectedArray];
            [arrayOfSelectedMenuTitles removeObjectAtIndex:indexOfSelectedArray];
            indexOfSelectedArray = [self indexOfPointInSeletedView:view.center];
            indexOfUnSelectedArray = [self indexOfPointInUnSeletedView:view.center];
            [self sortSeletcedViewsWithoutIndex:-1];
            [self sortUnSeletcedViewsWithoutIndex:indexInUnSelected];

        }else if (indexOfUnSelectedArray >= 0 && indexInUnSelected >= 0){
            if (indexOfUnSelectedArray < indexInUnSelected) {
                for (int j=0; j<indexInUnSelected-indexOfUnSelectedArray; j++) {
                    
                    [arrayOfCellsUnSelected exchangeObjectAtIndex:indexOfUnSelectedArray+j+1 withObjectAtIndex:indexOfUnSelectedArray+j];
                    [arrayOfUnSelectedMenuTitles exchangeObjectAtIndex:indexOfUnSelectedArray+j+1 withObjectAtIndex:indexOfUnSelectedArray+j];
                }
                indexOfUnSelectedArray = indexInUnSelected;//替换位置index
                [self sortUnSeletcedViewsWithoutIndex:indexInUnSelected];//排序
            }else{
                for (int j=0; j<indexOfUnSelectedArray-indexInUnSelected; j++) {
                    
                    [arrayOfCellsUnSelected exchangeObjectAtIndex:indexOfUnSelectedArray-j-1 withObjectAtIndex:indexOfUnSelectedArray-j];
                    [arrayOfUnSelectedMenuTitles exchangeObjectAtIndex:indexOfUnSelectedArray-j-1 withObjectAtIndex:indexOfUnSelectedArray-j];
                }
                indexOfUnSelectedArray = indexInUnSelected;
                [self sortUnSeletcedViewsWithoutIndex:indexInUnSelected];//排序
            }
            
        }else if (indexOfUnSelectedArray >= 0 && indexInSelected >= 0){
            [arrayOfCellsSelected insertObject:[arrayOfCellsUnSelected objectAtIndex:indexOfUnSelectedArray] atIndex:indexInSelected];
            [arrayOfSelectedMenuTitles insertObject:[arrayOfUnSelectedMenuTitles objectAtIndex:indexOfUnSelectedArray] atIndex:indexInSelected];
            [arrayOfCellsUnSelected removeObjectAtIndex:indexOfUnSelectedArray];
            [arrayOfUnSelectedMenuTitles removeObjectAtIndex:indexOfUnSelectedArray];
            indexOfUnSelectedArray = [self indexOfPointInUnSeletedView:view.center];
            indexOfSelectedArray = [self indexOfPointInSeletedView:view.center];
            [self sortSeletcedViewsWithoutIndex:indexInSelected];
            [self sortUnSeletcedViewsWithoutIndex:-1];
        }
        
        
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:Duration animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//定义动画块加速减速的方式
            for (id obj in view.subviews) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView * imageView = obj;
                    imageView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
                }
            }
        }];
        [self sortSeletcedViewsWithoutIndex:-1];
        [self sortUnSeletcedViewsWithoutIndex:-1];
    }
}


//判断点是在那个view内.
-(NSInteger)indexOfPoint:(CGPoint)point withButton:(UIView*)view
{
    for (NSInteger i = 0; i<arrayOfCells.count; i++) {
        UIView * otherView = [arrayOfCells objectAtIndex:i];
        if (otherView != view) {
            if (CGRectContainsPoint(otherView.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

//判断点是在那个view内.包含自己的view
-(NSInteger)indexOfPointInAllView:(CGPoint)point
{
    for (NSInteger i = 0; i<arrayOfCells.count; i++) {
        UIView * otherView = [arrayOfCells objectAtIndex:i];
        if (CGRectContainsPoint(otherView.frame, point)) {
            return i;
        }
    }
    return -1;
}

//判断点是在那个view内.只包含selected,不包括Button
-(NSInteger)indexInSelectedOfPoint:(CGPoint)point withButton:(UIView*)view
{
    for (NSInteger i = 0; i<arrayOfCellsSelected.count; i++) {
        UIView * otherView = [arrayOfCellsSelected objectAtIndex:i];
        if (otherView != view) {
            if (CGRectContainsPoint(otherView.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

//判断点是在那个view内.只包含unSelected，不包括button
-(NSInteger)indexInUnSelectedOfPoint:(CGPoint)point withButton:(UIView*)view
{
    for (NSInteger i = 0; i<arrayOfCellsUnSelected.count; i++) {
        UIView * otherView = [arrayOfCellsUnSelected objectAtIndex:i];
        if (otherView != view) {
            if (CGRectContainsPoint(otherView.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

//判断点是在哪个view内，包含自己的view，只包括seleted
-(NSInteger)indexOfPointInSeletedView:(CGPoint)point
{
    for (NSInteger i = 0; i<arrayOfCellsSelected.count; i++) {
        UIView * otherView = [arrayOfCellsSelected objectAtIndex:i];
        if (CGRectContainsPoint(otherView.frame, point)) {
            return i;
        }
    }
    return -1;
}

//判断点是在哪个view内，包含自己的view，只包括UnSeleted
-(NSInteger)indexOfPointInUnSeletedView:(CGPoint)point
{
    for (NSInteger i = 0; i<arrayOfCellsUnSelected.count; i++) {
        UIView * otherView = [arrayOfCellsUnSelected objectAtIndex:i];
        if (CGRectContainsPoint(otherView.frame, point)) {
            return i;
        }
    }
    return -1;
}



//检查已选View排序，重新排序已选
-(void)sortSeletcedViewsWithoutIndex:(NSInteger)indexWithout;
{
    
        [UIView animateWithDuration:Duration animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//定义动画块加速减速的方式
            
             for (int i = 0; i<arrayOfCellsSelected.count; i++)
             {
                 UIView * view = [arrayOfCellsSelected objectAtIndex:i];
                 float x_view = width_cellSpace+(width_cellSpace+width_cell)*(i%numberOfCellInRow);
                 float y_view = topOfCell + height_cellSpace + (height_cellSpace+height_cell)*(i/numberOfCellInRow);
                 if (i != indexWithout) {
                     view.layer.shadowOpacity = 0;
                     view.transform = CGAffineTransformIdentity;
                     view.alpha = 1.0;
                     view.frame = CGRectMake(x_view, y_view, width_cell, height_cell);
                     
                 }else{
//                     NSLog(@"------------");
                 }
//
             }
            UIView * view = [arrayOfCellsSelected lastObject];
            middleOfCell = view.frame.origin.y+view.frame.size.height;
            
        }];
}


//检查已选View排序，重新排序未选
-(void)sortUnSeletcedViewsWithoutIndex:(NSInteger)indexWithout;
{
    
    [UIView animateWithDuration:Duration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//定义动画块加速减速的方式
        for (int i = 0; i<arrayOfCellsUnSelected.count; i++)
        {
            UIView * view = [arrayOfCellsUnSelected objectAtIndex:i];
            float x_view = width_cellSpace+(width_cellSpace+width_cell)*(i%numberOfCellInRow);
            float y_view = (middleOfCell + HEIGHT_MIDDLE_VIEW) + height_cellSpace + (height_cellSpace+height_cell)*(i/numberOfCellInRow);
            if (i != indexWithout) {
                view.layer.shadowOpacity = 0;
                view.transform = CGAffineTransformIdentity;
                view.alpha = 1.0;
                view.frame = CGRectMake(x_view, y_view, width_cell, height_cell);
            }else{
                //                     NSLog(@"------------");
            }
            
        }
        [self adjustMiddleView];
    }];
    
}


#pragma mark - 点击手势
-(void)buttonTap:(UITapGestureRecognizer *)sender
{
    UIView * view = sender.view;
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSInteger indexInSelected = [self indexOfPointInSeletedView:view.center];
        NSInteger indexInUnSelected = [self indexOfPointInUnSeletedView:view.center];
        
        if (indexInSelected >= 0) {

            [arrayOfCellsUnSelected insertObject:[arrayOfCellsSelected objectAtIndex:indexInSelected] atIndex:0];
            [arrayOfUnSelectedMenuTitles insertObject:[arrayOfSelectedMenuTitles objectAtIndex:indexInSelected] atIndex:0];
            
            [arrayOfCellsSelected removeObjectAtIndex:indexInSelected];
            [arrayOfSelectedMenuTitles removeObjectAtIndex:indexInSelected];
            indexOfSelectedArray = [self indexOfPointInSeletedView:view.center];
            indexOfUnSelectedArray = [self indexOfPointInUnSeletedView:view.center];
            [self sortSeletcedViewsWithoutIndex:-1];
            [self sortUnSeletcedViewsWithoutIndex:-1];
        }
        if (indexInUnSelected >= 0) {
            [arrayOfCellsSelected addObject:[arrayOfCellsUnSelected objectAtIndex:indexInUnSelected]];
            [arrayOfSelectedMenuTitles addObject:[arrayOfUnSelectedMenuTitles objectAtIndex:indexInUnSelected]];
            [arrayOfCellsUnSelected removeObjectAtIndex:indexInUnSelected];
            [arrayOfUnSelectedMenuTitles removeObjectAtIndex:indexInUnSelected];
            indexOfUnSelectedArray = [self indexOfPointInUnSeletedView:view.center];
            indexOfSelectedArray = [self indexOfPointInSeletedView:view.center];
            [self sortSeletcedViewsWithoutIndex:-1];
            [self sortUnSeletcedViewsWithoutIndex:-1];
        }
        
        
        
    }
}




#pragma mark - 获取选择栏目
-(NSArray*)getSelectedMenuTitles:(NSArray *)selectedMenuTitles
{
    return arrayOfSelectedMenuTitles;
}

#pragma mark - 获取为选择栏目
-(NSArray *)getUnSeletedMenuTitles:(NSArray *)unSelectedMenuTitles
{
    return arrayOfUnSelectedMenuTitles;
}


@end
