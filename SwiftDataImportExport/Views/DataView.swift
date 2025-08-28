//
//  DataView.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import SwiftData
struct DataView: View {
    
    // Paso 2.2, ponemos la query
    @Query private var items : [IMCModel]
    @Environment(\.modelContext) var context
    //V-504,paso 3.3
    @State private var datos: [ExportModel] = []
    //V-505,paso 4.0 importación de datos
    @State private var importData = false
    @State private var index = 0
    var body: some View {
        //Paso 2.3
        VStack{
            List{
                //Paso 2.5, ponemos el ForEach
                ForEach(items){ item in
                    VStack(alignment: .leading){
                        
                        Text(item.nombre).font(.title).bold()
                        
                        Text(item.imc).font(.caption).bold()
                    }
                    .onAppear{
                        // Paso 3.4, exportamos los datos
                        let datosExport = ExportModel(id: item.id, nombre: item.nombre, imc: item.imc)
                        datos.append(datosExport)
                    }
                    .swipeActions{
                        //Paso 3.5, para eliminar
                        Button("Eliminar", role: .destructive){
                            context.delete(item)
                        }
                    }
                }// For
            }//List
        }//:V-STACK
        //Paso 2.4
        .navigationTitle("Datos")
            //Paso 3.6
            .toolbar{
                HStack{
                    ShareLink(item: Transactions(results: datos), preview: SharePreview("Share", image: "square.and.arrow.up"))
                    //Paso 4.1
                    Button("", systemImage: "square.and.arrow.down"){
                        importData.toggle()
                    }
                }//:H-STACK
            }//Toolbar
            //Paso 4.2
            .fileImporter(isPresented: $importData, allowedContentTypes: [.extensionType]) { result in
                
                switch result {
                case .success(let URL):
                    do{
                        //Nos pide la URL del archivo
                        let data = try Data(contentsOf: URL)
                        let datosImport = try JSONDecoder().decode(Transactions.self, from: data)
                        //recorremos datos para meterlos.
                        for itemData in datosImport.results {
                            /*V-506,Paso 5.0 comodín para acceder a los datos $0
                            si el id es igual no has nada*/
                            if let idExist = datos.firstIndex(where: { $0.id == itemData.id }){
                                print("ID Repetido: ", idExist)
                            }else{
                                // y sino guarda.
                                context.insert(IMCModel(id: itemData.id, nombre: itemData.nombre, imc: itemData.imc))
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }//Switch
            }
            .onChange(of: index) {
                print(index)
            }
    }
}

#Preview{
    DataView()
}
