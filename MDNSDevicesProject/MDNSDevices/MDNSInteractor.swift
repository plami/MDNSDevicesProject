//
//  MDNSInteractor.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 30.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class MDNSInteractor: MDNSBusinessLogic {
    
    private let presenter: MDNSPresentationLogic!
    private var worker: MDNSServiceWorker?
    
    private var browserObject: MDNSServiceModel?
    private var serviceBrowser = NetServiceBrowser()
    private let searchForAllString = "_services._dns-sd._udp."
    
    var services = [NetService]()
    
    init(output: MDNSPresentationLogic) {
        presenter = output
    }
    
    func fetchMDNS(success: Bool) {
        guard !success else {
            
            worker = MDNSServiceWorker()
            guard let domainString = browserObject?.domain else {
                return
            }
            worker?.startDiscovery(withType: searchForAllString, withDomain: domainString)
            
            if !(worker?.services.isEmpty)! {
                worker?.didFindService(completionHandler: { [weak self] servicesResult in
                    switch servicesResult {
                    case .success(let services):
                        self?.presenter.presentMDNSDevices(mdns: services)
                    case .failure(let error):
                        self?.presenter.presentError(error: error as String)
                    }
                })
            } else {
                self.presenter.presentError(error: "Error")
            }
            return
        }
    }
    
    func getBrowserObject(serviceName: String, transportLayer: String, domain: String) {
        
        browserObject = MDNSServiceModel(serviceName: serviceName, transportLayer: transportLayer, domain: domain)
        
        guard browserObject != nil else {
            fetchMDNS(success: false)
            return
        }
        fetchMDNS(success: true)
    }
}


// MARK: - Clean Swift Protocols

protocol MDNSBusinessLogic {
    func fetchMDNS(success: Bool)
    func getBrowserObject(serviceName: String, transportLayer: String, domain: String)
}
