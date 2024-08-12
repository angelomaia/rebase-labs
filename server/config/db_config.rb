DB_PARAMS = {
  dbname: ENV['DB_NAME'] ||= 'my_database',
  user: 'my_user',
  password: 'my_password',
  host: 'exams-db',
  port: 5432
}.freeze