//
//  Cardify.swift
//  Memorize
//
//  Created by Kirill Pukhov on 25.06.21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotationDegree: Double
    var animatableData: Double {
        get { rotationDegree }
        set { rotationDegree = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if rotationDegree > 90 {
                RoundedRectangle(cornerRadius: CardifyConstants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: CardifyConstants.cornerRadius)
                    .strokeBorder(lineWidth: CardifyConstants.borderWidth)
            } else {
                RoundedRectangle(cornerRadius: CardifyConstants.cornerRadius)
            }
            content
                .opacity(rotationDegree > 90 ? 1 : 0)
        }
        .rotation3DEffect(.degrees(rotationDegree), axis: (0, 1, 0))
    }
    
    struct CardifyConstants {
        static let cornerRadius: CGFloat = 10.0
        static let borderWidth: CGFloat = 3.0
    }
    
    init(_ isFaceUp: Bool) {
        rotationDegree = isFaceUp ? 180 : 0
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp))
    }
}
