require 'spec_helper'

describe '/import' do
  it 'POST' do
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
                              }].to_json
  end
end
