//
//  FirstChildViewController.m
//  AddChildControllerTest1110
//
//  Created by liuyang on 16/11/10.
//  Copyright © 2016年 liuyang. All rights reserved.
//

#import "FirstChildViewController.h"

@interface FirstChildViewController ()

@end

@implementation FirstChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, 200, 450)];
    scroll.backgroundColor = [UIColor purpleColor];
    scroll.contentSize = CGSizeMake(0, 600);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 20)];
    label.text = @"标签";
    label.font = [UIFont systemFontOfSize:18];
    [scroll addSubview:label];
    
    
    [self.view addSubview:scroll];
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
