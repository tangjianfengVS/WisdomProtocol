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
