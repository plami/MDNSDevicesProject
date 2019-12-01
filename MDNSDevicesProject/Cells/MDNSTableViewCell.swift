//
//  MDNSTableViewCell.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 1.12.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import UIKit

protocol MDNSConfigurable {
    func configure(with mdns: NetService)
}

class MDNSTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MDNSTableViewCell: MDNSConfigurable {
    func configure(with mdns: NetService) {
        self.textLabel?.text = mdns.hostName
        self.detailTextLabel?.text = mdns.domain
    }
}
