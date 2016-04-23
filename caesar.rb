require 'sinatra/base'

require 'active_support'
require 'active_model'
require 'active_record'

require 'sinatra/activerecord'

require 'securerandom'

class Application < ActiveRecord::Base
  has_many :votes
end
class Vote < ActiveRecord::Base
  belongs_to :application

  validates :intent, presence: true, inclusion: { in: ['yes', 'no'] }
  validates :name, :application, presence: true

  scope :yes, -> { where(intent: 'yes') }
  scope :no, -> { where(intent: 'no') }

  before_create :set_secret

private
  def set_secret
    self.secret = SecureRandom.hex(32)
  end
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
      redirect vote_path(@application, @vote)
    else
      erb :new_vote
    end
  end

  get '/applications/:application_id/votes/:vote_id' do
    find_vote

    erb :show_vote
  end

  post '/applications/:application_id/votes/:vote_id' do
    find_vote

    @vote.email = params[:email]
    @vote.save

    redirect vote_path(@application, @vote)
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

    def find_vote
      @application = Application.find(params[:application_id])
      @vote = @application.votes.where(id: params[:vote_id], secret: params[:secret]).first!
    end

    def application_path(application)
      "/applications/#{application.id}"
    end

    def vote_path(application, vote)
      "/applications/#{application.id}/votes/#{vote.id}?secret=#{vote.secret}"
    end
  end

end
