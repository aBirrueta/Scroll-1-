//
//  monitorExtension.swift
//  monitorExtension
//
//  Created by Alejandro Birrueta on 5/7/26.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

@main
struct monitorExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(activityReport: totalActivity)
        }
        // Add more reports here...
    }
}
