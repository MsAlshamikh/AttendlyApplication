//
//  FormVC.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 09/03/1444 AH.
//

import UIKit
import MobileCoreServices
class FormVC: UIViewController {

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
        let documentPicker  =  UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        //change the type ^^^^
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // ease of use.only one doc
     present(documentPicker, animated: true, completion: nil)
        
        
    }
 
}
extension FormVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectFileURL = urls.first else{
            return
        }
    }
}
