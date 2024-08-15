require 'spec_helper'

describe 'QueryService' do
  it '#fetch_all_tests' do
    importer = CSVImporter.new(DB_PARAMS, './sample/small_data.csv')

    importer.import
    result = QueryService.fetch_all_tests

    expect(result).to eq [{
                          "result_token": "0B5XII",
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

  it '#fetch_by_token' do
  importer = CSVImporter.new(DB_PARAMS, './sample/three_tokens.csv')

  importer.import
  result = QueryService.fetch_by_token('0W9I67')

  expect(result).to eq [{
                        "result_token": "0W9I67",
                        "result_date" => "2021-07-09",
                        "cpf" => "048.108.026-04",
                        "name" => "Juliana dos Reis Filho",
                        "patient_email" => "mariana_crist@kutch-torp.com",
                        "birthday" => "1995-07-03",
                        "doctor" => {
                          "crm" => "B0002IQM66",
                          "crm_state" => "SC",
                          "name" => "Maria Helena Ramalho",
                          "email" => "rayford@kemmer-kunze.info"
                        },
                        "tests" => [
                          {
                            "type" => "hemácias",
                            "limits" => "45-52",
                            "result" => "28"
                          }]
                      }].to_json
  end
end
