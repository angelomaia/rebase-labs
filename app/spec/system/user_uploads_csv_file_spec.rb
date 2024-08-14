require 'spec_helper'
require_relative '../../app'

describe 'Usuário faz upload de um arquivo csv', js: true do
  it 'com sucesso' do
    visit '/'
    attach_file('csv-file', File.expand_path('../support/sample.csv', __dir__), make_visible: true)
    click_on 'Enviar'

    expect(page).to have_content ({'success' => true}).to_json
  end
end