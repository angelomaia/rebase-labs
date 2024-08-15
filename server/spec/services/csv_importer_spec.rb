require 'spec_helper'

describe 'CSVImporter' do
  context '#import' do
    it 'successfully' do
      importer = CSVImporter.new(DB_PARAMS, './sample/small_data.csv')

      importer.import
      tests = DB.exec("SELECT * FROM tests;")
      patients = DB.exec("SELECT * FROM tests;")
      doctors = DB.exec("SELECT * FROM tests;")
      exams = DB.exec("SELECT * FROM exams;")

      expect(tests.ntuples).to be 1
      expect(patients.ntuples).to be 1
      expect(doctors.ntuples).to be 1
      expect(exams.ntuples).to be 3
    end

    it 'excluding duplicates' do
      importer = CSVImporter.new(DB_PARAMS, './sample/duplicate_exam.csv')

      importer.import
      tests = DB.exec("SELECT * FROM tests;")
      patients = DB.exec("SELECT * FROM tests;")
      doctors = DB.exec("SELECT * FROM tests;")
      exams = DB.exec("SELECT * FROM exams;")

      expect(tests.ntuples).to be 1
      expect(patients.ntuples).to be 1
      expect(doctors.ntuples).to be 1
      expect(exams.ntuples).to be 1
    end
  end
end
