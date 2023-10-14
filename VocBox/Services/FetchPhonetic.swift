//
//  FetchPhonetic.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import Foundation


class FetchData {
    
    /*
    func fetchVocabPronunciation(vocab: String, vocabType: String) async throws -> String {
        var fetchedVocab = [VocabularyPronunciation]()
        var pronunciation: Pronunciation
        var pronunciationString = ""
        let urlEndpoint = "https://wordsapiv1.p.mashape.com/words/\(vocab)"
        print("EndPoint = \(urlEndpoint)")
        do{
            guard let url = URL(string: urlEndpoint) else
            {throw FetchError.invalidURL}
                /*
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
              "Content-Type": "application/json",
              "X-Mashape-Key" : "<b520947fc8msh8f599d1b6a4f7a9p14e8bdjsn1d5580fb9124>"
            ]
            */
            var request = URLRequest(url: url)
                  request.httpMethod = "GET"
                  // Add headers to the request
                  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                  request.addValue("b520947fc8msh8f599d1b6a4f7a9p14e8bdjsn1d5580fb9124", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: request)
            guard(response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.serverError}
            print("DEBUG: statusCode =  \(response)")
             let dataString = String(data: data, encoding: .utf8)
            print("DEBUG: dataString =  \(String(describing: dataString))")
            guard let jsondata = try? JSONDecoder().decode([VocabularyPronunciation].self, from: data) else { return "\(vocab)" }
            print("DEBUG: jsonData = \(jsondata)")
            
            fetchedVocab += jsondata
            print("DEBUG: fetchedVocab = \(fetchedVocab)")
            
            for vocab in fetchedVocab {
                pronunciation = vocab.pronunciation
                if let all = pronunciation.all {
                    //print("DeBug: \(vocab.phonetic ?? "/fəˈnedik/")")
                    pronunciationString = all
                    print("PronunciationAll = \(pronunciationString))")
                }
                
                if let verb = pronunciation.verb {
                    if vocabType == "verb" {
                        pronunciationString = verb
                        print("PronunciationVerb = \(pronunciationString))")
                    }
                }
                
                if let noun = pronunciation.noun  {
                    if vocabType == "noun" {
                        pronunciationString = noun
                        print("PronunciationNoun = \(pronunciationString))")
                    }
                }
            }
            
            print("Reuturn \(pronunciationString)")
            return pronunciationString

        }catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
    */
    
    func fetchVocabPhonetic(vocab: String) async throws -> String {
      var fetchedVocab = [Vocabulary]()
      var phonetic = ""
      let urlEndpoint = "https://api.dictionaryapi.dev/api/v2/entries/en/\(vocab)"
        
      do{
          guard let url = URL(string: urlEndpoint) else
          {throw FetchError.invalidURL}
          let (data, response) = try await URLSession.shared.data(from: url)
          guard(response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.serverError}
         // print("DEBUG: statusCode =  \(response)")
          //let dataString = String(data: data, encoding: .utf8)
          //print("DEBUG: dataString =  \(String(describing: dataString))")
          guard let jsondata = try? JSONDecoder().decode([Vocabulary].self, from: data) else { return "\(vocab)" }
          //print("DEBUG: jsonData = \(jsondata)")

          fetchedVocab += jsondata
          print("DEBUG: fetchedVocab = \(fetchedVocab)")
          
          for vocab in fetchedVocab {
              phonetic = vocab.phonetic ?? ""
              print("DeBug: \(vocab.phonetic ?? "/fəˈnedik/")")
              print("Phonetic = \(phonetic)")
          }
          
          return phonetic
          
      }catch{
         print(error.localizedDescription)
          
      }
      
      return ""
      
    }
}

/*
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
 */
