# frozen_string_literal: true

require 'azurerm_resource'

class AzurermLogicApp < AzurermSingularResource
  name 'azurerm_logic_app'
  desc 'Verifies settings and configuration for an Azure Key Vault'
  example <<-EXAMPLE
    describe azurerm_logic_app(resource_group: 'rg-1', name: 'vault-1') do
      it            { should exist }
      its('name')   { should eq('vault-1') }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    tags
    properties
    sku
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
    logic_app = management.logic_app(resource_group, name)
    return if has_error?(logic_app)

    assign_fields(ATTRS, logic_app)

    @exists = true
  end
  
  def has_location_west_europe?
    return location.downcase == 'westeurope'
  end

  def enabled?
    return properties.state == "Enabled"
  end
  
  def to_s
    "Azure Logic App: '#{name}'"
  end
end
