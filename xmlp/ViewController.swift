//
//  ViewController.swift
//  xmlp
//
//  Created by Mahsa Golchian on 1/28/17.
//  Copyright © 2017 Mahsa Golchian. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, XMLParserDelegate
{
    
    @IBOutlet weak var tblView: UITableView!

    
   var parser = XMLParser()
   // var parser = NSString()
    var haberler = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var xmltitle = NSMutableString()
    var link = NSMutableString()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parsingDataFromURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    func parsingDataFromURL(){
    haberler = []
        _ = "/Users/mahsagolchian/Downloads/participantQuestions.xml"
       // let parser = NSString()
        
        
        parser = XMLParser(contentsOf : NSURL(string: "/Users/mahsagolchian/Downloads/participantQuestions.xml") as! URL)!
        parser.delegate = self
        parser.parse()
        tblView.reloadData()
    
    }
    
    
    
    //NSXML item
    
    func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        
    if (element as NSString) .isEqual(to: "question")
    
    {
        
        elements = NSMutableDictionary()
        elements = [:]
        xmltitle = NSMutableString()
        xmltitle = "subject"
        link = NSMutableString()
        link = "answers"
        
        
        }
        
    }

    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element .isEqual(to: "subject")
        {
        xmltitle.append(string)
        }
        
    else if element.isEqual(to: "answers")
        {
        link.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

    if (element as NSString).isEqual(to: "question")
    {
        if !xmltitle.isEqual(nil)
        {
        elements.setObject(xmltitle, forKey: "subject" as NSCopying)
        }
        
        if !link.isEqual(nil)
        {
        elements.setObject(link, forKey: "answers" as NSCopying)
        
        }
        
        haberler.add(elements)
        
        }
    
        
    }
    
    
    //UItableview data source
    
   internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
    
    return haberler.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")! as UITableViewCell
        if (cell.isEqual(NSNull.self))
        {
cell = Bundle.main.loadNibNamed ("mycell", owner: self , options: nil)?[0] as! UITableViewCell
            
        }
        
        cell.textLabel?.text = (haberler.object(at: indexPath.row) as AnyObject).value(forKey: "subject" ) as! NSString as String
        
         cell.detailTextLabel?.text = (haberler.object(at: indexPath.row) as AnyObject).value(forKey: "answers" ) as! NSString as String
        
        return cell
    }
}

