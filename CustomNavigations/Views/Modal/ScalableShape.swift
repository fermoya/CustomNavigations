//
//  ScalableShape.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 30/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

protocol ScalableShape: Shape {
    init(animatableData: CGFloat)
    var animatableData: CGFloat { get }
}

struct ScalableCircle: ScalableShape {
    var animatableData: CGFloat = 1

    func path(in rect: CGRect) -> Path {
        let hypotenuse = sqrt(rect.width * rect.width + rect.height * rect.height)
        let radius = hypotenuse * animatableData
        let center = CGPoint(x: rect.midX,
                             y: rect.midY)

        var path = Path()
        path.addArc(center: center,
                    radius: radius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360),
                    clockwise: false)

        return path
    }
}

struct ClipShapeModifier<T: ScalableShape>: ViewModifier {
    let shape: T

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

extension AnyTransition {
    static func reveal<T: ScalableShape> (shape: T.Type) -> AnyTransition {
        .modifier(
            active: ClipShapeModifier(shape: T(animatableData: 0)),
            identity: ClipShapeModifier(shape: T(animatableData: 1))
        )
    }
}
