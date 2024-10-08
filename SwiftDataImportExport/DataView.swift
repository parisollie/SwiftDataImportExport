//
//  DataView.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import SwiftData
struct DataView: View {
    
    //Vid 502
    @Query private var items : [IMCModel]
    @Environment(\.modelContext) var context
    //Vid 504
    @State private var datos: [ExportModel] = []
    //Vid 505
    @State private var importData = false
    @State private var index = 0
    var body: some View {
        VStack{
            List{
                ForEach(items){ item in
                    VStack(alignment: .leading){
                        Text(item.nombre).font(.title).bold()
                        Text(item.imc).font(.caption).bold()
                    }.onAppear{
                        //Vid 504
                        let datosExport = ExportModel(id: item.id, nombre: item.nombre, imc: item.imc)
                        datos.append(datosExport)
                    }.swipeActions{
                        Button("Eliminar", role: .destructive){
                            context.delete(item)
                        }
                    }
                }
            }
            
            
        }.navigationTitle("Datos")
            .toolbar{
                //Vid 503
                HStack{
                    ShareLink(item: Transactions(results: datos), preview: SharePreview("Share", image: "square.and.arrow.up"))
                    //Vid 505
                    Button("", systemImage: "square.and.arrow.down"){
                        importData.toggle()
                    }
                }
                //Vid 505
            }.fileImporter(isPresented: $importData, allowedContentTypes: [.extensionType]) { result in
                switch result {
                case .success(let URL):
                    do{
                        let data = try Data(contentsOf: URL)
                        let datosImport = try JSONDecoder().decode(Transactions.self, from: data)
                        for itemData in datosImport.results {
                            //Vid 506,comodin para acceder a los datos 
                            if let idExist = datos.firstIndex(where: { $0.id == itemData.id }){
                                print("ID Repetido: ", idExist)
                            }else{
                                context.insert(IMCModel(id: itemData.id, nombre: itemData.nombre, imc: itemData.imc))
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            .onChange(of: index) {
                print(index)
            }
    }
}
