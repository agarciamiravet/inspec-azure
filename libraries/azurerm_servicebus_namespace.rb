# frozen_string_literal: true

require 'azurerm_resource'

class AzurermServiceBusNamespace < AzurermSingularResource
  name 'azurerm_servicebus_namespace'
  desc 'Verifies settings and configuration for an Azure ServiceBus Namespace'
  example <<-EXAMPLE
    describe azurerm_servicebus_namespace(resource_group: 'rg-1', namespace_name: 'sb-example') do
      it            { should exist }
      its('name')   { should eq('vault-1') }
    end
  EXAMPLE

  ATTRS = %i(
    id
    name
    sku
    location
    type
    tags
    properties
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, namespace_name: nil)
    servicebus_namespace = management.service_bus_namespace(resource_group, namespace_name)
    return if has_error?(servicebus_namespace)

    assign_fields(ATTRS, servicebus_namespace)

    @exists = true
  end

  def has_basic_tier?
    if sku.tier == 'Basic'
      return true
    else
      return false 
    end
  end

  def to_s
    "Azure ServiceBus Namespace: '#{name}'"
  end
end
