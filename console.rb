require_relative('./models/pet')
require_relative('./models/pet_store')
require_relative('./db/sql_runner')
require('pry-byebug')

runner = SqlRunner.new({dbname:'pet_store', host:'localhost'})

pet_store = PetStore.new({"name" => "Magical Pets","address" => "lalalaalalal", "stock_type" =>"domestic"}, runner)
pet_store.save()

pet1=Pet.new({'name' => "Billy", 'kind' => 'dog', 'pet_store_id' => pet_store.id},runner)
pet1.save()

binding.pry
nil