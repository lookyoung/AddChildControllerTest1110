//
//  MainViewController.m
//  AddChildControllerTest1110
//
//  Created by liuyang on 16/11/10.
//  Copyright © 2016年 liuyang. All rights reserved.
//

#import "MainViewController.h"
#import "FirstChildViewController.h"
#import "SecondChildViewController.h"
#import "ThirdChildViewController.h"

@interface MainViewController ()
/** fristVC */
@property (nonatomic, strong) FirstChildViewController *firstVC;
/** SecondVC */
@property (nonatomic, strong) SecondChildViewController *secondVC;
/** thirdVC */
@property (nonatomic, strong) ThirdChildViewController *thirdVC;
/** currentVC */
@property (nonatomic, strong) UIViewController *currentVC;

/** menuBar */
@property (nonatomic, strong) UIScrollView *headScrollView;
/** headArray */
@property (nonatomic, strong) NSArray *headArray;

@end

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.title = @"网易TEST";
    self.headArray = @[@"头条", @"精选", @"娱乐", @"体育", @"科技", @"财经", @"汽车"];
    
    // iOS7在Controller中新增了这个属性：
    // automaticallyAdjustsScrollViewInsets，当设置为YES时（默认YES），如果视图里面存在唯一一个UIScrollView或其子类View，那么它会自动设置相应的内边距，这样可以让scroll占据整个视图，又不会让导航栏遮盖。这里若为YES时，headScrollView的滚动按钮显示不出来
    // 我们设置automaticallyAdjustsScrollViewInsets这个属性为no，就可以解决这个问题。
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.headScrollView];
    
    self.firstVC = [[FirstChildViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104)];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[SecondChildViewController alloc] init];
    [self.secondVC.view setFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104)];
    
    self.thirdVC = [[ThirdChildViewController alloc] init];
    [self.thirdVC.view setFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104)];
    
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
}

#pragma mark - lazy load
-(UIScrollView *)headScrollView {
    if (!_headScrollView) {
        _headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
        _headScrollView.backgroundColor = [UIColor grayColor];
        _headScrollView.contentSize = CGSizeMake(560, 0);
        _headScrollView.bounces = NO;
        _headScrollView.pagingEnabled = YES;
        for (int i = 0; i < self.headArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(80 * i, 0, 80, 40);
            [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(clickButtonWithTag:) forControlEvents:UIControlEventTouchUpInside];
            [_headScrollView addSubview:button];
            
        }
    }
    return _headScrollView;
}

- (void)clickButtonWithTag:(UIButton *)sender {
    //  点击处于当前页面的按钮,直接跳出
    if ((self.currentVC == self.firstVC && sender.tag == 1000)||(self.currentVC == self.secondVC && sender.tag == 1001)||(self.currentVC == self.thirdVC && sender.tag == 1002)) {
        return;
    }else{
        
        switch (sender.tag - 1000) {
            case 0:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 1:
                [self replaceController:self.currentVC newController:self.secondVC];
                break;
            case 2:
                [self replaceController:self.currentVC newController:self.thirdVC];
                break;
            case 3:
                
                break;
            case 4:
                
                break;
                
            default:
                break;
        }
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:2.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
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
