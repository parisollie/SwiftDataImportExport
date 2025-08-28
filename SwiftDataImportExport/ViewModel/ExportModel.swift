//
//  ExportModel.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import CoreTransferable
import UniformTypeIdentifiers

//V-503,paso 3.0, EXPORTAR DATOS, los datos deben de venir de una structura
struct ExportModel: Identifiable, Codable {
    // Deben ser los mismos datos
    var id: String
    var nombre: String
    var imc: String
}
//Paso 3.2
struct Transactions: Codable, Transferable {
    // Debe ser una estructura.
    var results: [ExportModel]
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .extensionType)
            .suggestedFileName("Datos: \(Date())")
    }
}

//Paso 3.1
extension UTType {
    //pegamos el identifier
    static var extensionType = UTType(exportedAs: "com.pjff.SwiftDataImportExport.jmb")
}
