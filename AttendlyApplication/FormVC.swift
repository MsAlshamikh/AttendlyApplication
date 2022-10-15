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
import FirebaseStorage
var x = ""
class FormVC: UIViewController , UITextFieldDelegate , UITextViewDelegate , UIDocumentPickerDelegate {

    
    @IBOutlet weak var messR: UILabel!
    @IBOutlet weak var messT: UILabel!
    @IBOutlet weak var imp: UIButton!

    @IBOutlet weak var reasonText: UITextView!
    @IBOutlet weak var titleView: UITextView!
    
    @IBOutlet weak var cnacelBtn: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var SendBtn: UIButton!
    var Takesection: String = ""
    var   datePreesed: String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Takesection ??",Takesection)
        print("datePreesed ???",datePreesed)
        reasonText.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        reasonText.layer.borderWidth = 1.0
        reasonText.layer.cornerRadius = 5
        titleView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        titleView.layer.borderWidth = 1.0
        titleView.layer.cornerRadius = 5
        self.titleView.delegate = self
        self.reasonText.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        cnacelBtn.layer.borderWidth = 1
      cnacelBtn.layer.borderColor = UIColor.black.cgColor
      

        // Do any additional setup after loading the view.
    }
    func textUITextViewShouldReturn(_ textField: UITextView) -> Bool {
        textField.resignFirstResponder()
 
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func isValid() -> (Bool, String, String) {
        messT.isHidden = true   // not show
        messR.isHidden = true
        
      
        guard let res = reasonText.text, !res.isEmpty else {
            messR.isHidden = false
            messR.text = "Can not be empty!"
            reasonText.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return (false, "", "")
        }
        guard let tit = titleView.text?.trimmingCharacters(in: .whitespaces).lowercased() , !tit.isEmpty else {
            messT.isHidden = false
            messT.text = "Can not be empty!"
            titleView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            messR.isHidden = false
            return (false, "", "")
        }
        guard let tit = titleView.text?.trimmingCharacters(in: .whitespaces).lowercased() , !tit.isEmpty, let res = reasonText.text?.trimmingCharacters(in: .whitespaces).lowercased(), !res.isEmpty
        else {
            messT.isHidden = false
            messT.text = "Can not be empty!"
            titleView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            messR.isHidden = false
            messR.text = "Can not be empty!"
            reasonText.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return (false, "", "")
        }
        
        
        
        return (true, tit, res)
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
  
    @IBAction func sendPressed(_ sender: Any) {
        let res = isValid()
        if res.0 == false {
            return
        }
    //   code
        let title = res.1
        let reason = res.2
        let db = Firestore.firestore()
        Task {
         
            guard let sectionDocID = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: Takesection).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else { return }

            guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo:  Global.shared.useremailshare).getDocuments().documents.first?.documentID else { return }

            try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
                            "Title": title,
                            "reason": reason ,
                            "file": ""  ,
                            "FormState": "Pending" ,
                        "State":"waiting"
                           
                
                        ],merge: true) { err in
                            if let err = err {
                                print("Error adding Lecturer  : \(err)")
                            } else {
                                print("Lecturer added sucsseful ")
                            }
                        }


        //EmailStudent
            
            
        } //task
        
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to send the form?", preferredStyle: .alert)
         // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap") }))

         
        // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
      
    }
    @IBAction func cancelPressed(_ sender: Any) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel ", preferredStyle: .alert)
         // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
            
          })
         //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap") }))

         
        // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
        
    }
    


        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
           
                
            // Create a root reference
         let storageRef = Storage.storage().reference()

            // Create a reference to "mountains.jpg"
          //  let mountainsRef = storageRef.child(UUID().uuidString ".pdf")

            // Create a reference to 'images/mountains.jpg'
            let mountainImagesRef = storageRef.child("images/\(UUID().uuidString).pdf")

            // While the file names are the same, the references point to different files
            //mountainsRef.name == mountainImagesRef.name            // true
            //mountainsRef.fullPath == mountainImagesRef.fullPath    // false
            // Create a root reference
            // Data in memory
            let data = Data()

            // Create a reference to the file you want to upload
            let riversRef = storageRef.child("images/\(UUID().uuidString).pdf")

            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
              }
              // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
              riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
              }
            }
            // Create storage reference
          let mountainsRef = storageRef.child("images/\(UUID().uuidString).pdf")

            // Create file metadata including the content type
            let metadata = StorageMetadata()
        //    metadata.contentType ="image/jpeg"

            // Upload data and metadata
            mountainsRef.putData(data, metadata: metadata)

            // Upload file and metadata
            let localFile = URL(string: "Doc33.pdf")!
            mountainsRef.putFile(from: localFile, metadata: metadata)
             
            dismiss(animated: true)
          

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        imp.backgroundColor = UIColor( white: 0xD6D6D6, alpha: 0.5)
       
    } //user closes the picker without making any selection
 
        imp.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
}
   /* func spl(x:String) {
        var str = x
        var result = str.split(separator: "-")
        result.removeFirst()
        var str_arr: [String] = result.map { String($0) }
         let tag = str_arr[0]
        
        let db = Firestore.firestore()
        
        Task {
           
            let snapshot = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: Global.shared.useremailshare).getDocuments()
            let sections: [String] = snapshot.documents.first?.data()["Sections"] as! [String]
           var d = "30-9-2022"
           // let name: String = snapshot.documents.first?.data()["name"] as! String
            let email:String = snapshot.documents.first?.data()["StudentEmail"] as! String
            
            for section in sections {
                print(section, str_arr)
                if !str_arr.contains(section) { continue }
              //  print(thed)
                let t_snapshot = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: section).whereField("st", isEqualTo: d).whereField("nameC", isEqualTo: "SWE381").getDocuments() //startDate
                
                let courseName = t_snapshot.documents.first?.data()["courseN"] as! String

                print("$$$$$$$$$$$$$")
                print(t_snapshot.documents.count)
               
                
              
            

                guard let documentID = t_snapshot.documents.first?.documentID else { continue }
                print("docID", documentID)

                
                let exist = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                
               
                guard let state  = exist.documents.first?.get("State") as? String else { continue }
                print("state/ +++++++++++++++ ",state)
                
                if (state == "absent" ){
                    
                   
                }
                
                else {
                
                var flag = ""
               
 
               
                
                
                let info =  db.collection("studentsByCourse").document(documentID)
                guard let student_id = try await info.collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments().documents.first?.documentID else { continue }
                
                try await info.collection("students").document(student_id).setData(["State": flag], merge: true)
                
            
                 
          
           
            
            // Create new Alert
          
          
        } // else
        }//loop
        }//task
    }// split
    */

  

/* {
 
 let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: "SWE381").getDocuments()

//   let st = t_snapshot.documents.first?.data()["st"] as! String
 
//     print("st is :" , st)
 for doc in t_snapshot.documents {
     let documentID = doc.documentID
     
     let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
     print(snp.documents.count)
 //      let st = t_snapshot.documents.first?.data()["st"] as! String
     
     guard let st  = doc.get("st") as? String else { continue }

     print("st is :" , st)
     for studentDoc in snp.documents {
         
         
         guard let state  = studentDoc.get("State") as? String else { continue }

         print("state of student/",state)
         
         guard let time  = studentDoc.get("time") as? String else { continue }

         print("time of student/",time)
         
         
         stateAll.append(state)
         dateAll.append(st)
  
         self.tableView.reloadData()
     }
     
     
 }
 
 
 
}*/

//  datePreesed

