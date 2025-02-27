//
//  IMCModel.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import Foundation
import SwiftData
//V-502,paso 2.0 swfit data
@Model
final class IMCModel {
    //Para que el atributo sea único.
    @Attribute(.unique) var id : String
    var nombre : String
    var imc : String
    
    init(id: String = UUID().uuidString, nombre: String, imc: String) {
        self.id = id
        self.nombre = nombre
        self.imc = imc
    }
}
