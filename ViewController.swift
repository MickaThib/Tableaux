//
//  ViewController.swift
//  Tableaux
//
//  Created by Mickael on 26/01/2016.
//  Copyright © 2016 Mickael Thibouret. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    
    @IBOutlet weak var tableau1: UIImageView!
    @IBOutlet weak var cibleTableau1: UIImageView!
    var tableau1EstAccroche: Bool = false
    
    @IBOutlet weak var tableau2: UIImageView!
    @IBOutlet weak var cibleTableau2: UIImageView!
    var tableau2EstAccroche: Bool = false
    
    @IBOutlet weak var tableau3: UIImageView!
    @IBOutlet weak var cibleTableau3: UIImageView!
    var tableau3EstAccroche: Bool = false
    
    @IBOutlet weak var tableau4: UIImageView!
    @IBOutlet weak var cibleTableau4: UIImageView!
    var tableau4EstAccroche: Bool = false

    @IBOutlet weak var tableau5: UIImageView!
    @IBOutlet weak var cibleTableau5: UIImageView!
    var tableau5EstAccroche: Bool = false

    @IBOutlet weak var messageGagne: UIView!
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageGagne.hidden = true
        
    }

    @IBAction func deplacement(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
        
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPointZero, inView: self.view)
        
        if sender.state == UIGestureRecognizerState.Ended { // Au relâchement de l'objet
            tableau1EstAccroche = comparePlacementTableauEtCible(tableau1, cible: cibleTableau1, marge: 20)
            tableau2EstAccroche = comparePlacementTableauEtCible(tableau2, cible: cibleTableau2, marge: 20)
            tableau3EstAccroche = comparePlacementTableauEtCible(tableau3, cible: cibleTableau3, marge: 20)
            tableau4EstAccroche = comparePlacementTableauEtCible(tableau4, cible: cibleTableau4, marge: 20)
            tableau5EstAccroche = comparePlacementTableauEtCible(tableau5, cible: cibleTableau5, marge: 20)
            
            if tableau1EstAccroche == true && tableau2EstAccroche == true && tableau3EstAccroche == true && tableau4EstAccroche == true && tableau5EstAccroche == true {
                messageGagne.hidden = false
                jouerSon("gagne", format: "mp3")
            }
        }
        
    }
    

    func comparePlacementTableauEtCible (tableau:UIImageView, cible:UIImageView, marge:CGFloat) -> Bool {
        if cible.center.x - marge <= tableau.center.x
           && tableau.center.x <= cible.center.x + marge
           && cible.center.y - marge <= tableau.center.y
           && tableau.center.y <= cible.center.y + marge {
            
            tableau.center = cible.center
            jouerSon("toc", format: "mp3")
            return true
            
        } else {return false}
    }
    
    func jouerSon(son: String!, format: String!){
        // Definir le chemin du fichier à jouer
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(son, ofType: format)!)
        
        // Essaie de jouer le son
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        }
        catch {
            print("Impossible de jouer les sons !")
        }
        
    }
    
    @IBAction func recommencer(sender: UIButton) {
        messageGagne.hidden = true
        jouerSon("recommencer", format: "mp3")
        
        // Remettre les tableaux sur le sol
        tableau1.center.y = self.view.bounds.size.height - (tableau1.frame.size.height)/2 - 15
        tableau1.center.x = self.view.bounds.size.width/2.5
        
        tableau2.center.y = self.view.bounds.size.height - (tableau2.frame.size.height)/2 - 15
        tableau2.center.x = self.view.bounds.size.width - 200
        
        tableau3.center.y = self.view.bounds.size.height - (tableau3.frame.size.height)/2 - 20
        tableau3.center.x = self.view.bounds.size.width - 50
        
        tableau4.center.y = self.view.bounds.size.height - (tableau4.frame.size.height)/2 - 20
        tableau4.center.x = self.view.bounds.size.width - 500
        
        tableau5.center.y = self.view.bounds.size.height - (tableau5.frame.size.height)/2 - 20
        tableau5.center.x = self.view.bounds.size.width/2
    }
}

