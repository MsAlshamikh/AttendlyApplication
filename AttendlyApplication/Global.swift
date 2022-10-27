//
//  Global.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
//

import Foundation

class Global{
    public static let shared = Global()
    
    public var useremailshare : String = ""
    
    public var sections: [String] = []
    public var coursess: [String] = []
    
    
    public  var section: String = ""
    public var titleB: String = ""
    public var name: String = ""
    
    public var WhatPressed: String = ""
  //  public var lecturerCourses : [[String:String]] = [[:]]
    public var lecturerId : String?
    public var Token: String = ""
    
    public  var sectionName = ""
}
