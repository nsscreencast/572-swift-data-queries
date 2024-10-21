import SwiftData


extension ModelContext {
    static func preview() -> ModelContext {
        let container = try! ModelContainer(for: Artist.self, configurations: .init(isStoredInMemoryOnly: true))
        let context = ModelContext(container)

        for (artistName, songs) in artistSongs {
            let artist = Artist(name: artistName)
            artist.songs = songs.map { Song(title: $0) }
            context.insert(artist)
        }

        return context
    }
}

private let artistSongs: [String: [String]] = [
    "Ed Sheeran": ["Shape of You", "Thinking Out Loud", "Photograph", "Castle on the Hill", "Galway Girl"],
    "The Weeknd": ["Blinding Lights", "Save Your Tears", "Starboy", "The Hills", "Can't Feel My Face"],
    "Dua Lipa": ["Levitating", "Don't Start Now", "New Rules", "Physical", "IDGAF"],
    "Olivia Rodrigo": ["good 4 u", "drivers license", "deja vu", "traitor", "brutal"],
    "Harry Styles": ["Watermelon Sugar", "Adore You", "Sign of the Times", "Falling", "Golden"],
    "Doja Cat": ["Kiss Me More", "Say So", "Streets", "Boss Bitch", "Like That"],
    "Pink Floyd": ["Money", "Hey You", "Time", "Wish You Were Here", "Comfortably Numb"],
    "Stevie Ray Vaughan": ["Little Wing", "Look at Little Sister", "Pride and Joy", "Texas Flood"],
    "Led Zeppelin": ["Stairway to Heaven", "Whole Lotta Love", "Immigrant Song", "Black Dog", "Rock and Roll"],
    "Queen": ["Bohemian Rhapsody", "We Will Rock You", "Somebody to Love", "Another One Bites the Dust", "Under Pressure"],
    "U2": ["With or Without You", "Sunday Bloody Sunday", "Beautiful Day", "Where the Streets Have No Name", "I Still Haven't Found What I'm Looking For"],
    "Guns N' Roses": ["Sweet Child o' Mine", "Welcome to the Jungle", "Paradise City", "November Rain", "Don't Cry"],
    "AC/DC": ["Back in Black", "Highway to Hell", "Thunderstruck", "You Shook Me All Night Long", "T.N.T."],
    "Bon Jovi": ["Livin' on a Prayer", "You Give Love a Bad Name", "Wanted Dead or Alive", "It's My Life", "Always"],
    "The Rolling Stones": ["Paint It Black", "Angie", "Sympathy for the Devil", "Start Me Up", "Gimme Shelter"],
    "Def Leppard": ["Pour Some Sugar on Me", "Love Bites", "Photograph", "Rock of Ages", "Hysteria"],
    "Nirvana": ["Smells Like Teen Spirit", "Come as You Are", "Lithium", "In Bloom", "Heart-Shaped Box"]
]

