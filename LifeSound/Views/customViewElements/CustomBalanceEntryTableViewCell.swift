//
//  MVVMCBalanceItemTableViewCell.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit

class CustomBalanceEntryTableViewCell: UITableViewCell {
	
	@IBOutlet weak var entryTitle: UILabel!
	@IBOutlet weak var mySlider: UISlider_discrete_iKK!
	
	weak var cellDelegate: BalancesViewModelCellDelegate?
	
	var entrySliderDataEntry: DataEntry? {
		didSet {
			if let entry = entrySliderDataEntry {
				self.entryTitle.text = entry.sliderTitle
				self.mySlider.minimumValue = entry.sliderMinValue
				self.mySlider.maximumValue = entry.sliderMaxValue
				self.animateSlider(value: entry.sliderCurrentValue)
			} else {
				self.entryTitle.text = "Unknown"
				self.mySlider.minimumValue = 0.0
				self.mySlider.maximumValue = 10.0
				self.animateSlider(value: 5.0)
			}
		}
	}
	
	func animateSlider(value: Float) {
		
		UIView.animate(withDuration: 0.5,
		               delay: 0.0,
		               options: .curveEaseInOut,
		               animations: { self.mySlider.setValue(value, animated: true) },
							completion: nil)
	}
	
	
	@IBAction func mySliderValueChanged(_ sender: UISlider_discrete_iKK) {
		
		cellDelegate?.didSliderValueChanged(sender.sectionNr, sender.rowNr, value: sender.value)
	}

}
