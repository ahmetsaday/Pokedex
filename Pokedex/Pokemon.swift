//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ahmet SADAY on 12.06.2017.
//  Copyright © 2017 ahmetsaday. All rights reserved.
//

import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    private var _height: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvo: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _currentEvo: String!
    private var _pokemonURL: String!
    
    var nextEvoLevel: String{
        if _nextEvoLevel == nil{
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var nextEvoId: String{
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoName: String{
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var height: String{
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense:String{
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var nextEvo: String{
        if _nextEvo == nil{
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = String(attack)
                }
                
                if let defense = dict["defense"]as? Int{
                    self._defense = String(defense)
                }
                
                print(self._attack)
                
                if let types = dict["types"] as? [Dictionary<String,String>], types.count > 0 {
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count{
                            
                            if let name = types[x]["name"]{
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                    
                }else{
                    self._type = ""
                }

                if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"]{
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                
                                if let description = descDict["description"] as? String{
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            completed()
                        })
                    }
                }else{
                    self._description = ""
                }
                
                // bu koşul çalışmıyor. api url leri kontrol et. kod sağlam görünüyor. (yoruldum aq :P )
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String{
                        
                        if nextEvo.range(of: "mega") == nil{
                            
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"]{
                                
                                    if let lvl = lvlExist as? Int{
                                        
                                        self._nextEvoLevel = "\(lvl)"
                                    }
                                    
                                }else{
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                    
                    print(self.nextEvoName)
                    print(self.nextEvoId)
                    print(self.nextEvoLevel)
                }
                
            }
            
            completed()
            
            
        }
        
    }
}
