# frozen_string_literal: true

require 'azurerm_resource'

class AzurermAppGateway < AzurermSingularResource
  name 'azurerm_app_gateway'
  desc 'Verifies settings for an Azure Network Interface'
  example <<-EXAMPLE
    describe azure_network_interface(resource_group: 'rg-1', name: 'my-nic-name') do
      it { should exist }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    properties
    tags
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
    app_gateway = management.app_gateway(resource_group, name)
    return if has_error?(app_gateway)

    assign_fields(ATTRS, app_gateway)

    @resource_group = resource_group
    @name = name
    @exists = true
  end


  def has_waf_enabled?
    if properties.sku.name == 'WAF_v2'
      return true
    else
      return false 
    end
  end

  def has_location_west_europe?
    if location== 'westeurope'
      return true
    else
      return false 
    end
  end

  def capacity
      return properties.sku.capacity
  end

  def has_firewall_enabled?
    return properties.webApplicationFirewallConfiguration.enabled
  end

  def has_firewall_in_mode_prevention?
    if properties.webApplicationFirewallConfiguration.firewallMode == 'Prevention'
      return true
    else
      return false 
    end
  end

  def to_s
    "Azure App Gateway: '#{name}'"
  end
end