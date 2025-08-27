//
//  ContentView.swift
//  SwiftDataImportExport
//
//  Created by Paul F on 08/10/24.
//  Actualizando

import SwiftUI
import SwiftData
struct ContentView: View {
    //V-500,paso 1.0, ponemos nuestras variables.
    @State private var nombre = ""
    @State private var altura = ""
    @State private var peso = ""
    @State private var resIMC = "Respuesta"
    //V-502,paso 2.6
    @Environment(\.modelContext) var context
    
    //paso 1.6
    func calcularIMC(peso:String, altura: String) -> String {
        var respuesta = ""
        if let pesoDouble = Double(peso),let alturaDouble = Double(altura), alturaDouble > 0 {
            //Formula de masa corporal
            let imc = pesoDouble / ( alturaDouble * alturaDouble )
            respuesta = String(format: "IMC: %.2f", imc)
            //Paso 1.7
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
    //V-501,paso 1.5, para limpiar
    func limpiar(){
        nombre = ""
        altura = ""
        peso = ""
        resIMC = "Respuesta"
    }
    
    var body: some View {
        //Paso 1.1
        NavigationStack{
            VStack{
                //Paso 1.3
                Text(resIMC).font(.title).bold()
                TextField("Nombre", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Altura", text: $altura)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                // .keyboardType(.numberPad)
                TextField("Peso", text: $peso)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //.keyboardType(.numberPad)
                
                //Paso 1.4
                HStack{
                    Button(action: {
                        //Paso 1.8
                        resIMC = calcularIMC(peso: peso, altura: altura)
                    }, label: {
                        Text("Calcular")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.green)
                    
                    Button(action: {
                        //Paso 1.9
                        limpiar()
                    }, label: {
                        Text("Limpiar")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.red)
                    
                    Button(action: {
                        //paso 2.7
                        context.insert(IMCModel(nombre: nombre, imc: resIMC))
                        //para poder hacer uno nuevo.
                        limpiar()
                    }, label: {
                        Text("Guardar")
                            .bold()
                    }).buttonStyle(.borderedProminent)
                        .tint(.blue)
                }
                //Para que empuje todo hacia arriba⬆️
                Spacer()
            }
            //Paso 1.2
            .navigationTitle("Calcular IMC")
            .padding(.all)
            //Paso 2.8
            .toolbar{
                NavigationLink(destination: DataView()){
                    Image(systemName: "book.pages.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
