//
//  FavoritesView.swift
//  Github Explorer
//
//  Created by THE3796 on 06/08/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var store: ReposStore
    @State var favorites: [Repository] = []
    
    func getRepoIndex(_ repo: Repository) -> Int? {
        store.repositories.firstIndex(where: {$0.id == repo.id})
    }
    
    func fetchFavoriteRepositories() {
        store.favoriteRepositories = RealmService.shared.foo(of: Repository.self)
    }
    
    func deleteCorrespondingRepository(repo: Repository) {
        if let found = self.getRepoIndex(repo) {
            self.store.repositories[found].isFavorite = false
        } else {
            RealmService.shared.delete(object: repo, id: repo.id)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        store.favoriteRepositories.swapAt(source.first!, destination)
    }
    
    // self.deleteCorrespondingRepository(repo: repository)
    // self.store.favoriteRepositories = RealmService.shared.foo(of: Repository.self)
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Favorites").font(.largeTitle).fontWeight(.heavy)
                Image(systemName: "star.fill").foregroundColor(Color.yellow)
                Spacer()
            }.offset(x: 60)
            
            VStack {
                ForEach(store.favoriteRepositories) { repository in
                    HStack {
                        Text(repository.name)
                        Spacer()
                    }
                    .padding()
                    .border(Color.black, width: 10)
                    .shadow(radius: 10)
                    .onTapGesture {
                        print("### TAPPED")
                    }
                }
            }.padding(.top, 10)
            
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width, minHeight: 0, maxHeight: UIScreen.main.bounds.height)
        .background(Color.white)
        .offset(x: self.store.showTest == MenuOpen.favorites ? 0 : UIScreen.main.bounds.width, y: 80)
        .padding(.top, 10)
        .onAppear {
            self.fetchFavoriteRepositories()
        }
        
    }
}

#if DEBUG
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(store: ReposStore())
    }
}
#endif
