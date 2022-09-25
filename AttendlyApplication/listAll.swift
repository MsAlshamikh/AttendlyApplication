//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit

class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nostudent: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
   
    @IBOutlet weak var currrentsectionpressed: UILabel!
    
    var nameStudent = [String]()
    var v: String = ""
    
    // @IBOutlet weak var courseLabel: UILabel!
   // @IBOutlet weak var sectionLabel: UILabel!
   // @IBOutlet weak var lecturerLabel: UILabel!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nostudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
            nostudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
            self.nostudent.text = "No Student Registered Yet "
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        
        
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: ""
                                        ));
        text1.append(NSAttributedString(string: v));
      currrentsectionpressed.attributedText = text1
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let my = tableView.dequeueReusableCell(withIdentifier: "cell")
        my?.textLabel?.text = nameStudent[indexPath.row]
     //   my?.imageView?.image = UIImage(named: "Att")
        
        my?.imageView?.image = UIImage(named: "girl")
      //  my?.textLabel?.text! += "                 "
          
          
     //  my?.textLabel?.text! += "0 %"
       // my?.textLabel?.font = UIFont (name: my?.textLabel?.font.fontName ?? 0 , size:15)// Change the font size as per your requirement

    //my?.textLabel!.font = UIFont(name: (my?.textLabel.font.fontName)! ?? );, size:15) // Change the font size as per your requirement
        
        let line =  UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(indexPath.row))) * 90 ), width: 200, height: 26))
                    
                           //
                           line.layer.cornerRadius = 0.04 * nostudent.bounds.size.width
                           line.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 0.75)
                           let z = 17
                           
                           let after = z*10
                          
                           let perc = UIButton(frame: .init(x: Int(self.view.frame.midX)-148 , y: 333 + ( Int((Double(indexPath.row))) * 90 ), width: after, height: 26))
                           //
                           perc.layer.cornerRadius = 0.04 * nostudent.bounds.size.width
                           if (z>20)
                           {perc.backgroundColor = UIColor(red: 355/255, green: 0/255, blue: 0/255, alpha: 0.75)}
                           else if (z>15)
                           {  perc.backgroundColor = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 0.75)}
                           else if (z>10)
                           {   perc.backgroundColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 0.75)}
                           else
                           { perc.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.75)}
        //
                           let pt = UILabel(frame: .init(x: Int(self.view.frame.midX)+105 , y: 333 + ( Int((Double(indexPath.row))) * 90 ), width: 70, height: 26))
                           pt.textColor = UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2)
                           
                         
                           pt.font = UIFont(name: "systemFont", size: 27.0)
                           
                           pt.text = " " + String(z) + "%"
                           
                           self.view.addSubview(line)
                           self.view.addSubview(perc)
                           self.view.addSubview(pt)


        return my!
    }
    
    
}
