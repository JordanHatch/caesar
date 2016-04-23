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
  url = ENV['URL']

  Application.create!(owner: owner, change: change, address: address, url: url)
end

task :update_application do
  id = ENV['ID']

  atts = { }
  keys = ['OWNER', 'CHANGE', 'ADDRESS', 'URL']

  keys.each do |key|
    if ENV[key].present?
      atts[key.downcase] = ENV[key]
    end
  end

  Application.find(id).update_attributes!(atts)
end
