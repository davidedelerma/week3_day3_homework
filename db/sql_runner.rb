require('pg')
class SqlRunner #delegation

  def initialize(options)
    @dbname = options[:dbname]
    @host = options[:host]
  end

  def run(sql)
    db = PG.connect ({dbname: @dbname, host:@host})
    result = db.exec(sql)
    return result
    db.close()
  end
end