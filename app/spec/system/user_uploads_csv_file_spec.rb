require 'spec_helper'
require_relative '../../app'

describe 'Usuário faz upload de um arquivo csv', js: true do
  it 'com sucesso' do
    allow(Faraday).to receive(:new).and_return(
      instance_double(Faraday::Connection, post: instance_double(
                      Faraday::Response, status: 200, body: { success: true }.to_json)))

    visit '/'
    attach_file('csv-file', File.expand_path('../support/sample.csv', __dir__), make_visible: true)
    click_on 'Enviar'

    expect(page).to have_content ({'success' => true}).to_json
  end
end