//
//  ViewController.m
//  tableViewLink
//
//  Created by itrax on 2018/3/19.
//  Copyright © 2018年 itrax. All rights reserved.
//

#import "ViewController.h"
#import "LinkView.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<linkViewDelegate>

@property (nonatomic, strong) LinkView *menu;

@property (nonatomic, strong) NSMutableArray *tmparray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tmparray = [NSMutableArray array];
    LinkView *menu = [[LinkView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.delegate = self;
    [self.view addSubview:menu];
    self.menu = menu;
    
    menu.cellHeight = 40;
    
    
    NSArray *firstArray = [NSArray arrayWithObjects:@"河南",@"河北",@"山东",@"湖南", nil];
    NSArray *secondArray = @[@[@"安阳",@"鹤壁",@"焦作市",@"信阳"],@[@"保定市",@"沧州市"],@[@"滨州市",@"德州市",@"莱芜市"],@[@"长沙市",@"常德市"]];
    
    NSArray *thirdArray = @[@[@"文峰区",@"北关区",@"殷都区"],@[@"鹤山区",@"山城区",@"淇滨区",@"浚县",@"淇县"],@[@"解放区",@"中站区",@"马村区"],@[@"光山县",@"新县",@"潢川县",@"息县"],@[@"新市区",@"北市区",@"南市区"],@[@"新华区",@"盐山县"],@[@"滨城区",@"惠民县",@"阳信县"],@[@"德城区",@"陵县",@"宁津县"],@[@"莱城区",@"钢城区"],@[@"芙蓉区",@"天心区"],@[@"武陵区",@"鼎城区"]];
    
    NSArray *forthArray = @[@[@"文峰区一",@"文峰区二"],@[@"北关区1"],@[@"殷都区"],@[@"鹤山区一"],@[@"山城区一"],@[@"淇滨区一"],@[@"浚县一"],@[@"淇县一"],@[@"解放区一"],@[@"中站区1"],@[@"马村区1"],@[@"光山县1",@"光山县2",@"光山县3"],@[@"新县1",@"新县2"],@[@"潢川县1"],@[@"息县1"],@[@"新市区1"],@[@"北市区1"],@[@"南市区1"],@[@"新华区1"],@[@"盐山县1"],@[@"滨城区1"],@[@"惠民县1"],@[@"阳信县1"],@[@"德城区1"],@[@"陵县1"],@[@"宁津县1"],@[@"莱城区1"],@[@"钢城区1"],@[@"芙蓉区1"],@[@"天心区1"],@[@"武陵区1"],@[@"鼎城区1"]];
    menu.tmpFirstData = firstArray;
    menu.tmpsecondData = secondArray;
    menu.tmpThirdData = thirdArray;
    menu.tmpForthData = forthArray;
    NSArray *allData = [NSArray arrayWithObjects:firstArray,secondArray,thirdArray, nil];
    [self.menu createMenuArray:allData];
    


    
}
-(void)menuCellDidSelectedfirstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent forthContent:(NSString *)forthContent
{
    NSLog(@"%@ %@ %@ %@",firstContent,secondContent,thirdContent,forthContent);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
