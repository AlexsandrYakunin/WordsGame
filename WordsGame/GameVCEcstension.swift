//
//  GameVCEcstension.swift
//  WordsGame
//
//  Created by Александр on 30.10.2021.
//

import UIKit

// Создали отдельный файл для написания логики таблицы

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beforeWords.count //Кол-во слов в массиве == кол-во строк в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
        
        cell.wordLabel.text = beforeWords[indexPath.row]
        cell.scoreLabel.text = "\(beforeWords[indexPath.row].count)"
      
        
        cell.wordLabel.textColor = .white
        cell.scoreLabel.textColor = .white
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(named: "firstPlayer")
        } else {
            cell.backgroundColor = UIColor(named: "secondPlayer")
        }
        
        return cell
    }
    
    // Задаем высоту ячейки программно
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let word = beforeWords[indexPath.row]
        
        print(word)
        showInfoAlert("\(word.uppercased()): \(word.count) очков")
    }
    
    
}
