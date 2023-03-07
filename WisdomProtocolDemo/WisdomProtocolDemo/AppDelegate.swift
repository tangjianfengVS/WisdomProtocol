//
//  AppDelegate.swift
//  WisdomProtocolDemo
//
//  Created by 汤建锋 on 2022/11/22.
//

import UIKit
import WisdomProtocol

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        var navVC = UINavigationController()
        
        // MARK: WisdomRouterControlable 路由 -> 控制器
        let vcClass = WisdomProtocol.getRouterControlable(from: RootProtocol.self)
        if let rootVC = vcClass?.routerControlable?(rootVC: nil, param: nil) {
            navVC = UINavigationController(rootViewController: rootVC)
        }
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        
        let list = RCProductFuncModel.decodable(list: [["tag": "start", "name": "启动", "id": "1622428828402884610", "type": "String"],
                                                       ["tag": "close", "name": "关闭", "id": "1622428895281061890", "type": "Bool"],
                                                       ["tag": "fortification", "name": "设防", "id": "1622429012155342850", "type": "String"],
                                                       ["tag": "disarm", "name": "解防", "id": "1622429116534792193", "type": "String"],
                                                       ["type": "String", "tag": "carSearch", "name": "寻车", "id": "1622429271522713601"],
                                                       ["type": "String", "tag": "cushionLock", "name": "坐垫锁", "id": "1622429426120564737"],
                                                       ["type": "String", "tag": "physicalExamination", "name": "体检", "id": "1622429669012709378"],
                                                       ["type": "String", "tag": "NFC", "name": "近场通信", "id": "1622429868401532929"],
                                                       ["type": "String", "tag": "senselessUnlocking", "name": "无感解锁", "id": "1622430030825955329"],
                                                       ["type": "String", "tag": "antiTheftSensitivity", "name": "防盗器灵敏度", "id": "1622430192763838465"],
                                                       ["type": "String", "tag": "muteArming", "name": "静音设防", "id": "1622430348489957377"],
                                                       ["type": "String", "tag": "sensingDistance", "name": "感应距离", "id": "1622430481805910018"]])
        let jsons = list.ableJsons()
        return true
    }

}

extension AppDelegate: WisdomCrashingable {
    
    func catchCrashing(crash: String) {
        print("[WisdomCrashable] catchCrashable\n"+crash)
    }
}

extension AppDelegate: WisdomTrackingable {
    
    func catchTracking(viewDidAppear controller: UIViewController.Type, title: String) {
        print("[WisdomProtocol] catchTracking viewDidAppear: \(controller)"+" title: "+title)
    }
    
    func catchTracking(viewDidDisappear controller: UIViewController.Type, appearTime: NSInteger, title: String) {
        print("[WisdomProtocol] catchTracking viewDidDisappear: \(controller)"+" appearTime: \(appearTime)"+" title: "+title)
    }
}

extension AppDelegate: WisdomRegisterLanguageable {
    
    func registerLanguageKey()->String? {
        return "registerLanguageKey"
    }
    
    func registerLanguage(language: WisdomLanguageStatus)->Bundle {
        let bundlePath = (Bundle.main.path(forResource: "WisdomProtocol", ofType: "bundle") ?? "")
        var path = bundlePath+"/Lan/"+language.file_lproj
        var bundle: Bundle?
        switch language {
        case .system:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.zh_Hans.file_lproj
            bundle = Bundle.init(path: path)
        case .en:
            bundle = Bundle.able(projectClass: classForCoder,
                                 resource: "WisdomProtocol",
                                 ofType: "bundle",
                                 fileName: "Lan/"+WisdomLanguageStatus.en.file_lproj)
        case .zh_Hans:
            bundle = Bundle.able(projectClass: classForCoder,
                                 resource: "WisdomProtocol",
                                 ofType: "bundle",
                                 fileName: "Lan/"+WisdomLanguageStatus.zh_Hans.file_lproj)
        case .zh_Hant:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.zh_Hans.file_lproj
            bundle = Bundle.init(path: path)
        case .zh_Hant_HK:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.zh_Hans.file_lproj
            bundle = Bundle.init(path: path)
        case .zh_Hant_TW:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.zh_Hans.file_lproj
            bundle = Bundle.init(path: path)
        case .fr:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .de:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .it:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .ja:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .ko:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .pt_PT:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .ru:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .es:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .nl:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .th:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .ar:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        case .uk:
            path = bundlePath+"/Lan/"+WisdomLanguageStatus.en.file_lproj
            bundle = Bundle.init(path: path)
        }
        return bundle ?? Bundle.main
    }
    
    func registerLanguageUpdate(language: WisdomLanguageStatus) {
        var navVC = UINavigationController()
        
        // MARK: WisdomRouterControlable 路由 -> 控制器
        let vcClass = WisdomProtocol.getRouterControlable(from: RootProtocol.self)
        if let rootVC = vcClass?.routerControlable?(rootVC: nil, param: nil) {
            navVC = UINavigationController(rootViewController: rootVC)
        }
        self.window?.rootViewController = navVC
    }
}



enum RCProductFuncStauts: String, Codable, WisdomCodingable {
    case start = "start"
    case close = "close"
    case openDoor = "openDoor"
    case lockDoor = "lockDoor"
    case fortification = "fortification" // 设防
    case disarm = "disarm" // 解防
    case carSearch = "carSearch"
    case cushionLock = "cushionLock" // 坐垫锁
    
    case totalMileage = "totalMileage" // 总里程
    case farthestDistance = "farthestDistance" // 续航里程
    case physicalExamination = "physicalExamination" // 体检
    
    case NFC = "NFC" // 近场通信
    case HIDBind = "HIDBind" // 本机绑定
    case senselessUnlocking = "senselessUnlocking" // 无感解锁
    case sensingDistance = "sensingDistance" // 感应距离
    
    case antiTheftSensitivity = "antiTheftSensitivity" // 防盗器灵敏度
    case muteArming = "muteArming"
    case automaticLight = "automaticLight" // 自动开启大灯

    case batteryTemperature = "batteryTemperature" // 电池温度
    case currentVoltage = "currentVoltage" // 当前电压
    case batteryLevel = "batteryLevel" // 电池电量
}

struct RCProductFuncModel: Codable, WisdomCodingable {
    
    private(set) var tag: RCProductFuncStauts?
    
    private(set) var name: String?
}
