//
//  PokeCell.swift
//  Pokedex
//
//  Created by Banu on 12.06.2017.
//  Copyright © 2017 ahmetsaday. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var img_thumb: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon:Pokemon){
        
        self.pokemon = pokemon
        
        lbl_name.text = self.pokemon.name.capitalized
        img_thumb.image = UIImage(named:"\(self.pokemon.pokedexId)")
        
    }
}
