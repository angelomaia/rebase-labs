require 'csv'
require 'json'

class CSVValidator
  REQUIRED_COLUMNS = ["cpf", "nome paciente", "email paciente", "data nascimento paciente", 
                      "endereço/rua paciente", "cidade paciente", "estado patiente", "crm médico", 
                      "crm médico estado", "nome médico", "email médico", "token resultado exame", 
                      "data exame", "tipo exame", "limites tipo exame", "resultado tipo exame"]

  def self.validate(file)
    begin
      rows = CSV.read(file, col_sep: ';')
    rescue CSV::MalformedCSVError
      return { success: false, error: 'Não é um arquivo CSV válido' }.to_json
    end

    columns = rows.shift
    if columns != REQUIRED_COLUMNS
      return { success: false, error: 'Dados do CSV estão em formato inválido' }.to_json
    end

    if rows.empty?
      return { success: false, error: 'O arquivo CSV está vazio' }.to_json
    end

    { success: true }.to_json
  end
end
