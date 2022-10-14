//
//  HomeView.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 13/10/2022.
//

import SwiftUI

struct HomeView: View {
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
