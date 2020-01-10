//
//  ModalTransitions.swift
//  CustomNavigations
//
//  Created by Fernando Moya de Rivas on 10/01/2020.
//  Copyright © 2020 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

enum ModalTransition: TransitionLinkType {
    case circleReveal
    case fullScreenModal

    var transition: AnyTransition {
        switch self {
        case .circleReveal:
            return .reveal(shape: ScalableCircle.self)
        case .fullScreenModal:
            return .move(edge: .bottom)
        }
    }
}
