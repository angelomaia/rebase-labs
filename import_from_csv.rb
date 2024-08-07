require 'pg'
require './config/db_config'

class CSVImporter
  def initialize(db_params, csv_file, table_name)
    @conn = PG.connect(db_params)
    @csv_file = csv_file
    @table_name = table_name
  end

  def import
    rows = CSV.read(@csv_file, col_sep: ';')
    columns = rows.shift

    create_table(columns)

    rows.each do |row|
      insert_row(columns, row)
    end
  end

  private

  def create_table(columns)
    column_definitions = columns.map { |col| "\"#{col}\" TEXT" }.join(", ")
    @conn.exec("CREATE TABLE IF NOT EXISTS #{@table_name} (id SERIAL PRIMARY KEY, #{column_definitions})")
  end

  def insert_row(columns, row)
    quoted_columns = columns.map { |column| "\"#{column}\"" }.join(", ")
    placeholders = (1..columns.length).map { |i| "$#{i}" }.join(", ")
    @conn.exec_params(
      "INSERT INTO #{@table_name} (#{quoted_columns}) VALUES (#{placeholders})",
      row
    )
  end
end

importer = CSVImporter.new(DB_PARAMS, './data.csv', 'imported_data')
importer.import
