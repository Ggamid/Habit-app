//
//  HabitStorage.swift
//  Habbit app
//
//  Created by Gamıd Khalıdov on 22.08.2023.
//

import Foundation

protocol HabitStorageProtocol{
    
    func loadHabit() -> [HabitProtocol]
    func saveHabit(_ habits: [HabitProtocol])
    
}
// сущность Хранилище
class HabitStorage: HabitStorageProtocol{

    
    // ссылка на хранилище
    private let storage = UserDefaults.standard
    
    // Ключ, по которому будет происходить сохранение и загрузка хранилища из User Defaults
    let storageKey: String = "habit"
    
    private enum HabitKey: String{
        case title, strick, time, status
    }
    func loadHabit() -> [HabitProtocol] {
        var habits: [Habit] = []
        let habitsFromStorage = storage.array(forKey: "habit") as? [[String:String]] ?? []
        
        for habit in habitsFromStorage {
            guard let title = habit[HabitKey.title.rawValue],
                  let strick = Int(habit[HabitKey.strick.rawValue] ?? "0"),
                let time = habit[HabitKey.time.rawValue],
                let status = habit[HabitKey.status.rawValue] else { continue }
            let habitStatus: HabitStatus = status == "completed" ? .completed : .notCompleted
            habits.append(Habit(title: title, time: time, strick: strick, status: habitStatus))
        }
        return habits
    }
    
    func saveHabit(_ habits: [HabitProtocol]) {
        var arrayForStorage: [[String:String]] = []
        habits.forEach{ habit in
            var habitDict: Dictionary<String, String> = [:]
            habitDict[HabitKey.strick.rawValue] = String(habit.strick)
            habitDict[HabitKey.title.rawValue] = habit.title
            habitDict[HabitKey.time.rawValue] = habit.time
            habitDict[HabitKey.status.rawValue] = habit.status == .completed ? "completed" : "notcompleted"
            arrayForStorage.append(habitDict)
        }
        storage.set(arrayForStorage, forKey: "habit")
    }
}
