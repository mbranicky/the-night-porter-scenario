//
//  Task.swift
//  The Night Porter
//
//  Created by marek on 20/08/2019.
//  Copyright © 2019 Webby, s.r.o. All rights reserved.
//

import Foundation

enum TaskType {
    case daily, weekly, monthly
}

struct Task {
    var name: String
    var type: TaskType
    var comleted: Bool
    var lastCompleted: NSDate? // optional date field    
}
