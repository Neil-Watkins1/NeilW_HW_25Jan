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

# def customers_at_film()
#   sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
#   values = [@id]
#   customer_data = SqlRunner.run(sql, values)
# return customer_data.map {|customer| Customer.new(customer)}.sort_by!(&:name)
# end

  # map {|customer| Customer.new(customer)}
  # end

  def delete()

      sql = "DELETE FROM customers where id = $1"
      values = [@id]
      SqlRunner.run(sql, values)

    end
end
