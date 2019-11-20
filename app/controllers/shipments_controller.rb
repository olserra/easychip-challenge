class ShipmentsController < ApplicationController
  def index
    company = Company.find(params[:company_id])
    @shipments = company.shipments
  end

  def show
    @shipment = Shipment.find(params[:id])
  end

end
