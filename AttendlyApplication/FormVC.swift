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
class FormVC: UIViewController , UITextFieldDelegate , UITextViewDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var TitleTixtFeild: UITextField!
    
    @IBOutlet weak var messR: UILabel!
    @IBOutlet weak var messT: UILabel!
    @IBOutlet weak var imp: UIButton!
    @IBOutlet weak var ReasonTextFeild: UITextField!
    @IBOutlet weak var reasonText: UITextView!
    @IBOutlet weak var titleView: UITextView!
    
    @IBOutlet weak var cnacelBtn: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var SendBtn: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        reasonText.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        reasonText.layer.borderWidth = 1.0
        reasonText.layer.cornerRadius = 5
        titleView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2.0).cgColor
        titleView.layer.borderWidth = 1.0
        titleView.layer.cornerRadius = 5
        self.titleView.delegate = self
        self.reasonText.delegate = self

       
        let db = Firestore.firestore()
     

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
        Task{
        // Get a reference to the storage service using the default Firebase App
       
        // Create a storage reference from our storage service
      
        
            let documentPicker  = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //change the type ^^^^
        documentPicker.delegate = self
       
        documentPicker.allowsMultipleSelection = false // ease of use.only one doc
        documentPicker.shouldShowFileExtensions = true
        
        
 present(documentPicker, animated: true, completion: nil)
      
      //  print("")
      //  print(documentPicker)
        }
        
    }
  
    @IBAction func sendPressed(_ sender: Any) {
        let res = isValid()
        if res.0 == false {
            return
        }
    //   code
        let title = res.1
        let reason = res.2
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
    


  
            
        // Create a root reference
       /* let storageRef = Storage.storage().reference()

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
            */
       /* guard urls[0] !=  nil else {
            return
        }
        label.text = urls[0].lastPathComponent
       x = urls[0].lastPathComponent
        print( "url.absoluteString")
        print( urls[0].absoluteString)
        let storage = Storage.storage().reference()
       // let filePathURL = URL(fileURLWithPath: urls[0].absoluteString)
        let filePath = Bundle.main.path(forResource: "Doc33", ofType: "pdf")
        let filePathURL = URL(fileURLWithPath: filePath!)
        let path = "files/\(UUID().uuidString).pdf"
        let file = storage.child(path)
        
        let uploadTask = file.putFile(from: filePathURL, metadata: nil) { metadata, error in
            if metadata != nil && error == nil  {
                // error!
                let dd = Firestore.firestore()
                dd.collection("files").document().setData(["url":file])
            }
        
                    }

       // let ff = url.path
      //  label.text! += ff
          dismiss(animated: true)
        guard urls[0].startAccessingSecurityScopedResource() != nil else {
            return
        }

        defer {
            urls[0].stopAccessingSecurityScopedResource()
        }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
       imp.backgroundColor = UIColor( white: 0xD6D6D6, alpha: 0.5)
       
    } //user closes the picker without making any selection
 
          imp.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }*/
    
  
}
