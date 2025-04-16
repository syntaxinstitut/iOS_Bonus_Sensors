//
//  iOS_Bonus_SensorsApp.swift
//  iOS_Bonus_Sensors
//
//  Created by Florian Rhein on 16.04.25.
//

import SwiftUI

@main
struct iOS_Bonus_SensorsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Neigungssensor", systemImage: "move.3d") {
                    GyroscopeSensorView()
                }

                Tab("Beschleunigungssensor", systemImage: "hare") {
                    AccelerometerSensorView()
                }

                Tab("Näherungssensor", systemImage: "face.dashed") {
                    ProximitySensorView()
                }

                Tab("Helligkeitssensor", systemImage: "circle.lefthalf.striped.horizontal.inverse") {

                }
            }
        }
    }
}
