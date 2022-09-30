//
//  TrialViewController.swift
//  AttendlyApplication
//
//  Created by Amani Aldahmash on 30/09/2022.
//

import UIKit

class TrialViewController: UIViewController {

    @IBOutlet weak var textscroll: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
scroll()
        // Do any additional setup after loading the view.
    }
    
    func  scroll(){
        for i in 0..<100 {
       let label = UIButton(frame: .init(x: self.view.frame.midX-238 , y: 333 + ( Double(i) * 90 ), width: 300, height: 60))
       label.setTitle("hi", for: .normal)
       label.titleLabel?.font = label.titleLabel?.font.withSize(30)
        label.setTitleColor(UIColor(red: 20/255, green: 108/255, blue: 120/255,alpha: 2), for: .normal)
            //textscroll.addSubview(label)
            
        //    textscroll.text = textscroll.text + "hi"
        }
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
