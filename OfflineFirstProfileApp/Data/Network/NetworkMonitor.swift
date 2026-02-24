//
//  NetworkMonitor.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 24/02/26.
//

import Foundation
import Network
import Combine

final class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    let statusPublisher = PassthroughSubject<Bool, Never>()
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.statusPublisher.send(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}
