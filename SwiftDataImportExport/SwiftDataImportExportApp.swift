//
//  SwiftDataImportExportApp.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import SwiftData
@main
struct SwiftDataImportExportApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Paso 2.1,ponemos el model
        }.modelContainer(for: IMCModel.self)
    }
}
