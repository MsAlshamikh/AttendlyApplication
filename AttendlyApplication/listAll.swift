//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit

class listAll: UIViewController {

   
    // @IBOutlet weak var courseLabel: UILabel!
   // @IBOutlet weak var sectionLabel: UILabel!
   // @IBOutlet weak var lecturerLabel: UILabel!
    
    
    @IBOutlet weak var cours: UILabel!
    
    @IBOutlet weak var lec: UILabel!
    @IBOutlet weak var sect: UILabel!
    
    
    var section2: String = ""
    var titleB2: String = ""
    var name2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var str = "heellllooooo"
//        var myMutableString = NSMutableAttributedString(string: str)
//        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:2,length:4))
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text1.append(NSAttributedString(string: name2, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
        
        //
        
        let text2 = NSMutableAttributedString()
        text2.append(NSAttributedString(string: "Section: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text2.append(NSAttributedString(string: section2, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
        
        cours.text = titleB2
   
        
        sect.attributedText = text2

        
        lec.attributedText = text1
  
        //
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

}

