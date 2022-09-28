//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class SectionsVC: UIViewController {
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
                   let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
                   print(actual)
                   for i in 0..<actual.count {

                       let label = UIButton(frame: .init(x: self.view.frame.midX-148 , y: 280 + ( Double(i) * 90 ), width: 300, height: 60))
                       label.setTitle(actual[i], for: .normal)
                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
                      
                       //
                       label.tag = Int(sects[i]) ?? 0
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
        
        let v =   sender.titleLabel?.text
        print(v!)
        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
        
        let db = Firestore.firestore()
        
        Task {
            sender.isEnabled = false
            let t_snapshot = try await db.collection("Unistudent").whereField("co", arrayContains: v!).getDocuments()
         //   let co: [String] = t_snapshot.documents.first?.data()["co"] as! [String]
          //  print(co)
           // print(coursess.count)
         //   print(t_snapshot)
          //for course in 0..<t_snapshot.count   {
      //  for course in coursess {
            var studentArry = [String]()
            var emailArry = [String]()
            var studentID = [String]()
              for document in t_snapshot.documents {
               // print(course)
                print("here")
             let name = document.get("name") as! String
                  let ID = document.get("studentID") as! String
                  let EMAIL = document.get("StudentEmail") as! String
                  studentArry.append(name)
                  studentID.append(ID)
                  emailArry.append(EMAIL)
                  
          //    let name = t_snapshot.course["name"] as? String??

              //  let name: String = snapshot.documents.first?.data()["name"] as! String
                  print("ID of student/",ID)
                  print("name of student/",name)
                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("docID", documentID)
                print(coursess.count)
                 
        
            
            }
            let stude = storyboard?.instantiateViewController(withIdentifier: "listAll") as! listAll
            stude.nameStudent = studentArry
            stude.idStudent = studentID
            stude.v = v!
            stude.emailStudent=emailArry
            navigationController?.pushViewController(stude, animated: true)
          //  present(stude, animated: true)
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
        
