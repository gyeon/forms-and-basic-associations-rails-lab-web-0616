class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    self.genre.name
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def artist_name
    self.try(:artist).try(:name)
  end

  def note_contents=(notes)
    # byebug
    notes.each do |content|
      if content.strip != ''
        self.notes.build(content: content)
      end
      #returns <Note id: nil, content: "hi", created_at: nil, updated_at: nil, song_id: nil>
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content
    end

  end


end
