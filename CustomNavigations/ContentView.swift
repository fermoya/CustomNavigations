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
    @State var isPresented = false
    @State var isMenuHidden = true
    
    var body: some View {
        FullScreenLink(isPresented: self.$isPresented,
                       destination: {
                        NavigationView {
                            ZStack {
                                Rectangle()
                                    .fill(Color.yellow)
                                VStack {
                                    Text("I've been presented")
                                    NavigationLink(destination: Text("Pushed")) {
                                        Text("Tap to push")
                                    }
                                }
                            }
                            .navigationBarItems(leading: self.isPresented ? AnyView(self.closeButton) : AnyView(EmptyView()))
                            .navigationBarTitle("Full screen", displayMode: .inline)
                        }
        }, content: {
            NavigationView {
                MenuView(indexSelected: self.$index,
                         isMenuHidden: self.$isMenuHidden,
                         menuItems: menuItems,
                         menuItemRow: { item in
                            if item.kind == .text {
                                Text("\(item.name)")
                            } else {
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("\(item.name) looks different")
                                }
                            }
                }) { section in
                    self.page(at: section)
                }
                .navigationBarItems(leading: self.menuButton)
                .navigationBarTitle(Text("Menu"), displayMode: .inline)
            }
        })
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
    
    func page(at section: Int) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
