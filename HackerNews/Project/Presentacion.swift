//
//  Presentacion.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 14/10/2022.
//

import SwiftUI

struct Presentacion: View {
    @StateObject var CharacterModel = ModelView()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    AsyncImage(url: CharacterModel.characterBasicInfo.image)
                    Text(CharacterModel.characterBasicInfo.name)
                    Text(CharacterModel.characterBasicInfo.firstEpisodeTilte)
                    Text(CharacterModel.characterBasicInfo.dimension)
                }
                .padding()
                .navigationTitle("Rick and Morty")
                
            }
            .onAppear {
                CharacterModel.executeRequest()
            }
        }
    }
}

struct Presentacion_Previews: PreviewProvider {
    static var previews: some View {
        Presentacion()
    }
}
