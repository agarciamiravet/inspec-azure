# frozen_string_literal: true

require 'azurerm_resource'

class AzurermContainerRegistry < AzurermSingularResource
  name 'azurerm_container_registry'
  desc 'Verifies settings and configuration for an Azure Container Registry'
  example <<-EXAMPLE
    describe azurerm_container_registry(resource_group: 'rg-1', name: 'container-registry-1') do
      it            { should exist }
      its('name')   { should eq('app-insight-1') }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    type
    tags
    properties
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
    container_registry = management.container_registry(resource_group, name)
    return if has_error?(container_registry)

    assign_fields(ATTRS, container_registry)

    @exists = true
  end

  def has_location_west_europe?
    if location.downcase == 'westeurope'
      return true
    else
      return false 
    end
  end

  def to_s
    "Azure Container Registry: '#{name}'"
  end
end
