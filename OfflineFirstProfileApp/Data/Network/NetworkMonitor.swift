//
//  NetworkMonitor.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 24/02/26.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject {

    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")

    @Published private(set) var isOnline: Bool = false

    private init() {}
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isOnline = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}
