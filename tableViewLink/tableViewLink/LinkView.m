//
//  LinkView.m
//  tableViewLink
//
//  Created by itrax on 2018/3/20.
//  Copyright © 2018年 itrax. All rights reserved.
//

#import "LinkView.h"

#define tableViewMaxHeightDefalut   300
#define screen_H [UIScreen mainScreen].bounds.size.height

#define TableTitleDefalutFont [UIFont systemFontOfSize:12]
#define tableViewWidth self.frame.size.width / 4.0

@interface LinkView ()

@property (nonatomic, strong) NSMutableArray *realDataSecond; // 第二个tableView的数据
@property (nonatomic, strong) NSMutableArray *realDataThird;  // 第三个tableView的数据
@property (nonatomic, strong) NSMutableArray *realDataForth;  // 第四个tableView的数据

@property (nonatomic, strong) UITableView    *firstTableView;
@property (nonatomic, strong) UITableView    *secondTableView;
@property (nonatomic, strong) UITableView    *thirdTableView;
@property (nonatomic, strong) UITableView    *forthTableView;

@property (nonatomic, assign) NSInteger      firstSelectIndex;
@property (nonatomic, assign) NSInteger      secondSelectIndex;
@property (nonatomic, assign) NSInteger      thirdSelectIndex;
@property (nonatomic, assign) NSInteger      forthSelectIndex;

@property (nonatomic, assign) BOOL            firstTableViewShow;
@property (nonatomic, assign) BOOL            secondTableViewShow;
@property (nonatomic, assign) BOOL            thirdTableViewShow;
@property (nonatomic, assign) BOOL            forthTableViewShow;

@property (nonatomic, assign) NSInteger      firstSelectedCellIndex; // 记录点击tableView的index
@property (nonatomic, assign) NSInteger      secondSelectedCellIndex;
@property (nonatomic, assign) NSInteger      thirdSelectedCellIndex;
@property (nonatomic, assign) NSInteger      forthSelectedCellIndex;

@property (nonatomic, strong) UIView         *backView; // 菜单
@property (nonatomic, assign) CGFloat        menuBaseHeight; // 菜单高度

@property (nonatomic, assign) NSInteger      num; //记录第三个tableView的数据在数组中的位置
@property (nonatomic, assign) NSInteger      forthNum;//记录第四个tableView的数据在数组中的位置




@end




@implementation LinkView

-(NSMutableArray *)realDataSecond
{
    if (_realDataSecond == nil) {
        _realDataSecond = [NSMutableArray array];
    }
    return _realDataSecond;
}

-(NSMutableArray *)realDataThird
{
    if (_realDataThird == nil) {
        _realDataThird = [NSMutableArray array];
    }
    return _realDataThird;
}

-(NSMutableArray *)realDataForth
{
    if (_realDataForth == nil) {
        _realDataForth = [NSMutableArray array];
    }
    return _realDataForth;
}

-(void)createBackView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBackground)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.menuBaseHeight)];
    self.backView.userInteractionEnabled = YES;
    self.backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.backView];

//    UIButton *pressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *pressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.menuBaseHeight)];
//    pressBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.menuBaseHeight);
    [pressBtn setTitle:@"点击显示菜单" forState:(UIControlStateNormal)];
    [pressBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [pressBtn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
    [pressBtn addTarget:self action:@selector(showFirstTableView:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:pressBtn];
 
}

#pragma mark -- 拦截轻拍手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCell"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else{
        return YES;
    }
}

-(void)removeBackground
{
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.firstTableView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
    
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.secondTableView.frame = CGRectMake(tableViewWidth, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
    
    self.thirdTableViewShow = NO;
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.thirdTableView.frame = CGRectMake(tableViewWidth * 2, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
    
    self.forthTableViewShow = NO;
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.forthTableView.frame = CGRectMake(tableViewWidth * 3, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
    
    [self hideCarverView];
}

#pragma mark -- 展示第一个tableView
-(void)showFirstTableView:(UIButton *)sender
{
    [self.firstTableView reloadData];
    
    CGFloat tableViewH = self.cellHeight * self.tmpFirstData.count;
    CGFloat maxHeight = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
    if (tableViewH > maxHeight) {
        self.firstTableView.scrollEnabled = YES;
        tableViewH = maxHeight;
    }else{
        self.firstTableView.scrollEnabled = NO;
    }
    
    if (self.firstTableViewShow == NO) { // 展开第一个tableView
        [self showCarverView];
        self.firstTableView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.firstTableView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), tableViewWidth, tableViewH);
        }];
    }else{ // 再次点击菜单的时候,所有的tableView都要关闭,同时关闭背景view
        
        self.firstTableViewShow = NO;
        self.secondTableViewShow = NO;
        self.thirdTableViewShow = NO;
        self.forthTableViewShow = NO;
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.firstTableView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
            self.secondTableView.frame = CGRectMake(tableViewWidth, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
            self.thirdTableView.frame = CGRectMake(tableViewWidth * 2, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
            self.forthTableView.frame = CGRectMake(tableViewWidth * 3, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
        }];
        
        [self hideCarverView];
    }
}

#pragma mark -- 展示第二个tableView
-(void)showSecondTableView:(BOOL)secondTableViewShow
{
    [self showTableView:self.secondTableView xposition:1 dataSource:self.realDataSecond isShowing:self.secondTableViewShow];
}


#pragma mark -- 展示第三个tableView
-(void)showThirdTableView:(BOOL)thirdTableViewShow
{
    [self showTableView:self.thirdTableView xposition:2 dataSource:self.realDataThird isShowing:self.thirdTableViewShow];
}

#pragma mark -- 展示第四个tableView
-(void)showForthTableView:(BOOL)forthTableViewShow
{
    [self showTableView:self.forthTableView xposition:3 dataSource:self.realDataForth isShowing:self.forthTableViewShow];
}

-(void)showTableView:(UITableView *)tableView xposition:(NSInteger)position dataSource:(NSMutableArray *)dataArray isShowing:(BOOL)isshow
{
    CGFloat tableViewH = self.cellHeight * dataArray.count;
    CGFloat maxHeight = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
    if (tableViewH > maxHeight) {
        tableView.scrollEnabled = YES;
        tableViewH = maxHeight;
    }else{
        tableView.scrollEnabled = NO;
    }
    
    if (isshow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            tableView.frame = CGRectMake(tableViewWidth * position, CGRectGetMaxY(self.backView.frame), tableViewWidth, tableViewH);
        }];
    }else{
        [self showCarverView];
        isshow = YES;
        tableView.frame = CGRectMake(tableViewWidth * position, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            tableView.frame = CGRectMake(tableViewWidth * position, CGRectGetMaxY(self.backView.frame), tableViewWidth, tableViewH);
        }];
    }
}


#pragma mark -- 当点击第一个tableView的时候,隐藏第三,第四个tableView
-(void)hideThirdTableView{
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.thirdTableView.frame = CGRectMake(tableViewWidth * 2, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
    
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.forthTableView.frame = CGRectMake(tableViewWidth * 3, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
}
#pragma mark -- 当点击第二个tableView的时候,隐藏第四个tableView
-(void)hideForthTableView{
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.forthTableView.frame = CGRectMake(tableViewWidth * 3, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0);
    }];
}

-(void)showCarverView
{
    self.firstTableViewShow = YES;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, screen_H - self.frame.origin.y);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CaverViewColor ? self.CaverViewColor :[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
}

-(void)hideCarverView
{
    self.firstTableViewShow = NO;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.menuBaseHeight);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CaverViewColor ? self.CaverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
}

-(void)createMenuArray:(NSArray *)dataArray
{
    self.menuBaseHeight = self.frame.size.height;
    [self createBackView];
    [self createTableView];
}

-(void)createTableView
{
    [self createFirstTableView];
    [self createSecondTableView];
    [self createThirdTableView];
    [self createForthTableView];
}

-(void)createFirstTableView{
    
    self.firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0) style:UITableViewStylePlain];
    self.firstTableView.scrollEnabled = NO;
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    [self insertSubview:self.firstTableView belowSubview:self.backView];

}
-(void)createSecondTableView{
    self.secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewWidth, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0) style:UITableViewStylePlain];
    self.secondTableView.scrollEnabled = NO;
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    [self insertSubview:self.secondTableView belowSubview:self.backView];
}

-(void)createThirdTableView{
    self.thirdTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewWidth * 2, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0) style:UITableViewStylePlain];
    self.thirdTableView.scrollEnabled = NO;
    self.thirdTableView.delegate = self;
    self.thirdTableView.dataSource = self;
    [self insertSubview:self.thirdTableView belowSubview:self.backView];
}

-(void)createForthTableView{
    self.forthTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewWidth * 3, CGRectGetMaxY(self.backView.frame), tableViewWidth, 0) style:UITableViewStylePlain];
    self.forthTableView.scrollEnabled = NO;
    self.forthTableView.delegate = self;
    self.forthTableView.dataSource = self;
    [self insertSubview:self.forthTableView belowSubview:self.backView];
}

- (void)changeCellTextStatueColorWith:(UITableViewCell *)cell{
    cell.textLabel.textColor = self.unSelectedColor ? self.unSelectedColor : [UIColor grayColor];
    cell.textLabel.highlightedTextColor = self.selectedColor ? self.selectedColor : [UIColor blackColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView) {
        static NSString *cellID = @"cellFirst";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.textLabel.text = self.tmpFirstData[indexPath.row];
        cell.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self changeCellTextStatueColorWith:cell];
        return cell;
    }else if (tableView == self.secondTableView){
        static NSString *cellID2 = @"cellSecond";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID2];
        }
        cell.textLabel.text = self.realDataSecond[indexPath.row];
        cell.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self changeCellTextStatueColorWith:cell];
        return cell;
    }else if (tableView == self.thirdTableView){
        static NSString *cellID3 = @"cellthird";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID3];
        }
        cell.textLabel.text = self.realDataThird[indexPath.row];
        cell.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self changeCellTextStatueColorWith:cell];
        return cell;
    }else if (tableView == self.forthTableView){
        static NSString *cellID4 = @"cellForth";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID4];
        }
        cell.textLabel.text = self.realDataForth[indexPath.row];
        cell.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [self changeCellTextStatueColorWith:cell];
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.firstTableView) {
        return self.tmpFirstData.count;
    }else if (tableView == self.secondTableView){
        return self.realDataSecond.count;
    }else if (tableView == self.thirdTableView){
        return self.realDataThird.count;
    }else if (tableView == self.forthTableView){
        return self.realDataForth.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.firstTableView) {
        // 当用户点击第一列数据的时候,要把self.secondSelectIndex和self.thirdSelectIndex重置
        self.secondSelectIndex = 0;
        self.thirdSelectIndex = 0;
        NSInteger i = indexPath.row;
        self.firstSelectIndex = indexPath.row;
        self.realDataSecond = self.tmpsecondData[i];
        self.num = 0;
        for (int j = 0; j < i; j++) {
            self.num += [self.tmpsecondData[j] count];
        }
        [self.secondTableView reloadData];
        [self showSecondTableView:self.secondTableViewShow];
        [self hideThirdTableView];
        [self outputContent:self.tmpFirstData[self.firstSelectIndex] secondContent:@"" thirdContent:@"" forthContent:@""];
    }else if (tableView == self.secondTableView){
        // 当用户点击第二个tableView的时候,要把self.thirdSelectIndex = 0,不然,当第三列数据比较多,第二列数据比较少,会崩溃
        self.thirdSelectIndex = 0;
        self.secondSelectIndex = indexPath.row;
        NSInteger i = indexPath.row;
        self.realDataThird = self.tmpThirdData[self.num + i];
        
        [self.thirdTableView reloadData];
        [self showThirdTableView:self.thirdTableViewShow];
        [self hideForthTableView];
        [self outputContent:self.tmpFirstData[self.firstSelectIndex] secondContent:self.realDataSecond[self.secondSelectIndex] thirdContent:@"" forthContent:@""];
        
    }else if (tableView == self.thirdTableView){

        self.forthSelectIndex = 0;
        self.thirdSelectIndex = indexPath.row;
        // 确定第四个tableView的数据
        NSMutableArray *tmparr = [NSMutableArray array];
        tmparr = [self inputArray:self.tmpThirdData result:tmparr];
        NSString *tmpthird = self.realDataThird[self.thirdSelectIndex];
        self.forthNum = [tmparr indexOfObject:tmpthird];
        self.realDataForth = self.tmpForthData[self.forthNum];

        [self.forthTableView reloadData];
        [self showForthTableView:self.forthTableViewShow];
        
        [self outputContent:self.tmpFirstData[self.firstSelectIndex] secondContent:self.realDataSecond[self.secondSelectIndex] thirdContent:self.realDataThird[self.thirdSelectIndex] forthContent:@""];
    }else if (tableView == self.forthTableView){
        self.forthSelectIndex = indexPath.row;
        [self outputContent:self.tmpFirstData[self.firstSelectIndex] secondContent:self.realDataSecond[self.secondSelectIndex] thirdContent:self.realDataThird[self.thirdSelectIndex] forthContent:self.realDataForth[self.forthSelectIndex]];
        
    }
}

-(NSMutableArray *)inputArray:(NSArray *)inputArray result:(NSMutableArray *)resultArray
{
    for (int i = 0; i < inputArray.count; i++) {
        
        if ([inputArray[i] isKindOfClass:[NSArray class]]) {
            [self inputArray:inputArray[i] result:resultArray];
        }else{
            [resultArray addObject:inputArray[i]];
        }
    }
    
    return resultArray;
}

-(void)outputContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent forthContent:(NSString *)forthContent
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuCellDidSelectedfirstContent:secondContent:thirdContent:forthContent:)]) {
        [self.delegate menuCellDidSelectedfirstContent:firstContent secondContent:secondContent thirdContent:thirdContent forthContent:forthContent];
    }
}









@end




