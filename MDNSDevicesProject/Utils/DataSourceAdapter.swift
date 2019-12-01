//
//  DataSourceAdapter.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 1.12.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

class DataSourceAdapter: NSObject, UITableViewDataSource {
    
    private var itemsInSection : Int = 0
    private let reuseIdentifier: String
    private var mdnsList = [NetService]()
    
    weak var delegate: DataSourceAdapterDelegate?
    
    init(cellReuseIdentifier: String) {
        self.reuseIdentifier = cellReuseIdentifier
    }
    
    func setItems(numberOfItemsInSection: Int){
        self.itemsInSection = numberOfItemsInSection
    }
    
    func injectData(mdnsList: [NetService]){
        self.mdnsList = mdnsList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MDNSTableViewCell else { fatalError("ArticleTableViewCell is not found") }
        cell.configure(with: self.mdnsList[indexPath.row])
        return cell
    }
}

extension DataSourceAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

protocol DataSourceAdapterDelegate: class {
    func populateMDNS(mdns: [NetService])
}
