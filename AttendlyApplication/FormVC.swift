//
//  FormVC.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 09/03/1444 AH.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import FirebaseFirestore
var x = ""
class FormVC: UIViewController {

    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//
    @IBAction func openFile(_ sender: Any) {
        if let url = Bundle.main.url(forResource: x, withExtension: "pdf"){
            let webView = UIWebView (frame: self.view.frame)
            let urlr = URLRequest(url: url)
            webView.loadRequest(urlr as URLRequest)
            self.view.addSubview(webView)
        }
        
    }
    
    @IBAction func importFile(_ sender: Any) {
        let documentPicker  = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png, .pdf])
        //change the type ^^^^
        documentPicker.delegate = self
       
        documentPicker.allowsMultipleSelection = false // ease of use.only one doc
        documentPicker.shouldShowFileExtensions = true
        
 present(documentPicker, animated: true, completion: nil)
      
      //  print("")
      //  print(documentPicker)
        
        
    }
 
}
extension FormVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        label.text = url.lastPathComponent
       x = url.lastPathComponent
        print( url.lastPathComponent)
       // let ff = url.path
      //  label.text! += ff
        dismiss(animated: true)
        guard url.startAccessingSecurityScopedResource() != nil else {
            return
        }

        defer {
            url.stopAccessingSecurityScopedResource()
        }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {

    } //user closes the picker without making any selection
 
   
    }
    func spl(x:String) {
        var str = x
        var result = str.split(separator: "-")
        result.removeFirst()
        var str_arr: [String] = result.map { String($0) }
         let tag = str_arr[0]
        
        let db = Firestore.firestore()
        
        Task {
           
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
            let sections: [String] = snapshot.documents.first?.data()["Sections"] as! [String]
           // let name: String = snapshot.documents.first?.data()["name"] as! String
            let email:String = snapshot.documents.first?.data()["StudentEmail"] as! String
            
            for section in sections {
                print(section, str_arr)
                if !str_arr.contains(section) { continue }
              //  print(thed)
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).whereField("st", isEqualTo: thed).getDocuments() //startDate
                
                let courseName = t_snapshot.documents.first?.data()["courseN"] as! String

                print("$$$$$$$$$$$$$")
                print(t_snapshot.documents.count)
               
                
              
            

                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("docID", documentID)

                
                let exist = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                
               
                guard let state  = exist.documents.first?.get("State") as? String else { continue }
                print("state/ +++++++++++++++ ",state)
                
                if (state == "attend" || state == "late"){
                    
                    var dialogMessage = UIAlertController(title: "Confirm", message: "You are already Attended Successfully to : \(courseName) don't try again ! ", preferredStyle: .alert)
                     // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     //Add OK button to a dialog message
                    dialogMessage.addAction(ok)
                     
                    // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)
                }
                
                else {
                
                var flag = ""
                var attend = false
                if ((timeHourfb == timeHourct || EndtimeHourfb == timeHourct)){ //8:00 == 8:00
                    if(timeMinct2 <= timeMinfb2+15) { //attended 8:00 - 8:15
                        flag = "attend"
                        attend = true
                        print("SSSS attend")
                    }
                    else if (timeMinct2 <= timeMinfb2+16 || timeMinct2 <= timeMinfb2+30){ //late 8:30
                        flag = "late"
                        attend = true
                    }
                    else{
                        flag = "absent"
                    }
                }
 
               
                
                
                let info =  db.collection("studentsByCourse").document(documentID)
                guard let student_id = try await info.collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments().documents.first?.documentID else { continue }
                
                try await info.collection("students").document(student_id).setData(["State": flag], merge: true)
                
                // Create new Alert
                if(flag=="attend"){
                    var dialogMessage = UIAlertController(title: "Confirm", message: "You Attended Successfully to : \(courseName)", preferredStyle: .alert)
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
                     self.present(dialogMessage, animated: true, completion: nil)
                    
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

          
        } // else
        }//loop
        }//task
    }// split

    
    
    
}
