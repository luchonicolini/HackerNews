//
//  Home.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 14/10/2022.
//

import SwiftUI

struct Home: View {
  
    @ObservedObject var ViewModel = NetworkPokemon()
    
    var body: some View {
        NavigationStack {
            List(ViewModel.pokemons, id: \.name) { index in
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                    
                    Text(index.name)
                        .foregroundColor(.primary)
                }
                    
               
            }
            .listStyle(.plain)
            .navigationTitle("Pokemons")
        }
        .onAppear {
            self.ViewModel.getPokemons()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
