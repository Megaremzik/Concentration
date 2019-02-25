//
//  ViewController.swift
//  Concentration
//
//  Created by Admin on 20.02.2019.
//  Copyright © 2019 Remza. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private var game: Concentration!{
        didSet{
            updateViewFromModel()
        }
    }
    var numberOfPairsOfCards: Int{
            return (cardButtons.count + 1) / 2
    }
    private(set) var flipCount = 0{
        didSet{
            updateFlipCount()
        }
    }
    @IBAction func startNewGame(_ sender: UIButton) {
        startGame()
    }
    var themeNumber :Int = 0
    private func updateFlipCount(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    private func startGame(){
        emojiChoices = ["😀😇😡🤯😎🤪","🐶🐱🐭🐹🐰🦊🐻🐼","🏓🏸🥅🏒🏑🏏⛳️🏹","🍏🍎🍐🍊🍋🍌🍉🍇🥝🥥🍍","🌭🍔🍟🍕🥪🥙🌯🍖🍗","🚗🚕🚙🚌🚎🏎🚑🚜"]
        game=Concentration(numberOfPairsOfCards:numberOfPairsOfCards)
        themeNumber=emojiChoices.count.arc4random
        flipCount = 0
        emoji = Dictionary<Card,String>()
    }
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCount()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            //updateViewFromModel()
        }else{
            print("error")
        }
        
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    //private var emojiChoices = ["😀", "😇", "😡","🤯","😎","🤪"]
    private var emojiChoices : [String]!
    private var emoji: Dictionary<Card,String>!
    private func emoji(for card: Card)-> String{
        if emoji[card] == nil, emojiChoices[themeNumber].count > 0{
            let randomStringIndex = emojiChoices[themeNumber].index(emojiChoices[themeNumber].startIndex, offsetBy: emojiChoices[themeNumber].count.arc4random)
                emoji[card] = String(emojiChoices[themeNumber].remove(at:randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}
