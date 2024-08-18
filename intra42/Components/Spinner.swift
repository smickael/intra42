//
//  Spinner.swift
//  intra42
//
//  Created by Mickaël on 18/08/2024.
//

import SwiftUI

struct Spinner: View {
    let rotationTime: Double = 0.75
    let animationTime: Double = 1.9
    let fullRotation: Angle = .degrees(360)
    static let initialDegrees: Angle = .degrees(270)
    
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndFirst: CGFloat = 0.03
    @State var spinnerEndSecond: CGFloat = 0.03
    
    @State var rotationDegreesFirst = initialDegrees
    @State var rotationDegreesSecond = initialDegrees
    @State var rotationDegreesThird = initialDegrees
    
    
    var body: some View {
        ZStack {
            SpinnerCircle(start: spinnerStart, end: spinnerEndSecond, rotation: rotationDegreesThird, color: .gray)
            SpinnerCircle(start: spinnerStart, end: spinnerEndSecond, rotation: rotationDegreesSecond, color: .gray)
            SpinnerCircle(start: spinnerStart, end: spinnerEndFirst, rotation: rotationDegreesFirst, color: .gray)
        }
        .frame(width: 200, height: 200)
        .onAppear() {
            self.animationSpinner()
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) {
                (minTimer) in self.animationSpinner()
            }
        }
    }
    
    func animationSpinner(with duration: Double, completion: @escaping(() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotationTime)) {
                completion()
            }
        }
    }
    
    func animationSpinner() {
        animationSpinner(with: rotationTime) {
            self.spinnerEndFirst = 1.0
        }
        animationSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreesFirst += fullRotation
            self.spinnerEndSecond = 0.8
        }
        animationSpinner(with: (rotationTime * 2)) {
            self.spinnerEndFirst = 0.03
            self.spinnerEndSecond = 0.03
        }
        animationSpinner(with: (rotationTime * 2) + 0.0525) {
            self.rotationDegreesSecond += fullRotation
        }
        animationSpinner(with: (rotationTime * 2) + 0.225) {
            self.rotationDegreesThird += fullRotation
        }
    }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
    }
}

#Preview {
    Spinner()
}
