//
//  Item.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
