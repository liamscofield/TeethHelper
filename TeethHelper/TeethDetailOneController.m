//
//  TeethDetailOneController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethDetailOneController.h"
#import "TeethChooseView.h"
#import <Masonry.h>
#import "Utils.h"
#import "TeethStateConfigureFile.h"
@interface TeethDetailOneController ()

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation TeethDetailOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"健康状况" onViewController:self];
    
    NSArray *arr = @[@"好",@"一般",@"不好",@"不知道"];
    
    self.views = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        
        TeethChooseView *view = [[TeethChooseView alloc] initWithTitle:arr[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        
        
        [self.views addObject:view];
        [self.view addSubview:self.views[i]];
        
        [self.views[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64 + 20 +  70 * i);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.height.equalTo(@50);
            
        }];
        

    }
    
    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeethChooseView *view = obj;
        if (idx == _currentIndex) {
            [view didCHangeColorType:Selected];

        } else{
            [view didCHangeColorType:Normal];

        }
    }];


}

-(void)selectIndex:(id)sender{

    UITapGestureRecognizer *tap = sender;
    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeethChooseView *view = obj;
        if (idx == tap.view.tag) {
            
            [view didCHangeColorType:Selected];
            [TeethStateConfigureFile setTeethStateLevel:idx];
        } else{
            [view didCHangeColorType:Normal];
        }
    }];
        
}

-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
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
