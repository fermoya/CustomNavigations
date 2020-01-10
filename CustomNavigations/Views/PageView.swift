//
//  PushedView.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 10/01/2020.
//  Copyright © 2020 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct PageView: View {

    var section: Int
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lightGray)
            VStack {
                Spacer()
                Text("You're on section \(section + 1)")
                    .font(.system(size: 23))
                    .bold()
                Spacer()
                HStack {
                    Spacer()
                    Text("Swipe right to open menu. Tap anywhere to close.")
                    Spacer()
                }
                Spacer()
                NavigationLink(destination: Text("pushed"), label: {
                    Text("Tap to push")
                })
                Spacer()
                Button(action: {
                    withAnimation {
                        self.isPresented.toggle()
                    }
                }) {
                    Text("Tap me to present full screen modal")
                }
                Spacer()
            }
        }
    }
}
