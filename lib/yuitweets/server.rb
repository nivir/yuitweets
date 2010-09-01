require 'builder'
require 'erubis'
require 'htmlentities'
require 'sinatra/base'

require 'yuitweets'

module YUITweets; class Server < Sinatra::Base
  set :logging, true
  set :root, ROOT_DIR

  get '/' do
    content_type('text/html', :charset => 'utf-8')
    erubis(:index)
  end

  get '/classify.json' do
    content_type('application/json', :charset => 'utf-8')

    text = params[:text] or json_error(400, "Missing required parameter: text")

    json_success(YUITweets.bayes.classify(text))
  end

  get '/recent.json' do
    content_type('application/json', :charset => 'utf-8')

    results = recent_tweets

    if results.empty?
      json_success({
        :limit    => @limit,
        :since_id => @since_id
      })
    else
      json_success({
        :add      => results.map {|t| t.to_hash(:html => render_tweet(t)) },
        :limit    => @limit,
        :max_id   => results.first && results.first.id || 0,
        :since_id => @since_id
      })
    end
  end

  get '/recent.rss' do
    content_type('application/rss+xml', :charset => 'utf-8')

    results  = recent_tweets
    entities = HTMLEntities.new

    x = Builder::XmlMarkup.new(:indent => 2)
    x.instruct!

    x.rss(:version     => '2.0',
          'xmlns:atom' => 'http://www.w3.org/2005/Atom',
          'xmlns:dc'   => 'http://purl.org/dc/elements/1.1/') do

      x.channel do
        x.title 'YUI Tweets'
        x.link  'http://yuitweets.pieisgood.org/'
        x.ttl   5

        results.each do |tweet|
          tweet_url = url_tweet(tweet)

          x.item do
            x.title   entities.decode(tweet.text)
            x.link    tweet_url
            x.dc      :creator, tweet.from_user
            x.guid    tweet_url, :isPermaLink => 'true'
            x.pubDate tweet.created_at.rfc2822
          end
        end
      end
    end

    x.target!
  end

  post '/vote.json' do
    content_type('application/json', :charset => 'utf-8')

    id    = params[:id] or json_error(400, "Missing required parameter: id")
    type  = params[:type] or json_error(400, "Missing required parameter: type")
    type.downcase!

    tweet = Tweet[id.to_i] or json_error(400, "Tweet id not found: #{id.to_i}")

    # Don't retrain if the tweet has already been trained as this type.
    if tweet.type != type
      unless tweet.type.nil?
        # Tweet was previously trained as a different type, so untrain it before
        # retraining.
        YUITweets.bayes.untrain(tweet.type, tweet.specimen)
      end

      YUITweets.bayes.train(type, tweet.specimen)
    end

    tweet.update(
      :type  => type,
      :votes => tweet.votes + 1
    )

    json_success({
      :update => [tweet.to_hash(:html => render_tweet(tweet))]
    })
  end

  helpers do
    def json_error(code, message = 'Unknown error')
      error(code, Yajl::Encoder.encode({:error => message}))
    end

    def json_success(data = nil, message = 'Yay!')
      body = {:success => message}
      body[:data] = data unless data.nil?

      Yajl::Encoder.encode(body)
    end

    def recent_tweets
      @limit    = (params[:limit] || 20).to_i
      @since_id = (params[:since_id] || 0).to_i
      @type     = params[:type]

      if @type.nil?
        results = []

        ['yui', nil, 'other'].each do |type|
          results += Tweet.recent(
            :limit    => @limit,
            :since_id => @since_id,
            :type     => type
          ).all
        end
      else
        results = Tweet.recent(
          :limit    => @limit,
          :since_id => @since_id,
          :type     => @type == 'unknown' ? nil : @type
        ).all
      end

      results.sort_by! {|tweet| tweet.id }
      results.reverse!
      results
    end

    def render_tweet(tweet)
      show_scores = !params[:show_scores].nil?
      erubis(:'partials/tweet', :locals => {:tweet => tweet, :show_scores => show_scores})
    end

    def url_tweet(tweet)
      "#{url_user(tweet.from_user)}/status/#{tweet.id}"
    end

    def url_user(user)
      "http://twitter.com/#{escape(user)}"
    end
  end
end; end
