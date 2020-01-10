//
//  DestinationView.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 10/01/2020.
//  Copyright © 2020 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct DestinationView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightYellow)
            VStack(alignment: .leading) {
                HStack {
                    Text("I've been presented")
                    Spacer()
                }
                NavigationLink(destination: Text("Pushed")) {
                    Text("Tap to push")
                }
            }
            .padding(.horizontal)
        }
    }

}
