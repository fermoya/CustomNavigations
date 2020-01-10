//
//  MenuRow.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 10/01/2020.
//  Copyright © 2020 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct MenuRow: View {

    var item: MenuItem

    var body: some View {
        Group {
            if item.kind == .text {
                Text("\(item.name)")
            } else {
                HStack {
                    Image(systemName: "star.fill")
                    Text("\(item.name) looks different")
                }
            }
        }
    }
}
