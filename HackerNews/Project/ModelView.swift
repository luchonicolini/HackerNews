//
//  ModelView.swift
//  HackerNews
//
//  Created by Luciano Nicolini on 14/10/2022.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let episode: [String]
    let locatioName: String
    let locationURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case episode
        case location
        case locationURL = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CharacterModel.CodingKeys> = try decoder.container(keyedBy: CharacterModel.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: CharacterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CharacterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: CharacterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: CharacterModel.CodingKeys.episode)
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locatioName = try locationContainer.decode(String.self, forKey: .name)
        self.locationURL = try locationContainer.decode(String.self, forKey: .locationURL)
        
    }
}

//2
struct EpisodeModel: Decodable {
    let id: Int
    let name: String
}

//3
struct LocationModel: Decodable {
    let id: Int
    let name: String
    let dimension: String
}


//Pyramid Of Doom!
final class ModelView: ObservableObject {
    @Published var characterBasicInfo: CharacterBasicInfo = .empty
    
    func executeRequest() {
        //PART1
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
            print("\(characterModel)")
           
            //PART2
            let firstEpisode = URL(string: characterModel.episode.first!)!
            URLSession.shared.dataTask(with: firstEpisode) { data, response, error in
                let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
                print("\(episodeModel)")
              
                //PART3
                let characterLocationURL = URL(string: characterModel.locationURL)!
                URLSession.shared.dataTask(with: characterLocationURL) { locationData, response, error in
                    let locationModel = try! JSONDecoder().decode(LocationModel.self, from: locationData!)
                    print("\(locationModel)")
                    DispatchQueue.main.async {
                        self.characterBasicInfo = .init(name: characterModel.name, image: URL(string: characterModel.image), firstEpisodeTilte: episodeModel.name, dimension: locationModel.dimension)
                    }
               
                }.resume()

            }.resume()
            
        }.resume()
    }
}


//Metodo 2 PART1

struct CharacterBasicInfo {
    let name: String
    let image: URL?
    let firstEpisodeTilte: String
    let dimension: String
    
    static var empty: Self {
        .init(name: "", image: nil, firstEpisodeTilte: "", dimension: "")
    }
}
