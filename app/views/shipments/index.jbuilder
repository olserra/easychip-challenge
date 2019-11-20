json.array! ShipmentItem.where(shipment_id: @shipments.map(&:id)).group_by(&:description) do |description, shipment_items|   
  json.description        description
  json.count              shipment_items.count  
end