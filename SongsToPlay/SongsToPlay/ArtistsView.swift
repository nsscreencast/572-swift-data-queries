import SwiftData
import SwiftUI

struct ArtistsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var artists: [Artist]
    @State var editingArtist: Artist?

    var body: some View {
        List {
            ForEach(artists) { artist in
                NavigationLink(value: artist) {
                    Text(artist.name)
                }
                .swipeActions {
                    Button {
                        editingArtist = artist
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        modelContext.delete(artist)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .navigationDestination(for: Artist.self) { artist in
            ArtistSongsView(artist: artist)
        }
        .toolbar {
            Button("Add", systemImage: "person.badge.plus") {
                editingArtist = Artist(name: "New Artist")
            }
        }
        .navigationTitle("Artists")
        .sheet(item: $editingArtist) { artist in
            NavigationStack {
                ArtistForm(artistID: artist.id, isNewRecord: artist.isNewRecord, container: modelContext.container)
                    .navigationTitle(artist.isNewRecord ? "New Artist" : "Edit Artist")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.height(200)])
        }
    }
}

extension PersistentModel {
    var isNewRecord: Bool {
        persistentModelID.storeIdentifier == nil
    }
}

#Preview {
    NavigationStack {
        ArtistsView()
    }
    .modelContainer(for: Artist.self, inMemory: true)
}

#Preview("Showing sheet") {
    let container = try! ModelContainer(for: Artist.self, configurations: .init(isStoredInMemoryOnly: true))
    let artist = Artist(name: "")

    return NavigationStack {
        ArtistsView(editingArtist: artist)
    }
    .modelContainer(container)
}
