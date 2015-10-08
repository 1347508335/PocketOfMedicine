//
//  ChemistController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "ChemistController.h"
#import "ChemistCell.h"
#import "DataTool.h"
#import "ChemistModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "CheTwoController.h"


#define LCDW [[UIScreen mainScreen] bounds].size.width
#define LCDH [[UIScreen mainScreen] bounds].size.height
#define kChemist @"http://api.lkhealth.net/index.php?r=drug/getInspectsList"

@interface ChemistController ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ChemistController

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
    
    self.title = @"化验指标";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChemistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self getData];

}

-(void)getData{
    
    
    __weak typeof(self) weakSelf =self;
    [DataTool solveDataWithUrlStr:kChemist method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        NSArray *list = dict[@"data"][@"inspectsList"];
        NSArray *list2 = [ChemistModel objectArrayWithKeyValuesArray:list];
        [weakSelf.dataArray addObjectsFromArray:list2];
        
        [weakSelf.tableView reloadData];
        //NSLog(@"%@", obj);
        
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
    
    ChemistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ChemistModel *model = self.dataArray[indexPath.row];
    [cell.img4pic sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"smile"]];
    cell.lab4name.text = model.name;
    
    NSString *str = [model.inspectsNum stringByAppendingString:@"  项"];
    cell.lab4num.text = str;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CheTwoController *CheTwoVC = [CheTwoController new];
    CheTwoVC.myTitle = [self.dataArray[indexPath.row] name];
    CheTwoVC.myId = [self.dataArray[indexPath.row] dataId];
    
    [self.navigationController pushViewController:CheTwoVC animated:YES];
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
