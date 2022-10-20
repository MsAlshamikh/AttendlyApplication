//
//  loginController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 13/09/2022.
//

//
//  loginController.swift
//  AttendlyApp
//
//  Created by Sara Alsaleh on 13/02/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia
//var useremailshare : String = ""



class loginController: UIViewController, UITextFieldDelegate {
    private let notificationPublisher = Notificationpublisher()
    
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    
    @IBOutlet weak var validationMassege: UILabel!
    
    // @IBOutlet weak var emailError: UILabel!
    //@IBOutlet weak var passError: UILabel!
    
    @IBOutlet weak var validationMessegepass: UILabel!
    @IBOutlet weak var buttonlogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationMassege.isHidden = true
        validationMessegepass.isHidden = true
        self.emailTextfiled.delegate = self
      
        self.passwordTextfiled.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        
        self.emailTextfiled.text = "400@student.ksu.edu.sa"
        self.passwordTextfiled.text = "12345678"
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //return key
 
    
    func isValid() -> (Bool, String, String) {
        validationMassege.isHidden = true   // not show
        validationMessegepass.isHidden = true
        
        guard let email = emailTextfiled.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            validationMassege.isHidden = false
            validationMassege.text = "please enter your Email"
            return (false, "", "")
        }
        guard let password = passwordTextfiled.text, !password.isEmpty else {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "please enter your password"
            return (false, "", "")
        }
        if !isValidEmail(emailID: email) {
            validationMassege.isHidden = false
            validationMassege.text = "Please enter valid email address"
            return (false, "", "")
        }
        if password.count != 8 {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "Please enter password with 8 number "
            return (false, "", "")
        }
        
        
        return (true, email, password)
    }
        
        
        
        
        @IBAction func loginpressed(_ sender: Any) {
            //  resetForm()
            
            let validationResult = isValid()
            if validationResult.0 == false {
                return
            }
            
            let email = validationResult.1
            let password = validationResult.2
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e=error{   //if no connect with firebase
                    print("failed")
                    let alert = UIAlertController(title: "Error", message: "No exist user ,try agin", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   // print(e)
                }else{   //user Auth in firebase
                    print("sucsses")
                    
                    Task {
                        if await self.checkEmailExist(email: email, collection: "Unistudent", field: "StudentEmail") {
                            // if self.isValidEmailSttudent (emailID: email) == true  {
                            //   self.storeUserInformation()
                            // }
                            if await !self.checkEmailExist(email: email, collection: "Appstudent", field: "StudentEmail") {
                                await self.storeUserInformation(collection: "Appstudent", data: ["StudentEmail": email])
                            }
                            self.NotificationStudent()
                            print("student exists")
                      self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            Global.shared.useremailshare = email
                            print("this is the email amani: " + email)
                            print("this is the global amani: " + Global.shared.useremailshare)
                            // students view
                        }
                        else if await self.checkEmailExist(email: email, collection: "Lectures", field: "EmailLectures") {
                        
//                            if await !self.checkEmailExist(email: email, collection: "Lecturer", field: "EmailLecture") {
//                                await self.storeUserInformation(collection: "Lecturer", data: ["EmailLecture": email])
//                            }
                            self.NotificationLec()
                            self.LectureNotificationForm()
                            print("lectures exists")
                          //  if self.isValidEmailLectures(emailID: email) == true  {
                              //  self.storeLecturesInformation() }
                         //MODHI & Y
                          self.performSegue(withIdentifier: "gotoLecturers", sender: self)
                            Global.shared.useremailshare = email
                            // lectures view
                        }
                        else {
                            print("not exists")
                            let alert = UIAlertController(title: "Error", message: "No Exist User ,try agin", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            //  self.storeUserInformation()
                            // self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            // Global.shared.useremailshare = email
                            
                        } //end else
                        //Task{
                        
                        // Student notification
                        
//
//                            let db = Firestore.firestore()
//                            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
//                        guard let documentID = snapshot.documents.first?.documentID else { return }
//                        print("docID", documentID)
//                        print("you seeeeeeeeeeeee222222??????????????????")
//                        var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
//                        print("abbsencest",abbsencest)
//                      //  for valueAbb in abbsencest {
//                        for (key,value) in abbsencest {
//                            print("\(key): \(value)")
//                            var sectionNumber = key
//                            var abbsentNumber = value
//                            print("sectionNumber",sectionNumber)
//                            print("abbsentNumber",abbsentNumber)
//
//                            let snapshot = try await db.collection("Sections").whereField("section", isEqualTo: sectionNumber).getDocuments()
//                            guard let coursN = snapshot.documents.first?.get("courseName") as? String else { continue }
//                            print("corsN",coursN)
//                            if(abbsentNumber >= 10 ){
//                                self.notificationPublisher.sendNotification(title: "Warning", subtitle: "You exceeded the allowed limit", body: "the section is :\(sectionNumber) in course name \(coursN)", badge: 1, dleayInterval: nil)
//                            }
//                            else{
//                                print("no notification")
//                            }
//
//                        }
     
                        
                        // Adviser notification
                        
//
//                       let db2 = Firestore.firestore()
//                       let A_snapshot = try await db2.collection("Lectures").whereField("EmailLectures", isEqualTo: Global.shared.useremailshare).getDocuments()
//                        guard let documentID = A_snapshot.documents.first?.documentID else { return }
//                        print("docID",documentID)
//                        print("I'm HEEEEERRRRREEEE !!!!!!!!!!!!!")
//                        var stuAdv = A_snapshot.documents.first!.get("AllstudentID") as! [String]
//                        print("stuAdv",stuAdv)
//
//                        for stuIDs in stuAdv{
//
//                            let s_snapshot = try await db2.collection("Unistudent").whereField("studentID", isEqualTo: stuIDs).getDocuments()
//                            print("stuIDs",stuIDs)
//
//                            var stuAbbsence = s_snapshot.documents.first!.get("abbsencest") as! [String: Int]
//                            print("stuAbbsence",stuAbbsence)
//
//                            for (key,value) in stuAbbsence {
//                                print("\(key): \(value)")
//                                var sectionNumber = key
//                                var abbsentNumber = value
//                                print("sectionNumber",sectionNumber)
//                                print("abbsentNumber",abbsentNumber)
//
//                                let snapshot = try await db.collection("Sections").whereField("section", isEqualTo: sectionNumber).getDocuments()
//                                guard let coursN = snapshot.documents.first?.get("courseName") as? String else { continue }
//                                print("corsN",coursN)
//                                if(abbsentNumber >= 10 ){
//                                    self.notificationPublisher.sendNotification(title: "Warning", subtitle: "\(stuIDs) exceeded the allowed limit", body: "in course:\(coursN) section:\(sectionNumber)", badge: 1, dleayInterval: nil)
//                                }
//                                else{
//                                    print("no notification")
//                                }
//
//                            }// iner for
//
//                        }// Outer for

                        // end of Advisor notification
                        
                        
                    }  //end tak
                } //end elsee
                
                    

            } //end sign in
        }   //end loginpressed
    
    //
    
    func NotificationStudent() {
        
        Task{
            
            let db = Firestore.firestore()
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
        guard let documentID = snapshot.documents.first?.documentID else { return }
        print("docID", documentID)
        print("you seeeeeeeeeeeee222222??????????????????")
        var abbsencest = snapshot.documents.first!.get("abbsencest") as! [String: Int]
        print("abbsencest",abbsencest)
      //  for valueAbb in abbsencest {
        for (key,value) in abbsencest {
            print("\(key): \(value)")
            var sectionNumber = key
            var abbsentNumber = value
            print("sectionNumber",sectionNumber)
            print("abbsentNumber",abbsentNumber)
         
            let snapshot = try await db.collection("Sections").whereField("section", isEqualTo: sectionNumber).getDocuments()
            guard let coursN = snapshot.documents.first?.get("courseName") as? String else { continue }
            print("corsN",coursN)
            if(abbsentNumber >= 10 ){
                self.notificationPublisher.sendNotification(title: "Warning", subtitle: "", body: "You exceeded the allowed limit in course:\(coursN) section:\(sectionNumber)", badge: 1, dleayInterval: nil)
            }
            else{
                print("no notification")
            }
            
        }// end loop
        }// end task
        
    }
    
    
    func NotificationLec() {
        
        Task{
            
                                   let db2 = Firestore.firestore()
                                   let A_snapshot = try await db2.collection("Lectures").whereField("EmailLectures", isEqualTo: Global.shared.useremailshare).getDocuments()
                                    guard let documentID = A_snapshot.documents.first?.documentID else { return }
                                    print("docID",documentID)
                                    print("I'm HEEEEERRRRREEEE !!!!!!!!!!!!!")
                                    var stuAdv = A_snapshot.documents.first!.get("AllstudentID") as! [String]
                                    print("stuAdv",stuAdv)
            
                                    for stuIDs in stuAdv{
            
                                        let s_snapshot = try await db2.collection("Unistudent").whereField("studentID", isEqualTo: stuIDs).getDocuments()
                                        print("stuIDs",stuIDs)
            
                                        let StudName = s_snapshot.documents.first!.get("Fullname") as! String
                                        
                                        var stuAbbsence = s_snapshot.documents.first!.get("abbsencest") as! [String: Int]
                                        print("stuAbbsence",stuAbbsence)
            
                                        
                                        for (key,value) in stuAbbsence {
                                            print("\(key): \(value)")
                                            var sectionNumber = key
                                            var abbsentNumber = value
                                            print("sectionNumber",sectionNumber)
                                            print("abbsentNumber",abbsentNumber)
            
                                            let snapshot = try await db2.collection("Sections").whereField("section", isEqualTo: sectionNumber).getDocuments()
                                            guard let coursN = snapshot.documents.first?.get("courseName") as? String else { continue }
                                            print("corsN",coursN)
                                            if(abbsentNumber >= 10 ){
                                                self.notificationPublisher.sendNotification(title: "Warning", subtitle: "", body: "\(StudName) has exceeded the allowed limit in course:\(coursN)", badge: 1, dleayInterval: nil)
                                            }
                                            else{
                                                print("no notification")
                                            }
            
                                        }// iner for
            
                                    }// Outer for
        }// end task
        
}// end func
    
    
    func LectureNotificationForm(){

       // var Stuhave : String = "t" // student have upload a form

        Task{

            let db2 = Firestore.firestore()
            let snapshot = try await db2.collection("studentsByCourse").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()

                     for doc in snapshot.documents {
                     let documentID = doc.documentID

                     let snp = try await db2.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
//                             .whereField("have", isEqualTo: Stuhave).getDocuments()
                         print(snp.documents.count)
                             
                         let HaveForm = snp.documents.first?.get("have") as! String
                         let StudName = snp.documents.first!.get("name") as! String
                         let CourseName = snapshot.documents.first!.get("courseN") as! String

                         
                         if(HaveForm == "t" ){
                             self.notificationPublisher.sendNotification(title: "Absence Excuse", subtitle: "", body: " \(StudName) has sent an absence excuse in course (\(CourseName)) ", badge: 1, dleayInterval: nil)
                         }
                         else{
                             print("no notification")
                         }
                         
                         
//                         self.notificationPublisher.sendNotification(title: "Warning", subtitle: "( \(StudName) )", body: "have upload an execution for her/his abbsent ", badge: 1, dleayInterval: nil)

        }// end loop

    }// end Task
}// end func
    
    
    
    
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailSttudent(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailLectures(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    
    //end
    
    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
       // print("what??")
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
            print("COUNT ", snapshot.count)
            print("not added")
            return snapshot.count != 0
        } catch {
            print(error.localizedDescription)
            print("added")
            return false
        }
        
        //return false
    }
    
    func storeUserInformation(collection: String, data: [String: Any]) async {
        //  var ref: DocumentReference? = nil
        // guard let uid=Auth.auth().currentUser?.uid else {return }
        let db = Firestore.firestore()
        do {
            try await db.collection(collection).document().setData(data)
        } catch {
            print(error.localizedDescription)
        }
    }  //end func
    
    
    
    
//    func storeLecturesInformation(){
//        //  var ref: DocumentReference? = nil
//        // guard let uid=Auth.auth().currentUser?.uid else {return }
//
//        Firestore.firestore().collection("Lecturer").addDocument(data: [
//            "EmailStudent": emailTextfiled.text,
//            "counter": "" ,
//            "date": ""  ,
//            "sectionID": "" ,
//            "studentID": "" ,
//            "time":""
//
//        ]) { err in
//            if let err = err {
//                print("Error adding Lecturer  : \(err)")
//            } else {
//                print("Lecturer added sucsseful ")
//            }
//        }
//    }
    
    
    
    
    
    
}
