require 'spec_helper'

describe '/tests/:token' do
  it 'GET' do
    importer = CSVImporter.new(DB_PARAMS, './sample/three_tokens.csv')
    importer.import

    get '/tests/0W9I67'

    puts last_response.body
    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq [{
                                                  "result_token" => "0W9I67",
                                                  "result_date" => "2021-07-09",
                                                  "cpf" => "048.108.026-04",
                                                  "name" => "Juliana dos Reis Filho",
                                                  "email" => "mariana_crist@kutch-torp.com",
                                                  "birthday" => "1995-07-03",
                                                  "doctor" => {
                                                    "crm" => "B0002IQM66",
                                                    "crm_state" => "SC",
                                                    "name" => "Maria Helena Ramalho"
                                                  },
                                                  "tests" => [
                                                    {
                                                      "type" => "hemácias",
                                                      "limits" => "45-52",
                                                      "result" => "28"
                                                    }]
                                                }]
  end
end
