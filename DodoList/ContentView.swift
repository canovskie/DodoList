import SwiftUI

struct ContentView: View {
    @State var notes: [Note] = loadNotes()
    
    var dateTimeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh:mm a"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    Section(header: Text("\(dateTimeString(from: note.date))")) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .padding(.bottom, 3.0)
                            
                            Text(note.description)
                                .font(.subheadline)
                    
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: move)
            }
            .navigationBarItems(leading: NavigationLink(destination: AddNoteView(notes: $notes)) {
                Text("\(Image(systemName: "plus.circle"))")
                    .font(.title2)
            })
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Notes")
            .toolbar { EditButton() }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: notes, perform: { _ in
            saveNotes(notes)
        })
    }
    
    func deleteItems(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        notes.move(fromOffsets: source, toOffset: destination)
    }
    
    func dateTimeString(from date: Date) -> String {
        let dateTime = dateTimeFormat.string(from: date)
        return dateTime
    }
}

#Preview {
    ContentView()
}
