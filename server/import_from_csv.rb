require 'pg'
require 'csv'
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

    rows.each do |row|
      insert_row(columns,row)
    end
  end

  private
  
  def insert_row(columns, row)
    placeholders = (1..columns.length).map { |i| "$#{i}" }.join(", ")
    
    query = "INSERT INTO #{@table_name} (patient_cpf, patient_name, patient_email, patient_birthdate, 
                                         patient_address, patient_city, patient_state, crm, crm_state, 
                                         doctor_name, doctor_email, result_token, result_date, exam_type, 
                                         exam_limits, exam_results) VALUES (#{placeholders})"
    @conn.exec_params(query, row)
  end
  
end

importer = CSVImporter.new(DB_PARAMS, './data.csv', 'complete_tests')
importer.import
