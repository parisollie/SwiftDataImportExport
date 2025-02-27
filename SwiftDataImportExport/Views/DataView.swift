//
//  DataView.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import SwiftData
struct DataView: View {
    
    //V-502,paso 2.2
    @Query private var items : [IMCModel]
    @Environment(\.modelContext) var context
    //V-504,paso 2.13
    @State private var datos: [ExportModel] = []
    //V-505,paso 2.17
    @State private var importData = false
    @State private var index = 0
    var body: some View {
        //Paso 2.3
        VStack{
            List{
                //paso 2.5, ponemos el ForEach
                ForEach(items){ item in
                    VStack(alignment: .leading){
                        Text(item.nombre).font(.title).bold()
                        Text(item.imc).font(.caption).bold()
                    }.onAppear{
                        //Paso 2.14
                        let datosExport = ExportModel(id: item.id, nombre: item.nombre, imc: item.imc)
                        datos.append(datosExport)
                    }.swipeActions{
                        //Paso 2.15, para eliminar
                        Button("Eliminar", role: .destructive){
                            context.delete(item)
                        }
                    }
                }
            }
        //Paso 2.4
        }.navigationTitle("Datos")
            .toolbar{
                //Paso 2.16
                HStack{
                    ShareLink(item: Transactions(results: datos), preview: SharePreview("Share", image: "square.and.arrow.up"))
                    //Paso 2,18
                    Button("", systemImage: "square.and.arrow.down"){
                        importData.toggle()
                    }
                }
                //Paso 2.19
            }.fileImporter(isPresented: $importData, allowedContentTypes: [.extensionType]) { result in
                switch result {
                //Paso 2.20
                case .success(let URL):
                    do{
                        //Nos pide la URL del archivo
                        let data = try Data(contentsOf: URL)
                        let datosImport = try JSONDecoder().decode(Transactions.self, from: data)
                        //recorremos datos para meterlos.
                        for itemData in datosImport.results {
                            /*V-506,Paso 2.2 comodin para acceder a los datos $0
                            si el id es igual no has nada*/
                            if let idExist = datos.firstIndex(where: { $0.id == itemData.id }){
                                print("ID Repetido: ", idExist)
                            }else{
                                context.insert(IMCModel(id: itemData.id, nombre: itemData.nombre, imc: itemData.imc))
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                //paso 2.21
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            .onChange(of: index) {
                print(index)
            }
    }
}

#Preview{
    DataView()
}
