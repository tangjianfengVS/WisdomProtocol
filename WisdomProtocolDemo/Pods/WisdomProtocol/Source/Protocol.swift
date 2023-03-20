//
//  Protocol.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit

@objc public final class WisdomProtocol: NSObject {

    @available(*, unavailable)
    override init() {}
}

extension WisdomProtocol: WisdomProtocolRegisterable {
    
    @objc static func registerable(){
        WisdomProtocolCore.registerable()
    }
    
    // MARK: Register Protocol: WisdomClassable
    // * Need to ensure the timing of registration, the level must be the highest *
    //   用于 手动注册 或 静态库链接引用类。解决 WisdomProtocol 静态库链接注册类问题
    @discardableResult
    @objc public static func registerable(classable: WisdomClassable)->Protocol{
        return WisdomProtocolCore.registerable(classable: classable)
    }
}


// * Create Protocol *
// Initialize the defined protocol using a string
extension WisdomProtocol: WisdomProtocolCreateable {
    
    // MARK: Create Protocol From Protocol Name: String
    @objc public static func create(protocolName: String)->Protocol? {
        return WisdomProtocolCore.create(protocolName: protocolName)
    }
    
    // MARK: Create Protocol From Project Name: String, Protocol Name: String
    @objc public static func create(projectName: String, protocolName: String)->Protocol? {
        return WisdomProtocolCore.create(projectName: projectName, protocolName: protocolName)
    }
}


// * Gets AnyClass / UIView.Type / UIViewController.Type / UIImage.Type / Bundle.Type *
// Gets the type of the registered binding protocol
extension WisdomProtocol: WisdomProtocolable {
    
    // MARK: Get AnyClass From Protocol
    @objc public static func getClassable(from Protocol: Protocol)->AnyClass?{
        return WisdomProtocolCore.getClassable(from: Protocol)
    }

    // MARK: Get UIView.Type From Protocol
    @objc public static func getViewable(from Protocol: Protocol)->UIView.Type?{
        return WisdomProtocolCore.getViewable(from: Protocol)
    }

    // MARK: Get UIViewController.Type From Protocol
    @objc public static func getControlable(from Protocol: Protocol)->UIViewController.Type?{
        return WisdomProtocolCore.getControlable(from: Protocol)
    }
    
    // MARK: Get UIImage.Type From Protocol
    @objc public static func getImageable(from Protocol: Protocol)->UIImage.Type?{
        return WisdomProtocolCore.getImageable(from: Protocol)
    }

    // MARK: Get Bundle.Type From Protocol
    @objc public static func getBundleable(from Protocol: Protocol)->Bundle.Type?{
        return WisdomProtocolCore.getBundleable(from: Protocol)
    }
}


// * Router Protocol *
// Gets Router WisdomRouterClassable.Type / WisdomRouterViewable.Type / WisdomRouterControlable.Type
// Gets Router WisdomRouterImageable.Type / WisdomRouterBundleable.Type / WisdomRouterNibable.Type
extension WisdomProtocol: WisdomProtocolRouterable {

    // MARK: Get Router AnyClass From Protocol
    @objc public static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?{
        return WisdomProtocolCore.getRouterClassable(from: Protocol)
    }

    // MARK: Get Router UIView.Type From Protocol
    @objc public static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?{
        return WisdomProtocolCore.getRouterViewable(from: Protocol)
    }

    // MARK: Get Router UIViewController.Type From Protocol
    @objc public static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?{
        return WisdomProtocolCore.getRouterControlable(from: Protocol)
    }
    
    // MARK: Get Router UIImage.Type From Protocol
    @objc public static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?{
        return WisdomProtocolCore.getRouterImageable(from: Protocol)
    }
    
    // MARK: Get Router Bundle.Type From Protocol
    @objc public static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?{
        return WisdomProtocolCore.getRouterBundleable(from: Protocol)
    }
    
    // MARK: Get Router UINib.Type From Protocol
    @objc public static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?{
        return WisdomProtocolCore.getRouterNibable(from: Protocol)
    }
}


// * Binary Bit Value(value==1) Protocol *
// Gets the value of the specified binary bit
extension WisdomProtocol: WisdomBinaryBitValueable {
    
    // MARK: return - [NSInteger]
    // get Binarierable list bit values when value==1 width: NSInteger, [NSInteger]
    // example: 'let res = WisdomProtocol.getBinaryable(value: 31, caseBitables: [0,1,2,3,4,5])'
    //          'res = [0,1,2,3,4]'
    @objc public static func getBinaryable(value: NSInteger, caseBitables: [NSInteger])->[NSInteger]{
        return WisdomProtocolCore.getBinaryable(value: value, caseBitables: caseBitables)
    }

    // MARK: return - Bool
    // get Binarierable a bit value when value==1 width: NSInteger, NSInteger
    // example: 'let res = WisdomProtocol.isBinaryable(value: 31, caseBitable: 3])'
    //          'res = ture'
    // example: 'let res = WisdomProtocol.isBinaryable(value: 31, caseBitable: 5])'
    //          'res = false'
    @objc public static func isBinaryable(value: NSInteger, caseBitable: NSInteger)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, caseBitable: caseBitable)
    }
}


// * NSString Timer Value *
extension NSString: WisdomTimerFormatable {
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00:00:00'
    @objc public static func dotFormat(seconds: UInt)->String{
        return String.dotFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00-00-00'
    @objc public static func lineFormat(seconds: UInt)->String{
        return String.lineFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion format 'String'
    @objc public static func timeFormat(seconds: UInt, format: String)->String{
        return String.timeFormat(seconds: seconds, format: format)
    }
}


// * String Timer Value *
extension String: WisdomTimerFormatable {
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00:00:00'
    public static func dotFormat(seconds: UInt)->String{
        return WisdomProtocolCore.dotFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00-00-00'
    public static func lineFormat(seconds: UInt)->String{
        return WisdomProtocolCore.lineFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion format 'String'
    public static func timeFormat(seconds: UInt, format: String)->String{
        return WisdomProtocolCore.timeFormat(seconds: seconds, format: format)
    }
}


// * String Version Compare *
extension String {
    
    // MARK: version Compare Version, is high version
    // version: version String
    public func isHighVersion(version: String)->Bool?{
        return WisdomProtocolCore.versionisHighVersion(masterVersion: self, compareVersion: version)
    }
}


// * Create Bundle Value *
extension Bundle: WisdomBundleCoreable {
    
    // MARK: Create Bundle Param - AnyClass?, String, String, String, String?
    // projectName: Bundle Module Class Name
    // resource:    Bundle Name
    // ofType:      Bundle Type Name
    // filePath:    File Name
    // inDirectory: Framework Name
    @objc public static func able(projectClass: AnyClass?=nil, resource: String, ofType: String, fileName: String, inDirectory: String?=nil)->Bundle?{
        return WisdomProtocolCore.able(projectClass: projectClass, resource: resource, ofType: ofType, fileName: fileName, inDirectory: inDirectory)
    }
}


// * Load Image in Memory/Disk Cache *
extension UIImageView {
    
    // MARK: Load Image in Memory Cache / Disk Cache
    // imageName:        Image Name (historical save Memory/Disk Cache)
    // placeholderImage: Placeholder picture (Memory/Disk Cache no Image)
    @objc public func loadingImageable(imageName: String, placeholderImage: UIImage?=nil) {
        loadImageable(imageName: imageName, placeholderImage: placeholderImage)
    }
    
    // MARK: Load Image in Network / Memory Cache / Disk Cache
    // imageUrl:         Image Url (historical save Memory/Disk Cache, if not, network download)
    // placeholderImage: Placeholder picture (Memory/Disk Cache no Image)
    @objc public func loadingImageable(imageUrl: String, placeholderImage: UIImage?=nil) {
        loadImageable(imageUrl: imageUrl, placeholderImage: placeholderImage)
    }
    
    // MARK: Tracking save Image in Memory Cache / Disk Cache, Paired use
    // Tracking UIImage ‘@objc public func saveingable(imageName: String)’ method, update icon
    // 当有图片本地缓存, 调用 UIImage ‘@objc public func saveingable(imageName: String)’ 方法时，对跟踪图片控件，刷新图片
    @objc public func trackingImageable() {
        WisdomProtocolCore.trackImageable(imageView: self)
    }
    
    // MARK: Missing save Image in Memory Cache / Disk Cache, Paired use
    // Make UIImage ‘@objc public func trackingImageable()’ method Missing
    // 使对跟踪图片控件刷新失效，失效设置 UIImage ‘@objc public func saveingable(imageName: String)’ 方法
    @objc public func missingImageable() {
        WisdomProtocolCore.missImageable(imageView: self)
    }
}


// * Save/Load Image in Memory/Disk Cache *
extension UIImage {
    
    // MARK: Save Image in Memory Cache / Disk Cache
    // imageName: Image Name
    @objc public func saveingable(imageName: String) {
        WisdomProtocolCore.save(image: self, imageName: imageName)
    }
    
    // MARK: Load Image in Memory Cache / Disk Cache
    // imageName:    Image Name
    // imageClosure: (UIImage,String)->() (has UIImage)
    // emptyClosure: ()->()               (no UIImage)
    @objc public static func loadingable(imageName: String, imageClosure: @escaping (UIImage,String)->(), emptyClosure: @escaping ()->()){
        WisdomProtocolCore.load(imageName: imageName, imageClosure: imageClosure, emptyClosure: emptyClosure)
    }
}
