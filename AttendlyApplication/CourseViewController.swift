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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get()
        percentage()
    }
    
    func percentage() {
        var globalAbbsencen = 0
        let date = Date()
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let thed = "\(day)-\(month)-\(year) "
        Task{
         
        let db = Firestore.firestore()
                
                let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
     
                let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
                print(sectsChk)
                print("sara")
                
            for section in sectsChk {
                print("whe??")
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).whereField("st", isEqualTo: thed).getDocuments()

                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("here come ")
                print("docID", documentID)
                
                let snp =   try await db.collection("studentsByCourse").document(documentID ).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                
                let emailNow = snp.documents.first!.get("EmailStudent") as! String
                let state = snp.documents.first!.get("State") as! String
                print("email of student/",emailNow)
                print("state/",state)
                if(state ==  "absent"){
                    print("hi")
                    globalAbbsencen =  globalAbbsencen + 2 //from section take dureation
                    print("globalAbbsence/",globalAbbsencen)
                }
                else{
                    print("by")
                }
            
                //store
              //  let abbsencest = snapshot.documents.first!.get("abbsencest") as! [Map]
              //  print("all number abbsecnce/",abbsencest)
                }
        }
            
        }
        
    
    
    
    
    
    
    
    func get(){
        let db = Firestore.firestore()
        db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments{
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
                    let actual = snapshot!.documents.first!.get("courses") as! [String]
                     let sects = snapshot!.documents.first!.get("Sections") as! [String]
                print(actual)
                for i in 0..<actual.count {

                    let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                    label.setTitle(actual[i], for: .normal)
                    label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                    label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                    label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                    //label.params["course"] = actual[i]
                    //!!!!!!
                    label.tag = Int(sects[i]) ?? 0
                    label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                    label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                    label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                    label.layer.cornerRadius = 0.07 * label.bounds.size.width
                    self.view.addSubview(label)
                }}
                
            }
        }
        
    }
    @objc func pressed1(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 0.75)
        
    }
    
    @objc func pressed2(sender:UIButton) {
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
    }
    
    @objc func pressed(sender:UIButton) {
       
        
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
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
    
  
}

