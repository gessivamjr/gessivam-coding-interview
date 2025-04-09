class TweetsController < ApplicationController
  def index
    if params[:user_id].present?
      user_tweets = Tweet.by_user(params[:user_id])
      return render json: user_tweets
    end

    page = params[:page]&.to_i || 1
    per_page = params[:per_page]&.to_i || 5

    render json: Tweet.all.limit(per_page).offset((page - 1) * per_page)
  end
end
