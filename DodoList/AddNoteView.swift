import SwiftUI

struct Note: Identifiable {
    let title: String
    let description: String
    let id: UUID
    let date: Date
}

struct AddNoteView: View {
    @State var title = ""
    @State var description = ""
    @Binding var notes: [Note]
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.4))
            
            TextEditor(text: $description)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.4))
                .frame(height: 300.0)
            
            DatePicker("Select Date and Time", selection: $selectedDate)
                .padding()
            
            Button("Add") {
                addNote()
            }.buttonStyle(.bordered)
        }
        .navigationTitle(Text("Take a Note"))
        .padding()
    }
    
    func addNote() {
        let newNote = Note(title: title, description: description, id: UUID(), date: selectedDate)
        notes.append(newNote)
    }
}

#Preview {
    AddNoteView(notes: .constant([]))
}
