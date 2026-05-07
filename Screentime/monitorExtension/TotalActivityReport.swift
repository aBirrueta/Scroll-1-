//
//  TotalActivityReport.swift
//  monitorExtension
//
//  Created by Alejandro Birrueta on 5/7/26.
//

import DeviceActivity
import SwiftUI
import ExtensionKit 
internal import ManagedSettings

func containsIPhone(_ name: String) -> Bool {
  return name.range(of: "iPhone", options: .caseInsensitive) != nil
}

extension DeviceActivityReport.Context {
  static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
  let context: DeviceActivityReport.Context = .totalActivity

  let content: (String) -> TotalActivityView

  func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.day, .hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    formatter.zeroFormattingBehavior = .dropAll

    let thisDevice = await UIDevice.current.model

    guard let singleDeviceData = await data.first(where: { containsIPhone(String($0.device.name!)) }) else {
      return "This device data is not available right now\n thisDevice:\(thisDevice) \n"
    }

    let totalActivityDuration = await singleDeviceData.activitySegments.reduce(0) { total, segment in
      total + segment.totalActivityDuration
    }

    var appNames = [String]()
    appNames.append("\(thisDevice),Time: \(String(describing: formatter.string(from: totalActivityDuration) ?? "Total time not found"))")

    for await activitySegment in singleDeviceData.activitySegments {
      for await category in activitySegment.categories {
        for await app in category.applications {
          let appName = app.application.localizedDisplayName ?? "nil"
          let appTime = formatter.string(from: app.totalActivityDuration) ?? "No Time Found"
          appNames.append("\(appName),Time:\(appTime)")
        }
      }
    }

    let res = appNames.joined(separator: "\n")
    return res.isEmpty ? "No activity data" : res
  }
}
