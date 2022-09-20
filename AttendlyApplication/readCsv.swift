//
//  readCsv.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 23/02/1444 AH.
//

import Foundation

extension String{
    func fileName() -> String{
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtenstion() -> String{
        return URL(fileURLWithPath: self).pathExtension
    }
}


func readCVC(inputFile: String, seprator: String) -> [String]{
    let fileExtenstion = inputFile.fileExtenstion()
    let fileName = inputFile.fileName()
    //get url
    let fileURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let inputFile = fileURL.appendingPathComponent(fileName).appendingPathExtension(fileExtenstion)
    
    do{
        let saveData = try String(contentsOf: inputFile)
        return saveData.components(separatedBy: seprator)
    }catch{
        return ["can not find "]
    }
    print(inputFile)
}

var myData = readCVC(inputFile: "input.csv", seprator: ",")

//print(myData)

//print(myData[0])



