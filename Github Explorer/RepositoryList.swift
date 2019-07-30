//
//  RepositoryList.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct RepositoryList : View {
    @EnvironmentObject var store: ReposStore
    
    func move(from source: IndexSet, to destination: Int) {
        store.repos.swapAt(source.first!, destination)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.repos) { repository in
                    NavigationLink(destination: RepositoryDetail(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }.padding(.vertical, 8.0)
                }.onDelete { index in
                    self.store.repos.remove(at: index.first!)
                }.onMove(perform: move)
            }.navigationBarTitle("Repositories").navigationBarItems(leading: Button(action: { self.store.searchText = "hurobaki" }) {
                Image(systemName: "plus.circle")
            },
            trailing: EditButton())
        }
    }
}

#if DEBUG
struct RepositoryList_Previews : PreviewProvider {
    static var previews: some View {
        RepositoryList().environmentObject(ReposStore())
    }
}
#endif

/*
 VStack {
 NavigationView {
 VStack(spacing: 0) {
 
 HStack {
 Image(systemName: "magnifyingglass").background(Color.blue).padding(.leading, 10.0)
 TextField($repoStore.searchText, placeholder: Text("Search")).background(Color.red)
 .padding(.vertical, 4.0)
 .padding(.trailing, 10.0)
 }
 .border(Color.secondary, width: 1, cornerRadius: 5)
 .padding()
 
 List {
 ForEach(self.repoStore.repos) { repository in
 NavigationLink(
 destination: RepositoryDetail(repository: repository).environmentObject(self.repoStore)
 ) {
 RepositoryRow(repository: repository)
 }
 }
 
 }.navigationBarTitle(Text("Repositories"))
 }
 }
 }
 */
