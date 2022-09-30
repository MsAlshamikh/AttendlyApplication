//
//  User.swift
//  AttendlyApplication
//
//  Created by Yumna Almalki on 04/03/1444 AH.
//
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

