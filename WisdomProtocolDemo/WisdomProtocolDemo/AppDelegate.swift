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
