require 'bcrypt'
require 'pg'

name = 'david Johnson'
email = 'david@clinidocs.co'
password = 'll'

# run ruby create_user.rb to get the scribbled pass created

password_digest = BCrypt::Password.create(password)

sql = "INSERT INTO doctors (name, email, password_digest) VALUES ('#{name}', '#{email}', '#{password_digest}');"

db = PG.connect(dbname: 'clinidocs')
db.exec(sql)
db.close



