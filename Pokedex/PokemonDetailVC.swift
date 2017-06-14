//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Ahmet SADAY on 12.06.2017.
//  Copyright © 2017 ahmetsaday. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_main: UIImageView!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_type: UILabel!
    @IBOutlet weak var lbl_defense: UILabel!
    @IBOutlet weak var lbl_height: UILabel!
    @IBOutlet weak var lbl_pokedex: UILabel!
    @IBOutlet weak var lbl_weight: UILabel!
    @IBOutlet weak var lbl_attack: UILabel!
    @IBOutlet weak var img_nextEvo: UIImageView!
    @IBOutlet weak var img_currentEvo: UIImageView!
    @IBOutlet weak var lbl_evo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_name.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        img_main.image = img
        img_currentEvo.image = img
        lbl_pokedex.text = "\(pokemon.pokedexId)"
        
        
        pokemon.downloadPokemonDetail {
            
            
            self.updateUI()
        }
        
    }

    @IBAction func btn_backPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        lbl_attack.text = pokemon.attack
        lbl_defense.text = pokemon.defense
        lbl_height.text = pokemon.height
        lbl_weight.text = pokemon.weight
        lbl_type.text = pokemon.type
    }
}
