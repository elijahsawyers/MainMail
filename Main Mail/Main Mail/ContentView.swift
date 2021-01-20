//
//  ContentView.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            WaveBackground()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                HStack {
                    Logo()
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct WaveBackground: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(whiteColor))
            GeometryReader { geometry in
                Wave()
                    .foregroundColor(Color(blueColor))
                    .frame(height: geometry.size.height * 0.75)
                    .shadow(
                        color: Color(shadowColor),
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY
                    )
            }
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private var whiteColor: NSColor = NSColor(red: 1.00, green: 0.976, blue: 0.969, alpha: 1.0)
    private var blueColor: NSColor = NSColor(red: 0.475, green: 0.773, blue: 0.906, alpha: 1.0)
    private var shadowColor: NSColor = NSColor.black
    private var shadowRadius: CGFloat = 15.0
    private var shadowX: CGFloat = +0.0
    private var shadowY: CGFloat = -5.0
}

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.maxY * 0.95)) // Lower left-hand corner.
        p.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY * 0.95), // Lower right-hand corner.
            control1: CGPoint(x: rect.minX + rect.size.width * 0.25, y: rect.maxY + rect.size.height * 0.125),
            control2: CGPoint(x: rect.minX + rect.size.width * 0.75, y: rect.maxY - rect.size.height * 0.25)
        )
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Top right-hand corner.
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // Top left-hand corner.
        p.closeSubpath()
        return p
    }
}

struct Logo: View {
    var body: some View {
        HStack {
            Text("\(Image(systemName: "envelope.fill"))")
                .font(.system(size: 32))
                .bold()
            Text("Main Mail")
                .font(.system(size: 32))
                .bold()
        }
        .shadow(color: Color.black.opacity(0.25), radius: 1.5, x: 0.0, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaveBackground()
    }
}
