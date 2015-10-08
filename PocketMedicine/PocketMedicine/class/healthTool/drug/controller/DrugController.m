//
//  DrugController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DrugController.h"
#import "DrugModel.h"
#import "DataTool.h"
#import "MJExtension.h"
#import "DrugSecModel.h"
#import "DrugTwoController.h"

#define LCDW [[UIScreen mainScreen] bounds].size.width
#define LCDH [[UIScreen mainScreen] bounds].size.height
#define kDrug @"http://api.lkhealth.net/index.php?r=drug/getdrugclassify"

@interface DrugController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)DrugModel *drugModel;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DrugController

//懒加载
-(NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"药品大全";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setView];
    [self getTableViewData];
}

- (void)setView{
    
    //左边tableView
    
    self.tableViewLeft = [[UITableView alloc]initWithFrame:(CGRectMake(0,0, LCDW/3, LCDH-44))];
    self.tableViewLeft.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableViewLeft];
    [self.tableViewLeft registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LeftCell"];
    self.tableViewLeft.dataSource = self;
    self.tableViewLeft.delegate = self;
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(LCDW/3,0, 2,LCDH)];
    vi.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vi];
    
    
    //右边tableView
    self.tableViewRight = [[UITableView alloc]initWithFrame:(CGRectMake(CGRectGetMaxX(vi.frame),64, LCDW - CGRectGetWidth(self.tableViewLeft.frame)-2, LCDH - 110))];
    self.tableViewRight.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableViewRight];
    [self.tableViewRight registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RightCell"];
    self.tableViewRight.dataSource = self;
    self.tableViewRight.delegate = self;
    
    
    
}

- (void)getTableViewData{
    
    __weak typeof(self)weakSelf = self;
    [DataTool solveDataWithUrlStr:kDrug method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        
        NSArray *list = dict[@"data"][@"classifyList"];
        NSArray *list2 = [DrugModel objectArrayWithKeyValuesArray:list];
        [weakSelf.dataArray addObjectsFromArray:list2];
        
        [weakSelf.tableViewLeft reloadData];
        
        self.drugModel = [DrugModel new];
        self.drugModel = list2[0];
        
        [weakSelf.tableViewRight reloadData];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableViewLeft]) {
        return self.dataArray.count;
    }else{
        return self.drugModel.twoType.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:self.tableViewLeft]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell" forIndexPath:indexPath];
        DrugModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.className;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [self.drugModel.twoType[indexPath.row] className];
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableViewLeft]) {
        DrugModel *model = self.dataArray[indexPath.row];
        self.drugModel = [DrugModel new];
        self.drugModel = model;
        [self.tableViewRight reloadData];
        
    }else{
        DrugTwoController *drugTowVC = [DrugTwoController new];
        drugTowVC.myTitle = [self.drugModel.twoType[indexPath.row] className];
        drugTowVC.myId = [self.drugModel.twoType[indexPath.row] classId];
        [self.navigationController pushViewController:drugTowVC animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
