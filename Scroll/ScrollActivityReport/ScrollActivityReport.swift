//
//  ScrollActivityReport.swift
//  ScrollActivityReport
//
//  Created by Alejandro Birrueta on 5/6/26.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

@main
struct ScrollActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
