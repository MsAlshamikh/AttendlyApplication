//
//  sectionLectures.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import UIKit
import FirebaseFirestore

class sectionLectures: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    let db = Firestore.firestore()

    @IBOutlet weak var dateOF: UILabel!
    
    var Sectionss: String = ""
   var coursess: String = ""
  
//    var name2: String = ""
//    var section2: String = ""
//    var titleB2: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    var actual = [String]()
    var  fullNameCourse = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " EEEE, MMM d, yyyy‏"
      dateOF.text = dateFormatter.string(from: date)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 100
       // get()
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
                self.tableView.reloadData()
    }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("here",self.actual)
        
         return actual.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cellnew2") as! currentClassTableview
        
        my.sectionName.text = actual[indexPath.row]
    
 
        my.imagebbok.image = UIImage(named: "bb" )
        my.sectionFullName.text = fullNameCourse[indexPath.row]

        return my
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
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
//                //   let sects = snapshot!.documents.first!.get("Sectionss") as! [String]
//                   print(actual)
//                   for i in 0..<actual.count {
//
//                       let label = UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 340 + ( i * 90 ), width: 300, height: 60))
//                       label.setTitle(actual[i], for: .normal)
//                       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
//                       label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
//                       label.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
//                      
//                       //
//                    //   label.tag = Int(sects[i]) ?? 0
//                       label.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
//                      label.addTarget(self, action: #selector(self.pressed1), for: .touchDown)
//                      label.addTarget(self, action: #selector(self.pressed2), for: .touchDragExit)
//                       label.layer.cornerRadius = 0.07 * label.bounds.size.width
//                       self.view.addSubview(label)
//                       
//                       print("SUCCESS?")
//                       //
//                       
//                       
//                     
//                       
//                       
//                       
//                   }
//                   //Vstack
//                   // coursesT.text = actual
//                   //     print((actual).count)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)   {
        print(indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! currentClassTableview
        let DateFromFirebase = currentCell.sectionName!.text!
        print("is preeesed", DateFromFirebase)
        
        let date = Date()
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let CureentDay = "\(day)-\(month)-\(year)"
        print(CureentDay)
        let db = Firestore.firestore()
        Task{
            await Cureentpress(v: DateFromFirebase, thed: CureentDay) }
    }
    
    func Cureentpress(v:String ,thed:String ) async{
        print("cuu")
        do{
      let   t_snapshot =    try await self.db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments()
            
            print("t_snapshot.documents",t_snapshot.documents)
            if (t_snapshot.documents != [] ){
            let currentTime = getCurrentTime()
            print(currentTime)
            let currentTimeSplit = currentTime.split(separator: ":")
            let timeHourct = currentTimeSplit[0]
            print("hour current",timeHourct )

            let endTimeF = t_snapshot.documents.first?.data()["endTime"] as! String


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



                    studentArry.append(name)
                    stateArray.append(state)
                    emailArray.append(email)
                    idArray.append(id)
                    seArray.append(ser)


                    if(endTimeF < timeHourct && state == "pending" ){
                      //  if(state == "pending")

                        guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }

                        guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }

                        try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
                    }
                }
            }
            let Lecture = storyboard?.instantiateViewController(withIdentifier: "ManualAttViewController") as! ManualAttViewController
            Lecture.nameStudent = studentArry
            Lecture.stateSt = stateArray
            Lecture.emailSt = emailArray
            Lecture.v = v
            Lecture.idstudent = idArray
            Lecture.serialNumber = seArray
      navigationController?.pushViewController(Lecture, animated: true)
          //
   // }
    
// }
            } else{
                print("????there is no day current at now ")
                
                var refreshAlert = UIAlertController(title: "Check!", message: "There is no class at this current time", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  print("Handle Ok logic here")
                  }))
                present(refreshAlert, animated: true, completion: nil)
            }
            
        } catch let error as NSError{
            print("there is no day current at now ")
    } 
    }
    
//    @objc func pressed(sender:UIButton)  {
//
//        let date = Date()
//        let calunder = Calendar.current
//        let day = calunder.component(.day , from: date)
//        let month = calunder.component(.month , from: date)
//        let year = calunder.component(.year , from: date)
//        let thed = "\(day)-\(month)-\(year)"
//        print(thed)
//        let v =   sender.titleLabel?.text
//        print(v!)
//        sender.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), for: .normal)
//        sender.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 183/255, alpha: 0.75)
//
//        let db = Firestore.firestore()
//
//        Task {
//         //   sender.isEnabled = false
//          //  let t_snapshot = try await db.collection("Unistudent").whereField("co", arrayContains: v!).getDocuments()
//            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v!).whereField("st", isEqualTo: thed).getDocuments()
//
//            let currentTime = getCurrentTime()
//            print(currentTime)
//            let currentTimeSplit = currentTime.split(separator: ":")
//            let timeHourct = currentTimeSplit[0]
//            //let timeMinct = Int(currentTimeSplit[1])
//          //  let timeMinct2 = Int(timeMinct ?? 0)
//            print("hour current",timeHourct )
//
//            let endTimeF = t_snapshot.documents.first?.data()["endTime"] as! String
//
//
//        print(t_snapshot.documents.count)
//            var studentArry = [String]()  //name
//            var stateArray = [String]()
//            var emailArray = [String]()
//            var idArray = [String]()
//            var seArray = [String]()
//            for doc in t_snapshot.documents {
//               let documentID = doc.documentID
//                  let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
//
//
//
//                print("here")
//                print(snp.documents.count)
//                print(snp.documents)
//
//                for studentDoc in snp.documents {
//                    guard let state  = studentDoc.get("State") as? String else { continue }
//                    guard let email  = studentDoc.get("EmailStudent") as? String else { continue }
//                    guard let name  = studentDoc.get("name") as? String else { continue }
//                    guard let id = studentDoc.get("id") as? String else { continue }
//                    guard let ser = studentDoc.get("SerialNum") as? String else { continue }
//
//                    print("name of student/",name)
//                    print("state of student/",state)
//                    print("email of student/",email)
//                    print("id of student/",id)
//                    print("serial N of student/",id)
//
////
////                    guard let studentDocID = try await db.collection("studentsByCourse").document(t_snapshot).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
//
////                    if(endTimeF < timeHourct && state == "pending" ){
////                      //  if(state == "pending")
////
////                        guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                        guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                        try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
////
////
////                    }
////
//
//                    studentArry.append(name)
//                    stateArray.append(state)
//                    emailArray.append(email)
//                    idArray.append(id)
//                    seArray.append(ser)
//
//
//                    if(endTimeF < timeHourct && state == "pending" ){
//                      //  if(state == "pending")
//
//                        guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
//
//                        guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
//
//                        try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
//
//
//                    }
//
//                }
//
//
//
//
//            }
//            let Lecture = storyboard?.instantiateViewController(withIdentifier: "ManualAttViewController") as! ManualAttViewController
//           // Lecture.nameStudentn = studentArry
//            Lecture.nameStudent = studentArry
//            Lecture.stateSt = stateArray
//            Lecture.emailSt = emailArray
//           // Lecture.state = stateArray
//            Lecture.v = v!
//            Lecture.idstudent = idArray
//            Lecture.serialNumber = seArray
//          //  Lecture.v = v!
////            stude.emailStudent=emailArry
//      navigationController?.pushViewController(Lecture, animated: true)
//          //  present(Lecture, animated: true)
//        }
////
//
//    }
    
//
    
  
    
    func getCurrentTime() -> String{

        let formater = DateFormatter()

        formater.dateFormat = "HH:mm"
        let dateString =  formater.string(from: Date())
        print("after formating")
        print(dateString)
        return dateString

        }
}
        

