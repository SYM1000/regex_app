//
//  ContentView.swift
//  Poyecto_MatesCompus
//
//  Created by Santiago Yeomans on 14/09/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View{
    
    @State private var original: String = "aabb"
    @State private var entrada: String = "ab"
    @State private var remplazar: String = "ccc"
    @State private var resultado: String = "acccb"
    
    var body : some View{
        
        ZStack{
            Color.init(.white).edgesIgnoringSafeArea(.all)
            
            VStack(spacing : 0){
            
            Image("otraFotillo")
            .resizable()
                .frame(height: UIScreen.main.bounds.height/4)
            
            ZStack(alignment: .topTrailing){
            
                ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    Text("Primer Proyecto")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.top, 25)
                
                HStack{
                    VStack(alignment: .leading, spacing: 15){
                        Text("Santiago Yeomans - A01251000")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 30)
                        
                    }
                    Spacer()
                }
                //.padding(.top)
                
                //Datos de entrada
                VStack{
                    
//                        Text("Ingresa Datos")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .padding(.bottom)
                    
                    
                    VStack(alignment: .leading){
                    Text("Cadena Original:")
                        .bold()
                        
                    TextField("Cadena original", text: $original)
                        .padding(.all,10)
                        .foregroundColor(.gray)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(10)
                        .font(.system(size: 18))
                    }.padding(.bottom,10)
                    
                    VStack(alignment: .leading){
                    Text("Patrón de entrada:")
                        .bold()
                        
                    TextField("Patroón de entrada", text: $entrada)
                        .padding(.all,10)
                        .foregroundColor(.gray)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(10)
                        .font(.system(size: 18))
                    }.padding(.bottom,10)
                    
                    VStack(alignment: .leading){
                    Text("Cadena a reemplazar:")
                        .bold()
                        
                    TextField("Cadena a reemplazar", text: $remplazar)
                        .padding(.all,10)
                        .foregroundColor(.gray)
                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                        .cornerRadius(10)
                        .font(.system(size: 18))
                    }.padding(.bottom,10)
                    
                }
                
                //Resultado
                Text("👇Resultado👇")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("\(resultado)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                //Boton de calcular
                Button(action: {
                    self.resultado = reemplazar(original: self.original, entrada: self.entrada, remplazadora: self.remplazar)
                    
                }) {
                    VStack{
                        Text("Calcular").foregroundColor(Color.white)
                            .font(.title)
                            .padding(.all)
                    }
                .frame(width: 270)
                    .background(Color("Color"))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    
                    
                }
                
                
                
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 20)
            .background(CustomShape().fill(Color.white))
            .clipShape(Corners())
                }
            }
            .zIndex(40)
            .offset(y: -40)
            
            Spacer()
            
        }.edgesIgnoringSafeArea(.top)
            
        }
    }
}

struct CustomShape : Shape{
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 40))
        }
    }
}

struct Corners : Shape{
    
    func path(in rect: CGRect) -> Path {
        
       let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
       
       return Path(path.cgPath)
    }
}

func reemplazar(original: String, entrada: String, remplazadora: String) -> String {
    var operaciones = [String]()
    var nueva = original
    
    let entrada2 = cambioSimbolo(original: entrada)
    
    operaciones = entrada2.components(separatedBy: "/")
    //print(operaciones)
    
    for oper in operaciones{
        
        //Si es una cerradura
        if(oper.contains("*")){
            
            let cerradura = oper;
            let palabrota = cerradura.prefix(cerradura.count-1) //Cuando la cerradura es mayor a 0
            var palabrita = cerradura.prefix(cerradura.count-2) //Cuando la cerradura es 0
            var letra = cerradura.suffix(2)
            letra = letra.prefix(1)
            
//            print("La cerradura es: \(cerradura)")
//            print("La palabrota es: \(palabrota)")
//            print("La palabrita es: \(palabrita)")
//            print("La última letra es: \(letra)")
            if(palabrota.count == 1){
                print("Tenemos una sola letra")
                letra = palabrota
                palabrita = palabrota
            }
            
            if(!nueva.contains(palabrita)){continue}
            
            while(nueva.contains(palabrita)){
            
                let ini = indice(base: nueva, buscar: String(palabrita))
                print("El indice es: \(ini) la cerradura es \(cerradura)")
                let cerrado = indice(base: nueva, buscar: String(palabrota))
                
                if(cerrado >= 0){
                    
                    var nuevita = String()
                    nuevita.append(contentsOf: palabrita)
                    var ciclo = ini + palabrita.count
                    var recorrido = [String]()
                    
                    //recorrido = nueva.components(separatedBy: "")
                    //recorrido = Array(arrayLiteral: nueva)
                    recorrido = nueva.map { String($0) }
                    
                    print("la longitud es: ", recorrido.count)
                    while(recorrido[ciclo] == letra && ciclo<recorrido.count){
                        nuevita.append(recorrido[ciclo])
                        ciclo+=1
                        if(ciclo == recorrido.count) {break}
                    }
                    print("La nueva es \(nuevita)")
                    nueva = nueva.replaceFirst(of: nuevita, with: remplazadora)
                    
                    
                }else{ //La cerradura tiene un elemento en 0
                    nueva = nueva.replacingOccurrences(of: palabrita, with: remplazadora)
                }
                
                
            
            }

            
            
            
        
        //Si no tiene cerradura
        }else{
            nueva = nueva.replacingOccurrences(of: oper, with: remplazadora)
        }
        
    }
    
    
    return nueva;
}

func cambioSimbolo(original: String) -> String{
    //Remplazar los '+' por '/'
    return original.replacingOccurrences(of: "+", with: "/")
}

func indice(base: String, buscar: String) -> Int{
    if let range: Range<String.Index> = base.range(of: buscar) {
                   let index: Int = base.distance(from: base.startIndex, to: range.lowerBound)
                   //print("index: ", index) //index: 2
                return index
               }
              return -1
}


//Foundation
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension String {
  
  public func replaceFirst(of pattern:String,
                           with replacement:String) -> String {
    if let range = self.range(of: pattern){
      return self.replacingCharacters(in: range, with: replacement)
    }else{
      return self
    }
  }
  
  public func replaceAll(of pattern:String,
                         with replacement:String,
                         options: NSRegularExpression.Options = []) -> String{
    do{
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let range = NSRange(0..<self.utf16.count)
      return regex.stringByReplacingMatches(in: self, options: [],
                                            range: range, withTemplate: replacement)
    }catch{
      NSLog("replaceAll error: \(error)")
      return self
    }
  }
  
}
