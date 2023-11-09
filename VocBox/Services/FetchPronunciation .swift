//
//  FetchPronunciation .swift
//  VocBox
//
//  Created by Jessie Pastan on 10/14/23.
//

import Foundation

class FetchVocabPronunciation {
    var myKey = ""

    func fetchVocabPronunciation(vocab: String) async throws -> String {
        var fetchedPronunce = [VocabPronunciation]()
        var pronunciation = ""

        // fetch Api key
        self.myKey  =  FetchApiKey.fetchWordNikApiKey()
        
        let urlEndpoint = "https://api.wordnik.com/v4/word.json/\(vocab.lowercased())/pronunciations?useCanonical=false&sourceDictionary=ahd-5&typeFormat=ahd-5&limit=1&api_key=\(myKey)"
        
        do{
            guard let url = URL(string: urlEndpoint) else
            {throw FetchError.invalidURL}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard(response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.serverError}
            // print("DEBUG: statusCode =  \(response)")
            //let dataString = String(data: data, encoding: .utf8)
            //print("DEBUG: dataString =  \(String(describing: dataString))")
            guard let jsondata = try? JSONDecoder().decode([VocabPronunciation].self, from: data) else { return "\(vocab)" }
            //print("DEBUG: jsonData = \(jsondata)")
            
            fetchedPronunce += jsondata
            print("DEBUG: fetchedVocab = \(fetchedPronunce)")
            
            //Get the first pronunciation out of fetched result( in case there's more than 1 pronunciation of the vocab and assign to pronunciation as return
            for pronunce in fetchedPronunce {
                pronunciation = SplitPronunciation.getFirstPronunciation(text: pronunce.raw ?? "")
                print("DeBug: \(pronunce.raw ?? "/fəˈnedik/")")
                print("Phonetic = \(pronunciation)")
            }
            
            return pronunciation
            
        }catch{
            print(error.localizedDescription)
            
        }
        
        return ""
        
    }
}

enum FetchError: Error, LocalizedError {
case invalidURL
case serverError
case parsingJson
case unknown(Error)

var errorDescription: String? {
    switch self{
    case .invalidURL:
        return " The URL was invalid"
    case .serverError:
        return "There was an errir with the server, please try again"
        
    case .parsingJson:
        return "Cannot parsing JsonData"
        
    case.unknown(let error):
        return error.localizedDescription
    }
    
}
}
