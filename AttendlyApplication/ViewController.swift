
import UIKit
import FirebaseFirestore
class ViewController: UIViewController {
    
    
    let helper = NFChelper()
    //var payloadLabel: UILabel!
    
    var result = ""
    //var press =Global.shared.Pressedsection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Press to attend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 0.26, green: 0.56, blue: 0.62, alpha: 1.00)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30.0)
        button.addTarget(self, action: #selector(didTapReadNFC), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 400, width: self.view.bounds.width - 120, height: 80)
        self.view.addSubview(button)
    }
    
    
    func onNFCResult(success: Bool, msg: String) {
        DispatchQueue.main.async {
            
            if !msg.hasPrefix("First"){
                self.spl(x: msg)
                
            }
        }
    }
    
    @objc func didTapReadNFC() {
        print("didTapReadNFC")
        helper.onNFCResult = onNFCResult(success:msg:)
        helper.restartSession()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func spl(x:String) {
        var str = x
        var result = str.split(separator: "-")
        result.removeFirst()
        var str_arr: [String] = result.map { String($0) }
         let tag = str_arr[0]
        
        let db = Firestore.firestore()
        
        Task {
            let date = Date()
            let calunder = Calendar.current
            let day = calunder.component(.day , from: date)
            let month = calunder.component(.month , from: date)
            let year = calunder.component(.year , from: date)
            let currentTime = getCurrentTime()
            print(currentTime)
            let currentTimeSplit = currentTime.split(separator: ":")
           
            let timeHourct = currentTimeSplit[0]
            let timeMinct = Int(currentTimeSplit[1])
            let timeMinct2 = Int(timeMinct ?? 0)
            print("hour current")
            print(timeHourct)
            print("Mins current")
           // print(timeMinct)
            //current date
            let thed = "\(day)-\(month)-\(year) "
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
            let sections: [String] = snapshot.documents.first?.data()["Sections"] as! [String]
            let name: String = snapshot.documents.first?.data()["name"] as! String
            let email:String = snapshot.documents.first?.data()["StudentEmail"] as! String
            
            for section in sections {
                print(section, str_arr)
                if !str_arr.contains(section) { continue }
                print(thed)
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).whereField("st", isEqualTo: thed).getDocuments() //startDate
                
               // let Attend :String = t_snapshot.documents.first?.data()["Attend"] as! String //Attend for specfic student
                
             
                // check if student email already exists in
//                if await self.checkEmailExist(email: email, collection: "studentsByCourse", field: section , filed2: Attend ) {
//                    }
                
                
                let secTime = t_snapshot.documents.first?.data()["startTime"] as! String
                let secTimeEnd = t_snapshot.documents.first?.data()["endTime"] as! String
               
                let timeSplitfb = secTime.split(separator: ":")
                print(timeSplitfb)
                let timeHourfb = timeSplitfb[0]
                let timeMinfb = Int(timeSplitfb[1])
                let timeMinfb2 = Int(timeMinfb ?? 0)
                
                let EndtimeSplitfb = secTimeEnd.split(separator: ":")
                print(timeSplitfb)
                let EndtimeHourfb = EndtimeSplitfb[0]
                let EndtimeMinfb = Int(EndtimeSplitfb[1])
                let EndtimeMinfb2 = Int(EndtimeMinfb ?? 0)
                print("timeMinfb2+15" )

                var flag = ""
                var attend = false
               // print(timeMinfb) 11:45
                if ((timeHourfb == timeHourct || EndtimeHourfb == timeHourct)){ //8 == 8
                    if(timeMinct2 <= timeMinfb2) { //attended 8:15
                        flag = "attend"
                        attend = true
                    }
                    else if (timeMinct2 < timeMinfb2+20){ //late 8:30
                        flag = "late"
                        attend = true
                    }
                    else{
                        flag = "absent"
                    }
                }
                
                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                
                print("docID", documentID)
          
               // let data: [String: Any] = [
                 //   "attendance": true
               // ]
              //  let db =  Firestore.firestore()
                let info = db.collection("studentsByCourse").document(documentID )//.collection("students")
                info.updateData(["State": flag ])

                    { (err ) in
                           if let err = err {

                               print("Error adding Lecturer  : \(err)")

                       } else {
                            print("Lecturer added sucsseful ")
                         }
                     }
                // Create new Alert
                if(flag=="attend"){
                    var dialogMessage = UIAlertController(title: "Confirm", message: "You Attended Successfully", preferredStyle: .alert)
                     // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     //Add OK button to a dialog message
                    dialogMessage.addAction(ok)
                     
                    // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)
                }
                 if(flag=="late"){
                    var dialogMessage = UIAlertController(title: "Confirm", message: "Be careful You are late! but you Attended Successfully", preferredStyle: .alert)
                     // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     //Add OK button to a dialog message
                    dialogMessage.addAction(ok)
                     
                    // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)
                    
                }
                if(flag=="absent")
                {   // Create new Alert
                    var dialogMessage = UIAlertController(title: "Warning!", message: "Sorry,You have exceeded the class time!you marked as Absent ", preferredStyle: .alert)
                     // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     //Add OK button to a dialog message
                    dialogMessage.addAction(ok)
                     
                    // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)}
            }
            
            // Create new Alert
            var dialogMessage = UIAlertController(title: "Warning!", message: "Sorry,You are not regester to this class!", preferredStyle: .alert)
             // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             //Add OK button to a dialog message
            dialogMessage.addAction(ok)
             
            // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

        }
    }
    
    func getCurrentTime() -> String{

        let formater = DateFormatter()

           // let formater = DateComponents()
      //  let dateFormatter = DateFormatter()
        formater.dateFormat = "HH:mm"
          // formater.timeStyle = .short

            let dateString =  formater.string(from: Date())
        print("after formating")
print(dateString)
            return dateString

        }
    
    
//    func checkEmailExist(email: String, collection: String, field: String  ) async -> Bool {
//       // print("what??")  //filed= section     //filed2 =Attend   , filed3
//        let db = Firestore.firestore()
//        do {
//            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: "tag").whereField(email, isEqualTo:"EmailStudent")
//                //.whereField(filed2, isEqualTo: "")
//                .getDocuments()
//            print("COUNT ", snapshot.count)
//            print("not added student exist")
//            return snapshot.count != 0
//        } catch {
//            print(error.localizedDescription)
//            print("no student exist")
//            return false
//        }
//}



}

