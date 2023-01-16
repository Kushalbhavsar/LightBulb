//
//  Manager.swift
//  LightBulb
//
//  Created by Kush on 15/01/23.
//

import SwiftUI

class BulbControl: ObservableObject {
        
    @Published var angle: Angle = .zero
    @Published var length: Double = 80
    @Published var bulbState: State = .on
    @Published var showBulbColorPicker: Bool = false
    @AppStorage("bulbColor") var bulbColor: Color = .yellow
    
    
    func handleDragLocationChanged(to value: DragGesture.Value) {
        // calculating the angle of rotation from the anchored point using Pendulum theoram.
        let dx = value.location.x - value.startLocation.x
        let dy = value.location.y + value.startLocation.y
        let angle = atan(dx/dy)
        let degrees = -(angle * 180 / .pi)
        
        // clamp the angle to the desired range; (-90 to 90 degrees) in our case.
        DispatchQueue.main.async {
            self.length = value.location.y
            self.angle = Angle(degrees: min(90, max(-90, degrees)))
        }
    }
    
    func handleDragGestureEnds() {
        // reset the angle of rotation and cord length when the drag gesture ends
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.35, blendDuration: 0.8 )) {
                self.angle = .zero
                self.length = 80
            }
        }
    }
    
    func handleBulbOnOffState() {
        withAnimation(.easeOut(duration: 0.3)) {
            self.bulbState.toggle()
        }
    }
}


enum State {
    case on, off
    
    mutating func toggle() {
        switch self {
            case .on:
                self = .off
            case .off:
                self = .on
        }
    }
}


