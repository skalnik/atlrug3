class TalksController < ApplicationController
  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(params[:talk])
    if @talk.save
      redirect_to root_url, notice: "Your talk has been submitted for review!"
    else
      render :new
    end
  end
end
