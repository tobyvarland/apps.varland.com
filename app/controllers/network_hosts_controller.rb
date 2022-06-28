class NetworkHostsController < ApplicationController
  before_action :set_network_host, only: %i[ show edit update destroy ]

  # GET /network_hosts or /network_hosts.json
  def index
    @network_hosts = NetworkHost.order(:vlan_number, :address)
  end

  # GET /network_hosts/new
  def new
    @network_host = NetworkHost.new
  end

  # GET /network_hosts/1/edit
  def edit
  end

  # POST /network_hosts or /network_hosts.json
  def create
    @network_host = NetworkHost.new(network_host_params)

    respond_to do |format|
      if @network_host.save
        format.html { redirect_to network_hosts_url, notice: "Network host <code>#{@network_host.fqdn}</code> was successfully created." }
        format.json { render :show, status: :created, location: @network_host }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @network_host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_hosts/1 or /network_hosts/1.json
  def update
    respond_to do |format|
      if @network_host.update(network_host_params)
        format.html { redirect_to network_hosts_url, notice: "Network host <code>#{@network_host.fqdn}</code> was successfully updated." }
        format.json { render :show, status: :ok, location: @network_host }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @network_host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_hosts/1 or /network_hosts/1.json
  def destroy
    @network_host.destroy
    respond_to do |format|
      format.html { redirect_to network_hosts_url, notice: "Network host was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_host
      @network_host = NetworkHost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def network_host_params
      params.require(:network_host).permit(:hostname, :vlan_number, :address, :mac_address, :device_type)
    end
end
