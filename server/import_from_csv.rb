require 'pg'
require 'csv'
require './config/db_config'
require './services/csv_importer'

importer = CSVImporter.new(DB_PARAMS, './sample/data.csv')
importer.import