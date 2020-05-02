//
//  VideosTableViewCell.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/2/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import UIKit

class VideosTableViewCell: UITableViewCell {
//    MARK:- Outlet
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    //    MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    MARK:- Method
    func setupCell(title:String, description:String){
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
