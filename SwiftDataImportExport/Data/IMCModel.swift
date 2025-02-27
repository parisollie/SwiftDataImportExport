//
//  IMCModel.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import SwiftData
//Vid 502
@Model
final class IMCModel {
    @Attribute(.unique) var id : String
    var nombre : String
    var imc : String
    
    init(id: String = UUID().uuidString, nombre: String, imc: String) {
        self.id = id
        self.nombre = nombre
        self.imc = imc
    }
}
