# frozen_string_literal: true

require 'azurerm_resource'

class AzurermRecoveryServiceVault < AzurermSingularResource
  name 'azurerm_recovery_service_vault'
  desc 'Verifies settings and configuration for an Azure Key Vault'
  example <<-EXAMPLE
    describe azurerm_recovery_service_vault(resource_group: 'rg-1', name: 'vault-1') do
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
    recovery_service_vault = management.recovery_service_vault(resource_group, name)
    return if has_error?(recovery_service_vault)

    assign_fields(ATTRS, recovery_service_vault)

    @exists = true
  end
  
  def has_location_west_europe?
    return location.downcase == 'westeurope'
  end

 #def diagnostic_settings
 #  @diagnostic_settings ||= management.key_vault_diagnostic_settings(id)
 #end

 #def has_standard_tier? 
 #  if properties.sku.name.downcase == 'standard'
 #    return true
 #  else
 #    return false 
 #  end
 #end

 #def has_location_west_europe?
 #  if location.downcase == 'westeurope'
 #    return true
 #  else
 #    return false 
 #  end
 #end

  def to_s
    "Azure Recovery Service Vault: '#{name}'"
  end
end
