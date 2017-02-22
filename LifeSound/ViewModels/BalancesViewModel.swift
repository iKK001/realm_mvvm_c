//
//  ListViewModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import RealmSwift

protocol BalancesViewModelViewDelegate: class {
	
    func entriesWereAdded(viewModel: BalancesViewModel)
}

protocol BalancesViewModelCoordinatorDelegate: class {
	
    func balancesViewModelDidSelectData(_ viewModel: BalancesViewModel, data: DataEntry)
}

protocol BalancesViewModelCellDelegate: class {
	
	func didSliderValueChanged(_ sectionNr: Int,_ rowNr: Int, value: Float)
}

protocol BalancesViewModel
{
	var model: BalancesModel? { get set }
	var viewDelegate: BalancesViewModelViewDelegate? { get set }
	var coordinatorDelegate: BalancesViewModelCoordinatorDelegate? { get set}
    
	var title: String { get }
	
	var numberOfEntries: Int { get }
	var numberOfSectionsFromEntries: Int { get }
	var sectionsTitlesFromEntries: [String] { get }
	func numberOfRowsInSectionFromEntries(_ category: Int) -> Int
	func entryAtSectionAndRow(_ sectionNr: Int,_ rowNr: Int) -> DataEntry?
	func updateViewModelAtIndex(_ sectionNr: Int,_ rowNr: Int, _ sliderCurrentValue: Float)
	// func useEntryAtIndex(_ index: Int)  // selection of cell not used
}
