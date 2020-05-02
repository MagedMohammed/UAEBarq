//
//  Videos.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/1/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import Foundation
import ObjectMapper

struct Videos : Mappable {
	var id : Int?
	var url : String?
	var vimeo_id : String?
	var thumb : String?
	var created_at : String?
	var updated_at : String?
	var category_id : Int?
	var home_workout : Int?
	var is_send_notification : String?
	var is_featured : String?
	var archived : String?
	var is_free : String?
	var keyword : String?
	var type : String?
	var is_nutrition : Int?
	var created_by : Int?
	var video_id : Int?
	var lang : String?
	var lang_code : String?
	var title : String?
	var description : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		url <- map["url"]
		vimeo_id <- map["vimeo_id"]
		thumb <- map["thumb"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		category_id <- map["category_id"]
		home_workout <- map["home_workout"]
		is_send_notification <- map["is_send_notification"]
		is_featured <- map["is_featured"]
		archived <- map["archived"]
		is_free <- map["is_free"]
		keyword <- map["keyword"]
		type <- map["type"]
		is_nutrition <- map["is_nutrition"]
		created_by <- map["created_by"]
		video_id <- map["video_id"]
		lang <- map["lang"]
		lang_code <- map["lang_code"]
		title <- map["title"]
		description <- map["description"]
	}

}
