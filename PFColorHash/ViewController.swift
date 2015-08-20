//
//  ViewController.swift
//  PFColorHash
//
//  Created by Cee on 20/08/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let colorHash = PFColorHash()
    
    var states: [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Views
        self.setupTextField()
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTextField() {
        // Add bottom line
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, inputTextField.frame.size.height - 1, inputTextField.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.blackColor().CGColor
        inputTextField.layer.addSublayer(bottomBorder)
        // Add target event
        inputTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    func textFieldDidChange(textField: UITextField) {
        states.append(textField.text)
        tableView.reloadData()
    }
    
    @IBAction func clearBtnPressed(sender: AnyObject) {
        states.removeAll()
        inputTextField.text = nil
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = states.count - indexPath.row - 1
        let str = states[index]
        let color = UIColor(red: (CGFloat)(colorHash.rgb(str).r) / 255.0,
                          green: (CGFloat)(colorHash.rgb(str).g) / 255.0,
                           blue: (CGFloat)(colorHash.rgb(str).b) / 255.0,
                          alpha: 1.0)
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let imageView = UIImageView(frame: CGRectMake(view.frame.width - 46, (cell.frame.height - 30) / 2.0, 30, 30))
        imageView.backgroundColor = color
        cell.addSubview(imageView)
        
        cell.selectionStyle = .None
        cell.textLabel?.text = str
        cell.textLabel?.frame.origin.x += 16
        cell.detailTextLabel?.text = "#" + colorHash.hex(str)
        cell.layoutSubviews()
        return cell
    }
}