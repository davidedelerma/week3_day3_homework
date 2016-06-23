require('pg')

class Pet
  attr_reader :name, :id, :kind, :pet_store_id
  def initialize(options,runner)
    @name=options['name']
    @id=options['id'].to_i
    @kind=options['kind']
    @pet_store_id=options['pet_store_id'].to_i
    @runner=runner
  end

  def save()
    sql = "INSERT INTO pets (name,kind,pet_store_id) VALUES ('#{name}','#{kind}', #{pet_store_id}) RETURNING *;"
    pets_data = @runner.run(sql)
    @id = pets_data.first['id'].to_i
  end

  def store()
    sql = "SELECT * FROM pet_stores WHERE id = #{@pet_store_id}"
    store_data = @runner.run(sql)
    return store = PetStore.new(store_data.first, @runner)
  end
end