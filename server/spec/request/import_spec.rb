require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe '/import' do
  context 'POST' do
    it 'success' do
      csv_file = Rack::Test::UploadedFile.new('./sample/small_data.csv', 'text/csv')

      post '/import', file: csv_file
      query_result = QueryService.fetch_all_tests

      expect(last_response).to be_ok
      expect(last_response.body).to include('{"success":true}')
      expect(query_result).to eq [{
                                  "result_token" => "0B5XII",
                                  "result_date" => "2021-07-15",
                                  "cpf" => "089.034.562-70",
                                  "name" => "Patricia Gentil",
                                  "patient_email" => "herta_wehner@krajcik.name",
                                  "birthday" => "1998-02-25",
                                  "doctor" => {
                                    "crm" => "B0002W2RBG",
                                    "crm_state" => "CE",
                                    "name" => "Dra. Isabelly Rêgo",
                                    "email" => "diann_klein@schinner.org"
                                  },
                                  "tests" => [
                                    {
                                      "type" => "hemácias",
                                      "limits" => "45-52",
                                      "result" => "57"
                                    },
                                    {
                                      "type" => "leucócitos",
                                      "limits" => "9-61",
                                      "result" => "62"
                                    },
                                    {
                                      "type" => "plaquetas",
                                      "limits" => "11-93",
                                      "result" => "73"
                                    }]
                                }].to_json
    end

    it 'arquivo não é um csv' do
      file = Rack::Test::UploadedFile.new('./spec/support/lab.svg', 'image/svg')

      post '/import', file: file

      expect(last_response.status).to eq 400
      expect(last_response.body).to include('"success":false')
      expect(last_response.body).to include('"error":"Não é um arquivo CSV válido"')
    end

    it 'arquivo é um csv com formato errado' do
      file = Rack::Test::UploadedFile.new('./spec/support/invalid_columns.csv', 'text/csv')

      post '/import', file: file

      expect(last_response.status).to eq 400
      expect(last_response.body).to include('"success":false')
      expect(last_response.body).to include('"error":"Dados do CSV estão em formato inválido"')
    end

    it 'arquivo é um csv sem linhas' do
      file = Rack::Test::UploadedFile.new('./spec/support/empty_rows.csv', 'text/csv')

      post '/import', file: file

      expect(last_response.status).to eq 400
      expect(last_response.body).to include('"success":false')
      expect(last_response.body).to include('"error":"O arquivo CSV está vazio"')
    end
  end
end
