require 'sinatra/activerecord/rake'
require './caesar'

namespace :db do
  task :load_config do
    require './caesar'
  end
end

task :create_application do
  owner = ENV['OWNER']
  change = ENV['CHANGE']
  address = ENV['ADDRESS']

  Application.create!(owner: owner, change: change, address: address)
end

task :update_application do
  id = ENV['ID']
  atts = {
    owner: ENV['OWNER'],
    change: ENV['CHANGE'],
    address: ENV['ADDRESS'],
  }

  Application.find(id).update_attributes!(atts)
end
