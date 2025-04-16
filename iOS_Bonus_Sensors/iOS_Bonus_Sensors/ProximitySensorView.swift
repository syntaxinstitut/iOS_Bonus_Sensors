//
//  ProximitySensorView.swift
//  iOS_Bonus_Sensors
//
//  Created by Florian Rhein on 16.04.25.
//

import SwiftUI

struct ProximitySensorView: View {

    @StateObject private var viewModel = ProximitySensorViewModel()

    // iOS schaltet automatisch den Bildschirm aus, wenn Proximity Monitoring eingeschaltet ist,
    // und der proximityState sich auf `true` ändern. Dafür wird nur dieser initializer benötigt.
    // Wenn wir zusätzlich dazu eigene Änderungen vornehmen wollen, wir das ViewModel als Observer benötigt
//    init() {
//        UIDevice.current.isProximityMonitoringEnabled = true
//    }

    var body: some View {
        VStack {
            if viewModel.isObjectClose {
                Text("👻")
                    .font(.system(size: 50))
                Text("Buh!")
                    .font(.system(size: 50))
            } else {
                Text("Komm mal näher...")
            }
        }
        .onAppear(perform: self.viewModel.activateProximitySensor)
        .onDisappear(perform: self.viewModel.deactivateProximitySensor)
    }
}

@MainActor
class ProximitySensorViewModel: ObservableObject {

    @Published private(set) var isObjectClose = false

    func activateProximitySensor() {
        UIDevice.current.isProximityMonitoringEnabled = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.proximityChanged(notification:)),
            name: UIDevice.proximityStateDidChangeNotification,
            object: UIDevice.current
        )
    }

    func deactivateProximitySensor() {
        UIDevice.current.isProximityMonitoringEnabled = false

        NotificationCenter.default.removeObserver(self)
    }

    @objc private func proximityChanged(notification: NSNotification) {
        guard let device = notification.object as? UIDevice else { return }

        if device.proximityState {
            self.isObjectClose = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isObjectClose = false
            }
        }
    }
}

#Preview {
    ProximitySensorView()
}
