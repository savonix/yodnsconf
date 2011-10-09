class ZonesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params.has_key?('show') && params['show'] == 'all'
      @zones = current_user.zones.paginate(:page => params[:page], :order => 'expires_at')
    else
      @zones = current_user.zones.fresh.paginate(:page => params[:page], :order => 'expires_at')
    end
  end

  def show
    @zone = Zone.user(current_user.id).find(params[:id])
  end

  def whois 
    @zone = Zone.user(current_user.id).find(params[:id])
  end

  def check 
    @zone = Zone.user(current_user.id).find(params[:id])
  end

  def edit
    @zone = Zone.user(current_user.id).find(params[:id])
  end

  def clone
    oldzone = Zone.user(current_user.id).find(params[:id])
    newzone = Zone.new(oldzone.attributes.merge(:origin => "clone-of-#{oldzone.origin}"))
    if newzone.save
      oldzone.records.each do |r|
        newzone.records << r.dup
      end
      redirect_to zone_path(newzone)
    end
  end

  def update
    @zone = Zone.user(current_user.id).find(params[:id])
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
    params[:zone][:user_id] = current_user.id
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
        zone = Zone.user(current_user.id).find(zid)
        zone.destroy
      end
    elsif params[:id].present?
      zone = Zone.user(current_user.id).find(params[:id])
      zone.destroy
    end
    redirect_to zones_path
  end

end
