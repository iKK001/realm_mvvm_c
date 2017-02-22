//
//  DataItem.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation

enum SliderType: Int {
	
	case analog = 1, discrete, highLow
	
	var description: String {
		switch self {
		case .analog:
			return "analog"
		case .discrete:
			return "analog"
		case .highLow:
			return "analog"
		}
	}
}

enum SectionCategory: Int {
	
	case Work = 0, Love, Travel
	
	var description: String {
		switch self {
		case .Work:
			return "Work"
		case .Love:
			return "Love"
		case .Travel:
			return "Travel"
		}
	}
}

protocol DataEntry: class {
	
	var idx: Int { get set }
	var sectionCategory: SectionCategory { get set }
	var sliderType: SliderType { get set }
	var sliderTitle: String { get set }
	var sliderCurrentValue: Float { get set }
	var sliderMinValue: Float { get set }
	var sliderMaxValue: Float { get set }
}
