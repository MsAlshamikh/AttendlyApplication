
import UIKit
import CoreServices
import MobileCoreServices
class ViewController2: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPresed() {
        open(fileTypes: [kUTTypeItem as String])
    }
    
    @IBAction func pdfOuttonPresed() {
        open(fileTypes: [kUTTypePDF as String])
    }
    
    @IBAction func imageButtonPresed() {
        open(fileTypes: [kUTTypeImage as String])
    }
    
    @IBAction func docButtonPresed() {
        open(fileTypes: ["com.microsoft.word.doc", "org.openxmlformats.wordprocessingml.document"])
    }
    
    func open(fileTypes: [String]) {
        let docVC = UIDocumentBrowserViewController(forOpeningFilesWithContentTypes: fileTypes)
        docVC.allowsDocumentCreation = false
        docVC.allowsPickingMultipleItems = false
        docVC.delegate = self
        self.show(docVC, sender: self)
    }

}

extension ViewController2: UIDocumentBrowserViewControllerDelegate {

    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        controller.dismiss(animated: true) {
            self.label.text = documentURLs.first?.absoluteString ?? "none"
        }
    }
}
