//
//  ToolController.h
//  PocketMedicine
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 organazation. All rights reserved.
//

#import "EFAnimationViewController.h"
#import "CommonDisController.h"
#import "BigDisController.h"
#import "DrugController.h"
#import "ChemistController.h"



#define RADIUS 100.0
#define PHOTONUM 4
#define TAGSTART 1000
#define TIME 0.5
#define SCALENUMBER 1.25
NSInteger array [PHOTONUM][PHOTONUM] = {
    {0,1,2,3},
    {3,0,1,2},
    {2,3,0,1},
    {1,2,3,0},
};

@interface EFAnimationViewController ()<EFItemViewDelegate>

@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation EFAnimationViewController

CATransform3D rotationTransform1[PHOTONUM];

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configViews];
}

#pragma mark - configViews 

- (void)configViews {
    
    NSArray *textArray = [NSArray arrayWithObjects:@"常见病症",@"大病罕见病",@"化验指标",@"药品大全",nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"health_background"]];
    NSArray *dataArray = @[@"commonDis", @"bigDis", @"chemist", @"drug"];
    
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    
    for (NSInteger i = 0;i < PHOTONUM;i++) {
        CGFloat tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        
        EFItemView *view = [[EFItemView alloc] initWithNormalImage:dataArray[i] highlightedImage:[dataArray[i] stringByAppendingFormat:@"%@", @"_hover"] tag:TAGSTART+i title:textArray[i]];
        
        view.frame = CGRectMake(0.0, 0.0,115,115);
        view.center = CGPointMake(tmpx,tmpy);
        view.delegate = self;
        rotationTransform1[i] = CATransform3DIdentity;
        
        CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        view.layer.transform=rotationTransform;
        [self.view addSubview:view];
        
    }
    self.currentTag = TAGSTART;
}

#pragma mark - EFItemViewDelegate

- (void)didTapped:(NSInteger)index {
    
    if (self.currentTag  == index) {

        switch (index) {
            case TAGSTART+0:{//常见病
                CommonDisController *comVC = [CommonDisController new];
                [self.navigationController pushViewController:comVC animated:YES];
                break;
            }
            case TAGSTART+1:{//大病罕见病
                BigDisController *bigVC = [BigDisController new];
                [self.navigationController pushViewController:bigVC animated:YES];
                break;
            }
            case TAGSTART+2:{//化验指标
                ChemistController *chemistVC = [ChemistController new];
                [self.navigationController pushViewController:chemistVC animated:YES];
                break;
            }
            case TAGSTART+3:{//药品大全
                DrugController *drugVC = [DrugController new];
                [self.navigationController pushViewController:drugVC animated:YES];
                break;
            }
                
            default:
                break;
        }
        
        return;
    }
    
    NSInteger t = [self getIemViewTag:index];
    
    for (NSInteger i = 0;i<PHOTONUM;i++ ) {
        
        UIView *view = [self.view viewWithTag:TAGSTART+i];
        [view.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
        [view.layer addAnimation:[self setscale:TAGSTART+i clicktag:index] forKey:@"transform"];
        
        NSInteger j = array[index - TAGSTART][i];
        CGFloat Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
    }
    self.currentTag  = index;
}

- (CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag {
    
    NSInteger i = array[clicktag - TAGSTART][tag - TAGSTART];
    NSInteger i1 = array[self.currentTag  - TAGSTART][tag - TAGSTART];
    CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    CGFloat Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber < 0.3) {
        Scalenumber = 0.4;
    }
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = TIME;
    animation.repeatCount =1;
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num {
    // CALayer
    UIView *view = [self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,view.layer.position.x,view.layer.position.y);
    
    NSInteger p =  [self getIemViewTag:tag];
    CGFloat f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    CGFloat h = f + 2.0*M_PI *num/PHOTONUM;
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    CGFloat tmpy =  centery + RADIUS*cos(h);
    CGFloat tmpx =	centerx - RADIUS*sin(h);
    view.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced"; 	
    return animation;
}

- (NSInteger)getIemViewTag:(NSInteger)tag {
    
    if (self.currentTag >tag){
        return self.currentTag  - tag;
    } else {
        return PHOTONUM  - tag + self.currentTag ;
    }
}

@end




@interface EFItemView ()

@property (nonatomic, strong) NSString *normal;
@property (nonatomic, strong) NSString *highlighted_;
@property (nonatomic, assign) NSInteger tag_;
@property (nonatomic, strong) NSString *title;

@end

@implementation EFItemView

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title {
    
    self = [super init];
    if (self) {
        _normal = normal;
        _highlighted_ = highlighted;
        _tag_ = tag;
        _title = title;
        [self configViews];
    }
    return self;
}

#pragma mark - configViews

- (void)configViews {
    
    self.tag = _tag_;
    [self setBackgroundImage:[UIImage imageNamed:_normal] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:_highlighted_] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitle:_title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
}

- (void)btnTapped:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapped:)]) {
        [self.delegate didTapped:sender.tag];
    }
}

@end

