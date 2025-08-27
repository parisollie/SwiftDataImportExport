//
//  ExportModel.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import CoreTransferable
import UniformTypeIdentifiers

//V-503,paso 2.10
struct ExportModel: Identifiable, Codable {
    //los mismos modelos
    var id: String
    var nombre: String
    var imc: String
}
//Paso 2.12
struct Transactions: Codable, Transferable {
    //Debe ser una estructura.
    var results: [ExportModel]
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .extensionType)
            .suggestedFileName("Datos: \(Date())")
    }
}

//Paso 2.11
extension UTType {
    //pegamos el identifier
    static var extensionType = UTType(exportedAs: "com.pjff.SwiftDataImportExport.jmb")
}
