import SwiftUI
import SwiftData

struct SongForm: View {
    @Environment(\.dismiss) var dismiss
    private let modelContext: ModelContext
    private let artist: Artist
    private let song: Song

    init(artist: Artist, song: Song, container: ModelContainer) {
        let context = ModelContext(container)
        context.autosaveEnabled = false

        self.artist = context.model(for: artist.id) as! Artist
        if song.isNewRecord {
            self.song = song
        } else {
            self.song = context.model(for: song.id) as! Song
        }
        modelContext = context
    }

    var body: some View {
        SongFormContent(song: song)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveChanges()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle(song.isNewRecord ? "New Song" : "Edit Song")
    }

    private func saveChanges() {
        song.artist = artist
        if song.isNewRecord {
            artist.songs.append(song)
        }
        try! modelContext.save()
    }
}

private struct SongFormContent: View {
    @Bindable var song: Song

    var body: some View {
        Form {
            TextField("Title", text: $song.title)
        }
    }
}
