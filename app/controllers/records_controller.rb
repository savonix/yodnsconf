class RecordsController < ApplicationController
  def index
  end

  def new
    @zone = Zone.find(params[:zone_id])
    @record = Record.new
  end

  def show
  end

  def edit
    @zone = Zone.find(params[:zone_id])
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(params[:record])
      redirect_to zone_path(params[:zone_id])
    else
      @zone = Zone.find(params[:zone_id])
      @record = Record.find(params[:id])
      render :action => :edit
    end
  end

  def create
    @record = Record.new(params[:record])
    if @record.save
      redirect_to zone_path(params[:zone_id])
    else
      @zone = Zone.find(params[:zone_id])
      render :action => 'new'
    end
  end

end
