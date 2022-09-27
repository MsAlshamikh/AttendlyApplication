//
//  User.swift
//  AttendlyApplication
//
//  Created by Modhy Abduallh on 29/02/1444 AH.
//

import Foundation

struct User : Codable {
    let email : String
    let name : String
    let sid : String?
    let major : String?
    let advn : String?
    var adviserID : String?
    let college : String?
    let department : String?
}
