//
//  GameViewController.swift
//  WordsGame
//
//  Created by Александр on 29.10.2021.
//

import UIKit

class GameViewController: UIViewController {
    var bigWord = ""
    var namePlayer1 = ""
    var namePlayer2 = ""
    var scorePlayer1 = 0
    var scorePlayer2 = 0
    
    var isFirst = true
    
    var beforeWords = [String]()
    
    @IBOutlet weak var firstUserStack: UIStackView!
    @IBOutlet weak var secondUserStack: UIStackView!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var bigWordLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapToDismiss()
    
        self.bigWordLabel.text = self.bigWord
        self.firstNameLabel.text = self.namePlayer1
        self.secondNameLabel.text = self.namePlayer2
 
        setupView()
    }
    
    /*
     1.Должна происходить верификация введённого слова
        - Слово не должно быть короче двух букв
        - Слово не должно являться исходным словом
        - Слово не должно быть составлено ранее
     2. Перевести слово в массив символов
     3. Привести слово в нижний регистр
     4. Написать основную логику 
     
     
     
     */
    
    func borderForStack() {
        var currentStack = UIStackView()
       var otherStack = UIStackView()
        
        
        if isFirst {
        currentStack = firstUserStack
        otherStack = secondUserStack
        } else {
            currentStack = secondUserStack
            otherStack = firstUserStack
        }
        currentStack.layer.shadowRadius = 8
        currentStack.layer.shadowColor = UIColor.white.cgColor
        currentStack.layer.shadowOpacity = 0.6
        
        otherStack.layer.shadowOpacity = 0
    }
    
    func updateView() {
        firstScoreLabel.text = "\(scorePlayer1)"
        secondScoreLabel.text = "\(scorePlayer2)"
        tableView.reloadData() // Обновляет таблицу
        borderForStack()
    }

    func setupView(){
    let roundedViews = [firstUserStack,
                        secondUserStack,
                        quitButton,
                        checkButton,
                        wordTextField]
        for view in roundedViews {
            view?.layer.cornerRadius = 12
        }
        firstNameLabel.text = namePlayer1
        secondNameLabel.text = namePlayer2
        firstScoreLabel.text = "\(scorePlayer1)"
        secondScoreLabel.text = String(scorePlayer2)
        
        bigWordLabel.text = bigWord
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func verify(word: String) -> Bool {
        guard word.count > 1 else {
           showInfoAlert("Слово должно содержать более одной буквы")
            return false
        }
        
        guard word != bigWord else {
            showInfoAlert("Это исходное слово, умник!")
            return false
        }
        guard !beforeWords.contains(word) else {
            showInfoAlert("Повторяться не спортивно")
            return false
        }
        return true
    }
    
    func wordToChars(word: String) -> [Character] {
       
        let word = word.lowercased()
        
        var chars = [Character]()
        for char in word {
            chars.append(char)
        }
        return chars
    }
    
    func check(word: String) -> Int {
        
        guard verify(word: word) else {return 0}
        
        let smallChars = wordToChars(word: word)
        var bigChars = wordToChars(word: bigWord)
        var resultString = ""
        
        wordTextField.text = "" // Очистить строку
        
        for char in smallChars {
            if bigChars.contains(char) {
                resultString.append(char)
                var index = 0
                while bigChars[index] != char {
                    index += 1
                }
                bigChars.remove(at: index)
            } else {
                self.showInfoAlert("Такое слово не может быть составлено")
                return 0
            }
        }
        beforeWords.append(word)
        return resultString.count
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        
        guard let word = wordTextField.text else {return}
        let resulScore = check(word: word)
        if isFirst {
          
            scorePlayer1 += resulScore
        } else {
            scorePlayer2 += resulScore
        }
        
        if resulScore > 0 { isFirst.toggle()}
        
        updateView()
    }
    
    @IBAction func backTap(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Вы уверены?", message: "Вы точно хотите покинуть игру?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel)

        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}

