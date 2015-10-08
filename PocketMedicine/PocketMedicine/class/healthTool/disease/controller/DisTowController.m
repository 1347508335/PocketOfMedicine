//
//  DisTowController.m
//  PocketMedicine
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "DisTowController.h"
#import "DiseaseTwoModel.h"
#import "DataTool.h"
#import "MJExtension.h"
#import "DisTowCell.h"
#import "UIImageView+WebCache.h"
#import "DisDetailController.h"
#import "DisInfoModel.h"
#import "DrugDetailController.h"


#define LCDW [[UIScreen mainScreen] bounds].size.width
#define LCDH [[UIScreen mainScreen] bounds].size.height
#define kDisTow @"http://api.lkhealth.net/index.php?r=drug/diseaseown&diseaseId=%@&uid=101469924&lat=40.036284&lng=116.350302"

@interface DisTowController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *infoArray;


@end

@implementation DisTowController

//懒加载
-(NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray *)infoArray{
    if (nil == _infoArray) {
        _infoArray = [[NSMutableArray alloc] init];
    }
    return _infoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.myTitle;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DisTowCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self getData];
    [self setupView];

}

- (void)setupView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, 130)];
    self.labelInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, LCDW - 20, 30)];
    self.labelContent = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, LCDW - 20, 80)];
    self.labelInfo.numberOfLines = 0;
    self.labelContent.numberOfLines = 0;
    self.labelContent.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:self.labelInfo];
    [self.headView addSubview:self.labelContent];
    self.tableView.tableHeaderView = self.headView;

}

-(void)getData{
    
    __weak typeof(self) weakSelf =self;
    [DataTool solveDataWithUrlStr:[NSString stringWithFormat:kDisTow, self.myId] method:@"GET" postBody:nil sloveBlock:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        NSDictionary *head = dict[@"data"];
        NSDictionary *info = head[@"deseaseInfo"];
        self.labelInfo.text = info[@"deseaseName"];
        self.labelContent.text = info[@"content"];
        
        NSArray *list = head[@"drugList"];
        NSArray *list2 = [DiseaseTwoModel objectArrayWithKeyValuesArray:list];
        
        NSArray *infoList = head[@"newsList"];
        NSArray *infoList2 = [DisInfoModel objectArrayWithKeyValuesArray:infoList];
        
        [weakSelf.infoArray addObjectsFromArray:infoList2];
        [weakSelf.dataArray addObjectsFromArray:list2];
        
        [weakSelf.tableView reloadData];
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.infoArray.count;
    }else{
        return self.dataArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DisTowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        DisInfoModel *model = self.infoArray[indexPath.row];

        [cell.imgView4Com sd_setImageWithURL:[NSURL URLWithString:model.infoLogo] placeholderImage:[UIImage imageNamed:@"drugback"]];
        cell.lab4Title.text = model.infoTitle;
        cell.lab4Des.text = model.infoContent;
    }else{
        DiseaseTwoModel *model = self.dataArray[indexPath.row];
        [cell.imgView4Com sd_setImageWithURL:[NSURL URLWithString:model.drugPic] placeholderImage:[UIImage imageNamed:@"drugback"]];
        cell.lab4Title.text = model.drugName;
        cell.lab4Des.text = model.promotionInfo;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return @"相关用药";
    }else{
        return @"疾病介绍";
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        DisDetailController *DisDVC = [[DisDetailController alloc]init];
        DisDVC.myId = [self.infoArray[indexPath.row] infoId];
        [self.navigationController pushViewController:DisDVC animated:YES];
    }else{
        DrugDetailController *drugDVC = [[DrugDetailController alloc]init];
        drugDVC.myId = [self.dataArray[indexPath.row] drugId];
        [self.navigationController pushViewController:drugDVC animated:YES];
    }
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
