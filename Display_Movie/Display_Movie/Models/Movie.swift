//
//  Movie.swift
//  Display_Movie
//
//  Created by Neacsu Dragos on 04.08.2022.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let original_language: String?
    let original_name: String?
    let original_title: String?
    let poster_path:String?
    let overview: String?
    let release_date: String?
    let vote_average: Double

}
    

/*
 id = 626735;
 "original_language" = en;
 "original_title" = Dog;
 overview = "An army ranger and his dog embark on a road trip along the Pacific Coast Highway to attend a friend's funeral.";
 popularity = "1258.3";
 "poster_path" = "/rkpLvPDe0ZE62buUS32exdNr7zD.jpg";
 "release_date" = "2022-02-17";
 title = Dog;
 video = 0;
 "vote_average" = "7.4";
 "vote_count" = 736;
},
 */
