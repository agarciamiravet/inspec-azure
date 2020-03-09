# frozen_string_literal: true

require 'azurerm_resource'

class AzurermKeyVaultsList < AzurermPluralResource
  name 'azurerm_key_vaults_list'
  desc 'Verifies settings for sql servers'
  example <<-EXAMPLE
    describe azurerm_key_vaults_list(resource_group: 'my-rg', resource_name: 'my-vm', resource_type: 'Microsoft.Compute/virtualMachines') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids,        field: :id )
             .register_column(:names,      field: :name)
             .register_column(:locations,  field: :location)
             .install_filter_methods_on_resource(self, :table)

  def initialize()
    resp = management.key_vaults_lists()
    return if has_error?(resp)
    @table = resp
  end

  def to_s
    'Azure KeyVaults list' 
  end
end
