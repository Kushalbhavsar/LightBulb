//
//  ContentView.swift
//  LightBulb
//
//  Created by Kush on 14/01/23.
//

import SwiftUI

struct ContentView: View {
    
    // - Properties -
    @StateObject private var bulbControl = BulbControl()
    
    // - Body -
    var body: some View {
        
        ZStack {
            PageView
            BulbView
            BulbColorPalette
        }
        .ignoresSafeArea()
    }
}


extension ContentView {
    
    @ViewBuilder
    private var PageView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(Page.header)
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                Text(Page.body)
                .font(.system(size: 18, weight: .regular, design: .rounded))
            }
            .foregroundColor(.gray)
            .padding(.all, 15)
            .padding(.top, 130)
        }
        .padding(.vertical)
    }
    
    
    @ViewBuilder
    private var BulbColorPalette: some View {
        if bulbControl.showBulbColorPicker {
            VStack {
                ColorPicker("", selection: $bulbControl.bulbColor)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.trailing, 20)
                    .padding(.top, 50)
            }
        }
    }
}


extension ContentView {
    
    @ViewBuilder
    private var BulbView: some View {
            
        let lamp = Bulb(control: bulbControl)
        
        VStack(spacing: 0) {
            lamp.cord
                            
            ZStack {
                lamp.bulbShade
                lamp.bulb
            }
            .frame(width: 50, height: 50)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.top)
        .foregroundColor(.gray)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    bulbControl.handleDragLocationChanged(to: value) // Handles the angle of rotation and cord length
                })
                .onEnded({ value in
                    bulbControl.handleDragGestureEnds() 
                })
        )
        .onTapGesture(count: 2, perform: { bulbControl.handleBulbOnOffState() }) // Double tap to on/off Bulb
        .onLongPressGesture { bulbControl.showBulbColorPicker.toggle() } // Long press gesture for Color Picker
        .rotationEffect(bulbControl.angle, anchor: .top)
    }
}

    

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
#endif


