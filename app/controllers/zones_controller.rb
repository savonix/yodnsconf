class ZonesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params.has_key?('show') && params['show'] == 'all'
      @zones = Zone.paginate(:page => params[:page], :order => 'expires_at')
    else
      @zones = Zone.fresh.paginate(:page => params[:page], :order => 'expires_at')
    end
  end

  def show
    @zone = Zone.find(params[:id])
  end

  def edit
    @zone = Zone.find(params[:id])
  end

  def clone
    oldzone = Zone.find(params[:id])
    newzone = Zone.new(oldzone.attributes.merge(:origin => "clone-of-#{oldzone.origin}"))
    if newzone.save
      oldzone.records.each do |r|
        newzone.records << r.dup
      end
      redirect_to zone_path(newzone)
    end
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone.update_attributes(params[:zone])
      redirect_to zone_path(params[:id])
    else
      render :action => :edit
    end
  end

  def new
    @zone = Zone.new
  end

  def create
    @zone = Zone.new(params[:zone])
    if @zone.save
      redirect_to zones_path
    else
      render :action => 'new'
    end
  end

  def destroy
    if params[:zone_ids].present? && params[:zone_ids].is_a?(Array)
      params[:zone_ids].each do |zid|
        zone = Zone.find(zid)
        zone.destroy
      end
    elsif params[:id].present?
      zone = Zone.find(params[:id])
      zone.destroy
    end
    redirect_to zones_path
  end

end
