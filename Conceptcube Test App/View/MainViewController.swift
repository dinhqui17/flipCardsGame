//
//  MainViewController.swift
//  Conceptcube Test App
//
//  Created by Dinh Quy on 2/2/22.
//  Copyright © 2022 Dinh Quy. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var shuffleLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    let sizeOfView = 50
    let maxCars = 78
    
    var listCards : [CardsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        generateCardModels()
        createCards()
        bgImageView.image = UIImage(named: "background.jpg")

    }
    
    @IBAction func shufflePressed(_ sender: UIButton) {
        
        loadView()
        viewDidLoad()
        
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        do {
            try! FirebaseAuth.Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
        
    }
    
    func createCards() {
        for _ in 0..<maxCars {
            
            let pointX = 50
            let pointY = 50
            
            let viewCard = CustomView(frame: CGRect(x: pointX, y: pointY, width: 120, height: 185))
            viewCard.card = listCards.randomElement()
            view.addSubview(viewCard)
            
        }
        
    }
    
    func generateCardModels() {
        let fm = FileManager.default
        let path = Bundle.main.resourceURL!.appendingPathComponent("cards").path
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
        
            for item in items {
                
                let name = item
                
                let cards = CardsModel(faceUp: name, isUp: false)
                
                listCards.append(cards)
        
            }
            
        } catch {
            print("Khong lay duoc file anh")
        }
    }
    

}
