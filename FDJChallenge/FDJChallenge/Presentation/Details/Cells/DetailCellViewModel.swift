//
//  DetailCellViewModel.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
class DetailsCellViewModel {
    let imageBanner: String
    let country: String
    let league: String
    let descrption: String
    
    init(
        imageBanner: String, country: String, league: String, descrption:String
    ) {
        self.imageBanner = imageBanner
        self.country = country
        self.league = league
        self.descrption = descrption
    }    
}
