require 'spec_helper'

describe 'CSVValidator' do
  context '#validate' do
    it 'não é um arquivo .csv' do
      validator = CSVValidator.validate('./spec/support/lab.svg')

      expect(validator).to eq({ success: false, error: 'Não é um arquivo CSV válido' }.to_json)
    end

    it 'é um CSV com colunas erradas' do
      validator = CSVValidator.validate('./spec/support/invalid_columns.csv')

      expect(validator).to eq({ success: false, error: 'Dados do CSV estão em formato inválido' }.to_json)
    end

    it 'é um csv com colunas mas sem linhas' do
      validator = CSVValidator.validate('./spec/support/empty_rows.csv')

      expect(validator).to eq({ success: false, error: 'O arquivo CSV está vazio' }.to_json)
    end

    it 'sucesso' do
      validator = CSVValidator.validate('./spec/support/correct.csv')

      expect(validator).to eq({ success: true }.to_json)
    end
  end
end