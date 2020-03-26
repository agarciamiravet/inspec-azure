# frozen_string_literal: true

require 'azurerm_resource'

class AzurermAppInsight < AzurermSingularResource
  name 'azurerm_app_insight'
  desc 'Verifies settings and configuration for an Azure Key Vault'
  example <<-EXAMPLE
    describe azurerm_app_insight(resource_group: 'rg-1', name: 'app-insight-1') do
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
    app_insight = management.app_insight(resource_group, name)
    return if has_error?(app_insight)

    assign_fields(ATTRS, app_insight)

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
    "Azure App Insight: '#{name}'"
  end
end
