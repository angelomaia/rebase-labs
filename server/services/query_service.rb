require 'pg'
require 'json'
require './config/db_config'

class QueryService
  def self.fetch_all_tests
    conn = PG.connect(DB_PARAMS)

    query = <<-SQL
      SELECT 
        tests.result_token, tests.result_date, 
        patients.cpf, patients.name, patients.email, patients.birthday,
        doctors.crm, doctors.crm_state, doctors.name AS doctor_name,
        exams.test_type, exams.test_limits, exams.result AS exam_result
      FROM 
        tests
      JOIN 
        patients ON tests.patient_id = patients.id
      JOIN 
        doctors ON tests.doctor_id = doctors.id
      JOIN 
        test_exams ON tests.id = test_exams.test_id
      JOIN 
        exams ON test_exams.exam_id = exams.id
    SQL

    result = conn.exec(query)

    data = result.group_by { |row| row['result_token'] }.map do |token, rows|
      {
        "result_token" => token,
        "result_date" => rows.first['result_date'],
        "cpf" => rows.first['cpf'],
        "name" => rows.first['name'],
        "email" => rows.first['email'],
        "birthday" => rows.first['birthday'],
        "doctor" => {
          "crm" => rows.first['crm'],
          "crm_state" => rows.first['crm_state'],
          "name" => rows.first['doctor_name']
        },
        "tests" => rows.map do |row|
          {
            "type" => row['test_type'],
            "limits" => row['test_limits'],
            "result" => row['exam_result']
          }
        end
      }
    end

    data.to_json
  end

  def self.fetch_by_token(token)
    conn = PG.connect(DB_PARAMS)

    query = <<-SQL
      SELECT 
        tests.result_token, tests.result_date, 
        patients.cpf, patients.name, patients.email, patients.birthday,
        doctors.crm, doctors.crm_state, doctors.name AS doctor_name,
        exams.test_type, exams.test_limits, exams.result AS exam_result
      FROM 
        tests
      JOIN 
        patients ON tests.patient_id = patients.id
      JOIN 
        doctors ON tests.doctor_id = doctors.id
      JOIN 
        test_exams ON tests.id = test_exams.test_id
      JOIN 
        exams ON test_exams.exam_id = exams.id
      WHERE
        tests.result_token = '#{token}'
    SQL

    result = conn.exec(query)

    data = result.group_by { |row| row['result_token'] }.map do |token, rows|
      {
        "result_token" => token,
        "result_date" => rows.first['result_date'],
        "cpf" => rows.first['cpf'],
        "name" => rows.first['name'],
        "email" => rows.first['email'],
        "birthday" => rows.first['birthday'],
        "doctor" => {
          "crm" => rows.first['crm'],
          "crm_state" => rows.first['crm_state'],
          "name" => rows.first['doctor_name']
        },
        "tests" => rows.map do |row|
          {
            "type" => row['test_type'],
            "limits" => row['test_limits'],
            "result" => row['exam_result']
          }
        end
      }
    end

    data.to_json
  end
end