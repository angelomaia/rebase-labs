require 'spec_helper'
require_relative '../../app'

describe 'Usuário visualiza listagem de exames' do
  it 'a partir da página inicial' do
    json_data = File.read(File.join(__dir__, '..', 'support', 'sample.json'))
    fake_response = instance_double(Faraday::Response, body: json_data)
    allow(Faraday).to receive(:get).with('http://exams-server:3000/tests').and_return(fake_response)

    visit '/'
    save_and_open_page

    expect(page).to have_content 'Rebase Labs - Listagem de Exames'
    within('#test-list') do
      expect(page).to have_content 'Núbia Sais Filho'
      expect(page).to have_content 'zachariah@olson.org'
      expect(page).to have_content '013.808.384-36'
      expect(page).to have_content '1972-11-08'
      expect(page).to have_content 'Dra. Isabelly Rêgo'
      expect(page).to have_content 'B0002W2RBG'
      expect(page).to have_content 'CE'
      expect(page).to have_content 'GY878I'
      expect(page).to have_content '2021-06-03'
      expect(page).to have_content 'hemácias'
      expect(page).to have_content '45-52'
      expect(page).to have_content '82'
      expect(page).to have_content 'leucócitos'
      expect(page).to have_content '9-61'
      expect(page).to have_content '18'
      expect(page).to have_content 'Henry Pinheira Filho'
      expect(page).to have_content 'Maria Helena Ramalho'
    end
  end
end