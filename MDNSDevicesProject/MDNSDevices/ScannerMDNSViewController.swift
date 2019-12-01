//
//  ViewController.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 29.11.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScannerMDNSViewController: UIViewController {
    
    @IBOutlet private weak var serviceTextField: UITextField!
    @IBOutlet private weak var transportLayerTextField: UITextField!
    @IBOutlet private weak var domainTextField: UITextField!
    @IBOutlet private weak var allBonjourButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var mdnsDataSource: DataSourceAdapter!
    private let minimalDomainLength = 5
    private let disposeBag = DisposeBag()
    
    // MARK: Clean Swift properties
    
    var interactor: MDNSBusinessLogic!
    var router: MDNSRouterLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Setup
    
    func configure() {
        MDNSConfigurator.shared.config(viewController: self)
    }
    
    private func setUpButtons() {
        allBonjourButton.setTitle("All Bonjour Services", for: .normal)
        allBonjourButton.backgroundColor = UIColor.red
        allBonjourButton.setTitleColor(UIColor.white, for: .normal)
        allBonjourButton.layer.cornerRadius = 5
        
        //Enable/Disable allBonjourButton
        let domainValidation = domainTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalDomainLength }
            .share(replay: 1)

         domainValidation
            .bind(to: allBonjourButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @IBAction func allBonjourPressed(_ sender: UIButton) {
        setBrowserObj()
    }

    private func setBrowserObj() {
        let sName = (self.serviceTextField?.text ?? "")
        let tl = (self.transportLayerTextField?.text ?? "")

        let text = (self.domainTextField?.text ?? "")
        let domain = (text == "" ? text: "\(text).")
        print("\(sName).\(tl).", domain)
        
         interactor.getBrowserObject(serviceName: "_\(sName)", transportLayer: "_\(tl)", domain: "\(domain)")
    }
}

private extension ScannerMDNSViewController {
    
    func setUpTableView() {
        mdnsDataSource = DataSourceAdapter(cellReuseIdentifier: "MDNSTableViewCell")
        
        mdnsDataSource.delegate = self
        
        tableView.dataSource = mdnsDataSource
        tableView.delegate = mdnsDataSource
    }
}

extension ScannerMDNSViewController: MDNSDisplayLogic, DataSourceAdapterDelegate {
    
    func populateMDNS(mdns: [NetService]) {
        self.mdnsDataSource.injectData(mdnsList: mdns)
        self.mdnsDataSource.setItems(numberOfItemsInSection: (mdns.count))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayMDNS(mdns: [NetService]) {
        print(mdns)
        populateMDNS(mdns: mdns)
    }
    
    func displayMDNSFailure(error: String) {
        self.showAlert(withTitle: "", message: "An error appeared while searching!", buttonTitle: "OK", preferredStyle: .alert, completion: nil)
    }
}

// MARK: - Clean Swift Protocols

protocol MDNSDisplayLogic: class {
    func displayMDNS(mdns: [NetService])
    func displayMDNSFailure(error: String)
}
