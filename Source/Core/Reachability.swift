//
//  Reachability.swift
//  Pods
//
//  Created by tangjianfeng on 2023/5/9.
//

import Foundation

#if !(os(watchOS) || os(Linux) || os(Windows))

import SystemConfiguration


// -------------------------------- NetworkReachability -------------------------------- //
// * Monitor network status changes                                                      //
// * 'networkReachability(didChange currentState: WisdomNetworkReachabilityStatus)'      //
//   -> Network Reachability State Did Change                                            //
// ------------------------------------------------------------------------------------- //
@objc public protocol WisdomNetworkReachabilityable {
    
    // MARK: networkReachability 'WisdomNetworkReachabilityStatus' - didChange
    // * network reachability did change
    @objc func networkReachability(didChange currentState: WisdomNetworkReachabilityStatus)
}


extension WisdomNetworkReachabilityable {
    
    // MARK: self start 'WisdomNetworkReachabilityStatus' Listening. < No need to implement >
    public func startReachabilityListening(){
        WisdomProtocolCore.startReachabilityListening(able: self)
    }
    
    // MARK: self stop 'WisdomNetworkReachabilityStatus' Listening. < No need to implement >
    public func stopReachabilityListening(){
        WisdomProtocolCore.stopReachabilityListening(able: self)
    }
}


/// Defines the various states of network reachability.
@objc public enum WisdomNetworkReachabilityStatus: NSInteger {
    /// It is unknown whether the network is reachable.
    case unknown=0
    /// The network is not reachable.
    case notReachable
    /// 蜂窝网络
    case cellular
    /// 以太网/WiFi
    case ethernetOrWiFi
}

extension WisdomNetworkReachabilityStatus {
    
    // MARK: get 'current': WisdomNetworkReachabilityStatus
    public static var current: WisdomNetworkReachabilityStatus {
        return WisdomNetworkReachability.current
    }
    
    // MARK: Whether the network is available network: 'cellular / ethernetOrWiFi'
    public static var isCurrentReachable: Bool {
        return WisdomNetworkReachability.isCurrentReachable
    }
    
    // MARK: Whether the current network is a cellular network: 'cellular'
    public static var isCurrentOnCellular: Bool {
        return WisdomNetworkReachability.isCurrentOnCellular
    }
    
    // MARK: Whether the current network is Ethernet / WiFi network: 'ethernetOrWiFi'
    public static var isCurrentOnEthernetOrWiFi: Bool {
        return WisdomNetworkReachability.isCurrentOnEthernetOrWiFi
    }
}


/// The `WisdomNetworkReachability` class listens for reachability changes of hosts and addresses for both cellular and
/// WiFi network interfaces.
///
/// Reachability can be used to determine background information about why a network operation failed, or to retry
/// network requests when a connection is established. It should not be used to prevent a user from initiating a network
/// request, as it's possible that an initial request may be required to establish reachability.
class WisdomNetworkReachability {

    /// `DispatchQueue` on which reachability will update.
    private let reachabilityQueue = DispatchQueue(label: "org.wisdomProtocol.reachabilityQueue")
    
    private var listener: ((WisdomNetworkReachabilityStatus)->())?

    /// Flags of the current reachability type, if any.
    private var flags: SCNetworkReachabilityFlags? {
        var flags = SCNetworkReachabilityFlags()
        return (SCNetworkReachabilityGetFlags(reachability, &flags)) ? flags : nil
    }

    /// `SCNetworkReachability` instance providing notifications.
    private let reachability: SCNetworkReachability
    
    private(set) var currentNetworkReachabilityState: WisdomNetworkReachabilityStatus = .unknown

    // MARK: - Initialization
    /// Creates an instance that monitors the address 0.0.0.0.
    ///
    /// Reachability treats the 0.0.0.0 address as a special token that causes it to monitor the general routing
    /// status of the device, both IPv4 and IPv6.
    convenience init?() {
        var zero = sockaddr()
        zero.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zero.sa_family = sa_family_t(AF_INET)

        guard let reachability = SCNetworkReachabilityCreateWithAddress(nil, &zero) else { return nil }

        self.init(reachability: reachability)
    }

    private init(reachability: SCNetworkReachability) {
        self.reachability = reachability
    }

    deinit {
        stopListening()
        print("[WisdomNetworkReachability] \(self) deinit")
    }

    @discardableResult
    func startListening(onQueue queue: DispatchQueue = .main,
                        onUpdatePerforming listener: @escaping (WisdomNetworkReachabilityStatus)->()) -> Bool {
        self.listener = listener
        var context = SCNetworkReachabilityContext(version: 0,
                                                   info: Unmanaged.passUnretained(self).toOpaque(),
                                                   retain: nil,
                                                   release: nil,
                                                   copyDescription: nil)
        let callback: SCNetworkReachabilityCallBack = { _, flags, info in
            guard let info = info else {
                return
            }
            let instance = Unmanaged<WisdomNetworkReachability>.fromOpaque(info).takeUnretainedValue()
            instance.notifyListener(flags)
        }
        let queueAdded = SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue)
        let callbackAdded = SCNetworkReachabilitySetCallback(reachability, callback, &context)

        // Manually call listener to give initial state, since the framework may not.
        if let currentFlags = flags {
            notifyListener(currentFlags)
        }
        return callbackAdded && queueAdded
    }

    // MARK: - Stops listening for changes in network reachability status.
    func stopListening() {
        listener = nil
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
    }

    // MARK: - Internal - Listener Notification
    private func notifyListener(_ flags: SCNetworkReachabilityFlags) {
        guard flags.isActuallyReachable else {
            currentNetworkReachabilityState = .notReachable
            listener?(.notReachable)
            return
        }
        var networkState: WisdomNetworkReachabilityStatus = .ethernetOrWiFi
        if flags.isCellular { networkState = .cellular }
        currentNetworkReachabilityState = networkState
        listener?(networkState)
    }
}

extension WisdomNetworkReachability {
    
    static var current: WisdomNetworkReachabilityStatus {
        if WisdomProtocolCore.WisdomReachability != nil {
            return WisdomProtocolCore.WisdomReachability?.currentNetworkReachabilityState ?? .unknown
        }
        var zero = sockaddr()
        zero.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zero.sa_family = sa_family_t(AF_INET)
        
        if let reachability = SCNetworkReachabilityCreateWithAddress(nil, &zero) {
            var flags = SCNetworkReachabilityFlags()
            let get_flags = (SCNetworkReachabilityGetFlags(reachability, &flags)) ? flags : nil

            // Manually call listener to give initial state, since the framework may not.
            if let currentFlags = get_flags {
                guard currentFlags.isActuallyReachable else {
                    return .notReachable
                }
                var networkStatus: WisdomNetworkReachabilityStatus = .ethernetOrWiFi
                if flags.isCellular { networkStatus = .cellular }
                return networkStatus
            }
        }
        return .unknown
    }
    
    static var isCurrentReachable: Bool{
        let current = WisdomNetworkReachability.current
        if current == .ethernetOrWiFi || current == .cellular {
            return true
        }
        return false
    }
    
    static var isCurrentOnCellular: Bool {
        if WisdomNetworkReachability.current == .cellular {
            return true
        }
        return false
    }
    
    static var isCurrentOnEthernetOrWiFi: Bool {
        if WisdomNetworkReachability.current == .ethernetOrWiFi {
            return true
        }
        return false
    }
}


fileprivate extension SCNetworkReachabilityFlags {
    var isReachable: Bool { contains(.reachable) }
    var isConnectionRequired: Bool { contains(.connectionRequired) }
    var canConnectAutomatically: Bool { contains(.connectionOnDemand) || contains(.connectionOnTraffic) }
    var canConnectWithoutUserInteraction: Bool { canConnectAutomatically && !contains(.interventionRequired) }
    var isActuallyReachable: Bool { isReachable && (!isConnectionRequired || canConnectWithoutUserInteraction) }
    var isCellular: Bool {
        #if os(iOS) || os(tvOS)
        return contains(.isWWAN)
        #else
        return false
        #endif
    }

    /// Human readable `String` for all states, to help with debugging.
    var readableDescription: String {
        let W = isCellular ? "W" : "-"
        let R = isReachable ? "R" : "-"
        let c = isConnectionRequired ? "c" : "-"
        let t = contains(.transientConnection) ? "t" : "-"
        let i = contains(.interventionRequired) ? "i" : "-"
        let C = contains(.connectionOnTraffic) ? "C" : "-"
        let D = contains(.connectionOnDemand) ? "D" : "-"
        let l = contains(.isLocalAddress) ? "l" : "-"
        let d = contains(.isDirect) ? "d" : "-"
        let a = contains(.connectionAutomatic) ? "a" : "-"

        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)\(a)"
    }
}
#endif
