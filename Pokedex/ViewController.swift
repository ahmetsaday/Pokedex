//
//  ViewController.swift
//  Pokedex
//
//  Created by Ahmet SADAY on 12.06.2017.
//  Copyright © 2017 ahmetsaday. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var Pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsePokemonCSV()
        
    }
    
    //MARK: - Parse pokemon csv
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon2", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                Pokemons.append(poke)
            }
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
    }


    //MARK: - CollectionView DataSource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return Pokemons.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            let poke = Pokemons[indexPath.row]
            cell.configureCell(poke)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

}

