require 'sinatra/base'

require 'active_support'
require 'active_model'
require 'active_record'

require 'sinatra/activerecord'

class Application < ActiveRecord::Base
  has_many :votes
end
class Vote < ActiveRecord::Base
  belongs_to :application

  validates :intent, presence: true, inclusion: { in: ['yes', 'no'] }
  validates :name, :application, presence: true

  scope :yes, -> { where(intent: 'yes') }
  scope :no, -> { where(intent: 'no') }
end

class Caesar < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/applications/:id' do
    @application = Application.find(params[:id])

    erb :show_application
  end

  get '/applications/:id/:intent' do
    @application = Application.find(params[:id])
    @vote = @application.votes.build(intent: params[:intent])

    # if @vote.errors.key?(:intent)
    #   halt 404
    # end

    erb :new_vote
  end

  post '/applications/:id/:intent' do
    @application = Application.find(params[:id])
    @vote = @application.votes.build(intent: params[:intent],
                                     name: params[:name])

    if @vote.save
      erb :create_vote
    else
      erb :new_vote
    end
  end

  helpers do
    def icon_class_for_vote(vote)
      case vote
      when 'yes' then 'fa-thumbs-up'
      when 'no' then 'fa-thumbs-down'
      end
    end

    def votes_yes
      @application.votes.yes.size
    end

    def votes_no
      @application.votes.no.size
    end
  end

end
