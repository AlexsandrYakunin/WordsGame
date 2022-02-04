//
//  ViewController.swift
//  WordsGame
//
//  Created by Александр on 29.10.2021.
//

import UIKit

class StartViewController: UIViewController {
   
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var firstPlayerTextField: UITextField!
    @IBOutlet weak var secondPlayerTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var words = ["Магнитотерапия","Рекогносцировка","Джамахирия","Гибрадтар", "Ничегонеделаниье"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seturViews()
        choiceUIELEMENT()
        addTapToDismiss()
    
        
    
    }
    
    func seturViews() {
        let array: [UIView] = [wordTextField, firstPlayerTextField, secondPlayerTextField, startButton]
        
        for view in array {
            view.layer.cornerRadius = 12
        }
        
    }
    
    // 1. Создать метод, который заменяет клавиатуру на пикер
    // 2. Прописать взаимодействие пикера с контроллером
    // 3. Создать массив слов
    
    func choiceUIELEMENT() {
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        wordTextField.inputView = picker
    }

    @IBAction func startTap(_ sender: UIButton) {
       

        let word: String = wordTextField.text!
        guard word.count <= 18 && word.count >= 8  else
        { return}

        
        let player1: String = firstPlayerTextField.text!
       
        if player1.count == 0 {firstPlayerTextField.text = "Игрок 1" } else if player1.count >= 2 && player1.count <= 12  {firstPlayerTextField.text = self.firstPlayerTextField.text} else {  showInfoAlert("Имя должно содержать более одной буквы")}
       
        let player2: String = secondPlayerTextField.text!
        if player2.count == 0 {secondPlayerTextField.text = "Игрок 2" } else if player2.count >= 2 && player2.count <= 12  {secondPlayerTextField.text = self.secondPlayerTextField.text} else {  showInfoAlert("Имя должно содержать более одной буквы")}
        
        
        
        performSegue(withIdentifier: "ToGameVC" , sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ToGameVC":
           
            let destVC = segue.destination as! GameViewController
            
            if let bigWord = self.wordTextField.text {
                destVC.bigWord = bigWord
            }
            
            if let namePl1 = self.firstPlayerTextField.text {
                destVC.namePlayer1 = namePl1
            }
            
            if let namePl2 = self.secondPlayerTextField.text {
                destVC.namePlayer2 = namePl2
            }
            
            
            
            
        default:
            break
        }
        wordTextField.text = ""
        firstPlayerTextField.text = ""
        secondPlayerTextField.text = "" 
    }
}

extension StartViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
    // Количество компонентов в ПикерВью (колес)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Количество строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return words.count
    }
    // Заголовок ячейки
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return words[row]
    }
    // Обработка выбора строки в ПикерВью
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        wordTextField.text = words[row]
    }
  
}

