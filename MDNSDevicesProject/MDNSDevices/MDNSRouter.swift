//
//  MDNSRouter.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 30.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class MDNSRouter: MDNSRouterLogic {
    
    private(set) weak var controller: MDNSDisplayLogic?
    
    init(viewController: MDNSDisplayLogic) {
        controller = viewController
    }
}

// MARK: - Clean Swift Protocols

protocol MDNSRouterLogic {
    
}
