require 'spec_helper'
require_relative '../../app'

describe 'Usuário vê um exame individual pelo token', js: true do
  it 'com sucesso' do
    token_data = File.read(File.join(__dir__, '..', 'support', 'token.json'))
    token_response = instance_double(Faraday::Response, body: token_data)
    allow(Faraday).to receive(:get).with('http://exams-server:3000/tests/FWZ3AT').and_return(token_response)

    visit '/FWZ3AT'

    expect(page).to have_content 'Rebase Labs'
    within('#test-list') do
      expect(page).to have_content 'Henry Pinheira Filho'
      expect(page).to have_content '092.375.756-29'
      expect(page).not_to have_content 'Núbia Sais Filho'
    end
  end
end