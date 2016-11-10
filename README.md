# AddChildControllerTest1110

关键是
[self addChildViewController:_firstVC];

以及子控制器之间的切换
	
        
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
