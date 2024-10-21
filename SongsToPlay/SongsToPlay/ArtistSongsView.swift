import SwiftUI
import SwiftData

struct ArtistSongsView: View {
    @Environment(\.modelContext) var modelContext
    let artist: Artist
    @State var editingSong: Song?

    var body: some View {
        SongsView(songs: artist.songs, editingSong: $editingSong)
            .id(editingSong)
            .navigationTitle(artist.name)
            .toolbar {
                Button("Add", systemImage: "mic.badge.plus") {
                    editingSong = Song(title: "")
                }
            }
            .sheet(item: $editingSong) { song in
                NavigationStack {
                    SongForm(artist: artist, song: song, container: modelContext.container)
                }
                .presentationDetents([.height(200)])
            }
    }
}

struct SongsView: View {
    let songs: [Song]
    @Binding var editingSong: Song?

    enum DisplayMode {
        case title
        case titleAndArtist
    }

    var displayMode: DisplayMode = .title

    var body: some View {
        List(songs) { song in
            VStack(alignment: .leading, spacing: 6) {
                Text(song.title)
                    .font(.headline)

                if case .titleAndArtist = displayMode {
                    Text(song.artist?.name ?? "")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                editingSong = song
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Artist.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = ModelContext(container)
    let artist = Artist(name: "Pink Floyd")
    artist.songs = [
        Song(title: "Hey You"),
        Song(title: "Money"),
        Song(title: "Breathe")
    ]
    context.insert(artist)

    return SongsView(songs: artist.songs, editingSong: .constant(nil))
}
