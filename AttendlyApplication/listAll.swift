//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var nostudent: UILabel!
    //@IBOutlet weak var tableview: UITableView!
    
   // @IBOutlet weak var nostudent: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet weak var nameSection: UILabel!
    
    @IBOutlet weak var zeroStudent: UILabel!
    
    
    var nameStudent = [String]()
    var emailStudent = [String]()
    var idStudent = [String]()
    var v: String = ""
    
     var percentagestu = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     zeroStudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
        zeroStudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
          self.zeroStudent.text = "No Student Registered Yet "
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        
        
     let text1 = NSMutableAttributedString()
       text1.append(NSAttributedString(string: ""
                                  ));
        text1.append(NSAttributedString(string: v));
        nameSection.attributedText = text1
       
        // let d = Int(date.split(separator: "-")[0])!

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableviewControolerTableViewCell
      
        
//        if percentagestu.[indexPath.row] == "h"  {
//                 my.backgroundColor = .systemGreen
//               }
//        else if percentagestu.[indexPath.row] == "n"  {
//            my.backgroundColor = .systemGreen
//        }
        
//        if percentagestu.[indexPath.row] == "nnn" {
//            my.backgroundColor = .systemGreen
//        }
        
        my.nostudent.text = nameStudent[indexPath.row]
        my.idStu.text = idStudent[indexPath.row]
        my.person.image = UIImage(named: "girl" )
        my.currrentsectionpressed.text = String ( percentagestu[indexPath.row] )
      //  my.currrentsectionpressed.text = percentage
       let emails = emailStudent[indexPath.row]
        
    
        print("befor task")
        print(emails)
//        let date = Date()
//        let calunder = Calendar.current
//        let day = calunder.component(.day , from: date)
//        let month = calunder.component(.month , from: date)
//        let year = calunder.component(.year , from: date)
//        let thed = "\(day)-\(month)-\(year)"
        //form here
        
//        Task{
//            var i = 0
//            let db = Firestore.firestore()
//            print("before for llop")
//            print(emails)
//            //loop
//          //  for x in ema {
//            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments()
//
//        //    print(emailStudent[i])
//            let student_docID = snapshot.documents.first!.documentID
//            guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }//
//            var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
//            print("dict ", abbsencest)
//
//
//
//                var globalAbbsencen = 0
//                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: "46467").getDocuments()
//                print(t_snapshot.documents.count)
//
//                print(t_snapshot.documents.count)
//                for doc in t_snapshot.documents {
//                    let documentID = doc.documentID
//                    guard let date = doc.get("st") as? String else { continue }
//                    print(date.split(separator: "-"))
//                    let d = Int(date.split(separator: "-")[0])!
//                    let m = Int(date.split(separator: "-")[1])!
//                    let y = Int(date.split(separator: "-")[2])!
//                    print(d, m, date, day)
//                    if d > day {
//                        print("skip")
//                        continue
//                    }
//
//                    let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments()
//
//                    print(snp.documents.count)
//                    guard let state  = snp.documents.first?.get("State") as? String else { continue }
//                    print("state/",state)
//                    if(state ==  "absent"){
//                        print("hi")
//                        globalAbbsencen = globalAbbsencen + 2 //from section take dureation
//                        print("globalAbbsence/",globalAbbsencen)
//                    }
//                    else{
//                        print("by")
//                    }
//                }
//
//
//
//                abbsencest["46467"] = globalAbbsencen
//                let data = [
//                    "abbsencest": abbsencest
//                ]
//                try await db.collection("Unistudent").document(student_docID).setData(data, merge: true)
//
//                db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments{
//                    (snapshot, error) in
//                    if let error = error {
//                        print("FAIL ")
//                    }
//                    else{
//                        //
//                        let total = snapshot!.documents.first!.get("sectionH") as! [String: Double]
//                        var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
//
//
//                        for (key, value) in total {
//                                   print(key)
//                                   if ( key == "46467")
//                            { print("LETS GOOOOO")
//
//                                    var step1 = value * 0.25
//                                       var step2 = ( Double(globalAbbsencen) /  step1 ) * 100
//                                            var final = step2 * 0.25
//                                       final = Double(round(10 * final) / 10 )
//
//
//                                       totalp["46467"] = final
//
//                                       print(final)
//
//                                       //
//                                       var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
//                                       print("this ok up/" , totalp)
//                                       //
//                                     //  let z = final
//                                     //  let after = final*10
//                                      //
//
//
//                                  let st = String(final) + "%"
//
//                                 //      my.currrentsectionpressed.text = st
//                                    // return st
//
//                                //  i=i+1
//
//
//
//                                   }
//
//                               }
//                    }
//
//                    }
//
//
//
//
//
//       // } for
//
//        } //until here
      
      
        
     

        return my
    }
    
//    func percentage(emails : String) -> String {
//        var numsec = v.split(separator: "-")[1]
//        var st=""
//        let date = Date()
//        let calunder = Calendar.current
//        let day = calunder.component(.day , from: date)
//        let month = calunder.component(.month , from: date)
//        let year = calunder.component(.year , from: date)
//        let thed = "\(day)-\(month)-\(year) "
//        Task{
//
//            let db = Firestore.firestore()
//
//            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: emails).getDocuments()
//
//            let student_docID = snapshot.documents.first!.documentID
//            guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }//
//            var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
//            print("dict ", abbsencest)
//
//            for section in sectsChk {
//                if (section == numsec){
//                var globalAbbsencen = 0
//                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).getDocuments()
//                print(t_snapshot.documents.count)
//
//                print(t_snapshot.documents.count)
//                for doc in t_snapshot.documents {
//                    let documentID = doc.documentID
//                    guard let date = doc.get("st") as? String else { continue }
//                    print(date.split(separator: "-"))
//                    let d = Int(date.split(separator: "-")[0])!
//                    let m = Int(date.split(separator: "-")[1])!
//                    let y = Int(date.split(separator: "-")[2])!
//                    print(d, m, date, day)
//                    if d > day {
//                        print("skip")
//                        continue
//                    }
//
//                    let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: emails).getDocuments()
//
//                    print(snp.documents.count)
//                    guard let state  = snp.documents.first?.get("State") as? String else { continue }
//                    print("state/",state)
//                    if(state ==  "absent"){
//                        print("hi")
//                        globalAbbsencen = globalAbbsencen + 2 //from section take dureation
//                        print("globalAbbsence/",globalAbbsencen)
//                    }
//                    else{
//                        print("by")
//                    }
//                }
//
//
//
//                abbsencest[section] = globalAbbsencen
//                let data = [
//                    "abbsencest": abbsencest
//                ]
//                try await db.collection("Unistudent").document(student_docID).setData(data, merge: true)
//
//                db.collection("Unistudent").whereField("StudentEmail", isEqualTo: emails ).getDocuments{
//                    (snapshot, error) in
//                    if let error = error {
//                        print("FAIL ")
//                    }
//                    else{
//                        //
//                        let total = snapshot!.documents.first!.get("sectionH") as! [String: Double]
//                        var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
//
//
//                        for (key, value) in total {
//                                   print(key)
//                                   if ( key == section)
//                            { print("LETS GOOOOO")
//
//                                    var step1 = value * 0.25
//                                       var step2 = ( Double(globalAbbsencen) /  step1 ) * 100
//                                            var final = step2 * 0.25
//
//                                       totalp[section] = final
//
//                                       print(final)
//
//                                       //
//                                       var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
//                                       print("this ok up/" , totalp)
//                                       //
//                                     //  let z = final
//                                     //  let after = final*10
//                                      //
//
//
//                                      st = String(final) + "%"
//
//
//                                    // return st
//
//
//
//
//
//                                   }
//
//                               }
//                    }
//
//                    }
//
//            }
//
//            }
//
//        }
//
//        return st}
    
    
    
}
