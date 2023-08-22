//
//  HabitStorage.swift
//  Habbit app
//
//  Created by Gamıd Khalıdov on 22.08.2023.
//

import Foundation

protocol HabitStorageProtocol{
    
    func loadHabit() -> [Habit]
    func saveHabit(_ habits: [Habit])
    
}


class HabitStorage: HabitStorageProtocol{
    func loadHabit() -> [Habit] {
        let habits = [
            Habit(title: "Drink water", time: "20:00", strick: 0, status: .notCompleted),
            Habit(title: "Sport", time: "15:00", strick: 0, status: .notCompleted),
            Habit(title: "Book", time: "13:00", strick: 0, status: .notCompleted),
            Habit(title: "Long named Habit for test Habit for test", time: "13:00", strick: 0, status: .notCompleted)
        ]
        return habits
    }
    
    func saveHabit(_ habits: [Habit]) {
        
    }
    
    
}
