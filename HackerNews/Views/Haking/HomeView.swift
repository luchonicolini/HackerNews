//
//  HomeView.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 13/10/2022.
//

import SwiftUI
import LoremSwiftum

struct HomeView: View {
    @State private var words = Array(Set(Lorem.words(3000).components(separatedBy: "")))
    
    @State private var seachText: String = ""
    @State private var filteredWords: [String] = []
   
    //1
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack {
            List(networkManager.post) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                            .fontWeight(.medium)
                        Text(post.title)
        
                    }
                }
            }
            .searchable(text: $seachText)
            .onChange(of: seachText) { search in
                filteredWords = words.filter({ $0.starts(with: search.lowercased())})
                
            }
            .listStyle(.inset)
            .navigationTitle("Noticias")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
