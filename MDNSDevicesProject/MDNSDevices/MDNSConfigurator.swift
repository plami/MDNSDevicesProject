//
//  MDNSConfigurator.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 30.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

class MDNSConfigurator {
    
    // MARK: - Singleton
    
    static var shared = MDNSConfigurator()
    private init() { }
    
    func config(viewController: ScannerMDNSViewController) {
        let presenter = MDNSPresenter(output: viewController)
        let router = MDNSRouter(viewController: viewController)
        let interactor = MDNSInteractor(output: presenter)
        viewController.interactor = interactor
        viewController.router = router
    }
}
