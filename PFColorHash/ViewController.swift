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
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: inputTextField.frame.size.height - 1, width: inputTextField.frame.size.width, height: 1.0);
        bottomBorder.backgroundColor = UIColor.black.cgColor
        inputTextField.layer.addSublayer(bottomBorder)
        // Add target event
        inputTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        states.append(textField.text!)
        tableView.reloadData()
    }
    
    @IBAction func clearBtnPressed(_ sender: AnyObject) {
        states.removeAll()
        inputTextField.text = nil
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = states.count - (indexPath as NSIndexPath).row - 1
        let str = states[index]
        let color = colorHash.uiColor(str)
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
        let imageView = UIImageView(frame: CGRect(x: view.frame.width - 46, y: (cell.frame.height - 30) / 2.0, width: 30, height: 30))
        imageView.backgroundColor = color
        cell.addSubview(imageView)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = str
        cell.textLabel?.frame.origin.x += 16
        cell.detailTextLabel?.text = "#" + colorHash.hex(str)
        cell.layoutSubviews()
        return cell
    }
}
