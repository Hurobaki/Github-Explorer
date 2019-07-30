//
//  RepositoryRow.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct RepositoryRow : View {
    
    var repository: Repository
    
    var body: some View {
        HStack(spacing: 12.0) {
            Image(repository.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .background(Color.red)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(repository.name).font(.headline)
                Text(repository.description ?? "No description provided.").lineLimit(2).lineSpacing(4).font(.subheadline).frame(height: 50.0)
            }
        }
    }
}

#if DEBUG
let dummyRepository = Repository(id: 1, name: "Test")

struct RepositoryRow_Previews : PreviewProvider {
    static var previews: some View {
        RepositoryRow(repository: dummyRepository)
    }
}
#endif
