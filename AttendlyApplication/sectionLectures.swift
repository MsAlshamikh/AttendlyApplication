//
//  sectionLectures.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import UIKit
import FirebaseFirestore

class sectionLectures: UIViewController {
    
    var Sectionss: String = ""
   var coursess: String = ""
  
//    var name2: String = ""
//    var section2: String = ""
//    var titleB2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        // Do any additional setup after loading the view.

    }

    
    func get(){
           let db = Firestore.firestore()
           db.collection("classes").whereField("LecturerEmail", isEqualTo: Global.shared.useremailshare ).getDocuments{
               (snapshot, error) in
               if let error = error {
                   print("FAIL ")
               }
               else{
                   print("SUCCESS??")
                   let actual = snapshot!.documents.first!.get("coursess") as! [String]
                //   let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
                   print(actual)
                   for i in 0..<actual.count {

                       let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                       label.setTitle(actual[i], for: .normal)
                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                      
                       //
                    //   label.tag = Int(sects[i]) ?? 0
                       label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
                      label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
                      label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
                       self.view.addSubview(label)
                       
                       print("SUCCESS?")
                       //
                       
                       
                     
                       
                       
                       
                   }
                   //Vstack
                   // coursesT.text = actual
                   //     print((actual).count)
                   
                   
               }
           }

       }

   

    
    @objc func pressed1(sender:UIButton) {
        print("d")
        sender.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 0.75)
        
    }
    
    @objc func pressed2(sender:UIButton) {print("S")
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
    }
    
    @objc func pressed(sender:UIButton)  {
        
        let date = Date()
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let thed = "\(day)-\(month)-\(year)"
        print(thed)
        let v =   sender.titleLabel?.text
        print(v!)
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
        let db = Firestore.firestore()
        
        Task {
         //   sender.isEnabled = false
          //  let t_snapshot = try await db.collection("Unistudent").whereField("co", arrayContains: v!).getDocuments()
            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v!).whereField("st", isEqualTo: thed).getDocuments()
            
          
        print(t_snapshot.documents.count)
            var studentArry = [String]()  //name
            var stateArray = [String]()
            var emailArray = [String]()
            var idArray = [String]()
            var seArray = [String]()
            for doc in t_snapshot.documents {
               let documentID = doc.documentID
                  let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
            
                print("here")
                print(snp.documents.count)
                print(snp.documents)
                
                for studentDoc in snp.documents {
                    guard let state  = studentDoc.get("State") as? String else { continue }
                    guard let email  = studentDoc.get("EmailStudent") as? String else { continue }
                    guard let name  = studentDoc.get("name") as? String else { continue }
                    guard let id = studentDoc.get("id") as? String else { continue }
                    guard let ser = studentDoc.get("SerialNum") as? String else { continue }
                    
                    print("name of student/",name)
                    print("state of student/",state)
                    print("email of student/",email)
                    print("id of student/",id)
                    print("serial N of student/",id)
    //             let name = document.get("name") as! String
    //                  let ID = document.get("studentID") as! String
    //                  let EMAIL = document.get("StudentEmail") as! String
                    studentArry.append(name)
                    stateArray.append(state)
                    emailArray.append(email)
                    idArray.append(id)
                    seArray.append(ser)
                }
                        
                
             // guard let name = snp.documents.get("name") as? String else { continue }
             
          //    let name = snp.doc.get("name") as! String
           //     let state = snp.doc.get("State") as! String
                
//                  emailArry.append(EMAIL)
                  
          //    let name = t_snapshot.course["name"] as? String??

              //  let name: String = snapshot.documents.first?.data()["name"] as! String
//
//                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
//                print("docID", documentID)
//                print(coursess.count)
                 
        
            
            }
            let Lecture = storyboard?.instantiateViewController(withIdentifier: "ManualAttViewController") as! ManualAttViewController
           // Lecture.nameStudentn = studentArry
            Lecture.nameStudent = studentArry
            Lecture.stateSt = stateArray
            Lecture.emailSt = emailArray
           // Lecture.state = stateArray
            Lecture.v = v!
            Lecture.idstudent = idArray
            Lecture.serialNumber = seArray
          //  Lecture.v = v!
//            stude.emailStudent=emailArry
      navigationController?.pushViewController(Lecture, animated: true)
          //  present(Lecture, animated: true)
        }
//        titleB2 = sender.title(for: .normal)!
//
//        section2 = String(sender.tag)
//
//
//
//        let db = Firestore.firestore()
//        db.collection("Sections").whereField("section", isEqualTo: section2).getDocuments{
//            (snapshot, error) in
//            if let error = error {
//                print("FAIL2 ")
//            }
//            else{
//                print("SUCCESS2")
//                let id = snapshot!.documents.first!.get("lecturerID") as! String
//                print(id)
//
//                db.collection("Lecturer").whereField("id", isEqualTo: id).getDocuments{
//                    (snapshot, error) in
//                    if let error = error {
//                        print("FAIL3 ")
//                    }
//                    else{
//                        print("SUCCESS 3")
//                        self.name2 = snapshot!.documents.first!.get("name") as! String
//                        self.performSegue(withIdentifier: "studen", sender: self)
//                        //3
//                        //print(name)
//
//
//                    }
//                }
//            }
//        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "studen" {
//            if let controller = segue.destination as? listAll {
//                controller.section2 = section2
//                controller.name2 = name2
//                controller.titleB2 = titleB2
//            }
//        }
//    }
    
  
}
        

