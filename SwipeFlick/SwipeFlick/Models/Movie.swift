import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let description: String
    let imageURL: String
    let releaseYear: Int
    let genre: [String]
    let rating: String
    let medium: String
    
    // !! BEFORE YOU ADD MORE MOVIES, MAKE SURE TO CHECK THE FOLLOWING !!
    
    // POSSIBLE GENRES:
    // ["Horror", "Action", "Drama", "Romance", "Comedy", "Fantasy", "Sci-fi", "Thriller", "Adventure", "Crime", "Western", "Historical"]
    
    // POSSIBLE MEDIUMS:
    // ["Live-Action", "Animation", "Stop-Motion", "Anime"]
    
    // POSSIBLE AGE RATINGS:
    // ["G", "PG", "PG-13", "R", "NC-17"]
    
    // Mock data
    static let mockMovies = [
        Movie(
            id: 0,
            title: "Interstellar",
            description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
            imageURL: "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg",
            releaseYear: 2014,
            genre: ["Sci-Fi", "Adventure", "Drama"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 1,
            title: "Forrest Gump",
            description: "The presidencies of Kennedy and Johnson, Vietnam, Watergate, and other history unfold through the perspective of an Alabama man with a low IQ.",
            imageURL: "https://image.tmdb.org/t/p/w500/saHP97rTPS5eLmrLQEcANmKrsFl.jpg",
            releaseYear: 1994,
            genre: ["Drama", "Comedy", "Romance"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 2,
            title: "The Godfather",
            description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
            imageURL: "https://image.tmdb.org/t/p/w500/eEslKSwcqmiNS6va24Pbxf2UKmJ.jpg",
            releaseYear: 1972,
            genre: ["Drama", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 3,
            title: "Parasite",
            description: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.",
            imageURL: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
            releaseYear: 2019,
            genre: ["Thriller", "Comedy", "Drama"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 4,
            title: "Spider-Man: Into the Spider-Verse",
            description: "Teen Miles Morales becomes the Spider-Man of his universe and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
            imageURL: "https://image.tmdb.org/t/p/w500/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg",
            releaseYear: 2018,
            genre: ["Action", "Adventure", "Sci-Fi"],
            rating: "PG",
            medium: "Animation"
        ),
        Movie(
            id: 5,
            title: "Inception",
            description: "A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            imageURL: "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
            releaseYear: 2010,
            genre: ["Sci-Fi", "Action", "Adventure"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 6,
            title: "The Dark Knight",
            description: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
            imageURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            releaseYear: 2008,
            genre: ["Action", "Drama", "Crime", "Thriller"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 7,
            title: "Pulp Fiction",
            description: "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
            imageURL: "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg",
            releaseYear: 1994,
            genre: ["Thriller", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 8,
            title: "The Shawshank Redemption",
            description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
            imageURL: "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
            releaseYear: 1994,
            genre: ["Drama", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 9,
            title: "The Matrix",
            description: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
            imageURL: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
            releaseYear: 1999,
            genre: ["Sci-Fi", "Action"],
            rating: "R",
            medium: "Live-Action"
        )
    ]
}
