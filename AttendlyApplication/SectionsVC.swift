//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class SectionsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
  
    @IBOutlet weak var tablekeView: UITableView!
    
    var Sectionss: String = ""
   var coursess: String = ""
    
    var actual = [String]()
    var  fullNameCourse = [String]()
    let imageF = [UIImage(named: "b1"),UIImage(named: "b2"),UIImage(named: "b2")]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tablekeView.delegate = self
        tablekeView.dataSource = self
        tablekeView.estimatedRowHeight = 50
        tablekeView.rowHeight = 80
        
        
     //   get()
        let db = Firestore.firestore()
        db.collection("Lectures").whereField("EmailLectures", isEqualTo: Global.shared.useremailshare ).getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                print("SUCCESS??")
                self.actual = snapshot!.documents.first!.get("coursess") as! [String]
                self.fullNameCourse = snapshot!.documents.first!.get("fullNameCourse") as! [String]
                print("section:", self.actual)
                print("fullNameCourse:", self.fullNameCourse)
                self.tablekeView.reloadData()
    }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("here",self.actual)
        
         return actual.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("s")
            let my = tableView.dequeueReusableCell(withIdentifier: "cellnew") as! SectionController
            
       my.namesection.text = actual[indexPath.row]
        
     

       //  my.courseName.image = imageF[indexPath.row]
        my.courseName.image = UIImage(named: "books" )


        my.detilasname.text = fullNameCourse[indexPath.row]
            return my
     
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! SectionController   // THE SOLUTION
        let v = currentCell.namesection!.text!
        print("is preeesed", v)
        
        
        //start
        let db = Firestore.firestore()
        
       Task {
          
           let t_snapshot = try await db.collection("Unistudent").whereField("co", arrayContains: v).getDocuments()
            var studentArry = [String]()
            var emailArry = [String]()
            var studentID = [String]()
            var perecmtageArrya = [String]()

              for document in t_snapshot.documents {
               // print(course)
                print("here")
             let name = document.get("name") as! String
                  let ID = document.get("studentID") as! String
                  let EMAIL = document.get("StudentEmail") as! String

                  studentArry.append(name)
                  studentID.append(ID)
                  emailArry.append(EMAIL)

                  var numsec = v.split(separator: "-")[1]

                  let shot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: EMAIL).getDocuments()
              guard let documentID = shot.documents.first?.documentID else { return }

                  var abbsencest = shot.documents.first!.get("abbsencest") as! [String: Int]
                  var sectionH = shot.documents.first!.get("sectionH") as! [String: Int]
                  var percentage = shot.documents.first!.get("percentage") as! [String: Int]

                  print("abbsencest",abbsencest)
                  var sherdabbsencest = 0
                  var sheredsectionH = 0
                  var sheredpercentage = 0
                //  for valueAbb in abbsencest {
                  for (key,value) in abbsencest {
                      print("\(key): \(value)")
                      var sectionNumber = key
                      var abbsentNumber = value
                      print("sectionNumber",sectionNumber)
                      print("abbsentNumber",abbsentNumber)

                      if( sectionNumber == numsec ){
                         print(" just for section that was perssed abbsence", abbsentNumber)
                          sherdabbsencest = abbsentNumber
                      }

                  }
                  for (key,value) in sectionH {
                      print("\(key): \(value)")
                      var sectionNumber2 = key
                      var abbsentNumber2 = value
                      print("sectionNumber2",sectionNumber2)
                      print("abbsentNumber2",abbsentNumber2)

                      if( sectionNumber2 == numsec ){
                         print(" just for section that was perssed abbsence", abbsentNumber2)
                          sheredsectionH = abbsentNumber2
                       // perecmtageArrya.append( abbsentNumber
                      }

                  }
                  for (key,value) in percentage {
                      print("\(key): \(value)")
                      var sectionNumber3 = key
                      var abbsentNumber3 = value
                      print("sectionNumber2",sectionNumber3)
                      print("abbsentNumber2",abbsentNumber3)

                    if( sectionNumber3 == numsec ){
                         print(" just for section that was perssed abbsence", abbsentNumber3)
                       // perecmtageArrya.append( abbsentNumber )
                        sheredpercentage = abbsentNumber3

                      }
                  }
                  print(" sherdabbsencest", sherdabbsencest)
                  print("sheredpercentage", sheredpercentage)
                  print(" sheredsectionH", sheredsectionH)

                  //perecmtageArrya.append( abbsentNumber )

                  var step1 = Double(sheredsectionH ) * 0.25
                     var step2 = ( Double(sherdabbsencest) /  step1 ) * 100
                          var final = step2 * 0.25
                     final = Double(round(10 * final) / 10 )

                     print(final)




                let st = String(final)
                perecmtageArrya.append(st)
          //    let name = t_snapshot.course["name"] as? String??

              //  let name: String = snapshot.documents.first?.data()["name"] as! String
                  print("ID of student/",ID)
                  print("name of student/",name)
                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("docID", documentID)
                print(coursess.count)

                  // perecmtageArrya.append( abbsentNumber

            }
            let stude = storyboard?.instantiateViewController(withIdentifier: "listAll") as! listAll
            stude.nameStudent = studentArry
            stude.idStudent = studentID
           stude.v = v
            stude.emailStudent = emailArry
            stude.percentagestu = perecmtageArrya
            navigationController?.pushViewController(stude, animated: true)
          //  present(stude, animated: true)
        }

       }
        
    
//    func get(){
//           let db = Firestore.firestore()
//           db.collection("classes").whereField("LecturerEmail", isEqualTo: Global.shared.useremailshare ).getDocuments{
//               (snapshot, error) in
//               if let error = error {
//                   print("FAIL ")
//               }
//               else{
//                   print("SUCCESS??")
//                   let actual = snapshot!.documents.first!.get("coursess") as! [String]
//                   let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
//                   print(actual)
//                   for i in 0..<actual.count {
//
//                       let label = UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 340 + ( i * 90 ), width: 300, height: 60))
//                       label.setTitle(actual[i], for: .normal)
//
//
//                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
//                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
//                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
//
//                       //
//                       label.tag = Int(sects[i]) ?? 0
//                       label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
//                      label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
//                      label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
//                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
//                       self.view.addSubview(label)
//
//                       print("SUCCESS?")
//
//                   }
//
//
//               }
//           }
//
//       }
    
//    @objc func pressed1(sender:UIButton) {
//        print("d")
//        sender.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 2), for: .normal)
//        sender.backgroundColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 0.75)
//
//    }
//
//    @objc func pressed2(sender:UIButton) {print("S")
//        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
//        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
//
//    }
//
//



  
}
        
