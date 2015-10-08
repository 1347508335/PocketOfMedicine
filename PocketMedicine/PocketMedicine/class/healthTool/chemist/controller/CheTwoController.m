//
//  CheTwoController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "CheTwoController.h"
#import "DataTool.h"
#import "ChemistThree.h"
#import "MJExtension.h"
#import "CheDetailController.h"

#define kCheTwo @"http://api.lkhealth.net/index.php?r=drug/getInspectsTwoList&id=%@"

@interface CheTwoController ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation CheTwoController

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self getData];
}

- (void)getData{
    
    NSString *urlStr = [NSString stringWithFormat:kCheTwo,self.myId];

    __weak typeof(self)weakSelf = self;
    [DataTool solveDataWithUrlStr:urlStr method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        
        NSArray *list = dict[@"data"][@"inspectsTwoList"];
        NSArray *list2 = [ChemistThree objectArrayWithKeyValuesArray:list];
        [weakSelf.dataArray addObjectsFromArray:list2];

        NSLog(@"%ld", self.dataArray.count);
        
        [weakSelf.tableView reloadData];
        
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArray[indexPath.row] name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CheDetailController *cheDVC = [[CheDetailController alloc]init];
    cheDVC.myTitle = [self.dataArray[indexPath.row] name];
    cheDVC.myId = [self.dataArray[indexPath.row] dataId];
    [self.navigationController pushViewController:cheDVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
