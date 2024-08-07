require 'spec_helper'
require_relative '../../config/db_config.rb'

describe '/tests' do
  it 'GET' do
    db = [{"id" => "1",
          "cpf" => "048.973.170-88",
          "nome paciente" => "Emilly Batista Neto",
          "email paciente" => "gerald.crona@ebert-quigley.com",
          "data nascimento paciente" => "2001-03-11",
          "endereço/rua paciente" => "165 Rua Rafaela",
          "cidade paciente" => "Ituverava",
          "estado patiente" => "Alagoas",
          "crm médico" => "B000BJ20J4",
          "crm médico estado" => "PI",
          "nome médico" => "Maria Luiza Pires",
          "email médico" => "denna@wisozk.biz",
          "token resultado exame" => "IQCZ17",
          "data exame" => "2021-08-05",
          "tipo exame" => "hemácias",
          "limites tipo exame" => "45-52",
          "resultado tipo exame" => "97"}]

    connection = double('PG:Connection', exec: db)
    allow(PG).to receive(:connect).and_return(connection)

    get '/tests'

    expect(last_response.status).to eq 200
    expect(last_response.content_type).to include 'application/json'
    expect(JSON.parse(last_response.body)).to eq [{"id" => "1",
                                                  "cpf" => "048.973.170-88",
                                                  "nome paciente" => "Emilly Batista Neto",
                                                  "email paciente" => "gerald.crona@ebert-quigley.com",
                                                  "data nascimento paciente" => "2001-03-11",
                                                  "endereço/rua paciente" => "165 Rua Rafaela",
                                                  "cidade paciente" => "Ituverava",
                                                  "estado patiente" => "Alagoas",
                                                  "crm médico" => "B000BJ20J4",
                                                  "crm médico estado" => "PI",
                                                  "nome médico" => "Maria Luiza Pires",
                                                  "email médico" => "denna@wisozk.biz",
                                                  "token resultado exame" => "IQCZ17",
                                                  "data exame" => "2021-08-05",
                                                  "tipo exame" => "hemácias",
                                                  "limites tipo exame" => "45-52",
                                                  "resultado tipo exame" => "97"}]
  end
end
