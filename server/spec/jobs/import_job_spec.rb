require 'spec_helper'

describe 'ImportJob' do
  it '#perform' do
    ImportJob.perform_sync('./spec/support/correct.csv')

    tests = DB.exec("SELECT * FROM tests;")
    patients = DB.exec("SELECT * FROM tests;")
    doctors = DB.exec("SELECT * FROM tests;")
    exams = DB.exec("SELECT * FROM exams;")

    expect(tests.ntuples).to be 3
    expect(patients.ntuples).to be 3
    expect(doctors.ntuples).to be 3
    expect(exams.ntuples).to be 3
  end
end