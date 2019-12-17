//
//  MenuView.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 16/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct MenuView<Item, Row, Content>: View where Item: Identifiable & Equatable, Row: View, Content: View {
    
    @Binding private var isMenuHidden: Bool
    @State private var draggingOffset: CGFloat = 0
    
    @Binding var indexSelected: Int
    var menuItems: [Item]
    var menuItemRow: (Item) -> Row
    var menuItemContent: (Int) -> Content
    var revealRatio: CGFloat
    
    init(indexSelected: Binding<Int>, isMenuHidden: Binding<Bool>, menuItems: [Item], revealRatio: CGFloat = 0.8, @ViewBuilder menuItemRow: @escaping (Item) -> Row, @ViewBuilder menuItemContent: @escaping (Int) -> Content) {
        self._indexSelected = indexSelected
        self._isMenuHidden = isMenuHidden
        self.menuItems = menuItems
        self.revealRatio = revealRatio
        self.menuItemRow = menuItemRow
        self.menuItemContent = menuItemContent
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                self.contentView
                    .onTapGesture (perform: {
                        withAnimation {
                            self.isMenuHidden = true
                        }
                    })
                self.revealList
                    .frame(width: self.revealListSize(proxy).width)
                    .offset(x: self.revealListOffset(proxy).x,
                            y: 0)
            }.gesture(DragGesture()
                .onChanged({ value in
                    withAnimation {
                        self.draggingOffset = self.isMenuHidden ? max(0, min(self.revealListSize(proxy).width, value.translation.width)) : min(0, max(-self.revealListSize(proxy).width, value.translation.width))
                    }
                }).onEnded({ _ in
                    withAnimation {
                        if abs(self.draggingOffset) > self.revealListSize(proxy).width / 2 {
                            self.isMenuHidden.toggle()
                        }
                        self.draggingOffset = 0
                    }
                }))
        }
    }
}

extension MenuView {
    
    private func revealListOffset(_ proxy: GeometryProxy) -> CGPoint {
        let hiddenOffset = -proxy.size.width * ((1 - revealRatio) * 0.5 + revealRatio) + draggingOffset
        return CGPoint(x: self.isMenuHidden ? hiddenOffset : hiddenOffset + revealListSize(proxy).width,
                       y: 0)
    }
    
    private func revealListSize(_ proxy: GeometryProxy) -> CGSize {
        CGSize(width: revealRatio * proxy.size.width,
               height: proxy.size.height)
    }
}

extension MenuView {
    
    private var contentView: some View {
        menuItemContent(indexSelected)
    }
    
    private var revealList: some View {
        List {
            ForEach(menuItems) { item in
                self.menuItemRow(item)
                    .onTapGesture (perform: {
                        withAnimation {
                            self.isMenuHidden = true
                            self.indexSelected = self.menuItems.firstIndex(of: item)!
                        }
                    })
            }
        }
    }
    
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
