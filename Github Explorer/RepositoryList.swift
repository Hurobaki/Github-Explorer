//
//  RepositoryList.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct RepositoryList : View {
    @ObservedObject var store: ReposStore
    
    func move(from source: IndexSet, to destination: Int) {
        store.repositories.swapAt(source.first!, destination)
    }
    
    func openEmail() {
        let appURL = URL(string: "mailto:noreply@gmail.com")!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL as URL)
        }
    }
    
    @State private var isTapped = false
    @State private var bgColor = Color.white
    
    var body: some View {
        NavigationView {
            VStack {
                SearchUserBar(text: $store.searchText, action: { self.store.searchText = ""}, placerHolder: "Search ...")
                if store.uiStatus == .loading {
                    Spacer()
                    LoadingView()
                    Spacer()
                } else {
                    if ( !store.errorMessage.isEmpty) {
                        VStack(spacing: 10) {
                            Text(store.errorMessage).font(.headline).foregroundColor(Color.red)
                            Text("If you think that is a bug please contact us.")
                            Button( action: {
                                withAnimation(.easeInOut(duration: 2)) {
                                self.openEmail()
                                self.isTapped.toggle()
                                self.bgColor = self.bgColor == Color.white ? Color.gray : Color.white
                                }
                            } ) {
                                VStack {
                                    HStack(alignment: .center) {
                                        Text("Contact us").padding()
                                        Image(systemName: "envelope.fill")
                                    }
                                    .frame(minHeight: 0, maxHeight: 40)
                                    .padding(.horizontal, 20)
                                    .background(bgColor)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                }
                            }.rotation3DEffect(Angle(degrees: isTapped ? 360 : 0), axis: (x: 0, y: 10, z: 0))
                            Spacer()
                        }
                        
                    } else {
                        if store.user != nil {
                            UserCard(user: store.user!)
                        }
                        List {
                            Section(header: Text("\(String(store.repositories.count)) repositories")) {
                                ForEach(store.repositories) { repository in
                                    NavigationLink(destination: RepositoryDetail(store: self.store, repository: repository)) {
                                        RepositoryRow(repository: repository)
                                    }.padding(.vertical, 8.0)
                                }.onDelete { index in
                                    self.store.repositories.remove(at: index.first!)
                                }.onMove(perform: move)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Github user").navigationBarItems(leading: Button(action: { self.store.searchText = "hurobaki" }) {
                Image(systemName: "plus.circle")
            },trailing: EditButton())
        }
    }
}

/*
 #if DEBUG
 struct RepositoryList_Previews : PreviewProvider {
 static var previews: some View {
 RepositoryList().environmentObject(ReposStore())
 }
 }
 #endif
 */
