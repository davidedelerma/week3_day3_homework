require('pg')

class PetStore
  attr_reader(:id, :name, :address, :stock_type)
  
  def initialize(options, runner)
    @id=options['id']
    @name=options['name']
    @address=options['address']
    @stock_type=options['stock_type']
    @runner=runner
  end

  def save()
    sql = "INSERT INTO pet_stores (name, address, stock_type) VALUES ('#{name}','#{address}','#{stock_type}') RETURNING *;"
    pet_store_data = @runner.run(sql)
    @id = pet_store_data.first['id'].to_i
    #return PetStore.new(pet_store_data.first, @runner)
  end

  def pets()
    sql = "SELECT * FROM pets WHERE pet_store_id = #{@id} ;"
    pets_data = @runner.run(sql)
    pets = pets_data.map {|pet| Pet.new(pet, @runner)}
    return pets
  end

  def self.find_by_id(id,runner)
    sql = "SELECT * FROM pet_stores WHERE id = #{id}"
    stores_data = runner.run (sql)
    return stores = stores_data.map {|store| PetStore.new(store,runner)}
  end

  def update (options,runner)
    if (options['name'])
      @name = options['name']
    end
    if (options['address'] )
      @address = options['address']
    end
    if (options['stock_type'])
      @stock_type = options['stock_type']
    end

    pet_store_id = options['id'].to_i
    sql = "UPDATE pet_stores SET 
      name = '#{ @name }', 
      address = '#{ @address }', 
      stock_type = '#{ @stock_type }' 
      WHERE id = #{ @id };"
    @runner.run(sql)
  end

  def delete(runner)
    sql = "DELETE FROM pet_stores WHERE #{@id} = id;"
    @runner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pet_stores;"
    pet_stores_data = runner.run (sql)
    return pet_stores = pet_stores_data.map {|pet_store| PetStore.new(pet_store,runner)}
  end
end
