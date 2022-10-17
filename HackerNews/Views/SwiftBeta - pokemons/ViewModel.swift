//
//  ViewModel.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 14/10/2022.
//

import Foundation

//API https://pokeapi.co/

struct PokemonDataModel: Decodable{
    let name: String
    let url: String
}

struct PokemonResponseDataModel: Decodable {
    let pokemons: [PokemonDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
    }
}


final class NetworkPokemon: ObservableObject {
    @Published var pokemons = [PokemonDataModel]()

    func getPokemons() {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(PokemonResponseDataModel.self, from: safeData)
                            DispatchQueue.main.async {
                                self.pokemons = results.pokemons
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}





//print("DATA INFO \(String(describing: data))")
//print("RESPONSE INFO \(String(describing: response))")
//print("ERROR INFO \(String(describing: error))")
//if let data = data {
//let json = try? JSONSerialization.jsonObject(with: data)
// print(String(describing: json))
