//
//  AccelerometerSensorView.swift
//  iOS_Bonus_Sensors
//
//  Created by Florian Rhein on 16.04.25.
//

import SwiftUI
import CoreMotion

struct AccelerometerSensorView: View {
    @State private var xAcceleration: Double = 0.0
    @State private var yAcceleration: Double = 0.0
    @State private var zAcceleration: Double = 0.0

    private let motionManager = CMMotionManager()

    var body: some View {
        VStack {
            Image(systemName: "iphone.gen3")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding()
                .offset(x: xAcceleration * 100, y: yAcceleration * 100)
                .scaleEffect(zAcceleration * 0.1 +  1.0)
                .animation(.easeInOut, value: xAcceleration)
                .animation(.easeInOut, value: yAcceleration)
                .animation(.easeInOut, value: zAcceleration)

            Text("X-Acceleration: \(xAcceleration, specifier: "%.2F G")")
            Text("Y-Acceleration: \(yAcceleration, specifier: "%.2F G")")
            Text("Z-Acceleration: \(zAcceleration, specifier: "%.2F G")")
        }
        .onAppear(perform: self.startDeviceMotionUpdates)
        .onDisappear(perform: self.stopDeviceMotionUpdates)
    }

    private func startDeviceMotionUpdates() {
        self.motionManager.deviceMotionUpdateInterval = 0.1

        self.motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            if let error {
                print(error)
                return
            }

            guard let data else { return }

            self.xAcceleration = data.userAcceleration.x
            self.yAcceleration = data.userAcceleration.y
            self.zAcceleration = data.userAcceleration.z
        }
    }

    private func stopDeviceMotionUpdates() {
        self.motionManager.stopDeviceMotionUpdates()
        self.xAcceleration = .zero
        self.yAcceleration = .zero
        self.zAcceleration = .zero
    }
}

#Preview {
    AccelerometerSensorView()
}
