//
//  VideosModel.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/1/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//


import Foundation
import ObjectMapper

struct VideosModel : Mappable {
	var error : Bool?
	var message : String?
	var videos : [Videos]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		error <- map["error"]
		message <- map["message"]
		videos <- map["videos"]
	}

}
