//
//  ExportModel.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import CoreTransferable
import UniformTypeIdentifiers

//Vid 503 
struct ExportModel: Identifiable, Codable {
    var id: String
    var nombre: String
    var imc: String
}

struct Transactions: Codable, Transferable {
    var results: [ExportModel]
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .extensionType)
            .suggestedFileName("Datos: \(Date())")
    }
}

extension UTType {
    static var extensionType = UTType(exportedAs: "com.pjff.SwiftDataImportExport.jmb")
}
