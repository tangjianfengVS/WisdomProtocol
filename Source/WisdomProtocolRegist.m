//
//  WisdomProtocolRegist+Regist.m
//  WisdomProtocol
//
//  Created by tangjianfeng on 2021/12/17.
//

#import "WisdomProtocolRegist.h"
#import <objc/runtime.h>

@implementation WisdomProtocolRegist

+ (void)load {
    Class protocolCla = objc_getClass("WisdomProtocol.WisdomProtocol");
    SEL sel = NSSelectorFromString(@"registerable");

    IMP imp = [protocolCla methodForSelector:sel];
    void (*func)(id, SEL) = (void *)imp;
    func(protocolCla, sel);
}

@end
