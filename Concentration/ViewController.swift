//
//  ViewController.swift
//  Concentration
//
//  Created by Joel Mendoza on 5/25/19.
//  Copyright © 2019 MappSci. All rights reserved.
//

//Things to learn:
//
//1. MVC - In iOS, when one creates a single view application, XCode creates the view (storyboard)
//and controller (i.e. ViewController.swift).  One can rename the ViewController by control clicking on
//the text, click refactor, and then click rename.  The controller invforms the view via outlets.
//The view informs the controllorer via delegates and data source.  One has to create the model.
//For Stanford's concentration game, the model is a class that contains an array of data structures
//that represents a card.
//
//2. One has to initialze class variables.
//
//3. A class has a default initializer.
//
//4. The view controller HAS A model (i.e. var game: Concentration).
//The view controller also HAS A set of buttons (i.e. var cardButtons:
//A property (i.e. count) of the set of buttons is being passed to the constructor
//of Concentration.  But since ViewController has not been fully initialized,
//XCode will produce an error.  To inform XCode that the instance creation
//(i.e. var game) will be deferred until something uses the instance, put
//lazy in front of the assignment to instance (i.e. var game: Concentration =
//Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2.
//Big restriction: lazy = no property observers.
//
//5. In Concentration.swift, class from which an instance is created, there is
//a short cut declaration of array - var cards = [Card]().  Another
//short cut is var emptyDoubles = [Double] = [].  Normal declaration
//var emptyFloats: Array<Float> = Array().
//
//6. There is a declaration of a dictionary in this file.  The standard
//declaration is var emoji = Dictionary<Int, String>().  Short cut for
//dictionary is emoji = [Int:String]()
//
//7. Shortcut for
//if emoji[card.identifier] != nil{
//    return emoji[card.identifier]!
//} else {
//    return "?"
//}
// return emoji[card.identifier] ?? "?"


import UIKit

class ViewController: UIViewController {
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
//    var game: Concentration = Concentration(numberOfPairsOfCards: 2)
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips; \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3218592701) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🦇", "😱", "😻", "😈", "🎃", "👻", "🍭","👑", "🍎"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}
