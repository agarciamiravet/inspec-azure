# frozen_string_literal: true

require 'azurerm_resource'

class AzurermApiManagement < AzurermSingularResource
  name 'azurerm_api_management'
  desc 'Verifies settings and configuration for an Azure Key Vault'
  example <<-EXAMPLE
    describe azurerm_api_management(resource_group: 'rg-1', name: 'api_management') do
      it            { should exist }
      its('name')   { should eq('api_management') }
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
    api_management = management.api_management(resource_group, name)
    return if has_error?(api_management)

    assign_fields(ATTRS, api_management)

    @exists = true
  end

  def has_consumption_tier? 
    return sku.name.downcase == 'consumption'
  end

  def has_location_west_europe?
    return location.downcase == 'west europe'
  end

  def to_s
    "Azure Api Management: '#{name}'"
  end
end
