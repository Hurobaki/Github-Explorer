//
//  RepositoryDetail.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct RepositoryDetail : View {
    @ObservedObject var store: ReposStore
    var repository: Repository
    
    var repoIndex: Int {
        store.repositories.firstIndex(where: {$0.id == repository.id})!
        
      
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(repository.name)
                Button(action: {
                    self.store.repositories[self.repoIndex].isFavorite.toggle()
                    self.store.favoriteRepositories = RealmService.shared.foo(of: Repository.self)
                    self.store.objectWillChange.send()
                }) {
                    if self.store.repositories.count > 0 && self.store.repositories[self.repoIndex].isFavorite {
                        Image(systemName: "star.fill").imageScale(.large).foregroundColor(Color.pink)
                    } else {
                        Image(systemName: "star").imageScale(.large).foregroundColor(Color.gray)
                    }
                        
                }
            }
            
            }.navigationBarTitle(Text(repository.name), displayMode: .inline)
    }
}
/*
#if DEBUG
//let dummyRepository = Repository(id: 1, name: "Pwet")

struct RepositoryDetail_Previews : PreviewProvider {
    static var previews: some View {
        RepositoryDetail(store: ReposStore(), repository: dummyRepository)
    }
}
#endif
 */

/*
 VStack(alignment: .leading) {
 
 HStack(alignment: .center) {
 Image("DetailBackground").resizable().aspectRatio(contentMode: .fit)
 }
 
 
 VStack(alignment: .leading, spacing: 20) {
 HStack {
 Text(verbatim: repository.name)
 .lineLimit(nil).font(.title)
 
 Spacer()
 
 Button(action: {
 self.repoStore.repos[self.repoIndex]
 .isFavorite.toggle()
 }) {
 if !self.repoStore.repos.isEmpty && self.repoStore.repos[self.repoIndex]
 .isFavorite {
 Image(systemName: "star.fill")
 .foregroundColor(Color.yellow)
 } else {
 Image(systemName: "star")
 .foregroundColor(Color.gray)
 }
 }
 }
 
 HStack {
 HStack(alignment: .center) {
 Image(systemName: "tuningfork")
 Text(repository.fork ? "Forked": "Not forked")
 }
 Spacer()
 HStack(alignment: .center) {
 if repository.stars > 0 {
 Image(systemName: "star.fill").foregroundColor(Color.yellow)
 } else {
 Image(systemName: "star").foregroundColor(Color.blue)
 }
 Text(String(repository.stars))
 }
 }
 
 HStack {
 Image(systemName: "clock")
 Text(repository.getDate(from: repository.created))
 }
 
 HStack {
 Image(systemName: "pencil.circle")
 Text(repository.getDate(from: repository.updated))
 }
 
 
 }.padding()
 
 
 VStack(alignment: .leading, spacing: 20) {
 Text("Description").font(.title)
 Text(verbatim: repository.description ?? "No description provided").lineLimit(nil).font(.body)
 }.padding()
 
 
 Spacer()
 
 }.navigationBarTitle(Text(repository.name), displayMode: .inline)
 */
