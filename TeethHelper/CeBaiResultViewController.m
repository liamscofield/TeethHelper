//
//  CeBaiResultViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/22.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "CeBaiResultViewController.h"
#import "AccountManager.h"
#import "Utils.h"
#import <Masonry.h>

#import "MeiBaiConfigFile.h"
#import "PostToSocialController.h"

@interface CeBaiResultViewController ()


@property (nonatomic, assign) NSInteger Level;

@end

@implementation CeBaiResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationController.navigationBar.translucent = YES;
    [self configRightNavigationItem];
    
    //TODO:通过SDK获得白度值
    self.Level = 7;
    
    
    
    
    
    
    if (![AccountManager isCompletedFirstCeBai]) {
        
        //未完成首次测白,完成，保存图片，保存初次测白等级

        [MeiBaiConfigFile setFirstCebaiLevel:self.Level];
        [self saveImage:self.image];

        //未完成首次测白，展示一张图片
        //
        
        
        UIView *imageBGView = [[UIView alloc] initWithFrame:CGRectZero];
        imageBGView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imageBGView];
        
        [imageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(74);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@150);
        }];
        
        UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        mainImageView.image = self.image;
        
        [imageBGView addSubview:mainImageView];
        
        [mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView.mas_top).offset(4);
            make.left.equalTo(imageBGView.mas_left).offset(4);
            make.right.equalTo(imageBGView.mas_right).offset(-4);
            make.height.equalTo(@115);
        }];
        
        UIImageView *comparsionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        comparsionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"check_N%ld",self.Level]];
        
        comparsionImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [imageBGView addSubview:comparsionImageView];
        
        [comparsionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainImageView.mas_bottom).offset(0);
            make.left.equalTo(imageBGView.mas_left).offset(4);
            make.right.equalTo(imageBGView.mas_right).offset(-4);
            make.bottom.equalTo(imageBGView.mas_bottom).offset(0);
        }];
//        check_N1
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label1.text = @"您当前的牙齿色阶为";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:25];
        
        [self.view addSubview:label1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView.mas_bottom).offset(50);
            make.left.equalTo(imageBGView.mas_left).offset(20);
        }];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label2.text = [NSString stringWithFormat:@"N%ld",self.Level];
        label2.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        label2.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:label2];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(8);
            make.centerY.equalTo(label1.mas_centerY).offset(0);
        }];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        
//        label3.text = @"击败了全国99%的人";
        label3.text = [NSString stringWithFormat:@"击败了全国%@的人",[self beatRateFromLevel:self.Level]];

        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:label3];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(0);
            make.left.equalTo(imageBGView.mas_left).offset(20);
            make.right.equalTo(imageBGView.mas_right).offset(-20);
            make.height.equalTo(@50);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];

        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3.mas_bottom).offset(20);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@45);
        }];
        
        
        
    } else{
        //展示对比图片
        
        //使用前
        UILabel *use_before_label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        use_before_label.text = @"使用前";
        use_before_label.textAlignment = NSTextAlignmentCenter;
        use_before_label.font = [UIFont systemFontOfSize:14.0];
        use_before_label.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        [self.view addSubview:use_before_label];
        
        [use_before_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(72);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
        }];
        
        UIView *imageBGView = [[UIView alloc] initWithFrame:CGRectZero];
        imageBGView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imageBGView];
        
        [imageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(use_before_label.mas_bottom).offset(4);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@150);
        }];
        
        UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        mainImageView.image = [self loadImage];
    
        [imageBGView addSubview:mainImageView];
        
        [mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView.mas_top).offset(4);
            make.left.equalTo(imageBGView.mas_left).offset(4);
            make.right.equalTo(imageBGView.mas_right).offset(-4);
            make.height.equalTo(@115);
        }];
        
        UIImageView *comparsionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        comparsionImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"check_N%ld",[MeiBaiConfigFile firstCeBaiLevel]]];
        
        [imageBGView addSubview:comparsionImageView];
        
        [comparsionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainImageView.mas_bottom).offset(0);
            make.left.equalTo(imageBGView.mas_left).offset(4);
            make.right.equalTo(imageBGView.mas_right).offset(-4);
            make.bottom.equalTo(imageBGView.mas_bottom).offset(0);
        }];
        
        //        使用后
        UILabel *use_after_label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        use_after_label.text = @"使用后";
        use_after_label.textAlignment = NSTextAlignmentCenter;
        use_after_label.font = [UIFont systemFontOfSize:14.0];
        use_after_label.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];

        [self.view addSubview:use_after_label];
        
        [use_after_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView.mas_bottom).offset(8);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
        }];
        
        UIView *imageBGView2 = [[UIView alloc] initWithFrame:CGRectZero];
        imageBGView2.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:imageBGView2];
        
        [imageBGView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(use_after_label.mas_bottom).offset(4);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@150);
        }];
        
        UIImageView *mainImageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        mainImageView2.image = self.image;
        
        [imageBGView2 addSubview:mainImageView2];
        
        [mainImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView2.mas_top).offset(4);
            make.left.equalTo(imageBGView2.mas_left).offset(4);
            make.right.equalTo(imageBGView2.mas_right).offset(-4);
            make.height.equalTo(@115);
        }];
        
        UIImageView *comparsionImageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        comparsionImageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"check_N%ld",self.Level]];
        
//        comparsionImageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        [imageBGView2 addSubview:comparsionImageView2];
        
        [comparsionImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainImageView2.mas_bottom).offset(0);
            make.left.equalTo(imageBGView2.mas_left).offset(4);
            make.right.equalTo(imageBGView2.mas_right).offset(-4);
            make.bottom.equalTo(imageBGView2.mas_bottom).offset(0);
        }];
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label1.text = @"您当前的牙齿色阶为";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:25];
        
        [self.view addSubview:label1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageBGView2.mas_bottom).offset(8);
            make.left.equalTo(imageBGView2.mas_left).offset(20);
        }];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label2.text = [NSString stringWithFormat:@"N%ld",self.Level];
        label2.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        label2.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:label2];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(8);
            make.centerY.equalTo(label1.mas_centerY).offset(0);
        }];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label3.text = [NSString stringWithFormat:@"击败了全国%@的人",[self beatRateFromLevel:self.Level]];
        
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:label3];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(0);
            make.left.equalTo(imageBGView.mas_left).offset(20);
            make.right.equalTo(imageBGView.mas_right).offset(-20);
            make.height.equalTo(@50);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
 
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3.mas_bottom).offset(8);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@45);
        }];
    }
}

-(void)configRightNavigationItem{
    UIImage *image = [UIImage imageNamed:@"icon_share_normal"];
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
    
    [popButton setImage:image forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(ShareToSocial:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popButton];

}

#pragma mark - 分享至社区
-(void)ShareToSocial:(id)sender{
    PostToSocialController *postVC = [[PostToSocialController alloc] initWithNibName:@"PostToSocialController" bundle:nil];
    
    
    UIImage *image = [self loadImage];
    if (image != nil) {
        postVC.firstImage = image;
    }
    postVC.secondImage = self.image;
    postVC.beatRateString = [self beatRateFromLevel:self.Level];

    postVC.levelString = [NSString stringWithFormat:@"N%ld",self.Level];
    [self.navigationController pushViewController:postVC animated:YES];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击完成

- (IBAction)done:(id)sender {
    
    if (![AccountManager isCompletedFirstCeBai]) {
        //首次测白，保存图片，并跳转至首页
        [AccountManager setCompletedFirstCeBai:YES];


        [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionsCompleted" object:nil];
    } else{
        //展示对比图片,返回
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}


-(void)saveImage:(UIImage*)image{
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/someImageName.png"];
    
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

-(UIImage *)loadImage{
    
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/someImageName.png"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)beatRateFromLevel:(NSInteger)level{
    switch (level) {
        case 1:
        {
            return @"99%";
        }
            break;
        case 2:
        {
            return @"98%";

        }
            break;
        case 3:
        {
            return @"96%";

        }
            break;
        case 4:
        {
            return @"92%";

        }
            break;
        case 5:
        {
            return @"84%";

        }
            break;
        case 6:
        {
            return @"73%";

        }
            break;
        case 7:
        {
            return @"58%";

        }
            break;
        case 8:
        {
            return @"42%";

        }
            break;
        case 9:
        {
            return @"27%";

        }
            break;
        case 10:
        {
            return @"16%";

        }
            break;
        case 11:
        {
            return @"8%";

        }
            break;
        case 12:
        {
            return @"4%";

        }
            break;
        case 13:
        {
            return @"1%";

        }
            break;
        case 14:
        {
            return @"0.5%";

        }
            break;
        case 15:
        {
            return @"0.1%";

        }
            break;
            
            default:
            return @"0.1%";

    }
}
@end
