#import <Cedar-iOS/Cedar.h>
#import "ViewController.h"
#import "AnotherViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RobotSpikeSpec)

void(^advanceRunLoop)(NSTimeInterval) = ^(NSTimeInterval interval){
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
};

describe(@"Robot spike", ^{
    __block UIWindow *window;
    __block ViewController *controller;

    beforeEach(^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UINavigationController *navigationController = [storyboard instantiateInitialViewController];

        controller = (ViewController *)navigationController.topViewController;
        controller should be_instance_of([ViewController class]);

        window.rootViewController = navigationController;
        [window makeKeyAndVisible];

        advanceRunLoop(0);
    });

    afterEach(^{
        advanceRunLoop(1);

        [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    });

    describe(@"tapping a button which presents a view controller", ^{
        beforeEach(^{
            UIButton *button = (UIButton *)[controller.view viewWithTag:1];
            button should be_instance_of([UIButton class]).or_any_subclass();
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        });

        it(@"should present the view controller", ^{
            controller.presentedViewController should be_instance_of([AnotherViewController class]);
        });
    });

    describe(@"tapping a button which pushes a view controller onto the nav stack", ^{
        beforeEach(^{
            UIButton *button = (UIButton *)[controller.view viewWithTag:2];
            button should be_instance_of([UIButton class]).or_any_subclass();
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        });

        it(@"should be the top view controller", ^{
            controller.navigationController.topViewController should be_instance_of([AnotherViewController class]);
        });

        describe(@"popping the top view controller", ^{
            beforeEach(^{
                [controller.navigationController popViewControllerAnimated:YES];
            });

            it(@"should fail without advancing the runloop", ^{
                ^{ controller.navigationController.topViewController should equal(controller); } should raise_exception;
            });

            it(@"should present the initial view controller", ^{
                advanceRunLoop(1);

                controller.navigationController.topViewController should equal(controller);
            });
        });

        describe(@"popping to the root view controller", ^{
            beforeEach(^{
                [controller.navigationController popToRootViewControllerAnimated:YES];
            });

            it(@"should fail without advancing the runloop", ^{
                ^{ controller.navigationController.topViewController should equal(controller); } should raise_exception;
            });

            it(@"should present the initial view controller", ^{
                advanceRunLoop(1);

                controller.navigationController.topViewController should equal(controller);
            });
        });
    });
});

SPEC_END

