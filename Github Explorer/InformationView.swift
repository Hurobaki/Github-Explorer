//
//  InformationView.swift
//  Github Explorer
//
//  Created by THE3796 on 30/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct InformationView : View {
    @Environment(\.presentationMode) private var isPresented
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Questions")
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 256).background(Color("Color3"))
                Spacer()
            }
            
            ZStack(alignment: .topTrailing) {
                HStack {
                    Button(action: { self.isPresented.value.dismiss() }) {
                        HStack {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .frame(width: 24, height: 24)
                        .background(BlurView(style:.systemThickMaterial))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        
                    }.padding()
                } 
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(verbatim: "Github Explorer").font(.title).fontWeight(.bold)
                MultilineTextView(text: "Github Explorer permet de récupérer l'ensemble des répertoires de l'utilisateur ou d'autres utilisateurs Github. Elle permet aussi de sauvegarder vos répertoires favoris et de les consulter ultérieurement. Enfin il est possible de rechercher des répertoires en fonction du nombre d'étoiles, de forks.", color: .darkGray)
                Text(verbatim: "Technologie").font(.subheadline).fontWeight(.bold)
                MultilineTextView(text: "Cette application a été développée en utilisant le nouveau framework Apple \"SwiftUI\". Ce framework est à destination d'iOS 13. Cette technologie est donc toujours en phase béta et peut donc comporter certains bugs.", color: .darkGray)
                
            }.padding().padding(.top, 260)
            
        }
        
    }
}

struct MultilineTextView: UIViewRepresentable {
    var text: String
    var size: CGFloat = 16.0
    var color: UIColor = .black
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: size)
        view.textColor = color
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

#if DEBUG
struct InformationView_Previews : PreviewProvider {
    static var previews: some View {
        InformationView().environmentObject(ReposStore())
    }
}
#endif
