//
//  AppDelegate.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        var navVC = UINavigationController()
        
        // MARK: WisdomRouterControlable 路由 -> 控制器
        let vcClass = WisdomProtocol.getRouterControlable(from: WisdomProtocolRootProtocol.self)
        if let rootVC = vcClass?.routerControlable?(rootVC: nil, param: nil) {
            navVC = UINavigationController(rootViewController: rootVC)
        }
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

