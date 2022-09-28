//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore

class CourseViewController: UIViewController {
    
    
    @IBOutlet weak var noC: UILabel!
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    
    @IBOutlet weak var levelUI: UILabel!
    @IBOutlet weak var dateUI: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        percentage()
      get()
       
    }
    /*  func loadStats(){
     let db = Firestore.firestore()
     db.collection("Unistudent").addDocument(data: ["advisorID" : "441111111", "major" : "SWE","sFirstN" : "Amani","sLastN" : "Aldahmash","studentID" : "441204066"])
     {error in
     if let error = error {
     print("FAAAAAIIIIILLLLLL ")
     }
     else{
     print("YESSSSSSSSSSS")
     }
     }}}*/
    
    func percentage() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        dateUI.text = dateFormatter.string(from: date)
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let thed = "\(day)-\(month)-\(year) "
        Task{
            
            let db = Firestore.firestore()
            
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments()
            let level = snapshot.documents.first!.get("Level")
            levelUI.text = "Level \(level!) - Semester 1"
            let student_docID = snapshot.documents.first!.documentID
            guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }
            var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
            print("dict ", abbsencest)
            var i = 0
            for section in sectsChk {
                var globalAbbsencen = 0
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).getDocuments()
                print(t_snapshot.documents.count)
                
                print(t_snapshot.documents.count)
                for doc in t_snapshot.documents {
                    let documentID = doc.documentID
                    guard let date = doc.get("st") as? String else { continue }
                    print(date.split(separator: "-"))
                    let d = Int(date.split(separator: "-")[0])!
                    let m = Int(date.split(separator: "-")[1])!
                    let y = Int(date.split(separator: "-")[2])!
                    print(d, m, date, day)
                    if d > day {
                        print("skip")
                        continue
                    }
                    
                    let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments()
                    
                    print(snp.documents.count)
                    guard let state  = snp.documents.first?.get("State") as? String else { continue }
                    print("state/",state)
                    if(state ==  "absent"){
                        print("hi")
                        globalAbbsencen = globalAbbsencen + 2 //from section take dureation
                        print("globalAbbsence/",globalAbbsencen)
                    }
                    else{
                        print("by")
                    }
                }
                
                
                
                abbsencest[section] = globalAbbsencen
                let data = [
                    "abbsencest": abbsencest
                ]
                try await db.collection("Unistudent").document(student_docID).setData(data, merge: true)
                
                db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL ")
                    }
                    else{
                        //
                        let total = snapshot!.documents.first!.get("sectionH") as! [String: Double]
                   //     var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
                        
                        
                        for (key, value) in total {
                                   print(key)
                                   if ( key == section)
                            { print("LETS GOOOOO")
                                       
                                    var step1 = value * 0.25
                                       var step2 = ( Double(globalAbbsencen) /  step1 ) * 100
                                            var final = step2 * 0.25
                                       
                              //         totalp[section] = final
                                       
                                       print(final)
                                       
                                      
                                       
                                       
                                       
                                       let actual = snapshot!.documents.first!.get("courses") as! [String]
                                        let sects = snapshot!.documents.first!.get("Sections") as! [String]
                                   print(actual)
                                   //for i in 0..<actual.count {
                                       let label = UIButton(frame: .init(x: self.view.frame.midX-238 , y: 320 + ( Double(i) * 90 ), width: 300, height: 60))
                                       label.setTitle(actual[i], for: .normal)
                                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                                      // label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                                       
                                       //line
                                       let line =  UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 373 + ( Int((Double(i))) * 90 ), width: 250, height: 26))
                                
                                       //
                                       line.layer.cornerRadius = 0.04 * label.bounds.size.width
                                       line.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.75)
                                       
                                       //
                                     //  var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
                                   //    print("this ok up/" , totalp)
                                       //
                                       let z = final
                                       let after = final*10
                                      //
                                       let perc = UIButton(frame: .init(x: CGFloat(self.view.frame.midX)-148 , y: Double(373 + ( Int((Double(i))) * 90 )), width: after, height: 26))
                                       //
                                       perc.layer.cornerRadius = 0.04 * label.bounds.size.width
                                       if (z>20)
                                       {perc.backgroundColor = UIColor(red: 355/255, green: 0/255, blue: 0/255, alpha: 0.75)}
                                       else if (z>15)
                                       {  perc.backgroundColor = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 0.75)}
                                       else if (z>10)
                                       {   perc.backgroundColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 0.75)}
                                       else
                                       { perc.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.75)}
                    //
                                       let pt = UILabel(frame: .init(x: Int(self.view.frame.midX)+105 , y: 373 + ( Int((Double(i))) * 90 ), width: 70, height: 26))
                                       pt.textColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2)
                                       
                                     final = Double(round(10 * final) / 10)
                                       pt.font = UIFont(name: "systemFont", size: 26.0)
                                       
                                       pt.text = " " + String(final) + "%"
                                       
                                       
                                       self.view.addSubview(perc)
                                       self.view.addSubview(pt)

                                       self.view.addSubview(line)
                                           //
                                       label.tag = Int(section) ?? 0
                                       label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                                       label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                                       label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
                                       self.view.addSubview(label)
                                       
                                       i = i+1
                                       
                                   
     
                                   }
                            
                               }
                    }
                        
                    }
      
            }}}
    
    func get() {
        
        let db = Firestore.firestore()
        db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "441201198@student.ksu.edu.sa").getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                print("SUCCESS")
                print(Global.shared.useremailshare)
                let actualChk = snapshot!.documents.first!.get("courses") as! [String]
                let sectsChk = snapshot!.documents.first!.get("Sections") as! [String]
                if((actualChk.count == 1 && actualChk[0] == "" ) || (sectsChk.count == 1 && sectsChk[0] == "" ) )
                {
                    print("IT WOOOORKED")
                    
                    self.noC.text = "No courses \n registered!"
                    
                }
                
                //
                else{
                    /*
                    let actual = snapshot!.documents.first!.get("courses") as! [String]
                     let sects = snapshot!.documents.first!.get("Sections") as! [String]
                print(actual)
                for i in 0..<actual.count {
                    let label = UIButton(frame: .init(x: self.view.frame.midX-238 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                    label.setTitle(actual[i], for: .normal)
                    label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                    label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                   // label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                    
                    //line
                    let line =  UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(i))) * 90 ), width: 250, height: 26))
             
                    //
                    line.layer.cornerRadius = 0.04 * label.bounds.size.width
                    line.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.75)
                    
                    //
                    var totalp = snapshot!.documents.first!.get("percentage") as! [String: Double]
                    print("this ok/" , totalp)
                    //
                    let z = Int(totalp[sects[i]]!)
                    let after = z*10
                   //
                    let perc = UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(i))) * 90 ), width: after, height: 26))
                    //
                    perc.layer.cornerRadius = 0.04 * label.bounds.size.width
                    if (z>20)
                    {perc.backgroundColor = UIColor(red: 355/255, green: 0/255, blue: 0/255, alpha: 0.75)}
                    else if (z>15)
                    {  perc.backgroundColor = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 0.75)}
                    else if (z>10)
                    {   perc.backgroundColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 0.75)}
                    else
                    { perc.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.75)}
 //
                    let pt = UILabel(frame: .init(x: Int(self.view.frame.midX)+105 , y: 333 + ( Int((Double(i))) * 90 ), width: 70, height: 26))
                    pt.textColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2)
                    
                  
                    pt.font = UIFont(name: "systemFont", size: 27.0)
                    
                    pt.text = " " + String(z) + "%"
                    
                    
                    self.view.addSubview(perc)
                    self.view.addSubview(pt)

                    self.view.addSubview(line)
                        //
                    label.tag = Int(sects[i]) ?? 0
                    label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                    label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                    label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                    label.layer.cornerRadius = 0.07 * label.bounds.size.width
                    self.view.addSubview(label)
                    
                    
                }}*/
                //Vstack
                // coursesT.text = actual
                //     print((actual).count)
            }
        }
        }
    }
                
    @objc func pressed1(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 2), for: .normal)
       // sender.backgroundColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 0.75)
        
    }
    
    @objc func pressed2(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
      //  sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
    }
    
    @objc func pressed(sender:UIButton) {
       
        
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        //sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
        //1
        titleB = sender.title(for: .normal)!
        //2
        section = String(sender.tag)
        
        
        
        let db = Firestore.firestore()
        db.collection("Sections").whereField("section", isEqualTo: section).getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL2 ")
            }
            else{
                print("SUCCESS2")
                let id = snapshot!.documents.first!.get("lecturerID") as! String
                print(id)
                
                db.collection("Lecturer").whereField("id", isEqualTo: id).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL3 ")
                    }
                    else{
                        print("SUCCESS 3")
                        self.name = snapshot!.documents.first!.get("name") as! String
                        self.performSegue(withIdentifier: "s1", sender: self)
                        //3
                        //print(name)
                        
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "s1" {
            if let controller = segue.destination as? DetailsViewController {
                controller.section = section
                controller.name = name
                controller.titleB = titleB
            }
        }
    }
    
 
    @IBAction func unwind(segue: UIStoryboardSegue ){
        
    }
}


