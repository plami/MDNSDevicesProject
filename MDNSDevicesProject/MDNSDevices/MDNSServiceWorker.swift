//
//  MDNSServiceWorker.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 30.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(String)
}

typealias OnSuccessCompletionHandlerService = (Result<[NetService]>) -> ()
typealias OnErrorHandler = (Result<String>) -> ()

class MDNSServiceWorker: NSObject, NetServiceBrowserDelegate, NetServiceDelegate  {
    
    var browser: NetServiceBrowser
    var services: [NetService]
    var connectedService: NetService?
    var connected: Bool
    
    override init() {
        browser = NetServiceBrowser()
        services = []
        connected = false
    }
    
    // Make a singleton
    class var sharedInstance : MDNSServiceWorker {
    struct Static {
        static var instance : MDNSServiceWorker? = nil
        }
        Static.instance = MDNSServiceWorker()
        return Static.instance!
    }
    
    func startDiscovery(withType: String, withDomain: String) {
        browser.delegate = self
        browser.searchForServices(ofType: withType, inDomain: withDomain)
    }
    
    func stopDiscovery() {
        browser.stop()
    }
    
    // NSNetService
    func connectToService(aService: NetService!) {
        if (connected) {
            self.disconnect()
        }

        aService.delegate = self
        aService.resolve(withTimeout: 30)
        
    }
    
    func disconnect() {
        connectedService = nil
        connected = false
    }
    
    func didFindService(completionHandler: @escaping OnSuccessCompletionHandlerService) {
        completionHandler(.success(services))
    }
    
    // NSNetServiceBrowser delegate
    func netServiceBrowser(aNetServiceBrowser: NetServiceBrowser!, didFindService aNetService: NetService!, moreComing: Bool) {
        services.append(aNetService)
    }
    
    func netServiceBrowser(aNetServiceBrowser: NetServiceBrowser!, didRemoveService aNetService: NetService!, moreComing: Bool) {
        
        if aNetService == connectedService {
            self.disconnect()
        }
        
        if let index = services.firstIndex(of: aNetService) {
            services.removeObject(obj: index)
        }
    }
    
    // NSNetServiceDelegate
    func netServiceDidResolveAddress(netservice: NetService!) {
        print("Resolved service \(netservice.description)")
    }
    
    func netService(netservice: NetService!,
        didNotResolve errorDict: [NSObject : AnyObject]!) {
        print("Failed to resolve service")
    }
}
