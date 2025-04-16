//
//  GyroscopeSensorView.swift
//  iOS_Bonus_Sensors
//
//  Created by Florian Rhein on 16.04.25.
//

import SwiftUI
import CoreMotion

struct GyroscopeSensorView: View {

    @State private var roll: Double = 0.0
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0

    private let motionManager = CMMotionManager()

    var body: some View {
        VStack {
            Image(systemName: "iphone.gen3")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .rotation3DEffect(.radians(pitch), axis: (1, 0, 0))
                .rotation3DEffect(.radians(roll), axis: (0, 1, 0))
                .rotation3DEffect(.radians(yaw), axis: (0, 0, 1))
                .padding()

            Text("Roll: \(roll, specifier: "%.2F rad") (\(roll.asDegree, specifier: "%.2F°")))")
            Text("Pitch: \(pitch, specifier: "%.2F rad") (\(pitch.asDegree, specifier: "%.2F°")))")
            Text("Yaw: \(yaw, specifier: "%.2F rad") (\(yaw.asDegree, specifier: "%.2F°")))")
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

            self.roll = data.attitude.roll
            self.pitch = data.attitude.pitch
            self.yaw = data.attitude.yaw
        }
    }

    private func stopDeviceMotionUpdates() {
        self.motionManager.stopDeviceMotionUpdates()
        self.roll = .zero
        self.pitch = .zero
        self.yaw = .zero
    }
}

extension Double {
    var asDegree: Double {
        self * 180 / .pi
    }
}

#Preview {
    GyroscopeSensorView()
}
