//
//  LinkView.h
//  tableViewLink
//
//  Created by itrax on 2018/3/20.
//  Copyright © 2018年 itrax. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol linkViewDelegate<NSObject>

- (void)menuCellDidSelectedfirstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent forthContent:(NSString *)forthContent;

@end

@interface LinkView : UIView <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

/** 下拉菜单cell的高度 */
@property (nonatomic,assign)CGFloat cellHeight;

/** 下拉的Tableview最大高度(超出高度可以滑动显示) */
@property (nonatomic,assign)CGFloat tableViewMaxHeight;

/** 遮盖的动画时间 */
@property (nonatomic,assign)CGFloat caverAnimationTime;

/** 遮盖层颜色 */
@property (nonatomic,strong)UIColor *CaverViewColor;

/** 下拉菜单的的字体大小 */
@property (nonatomic,assign)CGFloat tableTitleFont;

/** 未选中字体的颜色 */
@property (nonatomic,strong)UIColor *unSelectedColor;

/** 选中字体的颜色 */
@property (nonatomic,strong)UIColor *selectedColor;

@property (nonatomic, strong) NSArray *tmpFirstData;
@property (nonatomic, strong) NSArray *tmpsecondData;
@property (nonatomic, strong) NSArray *tmpThirdData;
@property (nonatomic, strong) NSArray *tmpForthData;


@property (nonatomic, assign) id<linkViewDelegate> delegate;

- (void)createMenuArray:(NSArray *)dataArray;

//-(void)passFirstTableViewData:(NSArray *)firstData;
//-(void)passSecondTableViewData:(NSArray *)secondData;
//-(void)passThirdTableViewData:(NSArray *)thirdData;

@end
