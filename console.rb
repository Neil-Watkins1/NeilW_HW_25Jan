require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => 'Neil Watkins', 'funds' => '30'})
customer1.save()

customer2 = Customer.new({ 'name' => 'Sarah Watkins', 'funds' => '10'})
customer2.save()

customer3 = Customer.new({ 'name' => 'Bill Oddie', 'funds' => '20'})
customer3.save()

customer4 = Customer.new({ 'name' => 'Graham Green', 'funds' => '20'})
customer4.save()


film1 = Film.new({ 'title' => 'Terminator', 'price' => '8'})
film1.save()

film2 = Film.new({ 'title' => 'Its a Wonderful Life', 'price' => '6'})
film2.save()

film3 = Film.new({ 'title' => 'Carry on up the Kyber', 'price' => '6'})
film3.save()

film4 = Film.new({ 'title' => 'Sharknado', 'price' => '10'})
film4.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film4.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film4.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket4.save()

ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket5.save()

ticket6 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})
ticket6.save()

# customer1.update ({'name' => 'Neil Watkins', 'Funds' => '25'})

binding.pry
nil
