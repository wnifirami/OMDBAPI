//
//  DetailViewController.swift

import UIKit
import AlamofireImage
import  Alamofire
class DetailViewController: UIViewController {
    var url = "http://www.omdbapi.com/?apiKey=295e6386&i="
    @IBOutlet weak var cover: UIImageView!
    var id = ""
    var MovieArray = [AnyObject]()
    @IBOutlet weak var likebtn: UIButton!
    @IBOutlet weak var favbtn: UIButton!
    @IBOutlet weak var Actorsname: UILabel!
    @IBOutlet weak var wrotername: UILabel!
    @IBOutlet weak var directorname: UILabel!
    @IBOutlet weak var Desc: UITextView!
    @IBOutlet weak var ratestar5: UIImageView!
    @IBOutlet weak var ratestar4: UIImageView!
    @IBOutlet weak var ratestar3: UIImageView!
    @IBOutlet weak var ratestar2: UIImageView!
    @IBOutlet weak var mvtitle: UILabel!
    
    @IBOutlet weak var ratestar1: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var Auteur: UILabel!
    @IBOutlet weak var rateval: UILabel!
    
    
    var movieimg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        cover.af_setImage(withURL:URL(string: movieimg)!)
        GetMovie( flag: true,completionHandler: { success in
            
        })
        
       
    }
    
    
    func GetMovie( flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(url+id).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    self.mvtitle.text = dict["Title"] as! String
                    self.Desc.text = dict["Plot"] as! String
                    self.genre.text = dict["Genre"] as! String
                    self.Auteur.text = dict["Director"] as! String
                    self.rateval.text = dict["imdbRating"] as! String
                    var valret = (dict["imdbRating"] as! String)
                    var x = Double(valret)
                    if x! > 0.0 && x! < 2.0 {
                        self.ratestar1.image = UIImage(named: "Star")
                        self.ratestar2.image = UIImage(named: "emptyStar")
                        self.ratestar3.image = UIImage(named: "emptyStar")
                        self.ratestar4.image = UIImage(named: "emptyStar")
                        self.ratestar5.image = UIImage(named: "emptyStar")
                    }
                    else if x! > 2.0 && x! < 4.0 {
                        self.ratestar1.image = UIImage(named: "Star")
                        self.ratestar2.image = UIImage(named: "Star")
                        self.ratestar3.image = UIImage(named: "emptyStar")
                        self.ratestar4.image = UIImage(named: "emptyStar")
                        self.ratestar5.image = UIImage(named: "emptyStar")
                    }
                    else if x! > 4.0 && x! < 6.0 {
                        self.ratestar1.image = UIImage(named: "Star")
                        self.ratestar2.image = UIImage(named: "Star")
                        self.ratestar3.image = UIImage(named: "Star")
                        self.ratestar4.image = UIImage(named: "emptyStar")
                        self.ratestar5.image = UIImage(named: "emptyStar")
                    }
                    else if x! > 6.0 && x! < 8.0 {
                        self.ratestar1.image = UIImage(named: "Star")
                        self.ratestar2.image = UIImage(named: "Star")
                        self.ratestar3.image = UIImage(named: "Star")
                        self.ratestar4.image = UIImage(named: "Star")
                        self.ratestar5.image = UIImage(named: "emptyStar")
                    }
                    else if x! > 8.0 && x! < 10.0 {
                        self.ratestar1.image = UIImage(named: "Star")
                        self.ratestar2.image = UIImage(named: "Star")
                        self.ratestar3.image = UIImage(named: "Star")
                        self.ratestar4.image = UIImage(named: "Star")
                        self.ratestar5.image = UIImage(named: "Star")
                    }
                    self.directorname.text = dict["Director"] as! String
                    self.wrotername.text = dict["Writer"] as! String
                    self.Actorsname.text = dict["Actors"] as! String
        
                }
                completionHandler(true)
        }
    }
    
    
    @IBAction func likebtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func favbtnpressed(_ sender: UIButton) {
        
        if (self.favbtn.currentBackgroundImage == (UIImage(named: "star-1")))  {
            self.favbtn.setBackgroundImage(UIImage(named: "Group"), for: .normal)
            
            
        }
        else {
            self.favbtn.setBackgroundImage(UIImage(named: "star-1"), for: .normal)
            
        }
    }
    
}
