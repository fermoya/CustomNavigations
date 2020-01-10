//
//  FullScreenLink.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 16/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

protocol TransitionLinkType {
    var transition: AnyTransition { get }
}

struct TransitionLink<Content, Destination>: View where Content: View, Destination: View {
    
    private var toggleButtonSize = CGSize(width: 50, height: 50)
    
    @Binding var isPresented: Bool
    var content: () -> Content
    var destination: () -> Destination
    var linkType: TransitionLinkType
        
    init(isPresented: Binding<Bool>, linkType: TransitionLinkType, @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.destination = destination
        self._isPresented = isPresented
        self.linkType = linkType
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if self.isPresented {
                    self.destination()
                        .transition(self.linkType.transition)
                } else {
                    self.content()
                }
            }
        }
    }
}

struct ModaLinkViewModifier<Destination>: ViewModifier where Destination: View {

    @Binding var isPresented: Bool
    var linkType: TransitionLinkType
    var destination: () -> Destination

    func body(content: Self.Content) -> some View {
        TransitionLink(isPresented: self.$isPresented,
                       linkType: linkType,
                       destination: {
                        self.destination()
        }, content: {
            content
        })
    }

}

extension View {

    func modalLink<Destination: View>(isPresented: Binding<Bool>,
                                      linkType: TransitionLinkType,
                                      destination: @escaping () -> Destination) -> some View {
        self.modifier(ModaLinkViewModifier(isPresented: isPresented,
                                           linkType: linkType,
                                           destination: destination))
    }

}

//struct FullScreenLink_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenLink()
//    }
//}
