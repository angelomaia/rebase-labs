require 'spec_helper'
require_relative '../../config/db_config.rb'

describe '/tests' do
  it 'GET' do
    result_rows = [
      {
        'result_token' => 'IQCZ17',
        'result_date' => '2021-08-05',
        'cpf' => '048.973.170-88',
        'name' => 'Emilly Batista Neto',
        'email' => 'gerald.crona@ebert-quigley.com',
        'birthday' => '2001-03-11',
        'crm' => 'B000BJ20J4',
        'crm_state' => 'PI',
        'doctor_name' => 'Maria Luiza Pires',
        'test_type' => 'hemácias',
        'test_limits' => '45-52',
        'exam_result' => '97'
      }
    ]

    mock_result = instance_double('PG::Result')
    allow(mock_result).to receive(:group_by).and_return(
      result_rows.group_by { |row| row['result_token'] }
    )

    connection = instance_double('PG::Connection', exec: mock_result)
    allow(PG).to receive(:connect).and_return(connection)

    get '/tests'

    puts last_response.body
    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq [{
                                                    "result_token" => "IQCZ17",
                                                    "result_date" => "2021-08-05",
                                                    "cpf" => "048.973.170-88",
                                                    "name" => "Emilly Batista Neto",
                                                    "email" => "gerald.crona@ebert-quigley.com",
                                                    "birthday" => "2001-03-11",
                                                    "doctor" => {
                                                      "crm" => "B000BJ20J4",
                                                      "crm_state" => "PI",
                                                      "name" => "Maria Luiza Pires"
                                                    },
                                                    "tests" => [
                                                      {
                                                        "type" => "hemácias",
                                                        "limits" => "45-52",
                                                        "result" => "97"
                                                      }]
                                                  }]
  end
end
