//
//  FormVC.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 09/03/1444 AH.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

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
        print( url.lastPathComponent)
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
}
