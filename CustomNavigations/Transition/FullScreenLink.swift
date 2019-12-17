//
//  FullScreenLink.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 16/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct FullScreenLink<Content, Destionation>: View where Content: View, Destionation: View {
    
    private var toggleButtonSize = CGSize(width: 50, height: 50)
    
    @Binding var isPresented: Bool
    var content: () -> Content
    var destination: () -> Destionation
        
    init(isPresented: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destionation, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.destination = destination
        self._isPresented = isPresented
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                self.content()
                if self.isPresented {
                    self.destination()
                        .background(Color.yellow)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

//struct FullScreenLink_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenLink()
//    }
//}
