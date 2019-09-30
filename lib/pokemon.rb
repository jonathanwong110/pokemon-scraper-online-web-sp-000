class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  
  @@all = []
  
  def initialize(pokemon)
    @id = id
    @name = name
    @type = type
    @db = db
    @@all << self
  end
  
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end
  
  def self.find(id, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE id=?", [id])
    new_pokemon = self.new(pokemon)
    new_pokemon.id = pokemon[0][0]
    new_pokemon.name = pokemon[0][1]
    new_pokemon.type = pokemon[0][2]
    new_pokemon.hp = pokemon[0][3]
    return new_pokemon
  end

  def alter_hp(id, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", [id], [self.id])
    self.hp = id
    name = db.execute("SELECT name FROM pokemon WHERE id = #{id}").flatten
    type = db.execute("SELECT type FROM pokemon WHERE id = #{id}").flatten
    pokemonhash = {id: id, name: name, type: type, db: db}
    
    newPokemon = Pokemon.new(pokemonhash)
  end

end