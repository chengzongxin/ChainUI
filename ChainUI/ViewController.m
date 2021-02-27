//
//  ViewController.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/25.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = View.xywh(100,100,100,100).bgColor(UIColor.redColor).onClick(^{
        NSLog(@"%zd",self.view.subviews.firstObject.tag);
    }).tg(320);
    [self.view addSubview:view];
    
    UILabel *label = UILabel.new.xywh(100,300,100,100).bgColor(UIColor.redColor).onClick(^{
        NSLog(@"%zd",self.view.subviews.lastObject.tag);
    }).tg(30);
    [self.view addSubview:label];
    
}
@end
