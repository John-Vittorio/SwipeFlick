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
            description: "Farmer drives a tractor, then a spaceship, to find a new home for humanity, but ends up sending secret messages through a bookshelf to his daughter.",
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
            description: "Guy asks for a favor, gets a horse head in his bed, and suddenly everyone's in the family business.",
            imageURL: "https://image.tmdb.org/t/p/w500/eEslKSwcqmiNS6va24Pbxf2UKmJ.jpg",
            releaseYear: 1972,
            genre: ["Drama", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 3,
            title: "Parasite",
            description: "Family gets jobs they're not qualified for. Things go underground.",
            imageURL: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
            releaseYear: 2019,
            genre: ["Thriller", "Comedy", "Drama"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 4,
            title: "Spider-Man: Into the Spider-Verse",
            description: "Pig, anime girl, and black-and-white detective teach teen to punch a man with a particle collider.",
            imageURL: "https://image.tmdb.org/t/p/w500/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg",
            releaseYear: 2018,
            genre: ["Action", "Adventure", "Sci-Fi"],
            rating: "PG",
            medium: "Animation"
        ),
        Movie(
            id: 5,
            title: "Inception",
            description: "Dude sleeps with all his employees.",
            imageURL: "https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
            releaseYear: 2010,
            genre: ["Sci-Fi", "Action", "Adventure"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 6,
            title: "The Dark Knight",
            description: "Man cosplays as bat to stop crime, accidentally inspires even weirder cosplay.",
            imageURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            releaseYear: 2008,
            genre: ["Action", "Drama", "Crime", "Thriller"],
            rating: "PG-13",
            medium: "Live-Action"
        ),
        Movie(
            id: 7,
            title: "Pulp Fiction",
            description: "Everyone talks too much, gets shot, or dances. Not in that order.",
            imageURL: "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg",
            releaseYear: 1994,
            genre: ["Thriller", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 8,
            title: "The Shawshank Redemption",
            description: "Man goes to prison for a crime he didn't commit, gets really good at digging and friendship.",
            imageURL: "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
            releaseYear: 1994,
            genre: ["Drama", "Crime"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 9,
            title: "The Matrix",
            description: "Bald man in sunglasses convinces depressed office worker to fight robots with karate.",
            imageURL: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
            releaseYear: 1999,
            genre: ["Sci-Fi", "Action"],
            rating: "R",
            medium: "Live-Action"
        ),
        Movie(
            id: 10,
        title: "Dune: Part One",
        description: "The whole family has to move because of dad's job. Everything goes horribly wrong, dad dies and teen son ends up lost and addicted to drugs. But he literally meets the girl of his dreams.",
        imageURL: "https://image.tmdb.org/t/p/w1280/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
        releaseYear: 2021,
        genre: ["Sci-Fi", "Adventure"],
        rating: "PG-13",
        medium: "Live-Action"
        ),
        Movie(id: 11, title: "WALL-E", description: "Little guy works overtime while also stealing body parts from his dead coworkers before ditching his job to go on a cruise with his unconscious girlfriend.", imageURL: "https://image.tmdb.org/t/p/w1280/iujbETnK8hvNcgkNwzS7Nv4Thqc.jpg", releaseYear: 2008, genre: ["Sci-fi"], rating: "G", medium: "Animation"),
        Movie(
            id: 12,
            title: "The Bourne Identity",
            description: "The big bad guy kills the main bad guy because he failed to kill their bad guy who was almost killed trying to kill a bad guy.",
            imageURL: "https://image.tmdb.org/t/p/w1280/aP8swke3gmowbkfZ6lmNidu0y9p.jpg",
            releaseYear: 2002,
            genre: ["Action", "Drama", "Thriller"],
            rating: "PG-13",
            medium: "Live-Action"),
        Movie(
            id: 13,
            title: "Requiem for a Dream",
            description: "Watch what happens when everyone says \"just one more time\" for 100 minutes straight.",
            imageURL: "https://image.tmdb.org/t/p/w1280/nOd6vjEmzCT0k4VYqsA2hwyi87C.jpg",
            releaseYear: 2000,
            genre: ["Crime", "Drame"],
            rating: "NC-17",
            medium: "Live-Action"
        ),
        Movie(id: 14, title: "Kung Fu Panda", description: "An overweight chef slaughters a snow leopard because his turtule died", imageURL: "https://image.tmdb.org/t/p/w1280/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg", releaseYear: 2008, genre: ["Action", "Adventure", "Comedy"], rating: "PG", medium: "Animation")
        
    ]
}
