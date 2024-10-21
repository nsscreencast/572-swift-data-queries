import SwiftUI
import SwiftData

struct SongSearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            Group {
                if searchText.isEmpty {
                    ContentUnavailableView(
                        "Search for songs",
                        systemImage: "music.mic",
                        description: Text("You can search for artists or songs")
                    )
                } else {
                    _SongSearchView(searchText: searchText)
                }
            }
            .navigationTitle("Search Songs")
            .searchable(text: $searchText)
        }
    }
}

private struct _SongSearchView: View {
    @Query var songs: [Song]

    init(searchText: String) {
        let predicate = #Predicate<Song> { song in
            song.title.localizedStandardContains(searchText) ||
            song.artist?.name.localizedStandardContains(searchText) == true
        }
        _songs = Query(
            filter: predicate,
            sort: [
                .init(\.title)
            ],
            animation: .default
        )
    }

    var body: some View {
        SongsView(songs: songs, editingSong: .constant(nil), displayMode: .titleAndArtist)
    }
}

#Preview {
    SongSearchView()
        .modelContext(.preview())
}
