//
//  DoubleExtension.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/2/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
