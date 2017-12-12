//
//  ViewController.swift
//  Concentration
//
//  Created by Alex Hannigan on 2017/11/13.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            flipCountLabel.text = "Flips: 0"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    var christmasEmoji = ["🤶🏻", "🎅🏻", "🎄", "🍗", "🎁", "⛄️", "⭐️", "🍷", "🦌"]
    
    var emojiChoicesDict = [
        1: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],
        2: ["🤶🏻", "🎅🏻", "🎄", "🍗", "🎁", "⛄️", "⭐️", "🍷", "🦌"],
        3: ["🐈", "🐑", "🐓", "🐖", "🦔", "🦍", "🐸", "🐎", "🐊"],
        4: ["🙂", "🙁", "🤪", "😎", "🤯", "😡", "😭", "😬", "😲"],
        5: ["🍓", "🥝", "🍉", "🍍", "🍌", "🍑", "🍇", "🍐", "🍋"],
        6: ["🚗", "🏍", "🚆", "🚚", "🛩", "🚁", "⛵️", "🛴", "🚲"]
        ]
    
    func randomEmojiSetIndex() -> Int {
        return Int(arc4random_uniform(UInt32(emojiChoicesDict.count))) + 1
    }
    
    lazy var emojiChoices = emojiChoicesDict[randomEmojiSetIndex()] ?? christmasEmoji
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        flipCountLabel.text = "Flips: 0"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = emojiChoicesDict[randomEmojiSetIndex()] ?? christmasEmoji
        updateViewFromModel()
    }
    
}

