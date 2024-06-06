import SwiftUI

struct Note: Identifiable, Codable, Equatable {
    let title: String
    let description: String
    let id: UUID
    let date: Date
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func saveNotes(_ notes: [Note]) {
    let url = getDocumentsDirectory().appendingPathComponent("notes.json")
    let encoder = JSONEncoder()
    if let data = try? encoder.encode(notes) {
        try? data.write(to: url)
    }
}

func loadNotes() -> [Note] {
    let url = getDocumentsDirectory().appendingPathComponent("notes.json")
    if let data = try? Data(contentsOf: url) {
        let decoder = JSONDecoder()
        return (try? decoder.decode([Note].self, from: data)) ?? []
    }
    return []
}
