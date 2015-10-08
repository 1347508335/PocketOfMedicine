//
//  DrugTwoController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DrugTwoController.h"
#import "DrugThreeCell.h"
#import "DataTool.h"
#import "DrugTwoModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "DrugDetailController.h"
#import "MJRefresh.h"


#define kDrugTwo @"http://api.lkhealth.net/index.php?r=drug/getdruglistbycalss&classId=%@&type=&start=%ld&rows=&lat=40.036261&lng=116.350322"

@interface DrugTwoController ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation DrugTwoController

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
    self.title = self.myTitle;
    
    _star = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DrugThreeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];

    [self getData];
    [self AddFooter];

}

- (void)getData{

    NSString *urlStr = [NSString stringWithFormat:kDrugTwo,self.myId, _star*20];

    __weak typeof(self) weakSelf =self;
    [DataTool solveDataWithUrlStr:urlStr method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        NSArray *list = dict[@"data"][@"drugList"];
        NSArray *list2 = [DrugTwoModel objectArrayWithKeyValuesArray:list];
        [weakSelf.dataArray addObjectsFromArray:list2];
        
        [weakSelf.tableView reloadData];
        _star++;
    }];
}


//上拉加载
-(void)AddFooter
{
    __weak typeof(self) weakSelf = self;
    //添加上拉尾部控件
    [weakSelf.tableView addFooterWithCallback:^{
        //刷新列表
        [weakSelf getData];
        //结束刷新
        [weakSelf.tableView footerEndRefreshing];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DrugThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DrugTwoModel *model = self.dataArray[indexPath.row];
    [cell.img4pic sd_setImageWithURL:[NSURL URLWithString:model.drugPic] placeholderImage:[UIImage imageNamed:@"drugback"]];

    cell.lab4Name.text = model.drugName;
    cell.lab4tro.text = model.indication;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DrugDetailController *drugDVC = [DrugDetailController new];
    drugDVC.myTitle = [self.dataArray[indexPath.row] drugName];
    drugDVC.myId = [self.dataArray[indexPath.row] drugId];
    
    [self.navigationController pushViewController:drugDVC animated:YES];

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
