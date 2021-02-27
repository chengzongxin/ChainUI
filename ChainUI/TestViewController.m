//
//  TestViewController.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "TestViewController.h"


#define P(A) printf("%s:%d\n",#A,A);
#define SQUARE(x) printf("The square of "#x" is %d.\n", ((x)*(x)));

#define XNAME(n) x ## n


#define my_print1(...)  printf(__VA_ARGS__)
#define my_print2(fmt,...)  printf(fmt,__VA_ARGS__)
#define my_print3(fmt,...)  printf(fmt,##__VA_ARGS__)
//#define my_print3(fmt,...)  printf(fmt,##__VA_ARGS__)  // 这个有问题，看不粗来



typedef void (^xywh1Block)(id);

typedef struct NER1Rect {
    CGRect value;
}NER1Rect;

typedef TestViewController *(^NER1Rectblock)(NER1Rect);

#define xywh1(...)               xywh1((NER1Rect){__VA_ARGS__})


@interface TestViewController ()
//CUI_PROP(v, Rect)               xywh;\
@property (nonatomic, strong) CUIObjectBlock xywh1;
//#define CUI_CHAINABLE_TYPE(v, t)    typedef v *(^CUIChainable##v##t##Block)
//typedef v *(^CUIChainable##v##t##Block)
// #define CUI_GECUIATE_CHAINABLE_TYPES(x) CUI_CHAINABLE_TYPE(x, Rect)(CUIRect);

@property (nonatomic, readonly) NER1Rectblock xywh1;



@end

@implementation TestViewController

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
    
    [self macro];
    
    
//    view.onLongPress(self, (^{
//        NSLog(@"on long press %@",self);
//        [self longpressaction];
//    }));
    
    printf("10、20 和 30 的和 = %d\n",  sum(1) );
      printf("4、20、25 和 30 的和 = %d\n",  sum(10, 20, 30, 40) );
    
    merge("333","444");
    
    UIViewController *obj = self.xywh1(1,2,3,4).xywh1(5,6,7,8);
    
//    obj.xywh1(2,3,4,5);
    NSLog(@"obj = %@",obj);
    
}

- (NER1Rectblock)xywh1{
    return ^(NER1Rect rect){
        NSLog(@"xywh1 = %@",NSStringFromCGRect(rect.value));
        return self;
    };
}

- (void)longpressaction{
    NSLog(@"dddd");
}

// 函数sum() 计算可选参数之和
int sum(int others, ...)
{
   int val = others;
    printf("a num = %d\n",others);
    va_list args;//定义一个指向个数可变的参数列表指针
    va_start(args, others);//得到第一个可变参数地址
    int aNum = 0;
    while ((aNum = va_arg(args, int))) {
        printf("a num = %d\n",aNum);
        val += aNum;
        aNum = 0;
    }
    
    va_end(args);//置空指针
 
   return val;
}


// 函数add() 计算可选参数之和,最少要有5个参数，不然后面的参数是乱的
char *  merge(char *others, ...)
{
    char * val = others;
    printf("a char = %s\n",others);
    va_list args;//定义一个指向个数可变的参数列表指针
    va_start(args, others);//得到第一个可变参数地址
    char *aChar = 0;
    while ((aChar = va_arg(args, char *))) {
        printf("a char = %s\n",aChar);
    }
    
    va_end(args);//置空指针
 
   return val;
}


- (void)macro{
//    一、#用来把参数转换成字符串
    int a = 1, b = 2;
    
    P(a);
    
    P(b);
    
    P(a+b);
//a:1
//b:2
//a+b:3
    
    
    SQUARE(8)

//    输出的是：The square of 8 is 64
    
    
//    二、##运算符可以用于宏函数的替换部分。这个运算符把两个语言符号组合成单个语言符号，为宏扩展提供了一种连接实际变元的手段
    int x8 = 10;
    
//    如果这样使用宏：XNAME(8)
//    则会被展开成这样：x8
    XNAME(8) += 20;
    NSLog(@"%d",x8);
    
//##就是个粘合剂，将前后两部分粘合起来，也就是有“字符化”的意思。但是“##”不能随意粘合任意字符，必须是合法的C语言标示符。在单一的宏定义中，最多可以出现一次“#”或“##”预处理操作符。如果没有指定与“#”或“##”预处理操作符相关的计算次序，则会产生问题。为避免该问题，在单一的宏定义中只能使用其中一种操作符(即，一份“#”或一个“##”，或都不用)。除非非常有必要，否则尽量不要使用“#”和“##”。
    
    
//    三、__VA_ARGS__ 是一个可变参数的宏，很少人知道这个宏，这个可变参数的宏是新的C99规范中新增的，目前似乎只有gcc支持（VC6.0的编译器不支持）。
//    实现思想就是宏定义中参数列表的最后一个参数为省略号（也就是三个点）。
//    四、##__VA_ARGS__ 宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用,否则会编译出错
    my_print1("i=%d,j=%d\n",1,2);
    my_print2("i=%d,j=%d\n",3,4);
//    my_print2("iiiiiii\n");  // 编译失败打印，因为扩展出来只有一个参数，至少要两个及以上参数
//    my_print3("iiiiiii\n");
    my_print3("iiiiiii\n");
}

@end
