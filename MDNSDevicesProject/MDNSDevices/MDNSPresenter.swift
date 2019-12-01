//
//  MDNSPresenter.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 30.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class MDNSPresenter: MDNSPresentationLogic {
    
    private(set) weak var controller: MDNSDisplayLogic?
    
    init(output: MDNSDisplayLogic) {
        controller = output
    }
    
    func presentMDNSDevices(mdns: [NetService]) {
        controller?.displayMDNS(mdns: mdns)
    }
    
    func presentError(error: String) {
        controller?.displayMDNSFailure(error: error)
    }
}

// MARK: - Clean Swift Protocols

protocol MDNSPresentationLogic {
    
    func presentMDNSDevices(mdns: [NetService])
    func presentError(error: String)
}
