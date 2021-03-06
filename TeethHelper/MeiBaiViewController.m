//
//  MeiBaiViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiViewController.h"
#import "Utils.h"
#import "ProductIntroduceViewController.h"
#import "AlienView.h"
#import "ALienGrayView.h"
#import <Masonry.h>
#import "MeiBaiConfigFile.h"

#import "MeibaiProjectController.h"
#import "WechatShareViewController.h"

@interface MeiBaiViewController ()

@property (nonatomic, strong) AlienView *alienView;
@property (nonatomic, strong) ALienGrayView *gray1View;
@property (nonatomic, strong) ALienGrayView *gray2View;
@property (nonatomic, strong) ALienGrayView *gray3View;
@property (nonatomic, strong) ALienGrayView *gray4View;

@property (nonatomic, strong) UILabel *currentProjectLabel;


@end

@implementation MeiBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];

    //产品介绍按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"产品介绍" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickProductIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    //分享按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //主视图
    [self configMainView];
}
-(void)configMainView{
    
    //计划进程
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.text = @"当前计划进程";
    label.textColor = [Utils commonColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(68);
        make.height.equalTo(@50);
    }];
    
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 110, width - CircleMargin * 2, width - CircleMargin * 2)];
        self.alienView.dayLabel.font = [UIFont systemFontOfSize:80];
        
    }
    //    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
    self.alienView.day = @"10";
    
    [self.view addSubview:_alienView];
    
    
    //
    UIButton *beginProjectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [beginProjectButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal"] forState:UIControlStateNormal];
    [beginProjectButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal"] forState:UIControlStateHighlighted];
    [beginProjectButton setTitle:@"开始美白程序" forState:UIControlStateNormal];
    [beginProjectButton addTarget:self action:@selector(beginMeibaiProject:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:beginProjectButton];
    
    [beginProjectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alienView.mas_bottom).offset(15);
        make.width.equalTo(@150);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@35);
    }];
    
    UILabel *completedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    completedLabel.text = @"已完成计划";
    completedLabel.textAlignment =NSTextAlignmentCenter;
    completedLabel.textColor = [Utils commonColor];
    completedLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:completedLabel];
    
    [completedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginProjectButton.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_centerX).offset(0);
    }];
    
    _currentProjectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    //    if (![MeiBaiConfigFile getCurrentProject] || [[MeiBaiConfigFile getCurrentProject] isEqualToString:@"治疗"]) {
    //        currentProjectLabel.text = @"当前计划: 治疗";
    //    } else{
    _currentProjectLabel.text = @"当前计划: 保持";
    //    }
    _currentProjectLabel.textAlignment =NSTextAlignmentCenter;
    _currentProjectLabel.textColor = [Utils commonColor];
    _currentProjectLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_currentProjectLabel];
    
    [_currentProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(completedLabel.mas_top);
    }];
    
    //左 - 治疗
    _gray1View = [[ALienGrayView alloc] initWithDays:0 forType:@"治疗"];
    
    [self.view addSubview:_gray1View];
    
    [_gray1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(completedLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //左 - 保持
    _gray2View = [[ALienGrayView alloc] initWithDays:0 forType:@"保持"];
    
    [self.view addSubview:_gray2View];
    
    [_gray2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(completedLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //右 -
    _gray3View = [[ALienGrayView alloc] initWithDays:0 forType:@"天"];
    
    [self.view addSubview:_gray3View];
    
    [_gray3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_currentProjectLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(_currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //保持天数
    _gray4View = [[ALienGrayView alloc] initWithDays:99 forType:@"次/天"];
    
    [self.view addSubview:_gray4View];
    
    [_gray4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentProjectLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(_currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
    BOOL iscure = [MeiBaiConfigFile isCureStage];
    if (iscure) {
        //如果是治疗阶段
        
        
        NSInteger needday = [MeiBaiConfigFile getNeedCureDays];
        NSInteger times = [MeiBaiConfigFile getCureTimesEachDay];
        self.gray3View.hidden = NO;

        self.gray3View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)needday];
        self.gray4View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)times];

        [self.alienView animateArcTo:0.5];
        _currentProjectLabel.text = @"当前计划: 治疗";

    } else{
        //保持阶段
        [self.alienView animateArcTo:1.0];
        self.alienView.dayLabel.text = @"1";
        
        self.gray3View.hidden = YES;
        self.gray4View.daysLabel.text = @"4";
        _currentProjectLabel.text = @"当前计划: 保持";

    }
    
    NSInteger completedCuredays = [MeiBaiConfigFile getCompletedCureDays];
    NSInteger completedkeepdays = [MeiBaiConfigFile getCompletedKeepDays];
    
    self.gray1View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)completedCuredays];
    self.gray2View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)completedkeepdays];

}


-(void)clickProductIntroduce:(UIButton *)button {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    ProductIntroduceViewController *introduceVC =[sb instantiateViewControllerWithIdentifier:@"ProductIntroduceViewController"];
    
    introduceVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:introduceVC animated:YES];
    
    
}

-(void)share:(UIButton*)button{
    WechatShareViewController *wechatShare = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    
    wechatShare.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self showDetailViewController:wechatShare sender:self];
}

-(void)beginMeibaiProject:(id)sender{
    MeibaiProjectController * projectVC = [[MeibaiProjectController alloc] initWithNibName:@"MeibaiProjectController" bundle:nil];
    projectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectVC animated:YES];
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
