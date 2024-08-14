require 'sidekiq'
require_relative '../services/csv_importer.rb'
require_relative '../config/db_config'

class ImportJob
  include Sidekiq::Job

  def perform(file_path)
    if File.exist?(file_path)
      importer = CSVImporter.new(DB_PARAMS, file_path)
      importer.import
    else
      raise "File not found: #{file_path}"
    end
  end
end