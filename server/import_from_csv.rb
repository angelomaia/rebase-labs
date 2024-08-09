require 'pg'
require 'csv'
require './config/db_config'

class CSVImporter
  def initialize(db_params, csv_file)
    @conn = PG.connect(db_params)
    @csv_file = csv_file
    @doctor_cache = {}
    @patient_cache = {}
    @test_cache = {}
  end

  def import
    rows = CSV.read(@csv_file, col_sep: ';')
    columns = rows.shift

    rows.each do |row|
      patient_id = import_patient(columns, row)
      doctor_id = import_doctor(columns, row)
      test_id = import_test(columns, row, doctor_id, patient_id)
      exam_id = import_exam(columns, row)
      link_test_exam(test_id, exam_id)
    end
  end

  private

  def import_patient(columns, row)
    cpf = row[columns.index('cpf')]
    return @patient_cache[cpf] if @patient_cache.key?(cpf)

    patient_columns = ['cpf', 'nome paciente', 'email paciente', 'data nascimento paciente', 
                       'endereço/rua paciente', 'cidade paciente', 'estado patiente']
    patient_values = extract_values(columns, row, patient_columns)
    
    patient_db_columns = ['cpf', 'name', 'email', 'birthday', 'address', 'city', 'state']
    query = "INSERT INTO patients (#{patient_db_columns.join(', ')}) VALUES (#{generate_placeholders(patient_columns)}) ON CONFLICT (cpf) DO NOTHING RETURNING id"
    result = @conn.exec_params(query, patient_values)

    patient_id = result.ntuples > 0 ? result[0]['id'] : fetch_patient_id(cpf)
    @patient_cache[cpf] = patient_id
    patient_id
  end

  def import_doctor(columns, row)
    crm = row[columns.index('crm médico')]
    return @doctor_cache[crm] if @doctor_cache.key?(crm)

    doctor_columns = ['crm médico', 'crm médico estado', 'nome médico', 'email médico']
    doctor_values = extract_values(columns, row, doctor_columns)
    
    doctor_db_columns = ['crm', 'crm_state', 'name', 'email']
    query = "INSERT INTO doctors (#{doctor_db_columns.join(', ')}) VALUES (#{generate_placeholders(doctor_columns)}) ON CONFLICT (crm) DO NOTHING RETURNING id"
    result = @conn.exec_params(query, doctor_values)

    doctor_id = result.ntuples > 0 ? result[0]['id'] : fetch_doctor_id(crm)
    @doctor_cache[crm] = doctor_id
    doctor_id
  end

  def import_test(columns, row, doctor_id, patient_id)
    token = row[columns.index('token resultado exame')]
    return @test_cache[token] if @test_cache.key?(token)

    test_values = extract_values(columns, row, ['token resultado exame', 'data exame']) + [doctor_id, patient_id]
    
    test_columns = ['result_token', 'result_date', 'doctor_id', 'patient_id']
    query = "INSERT INTO tests (#{test_columns.join(', ')}) VALUES (#{generate_placeholders(test_columns)}) ON CONFLICT (result_token) DO NOTHING RETURNING id"
    result = @conn.exec_params(query, test_values)

    test_id = result.ntuples > 0 ? result[0]['id'] : fetch_test_id(token)
    @test_cache[token] = test_id
    test_id
  end

  def import_exam(columns, row)
    exam_values = extract_values(columns, row, ['tipo exame', 'limites tipo exame', 'resultado tipo exame'])
    
    exam_columns = ['test_type', 'test_limits', 'result']
    query = "INSERT INTO exams (#{exam_columns.join(', ')}) VALUES (#{generate_placeholders(exam_columns)}) RETURNING id"
    result = @conn.exec_params(query, exam_values)
    result[0]['id']
  end

  def link_test_exam(test_id, exam_id)
    query = "INSERT INTO test_exams (test_id, exam_id) VALUES ($1, $2)"
    @conn.exec_params(query, [test_id, exam_id])
  end

  def fetch_patient_id(cpf)
    query = "SELECT id FROM patients WHERE cpf = $1 LIMIT 1"
    result = @conn.exec_params(query, [cpf])
    raise "Patient not found" if result.ntuples == 0
    result[0]['id']
  end
  
  def fetch_doctor_id(crm)
    query = "SELECT id FROM doctors WHERE crm = $1 LIMIT 1"
    result = @conn.exec_params(query, [crm])
    raise "Doctor not found" if result.ntuples == 0
    result[0]['id']
  end
  
  def fetch_test_id(token)
    query = "SELECT id FROM tests WHERE result_token = $1 LIMIT 1"
    result = @conn.exec_params(query, [token])
    raise "Test not found" if result.ntuples == 0
    result[0]['id']
  end
  

  def extract_values(columns, row, required_columns)
    required_columns.map { |col| row[columns.index(col)] }
  end

  def generate_placeholders(columns)
    (1..columns.length).map { |i| "$#{i}" }.join(", ")
  end
end

importer = CSVImporter.new(DB_PARAMS, './sample/data.csv')
importer.import
