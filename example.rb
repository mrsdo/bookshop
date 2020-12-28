# Here DOC using sql that can be set to variables
def method_that_does_sql(db)
  <<-SQL
      SELECT * FROM books;
  SQL
  # db.execute(sql)
end