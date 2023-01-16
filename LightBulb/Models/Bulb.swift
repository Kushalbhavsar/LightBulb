//
//  LampView.swift
//  LightBulb
//
//  Created by Kush on 14/01/23.
//

import SwiftUI

struct Bulb {
    
    // - Properties -
    @ObservedObject var control: BulbControl

    // - Bulb Cord -
    var cord: some View {
        Color.gray
            .frame(width: max(min(300 / control.length, 5), 0.8), height: max(80, min(UIScreen.main.bounds.height * 0.6, control.length)))
    }

    // - Bulb Shape -
    var bulb: some View {
        Image("bulb")
            .renderingMode(control.bulbState == .on ? .template : .original)
            .resizable()
            .foregroundColor(control.bulbColor)
            .frame(width: 45, height: 45)
            .offset(y: -5)
    }

    // - Bulb Gradient Shade -
    @ViewBuilder
    var bulbShade: some View {
        if control.bulbState == .on {
            RadialGradient(
                gradient: Gradient(colors:
                                    [control.bulbColor.opacity(0.9),
                                     control.bulbColor.opacity(0.7),
                                     control.bulbColor.opacity(0.5),
                                     control.bulbColor.opacity(0.3),
                                     control.bulbColor.opacity(0.1),
                                     control.bulbColor.opacity(0.1),
                                    .clear]),
                        center: .center,
                        startRadius: 20,
                        endRadius: 250
                    )
            .frame(width: 350, height: 350)
            .mask(Circle())
                .clipped()
                .blendMode(.color)
        }
    }
}
