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
import PDFKit

var x = ""
class FormVC: UIViewController , UITextFieldDelegate , UITextViewDelegate , UIDocumentPickerDelegate {
    
    @IBOutlet weak var nameSection: UILabel!
    
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
    var fileURL: URL?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Excuse Form"
        
        
        
//        self.navigationItem.hidesBackButton = YES;
//            UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
//            self.navigationItem.leftBarButtonItem = newBackButton;‏
        
        
        
        nameSection.text = Takesection
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
       // self.tabBarController?.tabBar.isHidden = true
        cnacelBtn.layer.borderWidth = 1
       cnacelBtn.layer.borderColor = UIColor.black.cgColor
        cnacelBtn.layer.cornerRadius = 10.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(_:)))
            tap.numberOfTapsRequired = 2
        reasonText.tag = 2
       reasonText.isUserInteractionEnabled = true
        titleView.tag = 1
        titleView.isUserInteractionEnabled = true
    }
    //touch out
    @objc func doubleTapped(_ recognizer: UITapGestureRecognizer) {

            print(recognizer.view!.tag)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textViewDidChange(_ textView: UITextView) {
        if(titleView.text?.count ?? 0 > 0 ){
            messT.text = ""
            messT.isHidden = true
            titleView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        }
    
        else{
            
            if( textView.resignFirstResponder() == true){
            titleView.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
            messT.isHidden = false
                messT.text = "This field is required"}
        }
        if(reasonText.text?.count ?? 0 > 0 ){
            messR.text = ""
            messR.isHidden = true
            reasonText.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
            textView.becomeFirstResponder()
        }
    
        else{
            if( reasonText.resignFirstResponder() == true){
            messR.text = "This field is required"
            messR.isHidden = false
           // messR.text = "Can not be empty!"
            reasonText.layer.borderColor = #colorLiteral(red: 0.7241919041, green: 0.002930019982, blue: 0.06262063235, alpha: 1)
            }
        }
        
    }
    func isValid() -> (Bool, String?, String?) {
        messT.isHidden = true   // not show
      messR.isHidden = true
       let res = reasonText.text
        let tit = titleView.text
        print("is valid")

        let file = fileURL?.absoluteString
       let c =  fileURL?.lastPathComponent
     //   print(c?.isEmpty)
        print(c)

        var vb = file?.count
     
        if let res = reasonText.text?.trimmingCharacters(in: .whitespaces), let t = titleView.text?.trimmingCharacters(in: .whitespaces) , res.isEmpty && t.isEmpty
         {
            
            messT.isHidden = false
            messT.text = "This field is required"
            titleView.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
            messR.isHidden = false
            messR.text = "This field is required"
            reasonText.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
        

            return (false, "", "")
        }
        if let res = reasonText.text?.trimmingCharacters(in: .whitespaces) , res.isEmpty
         {
            
          
            messR.isHidden = false
            messR.text = "This field is required"
            reasonText.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
         

            return (false, "", "")
        }
        if  let t = titleView.text ,  t.isEmpty
         {
            
            messT.isHidden = false
            messT.text = "This field is required"
            titleView.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
           
            label.text = "please choose a file!"
            label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

            return (false, "", "")
        }
        if let res = reasonText.text?.trimmingCharacters(in: .whitespaces), res.isEmpty  {
            messR.isHidden = false
            messR.text = "This field is required"
            reasonText.layer.borderColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
            return (false, "", "")
        }
        if let tit = titleView.text?.trimmingCharacters(in: .whitespaces) , tit.isEmpty  {
            messT.isHidden = false
            messT.text = "This field is required!"
            titleView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            messR.isHidden = false
            return (false, "", "")
        }
        
        
        
        
        return (true, tit, res)
    }
    
   
    
    
    @IBAction func importFile(_ sender: Any) {
        
        print("before import")
        let documentPicker  = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        
        //change the type ^^^^
        documentPicker.delegate = self
        
        documentPicker.allowsMultipleSelection = false // ease of use.only one doc
        documentPicker.shouldShowFileExtensions = true
        print("after  import")
        present(documentPicker, animated: true, completion: nil)
        
        //  print("")
        //  print(documentPicker)
        
    }
    
    @IBAction func sendPressed(_ sender: Any) {

        print("send is statrt")
     SendBtn.isEnabled = false
        areYouSure()
//        let res = isValid()
//        if res.0 == false {
//        SendBtn.isEnabled = true
//            print("what is ???? ")
//            return
//
//        }
//        //   code
//        let title = res.1
//        let reason = res.2
//        let db = Firestore.firestore()
//
//        Task {
//            print("task1")
//             let url = await uploadPDF()
//                print("task2")
//            areYouSure()
//              SendBtn.isEnabled = false
//              //  print("url", url)
//
//
//            print("task3")
//            guard let sectionDocID = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: Takesection).whereField("st", isEqualTo: datePreesed).getDocuments().documents.first?.documentID else {
//       SendBtn.isEnabled = true
//                return
//            }
//            print("task4")
//            guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo:  Global.shared.useremailshare).getDocuments().documents.first?.documentID else {
//               SendBtn.isEnabled = true
//                return
//            }
//            print("task5")
//            try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
//                "Title": title,
//                "reason": reason ,
//                "file": url?.absoluteString  ,
//                "FormState": "Pending" ,
//                "have":"t"
//
//
//            ],merge: true) { err in
//                if let err = err {
//                    print("Error adding Lecturer  : \(err)")
//                } else {
//                    print("Lecturer added sucsseful ")
//
//                }
//             self.SendBtn.isEnabled = true
//            }
//
//
//            //EmailStudent
//
//
//        } //task

     
//            var dialogMessagee2 = UIAlertController(title: "Message", message: "Execution send sucssefully ", preferredStyle: .alert)
//
//            // Create OK button with action handler
//            let ok2 = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//                print("Ok button tapped")
//
//
//             })
//
//            //Add OK button to a dialog message
//            dialogMessagee.addAction(ok2)
//
//            // Present Alert to
//            self.present(dialogMessagee2, animated: true, completion: nil)
//
            
        
    }
    func areYouSure () {
    var sure = false
         
         var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to send the form?", preferredStyle: .alert)
         // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { [self] (action) in
             print("Ok button tapped")
             let res = self.isValid()
             if res.0 == false {
            // SendBtn.isEnabled = true
                 print("what is ???? ")
                 return
                 
             }
             //   code
             let title = res.1
             let reason = res.2
             let db = Firestore.firestore()
         
             Task {
                 print("task1")
                 let url = await self.uploadPDF()
                     print("task2")
               //  areYouSure()
                  // SendBtn.isEnabled = false
                   //  print("url", url)
                    
                 if (url == nil){
                     print("inside task with print url" , url)
                     return
                 }
                 print("task3")
                 guard let sectionDocID = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: Takesection).whereField("st", isEqualTo: self.datePreesed).getDocuments().documents.first?.documentID else {
           // SendBtn.isEnabled = true
                     return
                 }
                 print("task4")
                 guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo:  Global.shared.useremailshare).getDocuments().documents.first?.documentID else {
                    //SendBtn.isEnabled = true
                     return
                 }
                 print("task5")
                 try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData([
                     "Title": title,
                     "reason": reason ,
                     "file": url?.absoluteString  ,
                     "FormState": "Pending" ,
                     "have":"t"
                    
                     
                 ],merge: true) { err in
                     if let err = err {
                         print("Error adding Lecturer  : \(err)")
                     } else {
                         
                         var dialogMessagee2 = UIAlertController(title: "Message", message: "Excuse sent successfully ", preferredStyle: .alert)
                         // Create OK button with action handler
                         
                        
                         let ok2 = UIAlertAction(title: "OK", style: .default, handler: { (action)  in
                             print("Ok button tapped")
                             self.navigationController?.popViewController(animated: true)
                             
//                             let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                             let vc = storyboard.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
//                             self.navigationController?.pushViewController(vc, animated: true)
                          })
             
                         dialogMessagee2.addAction(ok2)
             
                         // Present Alert to
                         self.present(dialogMessagee2, animated: true, completion: nil)
                         
                         print("Lecturer added sucsseful ")
                       
                     }
                 // self.SendBtn.isEnabled = true
                 }
             } //task

//                        var dialogMessagee2 = UIAlertController(title: "Message", message: "Execution send sucssefully ", preferredStyle: .alert)
//                        // Create OK button with action handler
//                        let ok2 = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//                            print("Ok button tapped")
//                         })
//
//                        dialogMessagee2.addAction(ok2)
//
//                        // Present Alert to
//                        self.present(dialogMessagee2, animated: true, completion: nil)
            
          //     self.performSegue(withIdentifier: "form", sender: self)

         })
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
        // self.performSegue(withIdentifier: "goto", sender: self)
       
  
         dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                               style: .cancel,
                                               handler: { _ in print("Cancel tap") })
         )

        self.SendBtn.isEnabled = true
         // Present Alert to
             
          
   
         self.present(dialogMessage, animated: true, completion: nil)
    }
    @IBAction func cancelPressed(_ sender: Any) {
        var f = false

        var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to cancel ", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action)  in
            
            self.performSegue(withIdentifier: "form", sender: self)

            f = true
            
        })
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        
        dialogMessage.addAction(UIAlertAction(title: "Cancel",
                                              style: .cancel,
                                              handler: { _ in print("Cancel tap")
            f = false
        }))
        
        
        // Present Alert to
      //  self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func uploadPDF() async -> URL? {
       
        guard let fileURL = fileURL else {
          // SendBtn.isEnabled = false
            print("fileURL",fileURL)
            label.text = "please choose a file!"
            label.textColor = #colorLiteral(red: 0.662745098, green: 0.1333333333, blue: 0.1176470588, alpha: 1)
            return nil }//here
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("files/\(UUID().uuidString).pdf")
        do {
            let _ = try await fileRef.putFileAsync(from: fileURL, metadata: nil)
            print("uploaded")
            
                   
            let url = try await fileRef.downloadURL()
            print("url", url)
            return url
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
        // Create a root reference
        print("inside doucoment ")
        fileURL = urls.first
        print("inside doucoment fileURL" , fileURL)
        imp.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        label.text = urls.first?.lastPathComponent
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var dialogMessage = UIAlertController(title: "Message", message: "file uploaded successfuly", preferredStyle: .alert)
       
               // Create OK button with action handler
               let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                   print("Ok button tapped")
                })
       
               //Add OK button to a dialog message
               dialogMessage.addAction(ok)
               // Present Alert to
               self.present(dialogMessage, animated: true, completion: nil)
        // Create new Alert
//        var dialogMessage = UIAlertController(title: "Message", message: "file uploaded successfuly", preferredStyle: .alert)
//
//        // Create OK button with action handler
//        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//            print("Ok button tapped")
//         })
//
//        //Add OK button to a dialog message
//        dialogMessage.addAction(ok)
//        // Present Alert to
//        self.present(dialogMessage, animated: true, completion: nil)
        
        // Create a reference to "mountains.jpg"
        //  let mountainsRef = storageRef.child(UUID().uuidString ".pdf")
        
        // Create a reference to 'images/mountains.jpg'
        //let mountainImagesRef = storageRef.child("images/\(UUID().uuidString).pdf")
        
        // While the file names are the same, the references point to different files
        //mountainsRef.name == mountainImagesRef.name            // true
        //mountainsRef.fullPath == mountainImagesRef.fullPath    // false
        // Create a root reference
        // Data in memory
        // let data = Data()
        
        // Create a reference to the file you want to upload
//        print("upload file")
//        let riversRef = storageRef.child("files/\(UUID().uuidString).pdf")
//
//        SendBtn.isEnabled = false
        
        
        //            let bucket = storageRef.child("file.pdf")
        //            // Upload the file to the path "images/rivers.jpg"
        //            let uploadTask = bucket.putFile(from: urls.first!, metadata: nil) { (metadata, error) in
        //                if let error = error {
        //                    print(error.localizedDescription)
        //                  return
        //                }
        //                if let metadata = metadata {
        //                    print("uploaded")
        //                    let size = metadata.size
        //                    // You can also access to download URL after upload.
        //                    riversRef.downloadURL { (url, error) in
        //                      guard let downloadURL = url else {
        //                        // Uh-oh, an error occurred!
        //                        return
        //                      }
        //                    }
        //                }
        //                // Metadata contains file metadata such as size, content-type.
        //
        //            }
        //
        //            }
        //            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
        //              guard let metadata = metadata else {
        //                // Uh-oh, an error occurred!
        //                return
        //              }
        //              // Metadata contains file metadata such as size, content-type.
        //              let size = metadata.size
        //              // You can also access to download URL after upload.
        //              riversRef.downloadURL { (url, error) in
        //                guard let downloadURL = url else {
        //                  // Uh-oh, an error occurred!
        //                  return
        //                }
        //              }
        //            }
        // Create storage reference
        //let mountainsRef = storageRef.child("images/\(UUID().uuidString).pdf")
        
        // Create file metadata including the content type
        //let metadata = StorageMetadata()
        //    metadata.contentType ="image/jpeg"
        
        // Upload data and metadata
        //mountainsRef.putData(data, metadata: metadata)
        
        // Upload file and metadata
        //            let localFile = URL(string: "Doc33.pdf")!
        //            mountainsRef.putFile(from: localFile, metadata: metadata)
        
        //dismiss(animated: true)
        
        
         //user closes the picker without making any selection
        
       
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        imp.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "please choose a file!"
        label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIKit.UIBarButtonItem(title: "", style: .plain, target: nil, action: nil )
      //  navigationItem.backBarButtonItem =
        
       
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

