//
//  TotalActivityView.swift
//  monitorExtension
//
//  Created by Alejandro Birrueta on 5/7/26.
//

import SwiftUI

struct TotalActivityView: View {
  var activityReport: String

  var body: some View {
    var apps: [(name: String, time: String, timeInSeconds: TimeInterval)] {
      activityReport.split(separator: "\n").compactMap { line in
        let parts = line.split(separator: ",")
        guard parts.count == 2 else { return nil }
        let name = String(parts[0])
        let time = parts[1].replacingOccurrences(of: "Time:", with: "")
        let timeInSeconds = timeStringToSeconds(time)
        return (name: name, time: time, timeInSeconds: timeInSeconds)
      }
    }

    var totalAppsTime: TimeInterval {
      timeStringToSeconds(apps.first?.time ?? "0")
    }

    List(apps, id: \.name) { app in
      HStack(alignment: .center) {
        VStack(alignment: .leading) {
          Text(app.name).font(.headline)
          Text(app.time).font(.subheadline).foregroundColor(.gray)
          ProgressView(value: app.timeInSeconds / totalAppsTime)
            .accentColor(.blue)
            .scaleEffect(x: 1, y: 2, anchor: .center)
        }
        .padding(.vertical, 8)
      }
    }
  }

  func timeStringToSeconds(_ timeString: String) -> TimeInterval {
    var totalSeconds: TimeInterval = 0
    let components = timeString.split(separator: " ")
    for component in components {
      if component.hasSuffix("h"), let hours = Double(component.dropLast()) {
        totalSeconds += hours * 3600
      } else if component.hasSuffix("m"), let minutes = Double(component.dropLast()) {
        totalSeconds += minutes * 60
      } else if component.hasSuffix("s"), let seconds = Double(component.dropLast()) {
        totalSeconds += seconds
      }
    }
    return totalSeconds
  }
}
    TotalActivityView()
}
