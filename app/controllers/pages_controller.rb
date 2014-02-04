class PagesController < ApplicationController

   before_filter :user_signed_in?

  def home

  end

end