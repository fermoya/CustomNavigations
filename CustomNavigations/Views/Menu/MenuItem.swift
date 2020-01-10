//
//  MenuItem.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 16/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

struct MenuItem: Identifiable, Equatable {
    
    enum Kind {
        case text
        case image
    }
    
    var id: String { return name }
    var name: String
    var kind: Kind
}

let menuItems: [MenuItem] = [
    MenuItem(name: "Setion 1", kind: .text),
    MenuItem(name: "Setion 2", kind: .text),
    MenuItem(name: "Setion 3", kind: .image),
    MenuItem(name: "Setion 4", kind: .text),
    MenuItem(name: "Setion 5", kind: .image),
    MenuItem(name: "Setion 6", kind: .text)
]
