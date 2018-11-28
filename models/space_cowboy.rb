require('pg')

class SpaceCowboy

  attr_accessor :name, :species, :bounty_value, :fav_weapon
  attr_reader :id

  def initialize(tracks)
    @name = tracks['name']
    @species = tracks['species']
    @bounty_value = tracks['bounty_value']
    @fav_weapon = tracks['fav_weapon']
    @id = tracks['id'].to_i if tracks['id']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO space_cowboys
    (name, species, bounty_value, fav_weapon)
    VALUES ($1, $2, $3, $4) RETURNING *;"
    values =[@name, @species, @bounty_value, @fav_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def SpaceCowboy.delete_all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    # connect to the database
    sql = "DELETE FROM space_cowboys;"
    # create an SQL string
    db.prepare("delete_all", sql)
    # prepare a statement
    db.exec_prepared("delete_all")
    # execute the prepared statement
    db.close()
    # close the DB connection
  end

  def SpaceCowboy.all
    #connect to the database
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    #create and sql string
    sql = "SELECT * FROM space_cowboys"
    #prepare the statement
    db.prepare("all", sql)
    #executed prepared statement
    tracks = db.exec_prepared("all")
    #close the DB connection
    db.close()
    #return all the PizzaOrders
    return tracks.map {|track| SpaceCowboy.new(track)}
  end

  def delete()
    #connect to the database
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    #create sql string
    sql = "DELETE FROM space_cowboys WHERE id = $1"
    #set up values array
    values = [@id]
    #prepare the statement
    db.prepare("delete_one", sql)
    #executed the prepared statement
    db.exec_prepared("delete_one", values)
    #close the DB connection
    db.close()
    #we dont return anything because we are deleting something
  end

  def update()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "UPDATE space_cowboys
    SET (name, species, bounty_value, fav_weapon)
    = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @bounty_value, @fav_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update",values)
    db.close()
  end

  def SpaceCowboy.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT name FROM space_cowboys WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    array = db.exec_prepared("find_by_name", values)
    db.close()
    bounty_hash = array[0]
    bounty = SpaceCowboy.new(bounty_hash)
    return bounty
  end

  def SpaceCowboy.find_by_id(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM space_cowboys WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    array = db.exec_prepared("find_by_id", values)
    db.close()
    bounty_hash = array[0]
    bounty = SpaceCowboy.new(bounty_hash)
    return bounty
  end


end
