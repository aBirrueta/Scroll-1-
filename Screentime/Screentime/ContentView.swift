//
//  ContentView.swift
//  Screentime
//
//  Created by Alejandro Birrueta on 5/7/26.
//

import SwiftUI
import DeviceActivity

struct ContentView: View {
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        //users: .all,
        devices: .init([.iPhone, .iPad])
    )

    var body: some View {
        VStack {
            //            STProgressView()
        DeviceActivityReport(context, filter: filter)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    // Helper function to format the time interval as a readable string
    private func formatTime(from duration: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: duration)
    }
}
#Preview {
    ContentView()
}
