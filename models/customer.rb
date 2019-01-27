require_relative ('../DB/sql_runner')
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize (options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @funds = options['funds']
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end


  def save()
    sql = "INSERT INTO customers
    ( name, funds ) VALUES ( $1, $2 ) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def update ()
    sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def tickets_by_customer()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map {|film| Film.new(film)}
  end

  def count_tickets_by_customer()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    tickets_held = film_data.map {|film| Film.new(film)}
    return tickets_held.count
  end


  def delete()

    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)

  end

  # def buy_ticket()
  #   ticket_price = Film.price
  #   @funds -= ticket_price
  # update()
  # end


    # def customer_pay_for_film()
  #   sql = "SELECT films.price FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
  #   values = [@id]
  #   film_price = SqlRunner.run(sql, values)
  #   film_price = film_price.map {|film| Film.new(film)}
  #   @funds -= film_price[0]
  #
  # end

end
