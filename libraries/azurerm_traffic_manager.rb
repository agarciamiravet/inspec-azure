# frozen_string_literal: true

require 'azurerm_resource'

class AzurermTrafficManager < AzurermSingularResource
  name 'azurerm_traffic_manager'
  desc 'Verifies settings for an Azure Traffic Manager'
  example <<-EXAMPLE
    describe azure_traffic_manager(resource_group: 'rg-1', server_name: 'traffic-manager-name') do
      it { should exist }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    kind
    location
    type
    tags
    properties
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
    traffic_manager = management.traffic_manager(resource_group, name)
    return if has_error?(traffic_manager)

    assign_fields(ATTRS, traffic_manager)

    @resource_group = resource_group
    @traffic_manager_name = name
    @exists = true
  end

  def has_routing_method_performance?
      return properties.trafficRoutingMethod == "Performance"
  end

  def enabled?
    return properties.profileStatus == "Enabled"
  end

  def disabled?
    return properties.profileStatus == "Disabled"
  end

  def to_s
    "Azure Traffic Manager: '#{name}'"
  end
end
