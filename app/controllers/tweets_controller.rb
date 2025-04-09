class TweetsController < ApplicationController
  def index
    if params[:user_id].present?
      user_tweets = Tweet.by_user(params[:user_id])
      return render json: user_tweets
    end

    render json: Tweet.all
  end
end
