# frozen_string_literal: true

require 'azurerm_resource'

class AzurermFunction < AzurermSingularResource
  name 'azurerm_azure_function'
  desc 'Verifies settings for an Azure Virtual Machine'
  example <<-EXAMPLE
    describe azurerm_virtual_machine(resource_group: 'example', name: 'vm-name') do
      it { should have_monitoring_agent_installed }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    location
    properties
    resources
    tags
    type
    zones
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, web_site: nil, name: nil)
   
    azure_function = management.azure_function(resource_group, web_site, name)
    return if has_error?(azure_function)

    assign_fields(ATTRS, azure_function)
    @resource_group = resource_group
    @name = name
    @exists = true
  end

  def to_s
    "'#{name}' Azure function"
  end
end