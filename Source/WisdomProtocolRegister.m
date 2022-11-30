//
//  WisdomProtocolRegister.m
//  WisdomProtocol
//
//  Created by tangjianfeng on 2021/12/17.
//

#import "WisdomProtocolRegister.h"
#import <objc/runtime.h>
#import <mach-o/dyld.h>

@implementation WisdomProtocolRegister

+ (void)load {
    Class protocolCla = objc_getClass("WisdomProtocol.WisdomProtocol");
    SEL sel = NSSelectorFromString(@"registerable");

    IMP imp = [protocolCla methodForSelector:sel];
    void (*func)(id, SEL) = (void *)imp;
    func(protocolCla, sel);
}
@end

long wisdom_calculate(void){
    long slide = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        if (_dyld_get_image_header(i)->filetype == MH_EXECUTE) {
            slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    return slide;
}
