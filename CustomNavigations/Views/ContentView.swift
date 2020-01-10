//
//  ContentView.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 16/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var index = 0
    @State var isMenuHidden = true
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            MenuView(indexSelected: self.$index,
                     isMenuHidden: self.$isMenuHidden,
                     menuItems: menuItems,
                     menuItemRow: { MenuRow(item: $0) },
                     menuItemContent: { section in
                        PageView(section: section, isPresented: self.$isPresented)
                            .navigationBarItems(leading: self.menuButton)
                            .navigationBarTitle(Text("Section \(section + 1)"), displayMode: .inline)
                            .modalLink(isPresented: self.$isPresented,
                                       linkType: section % 2 == 0 ? ModalTransition.circleReveal : ModalTransition.fullScreenModal,
                                       destination: {
                                        DestinationView()
                                            .navigationBarItems(leading: self.closeButton)
                                            .navigationBarTitle(section % 2 == 1 ? "Full screen" : "Reveal screen", displayMode: .inline)
                    })
            })
        }
    }
}

extension ContentView {

    private var closeButton: some View {
        Button(action: {
            withAnimation {
                self.isPresented.toggle()
            }
        }) {
            Image(systemName: "xmark")
                .padding(8)
        }
    }
    
    var menuButton: some View {
        Button(action: {
            withAnimation {
                self.isMenuHidden.toggle()
            }
        }) {
            Image(systemName: self.isMenuHidden ? "list.bullet" : "xmark" )
        }
    }
    
}
