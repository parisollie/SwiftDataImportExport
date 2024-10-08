//
//  ContentView.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    //Vid 500
    @State private var nombre = ""
    @State private var altura = ""
    @State private var peso = ""
    @State private var resIMC = "Respuesta"
    
    @Environment(\.modelContext) var context
    
    //Vid 501
    func calcularIMC(peso:String, altura: String) -> String {
        var respuesta = ""
        if let pesoDouble = Double(peso),let alturaDouble = Double(altura), alturaDouble > 0 {
            let imc = pesoDouble / ( alturaDouble * alturaDouble )
            respuesta = String(format: "IMC: %.2f", imc)
            
            if imc < 18.5 {
                respuesta += " - Bajo peso"
            } else if imc < 24.9 {
                respuesta += " - Peso normal (Saludable)"
            } else if imc < 29.9 {
                respuesta += " - Sobrepeso"
            }else{
                respuesta += " - Obesidad"
            }
            
        }else{
            respuesta = "Ingresa valores correctos para altura y peso"
        }
        
        
        return respuesta
    }
    //Vid 501
    func limpiar(){
        nombre = ""
        altura = ""
        peso = ""
        resIMC = "Respuesta"
    }
    
    var body: some View {
        //Vid 500
        NavigationStack{
            VStack{
                Text(resIMC).font(.title).bold()
                TextField("Nombre", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Altura", text: $altura)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   // .keyboardType(.numberPad)
                TextField("Peso", text: $peso)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //.keyboardType(.numberPad)
                
                HStack{
                    Button(action: {
                        resIMC = calcularIMC(peso: peso, altura: altura)
                    }, label: {
                        Text("Calcular")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.green)
                    
                    Button(action: {
                        limpiar()
                    }, label: {
                        Text("Limpiar")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.red)
                    
                    Button(action: {
                        //Vid 502
                        context.insert(IMCModel(nombre: nombre, imc: resIMC))
                        limpiar()
                    }, label: {
                        Text("Guardar")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.blue)
                }
                Spacer()
            }.navigationTitle("Calcular IMC")
                .padding(.all)
                .toolbar{
                    //Vid 502
                    NavigationLink(destination: DataView()){
                        Image(systemName: "book.pages.fill")
                    }
                }
        }
    }
}

