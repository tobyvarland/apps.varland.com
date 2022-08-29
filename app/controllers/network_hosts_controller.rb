class NetworkHostsController < ApplicationController

  before_action :set_network_host,
                only: %i[ edit update destroy ]

  def index
    authorize(NetworkHost)
    @network_hosts = NetworkHost.by_vlan_and_address
  end

  def new
    authorize(NetworkHost)
    @network_host = NetworkHost.new
  end

  def edit
    authorize(@network_host)
  end

  def create
    @network_host = NetworkHost.new(network_host_params)
    authorize(@network_host)
    if @network_host.save
      redirect_to network_hosts_url, notice: "Network host <code>#{@network_host.fqdn}</code> was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@network_host)
    if @network_host.update(network_host_params)
      redirect_to network_hosts_url, notice: "Network host <code>#{@network_host.fqdn}</code> was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@network_host)
    @network_host.discard
    redirect_to network_hosts_url, notice: "Network host <code>#{@network_host.fqdn}</code> was successfully destroyed."
  end

  private

    def set_network_host
      @network_host = NetworkHost.find(params[:id])
    end

    def network_host_params
      params.require(:network_host).permit(:hostname,
                                           :vlan_number,
                                           :address,
                                           :location)
    end

end