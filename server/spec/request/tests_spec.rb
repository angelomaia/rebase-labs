require 'spec_helper'

describe '/tests' do
  it 'GET' do
    importer = CSVImporter.new(DB_PARAMS, './sample/small_data.csv')
    importer.import

    get '/tests'

    puts last_response.body
    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq [{
                                                    "result_token" => "0B5XII",
                                                    "result_date" => "2021-07-15",
                                                    "cpf" => "089.034.562-70",
                                                    "name" => "Patricia Gentil",
                                                    "email" => "herta_wehner@krajcik.name",
                                                    "birthday" => "1998-02-25",
                                                    "doctor" => {
                                                      "crm" => "B0002W2RBG",
                                                      "crm_state" => "CE",
                                                      "name" => "Dra. Isabelly Rêgo"
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
                                                  }]
  end
end
