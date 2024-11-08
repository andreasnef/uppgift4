//
//  Item.swift
//  ModernaSwiftUppgift4
//
//  Created by Andreas Nef on 07.11.2024.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var created: Date = Date.now
    var desc: String
    var isCompleted: Bool = false
    
    init(desc: String) {
        self.desc = desc
    }
}
