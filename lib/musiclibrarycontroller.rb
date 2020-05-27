class MusicLibraryController 
  attr_accessor :path 
  extend Concerns::Findable
  def initialize(path='./db/mp3s')
    @path =path
    MusicImporter.new(path).import
  end
  
   def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
     input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

    end
  end
  
  def list_songs 
    Song.all.sort_by {|song| song.name}.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    Artist.all.sort_by {|artist| artist.name}.each_with_index do |artist,index|
      puts "#{index+1}. #{artist.name}"
    end
  end
  
  def list_genres
    Genre.all.sort_by {|genre| genre.name}.each_with_index do |genre,index|
      puts "#{index+1}. #{genre.name}"
    end
  end
  
  
  def list_songs_by_artist 
    extend Concerns::Findable
    puts "Please enter the name of an artist:"
    input =gets.chomp
    if Artist.find_by_name(input)
      artist=Artist.find_by_name(input)
      artist.songs.sort_by {|song| song.name}.each_with_index do |song,index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if Genre.find_by_name(input)
      genre=Genre.find_by_name(input)
      genre.songs.sort_by{|song| song.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    # self.list_songs
    puts "Which song number would you like to play?"
    input =gets.chomp.to_i
    songarray=Song.all.sort_by{|song| song.name}
    if input>0 && input<=songarray.size
      song=songarray[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
    
end
