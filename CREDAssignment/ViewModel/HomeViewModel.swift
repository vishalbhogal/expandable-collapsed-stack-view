//
//  HomeViewModel.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 20/09/22.
//


import Foundation

enum CellTypes: Int {
    case selectYourCharacter
    case selectYourAvatar
    case confirmDetails
}

enum CellState {
    case expanded, collapsed
}


protocol HomeViewable {
    var cellTypes: [CellTypes] { get }
    var selectedRows: [CellTypes: Bool] { get set }
}

class HomeViewModel: HomeViewable {
    var cellTypes: [CellTypes] =  [.selectYourCharacter, .selectYourAvatar, .confirmDetails]
    var selectedRows: [CellTypes: Bool] = {
        [.selectYourCharacter: false,
         .selectYourAvatar: false,
         .confirmDetails: false
        ]
    }()
}
