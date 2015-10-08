//
//  CommonDisController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "CommonDisController.h"
#import "SecondCollectionViewCell.h"
#import "DataTool.h"
#import "DisModelOne.h"
#import "MJExtension.h"
#import "DisTowController.h"


#define LCDW [[UIScreen mainScreen] bounds].size.width
#define LCDH [[UIScreen mainScreen] bounds].size.height
#define kComDisOne @"http://api.lkhealth.net/index.php?r=drug/getcommondisease&uid=101469924"

@interface CommonDisController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)DisModelOne *disModel;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CommonDisController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"常见病症";
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
    
    self.dataArray = [NSMutableArray array];
    
    __weak typeof(self)weakSelf = self;
    [DataTool solveDataWithUrlStr:kComDisOne method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        NSArray *list = dict[@"data"][@"commonDiseaseList"];
        NSArray *list2 = [DisModelOne objectArrayWithKeyValuesArray:list];
        [weakSelf.dataArray addObjectsFromArray:list2];
        
        [weakSelf.tableViewLeft reloadData];
        
        self.disModel = [DisModelOne new];
        self.disModel = list2[0];
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
        return self.disModel.twoType.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if ([tableView isEqual:self.tableViewLeft]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell" forIndexPath:indexPath];
        DisModelOne *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.dataName;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell" forIndexPath:indexPath];

        cell.textLabel.text = [self.disModel.twoType[indexPath.row] dataName];
        return cell;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.tableViewLeft]) {
        DisModelOne *model = self.dataArray[indexPath.row];
        self.disModel = [DisModelOne new];
        self.disModel = model;
        [self.tableViewRight reloadData];
        
    }else{
        DisTowController *disTowVC = [DisTowController new];
        disTowVC.myTitle = [self.disModel.twoType[indexPath.row] dataName];
        disTowVC.myId = [self.disModel.twoType[indexPath.row] dataId];
        [self.navigationController pushViewController:disTowVC animated:YES];
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
