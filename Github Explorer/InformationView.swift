//
//  InformationView.swift
//  Github Explorer
//
//  Created by THE3796 on 30/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct InformationView : View {
    @Environment(\.isPresented) private var isPresented
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Questions")
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 256).background(Color("Color3"))
                Spacer()
            }
            
            ZStack(alignment: .topTrailing) {
                Button(action: { self.isPresented?.value = false }) {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .frame(width: 26, height: 26)
                        .background(Color.gray)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                    
                }.padding(.top, 10).padding(.trailing, 10)
                
                Spacer()
            }
            
            VStack {
                ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("")
                                .lineLimit(nil)
                                .frame(idealHeight: .infinity)
                            
                            Text("Github Explorer").font(.title).fontWeight(.bold)
                            
                            Text("Cette application permet, en se connectant à votre compte Github, de voir l'intégralité des informations de votre compte.").lineLimit(nil).font(.body).foregroundColor(Color.gray)
                            
                            Text("Possibilités").font(.headline).fontWeight(.bold)
                            
                            Text("Github Explorer permet de récupérer l'ensemble des répertoires de l'utilisateur ou d'autres utilisateurs Github. Elle permet aussi de sauvegarder vos répertoires favoris et de les consulter ultérieurement. Enfin il est possible de rechercher des répertoires en fonction du nombre d'étoiles, de forks ...").lineLimit(nil).font(.body).foregroundColor(Color.gray)
                            
                            Text("Technologie").font(.headline).fontWeight(.bold)
                            
                            Text("Cette application a été développée en utilisant le nouveau framework Apple \"SwiftUI\". Ce framework est à destination d'iOS 13. Cette technologie est donc toujours en phase béta et peut donc comporter certains bugs.").lineLimit(nil).font(.body).foregroundColor(Color.gray)
                            
                        }.frame(height: 900)
                }.padding()
            }.padding(.top, 50)
           
            
        }
        
    }
}

#if DEBUG
struct InformationView_Previews : PreviewProvider {
    static var previews: some View {
        InformationView().environmentObject(ReposStore())
    }
}
#endif
