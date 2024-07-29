//
//  NetworkMonitorManager.swift
//  mood-folio
//
//  Created by junehee on 7/29/24.
//

import Foundation
import Network

final class NetworkMonitorManager {
    
    private init() { }
    static let shared = NetworkMonitorManager()
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private let monitor = NWPathMonitor()
    
    var isConnected = false
    var connectionType: ConnectionType = .unknown
    
    func startMonitoring() {
        monitor.start(queue: .global())
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.getConnectionType(path)
            if path.status == .satisfied {
                // 인터넷 연결 OK
                print("Network OK")
                self?.isConnected = true
            } else {
                // 인터넷 연결 Fail
                print("Network FAIL")
                self?.isConnected = false
            }
        }
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("Connect To WiFi")

        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("Connect To Cellular")

        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("Connect To WiFi WiredEthernet")

        } else {
            connectionType = .unknown
            print("Unknown Network")
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
}
