
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
        button.backgroundColor = UIColor(red: 0.26, green: 0.56, blue: 0.62, alpha: 1.00)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30.0)
        button.addTarget(self, action: #selector(didTapReadNFC), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 400, width: self.view.bounds.width - 120, height: 80)
        self.view.addSubview(button)
        /*
         payloadLabel = UILabel(frame: button.frame.offsetBy(dx: 0, dy: 300))
         payloadLabel.numberOfLines = 10
         //payloadLabel.text = "Scan an NFC Tag" //passed
         self.view.addSubview(payloadLabel) //passed */
        //shamma
    

    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*  let actual = snapshot!.documents.first!.get("Sectionss") as! [String]
     
     for sec in actual{
     if self.result.contains(sec){
     let alertController = UIAlertController(title: "Success", message: "You are attended succssfully",preferredStyle: .alert)
     // ## should change the color ( attended = true )
     }
     else {
     let alertController = UIAlertController(title: "Fail", message: "Your attended is Fail ",preferredStyle: .alert)
     }
     }
     for i in 0..<actual.count {
     for j in 0..<result.count {
     
     /*let myString1 = "556"
      let myInt1 = Int(myString1)*/
     
     let result2 = String(result)
     //if result2[j] == actual[i]{
     
     
     break
     }
     
     }
     */
    
    
    
    
    
    
    
    func onNFCResult(success: Bool, msg: String) {
        DispatchQueue.main.async {
            // self.payloadLabel.text = "\(self.payloadLabel.text!)\n\(msg)"//Msg Holder , ==Sections of lecturer
            
            //  self.payloadLabel.text = msg //passed
            //  let x = msg//passed
            
            //print(x)//inner tag
            
            
            if !msg.hasPrefix("First"){
                self.spl(x: msg)
                
                
            }
            
        }
        
    }
    
    @objc func didTapReadNFC() {
        print("didTapReadNFC")
        //  self.payloadLabel.text = "" //passed
        helper.onNFCResult = onNFCResult(success:msg:)
        // print("*********ssssss")
        //  print(helper.onNFCResult as String)
        helper.restartSession()
    }
    //jj
    
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
            print("hour current" )
            print(timeHourct)
            print("Mins current" )
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
               // let t_snapshot = try await db.collection("studentsByCourse").wh//startDate
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
               // print("ff" )
               // print(ff)
                print("timeMinfb2+15" )
               // print(timeMinfb2+30)
              var flag = ""
               // print(timeMinfb) 11:45
                if ((timeHourfb == timeHourct || EndtimeHourfb == timeHourct)){ //8 == 8
                    if(timeMinct2 <= timeMinfb2+1) { //attended 8:15
                        flag = "attend"
                    }
                    else if (timeMinct2 < timeMinfb2+20){ //late 8:30
                        flag = "late"
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
                
             //   func storeLecturesInformation(){

             // var ref: DocumentReference? = nil

         //   guard let uid=Auth.auth().currentUser?.uid else {return }

           

                Firestore.firestore().collection("studentsByCourse").document(documentID ).collection("students").addDocument(data: [

                         "EmailStudent": Global.shared.useremailshare,

                         "name": name ,

                           "date": thed,
                         "State" : flag

                        //   "sectionID":

                          //"studentID": "" ,

                   //   "time":""

               

                       ]) { err in

                           if let err = err {

                               print("Error adding Lecturer  : \(err)")

                       } else {

                            print("Lecturer added sucsseful ")

                         }

                     }

               //    }


                /*let s_snapshot = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
                guard let s_documentID = s_snapshot.documents.first?.documentID else { continue }
                print("sdocID", s_documentID)
                try await db.collection("studentsByCourse").document(documentID).collection("students").document(s_documentID).setData(data, merge: true)*/
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
    
    
    //       for i in 1..<result.count{
    //print(result[i])
    //}
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
}




/*
 
 ######### if the student is not at the same section ##########
 
 func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
 // Check the invalidation reason from the returned error.
 if let readerError = error as? NFCReaderError {
 // Show an alert when the invalidation reason is not because of a success read
 // during a single tag read mode, or user canceled a multi-tag read mode session
 // from the UI or programmatically using the invalidate method call.
 if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
 && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
 let alertController = UIAlertController(
 title: "Session Invalidated",
 message: error.localizedDescription,
 preferredStyle: .alert
 )
 alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 DispatchQueue.main.async {
 self.present(alertController, animated: true, completion: nil)
 }
 }
 }
 
 // A new session instance is required to read new tags.
 self.session = nil
 }
 
 
 */












