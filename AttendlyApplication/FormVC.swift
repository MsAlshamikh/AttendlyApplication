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
import UniformTypeIdentifiers

var x = ""

class FormVC: UIViewController , UITextFieldDelegate , UITextViewDelegate, UIDocumentPickerDelegate , UIImagePickerControllerDelegate , UIDocumentMenuDelegate {
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
      
        
         //   let documentPicker  = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //change the type ^^^^
      //  documentPicker.delegate = self
            
       
      //  documentPicker.allowsMultipleSelection = false // ease of use.only one doc
     //   documentPicker.shouldShowFileExtensions = true
        
        
 //present(documentPicker, animated: true, completion: nil)
      
      //  print("")
      //  print(documentPicker)
            
            let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .open)
                importMenu.delegate = self
                importMenu.modalPresentationStyle = .formSheet
              present(importMenu, animated: true, completion: nil)
        }
        
    }
    func selectFiles() {
        let types = UTType.types(tag: "pdf",
                                 tagClass: UTTagClass.filenameExtension,
                                 conformingTo: nil)
        let documentPickerController = UIDocumentPickerViewController(
                forOpeningContentTypes: types)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
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
  
        
    }
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var videoUrl = "ff.pdf"
        guard let mediaInfo = info[.mediaType] else { return }
        let mediaType = "\(mediaInfo)"
        if mediaType == "public.movie" {
           // how we handle it if it's a video
           guard let videoURL = info[.mediaURL] as? NSURL else {return }
         videoUrl = videoURL.filePathURL as? NSURL // this is the only thing I changed cause this is the file we are uploading
         }
        guard let videoUrl = videoUrl else { return }
              
              let videoName = NSUUID().uuidString
              let storageRef = Storage.storage().reference().child("\(videoName).mov")
              storageRef.putFile(from: videoUrl as URL, metadata: nil) { (metaData, error) in
                   // IMPORTANT: this is where I got the error from
                  if error != nil {
                      print("error uploading video: \(error!.localizedDescription)")
                  } else {
                      // successfully uploaded the video
                      storageRef.downloadURL { (url, error) in
                          if error != nil {
                              print("error downloading uploaded videos Url: \(error!.localizedDescription)")
                          } else {
                              if let downloadUrl = url {
                                  let contentType = "videoUrl" //just a var for the following func
                                  self.uploadPost(for: downloadUrl, contentType: contentType) // func that uploads the url to the database
                              }
                          }
                      }
                  }
             
  
    }
    }*/
   

        
        // Initializes the picker instance for selecting a document in a remote location. The valid modes are Import and Open.
      
        
        /// Initializes the picker instance for selecting a document in a remote location.
        /// @param asCopy if true, the picker will give you access to a local copy of the document, otherwise you will have access to the original document
      

        
        /// Initializes the picker instance for selecting a document in a remote location, giving you access to the original document.
     

        
     //   public init?(coder: NSCoder)

        
        // Initializes the picker for exporting a local file to an external location. The valid modes are Export and Move. The new location will be returned using `didPickDocumentAtURL:`.
       
        
        // Initializes the picker for exporting local files to an external location. The valid modes are Export and Move. The new locations will be returned using `didPickDocumentAtURLs:`.
       

        
        /// Initializes the picker for exporting local documents to an external location. The new locations will be returned using `didPickDocumentAtURLs:`.
        /// @param asCopy if true, a copy will be exported to the destination, otherwise the original document will be moved to the destination. For performance reasons and to avoid copies, we recommend you set `asCopy` to false.
       // @available(iOS 14.0, *)
      //  public init(forExporting urls: [URL], asCopy: Bool)

        
        /// Initializes the picker for exporting local documents to an external location. The new locations will be returned using `didPickDocumentAtURLs:`. The original document will be moved to the destination.
     //   @available(iOS 14.0, *)
      //  public convenience init(forExporting urls: [URL])

        
     //   weak open var delegate: UIDocumentPickerDelegate?

       

     //   @available(iOS 11.0, *)
     //   open var allowsMultipleSelection: Bool

        
        /// Force the display of supported file extensions (default: NO).
       // @available(iOS 13.0, *)
        //open var shouldShowFileExtensions: Bool

        
        /// Picker will try to display this URL when presented
      //  @available(iOS 13.0, *)
      //  open var directoryURL: URL?
    


    /*func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt url: [URL]){
        let uuid = UUID().uuidString
               // Create a root reference
               let storage = Storage.storage()
               
               // Create a storage reference from our storage service
               let storageRef = storage.reference()
               
               // Data in memory
               let data = Data()
        

               // Create a reference to the file you want to upload
        let pdfRef = storageRef.child("docRequest/" + uuid + ".pdf")

               // Upload the file to the path "images/rivers.jpg"
        let uploadTask = pdfRef.putData(data, metadata: nil) { (metadata, error) in
                 guard let metadata = metadata else {
                   // Uh-oh, an error occurred!
                   print(error)
                   return
                 }
                 // Metadata contains file metadata such as size, content-type.
                 let size = metadata.size
            metadata.contentType = "application/pdf"
                 // You can also access to download URL after upload.
                 pdfRef.downloadURL { (url, error) in
                   guard let downloadURL = url else {
                     // Uh-oh, an error occurred!
                       print(error)
                     return
                   }
                 }
             
  
    }
        
   */
       
        // Create a root reference
     /*let storageRef = Storage.storage().reference()

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
        mountainsRef.putFile(from: localFile, metadata: metadata)*/
         
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
    
 func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
     
    guard let myURL = urls.first else {
        return
    }
     let url = urls.first?.resourceBytes
    print("import result : \(myURL)")
     print("urls.first?.resourceBytes \(urls.first?.resourceBytes)")
     print("lastPathComponent \(urls.first?.lastPathComponent)")
     print("absoluteURL \(urls.first?.absoluteURL)")
     //print("absoluteURL \(urls.first?.n)")
     let FIRStorage = Storage.storage()

     // reference of the storage
     let storageRef = FIRStorage.reference()

     // You have to get the file URL from disk or anywhere

     let filePath = Bundle.main.path(forResource: "mypdf", ofType: "pdf")
     let filePathURL = URL(fileURLWithPath: filePath!)

  
     let fileRef = storageRef.child("images/\(UUID().uuidString).pdf")

     // from this you cant upload the file on fileRef path
     let uploadTask = fileRef.putFile(from: filePathURL, metadata: nil) { metadata, error in
         guard let metadata = metadata else {
             // error!
             return
         }
         let metadataSize = metadata.size
         // get the download url of this file
         fileRef.downloadURL { (url, error) in
             guard let downloadURL = url else {
                 // error!
                 return
             }
         }
     }
}
  
func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
    documentPicker.delegate = self
    present(documentPicker, animated: true, completion: nil)
}
    }
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {

        let storageRef = Storage.storage().reference()
       
                  //  completion((metadata?.downloadURL()?.absoluteString)!))
                    // your uploaded photo url.

        // Create a reference to the file you want to download
        let pdfRef = storageRef.child("files/file.pdf")

        // Create local filesystem URL
        let localURL = URL(string: "path/to/local/file.pdf")!

        // Download to the local filesystem
        let downloadTask = pdfRef.write(toFile: localURL) { url, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Local file URL for "path/to/local/file.pdf" is returned
          }
        }
             
            
         
}
    

