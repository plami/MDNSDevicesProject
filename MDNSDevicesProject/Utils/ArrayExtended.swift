//
//  ArrayExtended.swift
//  MDNSDevicesProject
//
//  Created by Plamena Nikolova on 1.12.19.
//  Copyright © 2019 plamena. All rights reserved.
//

import Foundation

extension Array {
    func index<T>(with type: T.Type) -> Index? {
        return firstIndex { $0 is T }
    }
    
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
}
